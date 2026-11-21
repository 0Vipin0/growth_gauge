// validateTemplates.dart
//
// Validates that every exercise referenced by the workout templates exists in
// the exercise catalog, runs integrity checks on both seed files, and prints a
// tabular summary of the current exercise and template data.
//
// This single file is the only implementation. The platform wrappers
// (validateTemplates.sh / validateTemplates.ps1) simply locate the Dart SDK and
// run it, so the output is identical on Linux, macOS and Windows.
//
// Usage:
//   dart validateTemplates.dart [exercise_file] [template_file] [options]
//
// Options:
//   --exercise-file <path>   Exercise seed file (alternative to the 1st argument)
//   --template-file <path>   Template seed file (alternative to the 2nd argument)
//   --strict                 Treat warnings as failures (exit 1)
//   --show-all               Also print the full exercise usage table
//   --no-color               Disable coloured output
//   -h, --help               Show this help
//
// Exit codes: 0 = passed, 1 = validation failed, 2 = usage / input error.
//
// Requirements: Dart SDK only (no packages, no pub get).

import 'dart:convert';
import 'dart:io';

const String kDefaultExerciseFile =
    './lib/features/catalog/infrastructure/seed/exercise_seed_data.dart';
const String kDefaultTemplateFile =
    './lib/features/template/infrastructure/seed/workout_template_seed_data.dart';

const String kUsage = '''
Usage: dart validateTemplates.dart [exercise_file] [template_file] [options]

Options:
  --exercise-file <path>   Exercise seed file (alternative to the 1st argument)
  --template-file <path>   Template seed file (alternative to the 2nd argument)
  --strict                 Treat warnings as failures (exit 1)
  --show-all               Also print the full exercise usage table
  --no-color               Disable coloured output
  -h, --help               Show this help

Exit codes: 0 = passed, 1 = validation failed, 2 = usage / input error''';

// ---------------------------------------------------------------------------
// Entry point
// ---------------------------------------------------------------------------
Future<void> main(List<String> arguments) async {
  final int code = _run(arguments);
  await stdout.flush();
  exit(code);
}

// ---------------------------------------------------------------------------
// Options
// ---------------------------------------------------------------------------
class Options() {
  bool strict = false;
  bool showAll = false;
  bool noColor = false;
  bool help = false;
  String? exercisePath;
  String? templatePath;
  String? unknown;
}

Options parseArgs(List<String> args) {
  final Options o = Options();
  final List<String> positional = <String>[];
  for (int i = 0; i < args.length; i++) {
    final String a = args[i];
    if (a == '--strict') {
      o.strict = true;
    } else if (a == '--show-all') {
      o.showAll = true;
    } else if (a == '--no-color') {
      o.noColor = true;
    } else if (a == '-h' || a == '--help') {
      o.help = true;
    } else if (a == '--exercise-file' || a == '--template-file') {
      if (i + 1 < args.length) {
        i++;
        if (a == '--exercise-file') {
          o.exercisePath = args[i];
        } else {
          o.templatePath = args[i];
        }
      } else {
        o.unknown = a;
      }
    } else if (a.startsWith('--exercise-file=')) {
      o.exercisePath = a.substring('--exercise-file='.length);
    } else if (a.startsWith('--template-file=')) {
      o.templatePath = a.substring('--template-file='.length);
    } else if (a.startsWith('-')) {
      o.unknown ??= a;
    } else {
      positional.add(a);
    }
  }
  if (o.exercisePath == null && positional.isNotEmpty) {
    o.exercisePath = positional[0];
  }
  if (o.templatePath == null && positional.length > 1) {
    o.templatePath = positional[1];
  }
  return o;
}

// ---------------------------------------------------------------------------
// Small helpers
// ---------------------------------------------------------------------------
String displayPath(String p) => p.replaceAll('\\', '/');

List<String> readLines(String path) {
  final List<int> bytes = File(path).readAsBytesSync();
  String text = utf8.decode(bytes, allowMalformed: true);
  if (text.isNotEmpty && text.codeUnitAt(0) == 0xFEFF) {
    text = text.substring(1);
  }
  return const LineSplitter().convert(text);
}

String? findSeed(String fileName) {
  const Set<String> skip = <String>{
    'build',
    '.dart_tool',
    '.git',
    'node_modules',
  };
  String? walk(Directory dir, String prefix) {
    final List<FileSystemEntity> entries = <FileSystemEntity>[];
    try {
      entries.addAll(dir.listSync(followLinks: false));
    } catch (_) {
      return null;
    }
    entries.sort(
      (FileSystemEntity a, FileSystemEntity b) => a.path.compareTo(b.path),
    );
    for (final FileSystemEntity e in entries) {
      final String base = e.uri.pathSegments.lastWhere(
        (String s) => s.isNotEmpty,
        orElse: () => '',
      );
      if (e is File && base == fileName) {
        return '$prefix$base';
      }
    }
    for (final FileSystemEntity e in entries) {
      if (e is Directory) {
        final String base = e.uri.pathSegments.lastWhere(
          (String s) => s.isNotEmpty,
          orElse: () => '',
        );
        if (skip.contains(base)) {
          continue;
        }
        final String? hit = walk(e, '$prefix$base/');
        if (hit != null) {
          return hit;
        }
      }
    }
    return null;
  }

  return walk(Directory.current, './');
}

final Map<String, RegExp> _quotedCache = <String, RegExp>{};

String _unquote(String s, int start) {
  final String q = s[start];
  final StringBuffer sb = StringBuffer();
  for (int i = start + 1; i < s.length; i++) {
    final String c = s[i];
    if (c == '\\') {
      if (i + 1 < s.length) {
        sb.write(s[i + 1]);
      }
      i++;
      continue;
    }
    if (c == q) {
      break;
    }
    sb.write(c);
  }
  return sb.toString();
}

/// Returns the first quoted string value that follows `key:` (or '' if none).
String getQuoted(String line, String key) {
  final RegExp re = _quotedCache.putIfAbsent(
    key,
    () => RegExp('(^|[^A-Za-z0-9_])$key:[ \\t]*[\\x22\\x27]'),
  );
  final RegExpMatch? m = re.firstMatch(line);
  if (m == null) {
    return '';
  }
  return _unquote(line, m.end - 1);
}

int countMatches(RegExp re, String line) => re.allMatches(line).length;

String dash(List<String> items) => items.isEmpty ? '-' : items.join(',');

Map<String, int> countMap(Iterable<String> items) {
  final Map<String, int> m = <String, int>{};
  for (final String x in items) {
    m[x] = (m[x] ?? 0) + 1;
  }
  return m;
}

/// Sorted list of values that occur more than once, with their counts.
List<MapEntry<String, int>> duplicateGroups(Iterable<String> values) {
  final Map<String, int> counts = countMap(
    values.where((String v) => v.isNotEmpty),
  );
  final List<MapEntry<String, int>> out = counts.entries
      .where((MapEntry<String, int> e) => e.value > 1)
      .toList();
  out.sort(
    (MapEntry<String, int> a, MapEntry<String, int> b) =>
        a.key.compareTo(b.key),
  );
  return out;
}

/// Multiset difference (items of [a] not matched by an item of [b]), sorted.
List<String> multisetDiff(List<String> a, List<String> b) {
  final Map<String, int> cb = countMap(b);
  final Map<String, int> seen = <String, int>{};
  final List<String> sortedA = List<String>.from(a)..sort();
  final List<String> out = <String>[];
  for (final String x in sortedA) {
    final int n = (seen[x] ?? 0) + 1;
    seen[x] = n;
    if (n > (cb[x] ?? 0)) {
      out.add(x);
    }
  }
  return out;
}

List<String> tokensOf(String id) {
  final List<String> out = <String>[];
  for (final String p in id.split('-')) {
    if (p.isNotEmpty && p != 'exercise' && !RegExp(r'^[0-9]+$').hasMatch(p)) {
      out.add(p);
    }
  }
  return out;
}

// ---------------------------------------------------------------------------
// Table rendering (rows[0] is the header)
// ---------------------------------------------------------------------------
String renderTable(
  String title,
  List<List<String>> rows,
  String aligns,
  int maxWidth,
) {
  final StringBuffer sb = StringBuffer();
  if (title.isNotEmpty) {
    sb.write('\n $title\n');
  }
  if (rows.isEmpty) {
    sb.write(' (none)\n');
    return sb.toString();
  }
  String fit(String s) {
    if (s.length > maxWidth) {
      return '${s.substring(0, maxWidth - 3)}...';
    }
    return s;
  }

  int cols = 0;
  for (final List<String> r in rows) {
    if (r.length > cols) {
      cols = r.length;
    }
  }
  final List<List<String>> cells = <List<String>>[];
  final List<int> widths = List<int>.filled(cols, 0);
  for (final List<String> r in rows) {
    final List<String> fitted = <String>[];
    for (int c = 0; c < cols; c++) {
      final String v = c < r.length ? fit(r[c]) : '';
      fitted.add(v);
      if (v.length > widths[c]) {
        widths[c] = v.length;
      }
    }
    cells.add(fitted);
  }
  final StringBuffer sepB = StringBuffer('+');
  for (int c = 0; c < cols; c++) {
    sepB.write('-' * (widths[c] + 2));
    sepB.write('+');
  }
  final String sep = sepB.toString();
  sb.write('$sep\n');
  for (int r = 0; r < cells.length; r++) {
    final StringBuffer line = StringBuffer('|');
    for (int c = 0; c < cols; c++) {
      final String al = (r == 0 || c >= aligns.length) ? 'l' : aligns[c];
      final String v = cells[r][c];
      final String padded = al == 'r'
          ? v.padLeft(widths[c])
          : v.padRight(widths[c]);
      line.write(' $padded |');
    }
    sb.write('$line\n');
    if (r == 0) {
      sb.write('$sep\n');
    }
  }
  sb.write('$sep\n');
  return sb.toString();
}

/// Sorts rows by their tab-joined text (ordinal), like `sort` in the C locale.
List<List<String>> sortRows(List<List<String>> rows) {
  final List<List<String>> copy = List<List<String>>.from(rows);
  copy.sort(
    (List<String> a, List<String> b) => a.join('\t').compareTo(b.join('\t')),
  );
  return copy;
}

// ---------------------------------------------------------------------------
// Exercise seed file parsing
// ---------------------------------------------------------------------------
class ExerciseInfo({
  required final String id,
  required final String name,
  required final List<String> equipment,
  required final List<String> regions,
  required final List<String> patterns,
  required final List<String> primary,
  required final List<String> missing,
  required final String variable,
});

class _ExerciseBuilder(final String variable, final bool isMove) {
  String id = '';
  String name = '';
  bool hasEquip = false;
  bool hasSetup = false;
  bool hasExec = false;
  bool hasCues = false;
  bool hasBreath = false;
  final Map<String, List<String>> lists = <String, List<String>>{
    'equip': <String>[],
    'region': <String>[],
    'pattern': <String>[],
    'primary': <String>[],
  };

  ExerciseInfo build() {
    final List<String> miss = <String>[];
    if (!hasSetup) {
      miss.add('setup');
    }
    if (!hasExec) {
      miss.add('execution');
    }
    if (!hasCues) {
      miss.add('cues');
    }
    if (!hasBreath) {
      miss.add('breathing');
    }
    List<String> equip = lists['equip']!;
    if (!hasEquip && isMove) {
      equip = <String>['bodyweight'];
    }
    return ExerciseInfo(
      id: id,
      name: name,
      equipment: equip,
      regions: lists['region']!,
      patterns: lists['pattern']!,
      primary: lists['primary']!,
      missing: miss,
      variable: variable,
    );
  }
}

class ParsedExercises(
  final List<ExerciseInfo> exercises,
  final List<String> declared,
  final List<String> registered,
);

ParsedExercises parseExercises(List<String> lines) {
  final RegExp reDecl = RegExp(
    r'static final (_[A-Za-z0-9_]+) = (Exercise|_movement)\(',
  );
  final RegExp reAllStart = RegExp(r'get all => \[');
  final RegExp reAllEnd = RegExp(r'^  \];');
  final RegExp reAllEntry = RegExp(r'^[ \t]*(_[A-Za-z0-9_]+),');
  final RegExp reTok = RegExp(
    r'(EquipmentType|BodyRegion|MovementPattern|MuscleGroup)\.([A-Za-z0-9_]+)',
  );
  final RegExp reIdKey = RegExp('(^|[^A-Za-z0-9_])id:');
  final RegExp reNameKey = RegExp(r'^[ \t]*name:');
  final RegExp reRegion = RegExp(r'^[ \t]*(bodyRegions|regions):');
  final RegExp rePattern = RegExp(r'^[ \t]*(movementPatterns|patterns):');
  final RegExp rePrimary = RegExp(r'^[ \t]*(primaryMuscles|primary):');
  final RegExp reEquip = RegExp(r'^[ \t]*(requiredEquipment|equipment):');
  final RegExp reSetup = RegExp(r'^[ \t]*(setupInstructions|setup):');
  final RegExp reExec = RegExp(
    r'^[ \t]*(executionInstructions:|execution:[ \t]*(const[ \t]*)?\[)',
  );
  final RegExp reCues = RegExp(r'^[ \t]*(techniqueCues|cues):');
  final RegExp reBreath = RegExp(r'^[ \t]*(breathingInstructions|breathing):');
  final RegExp reDeclEnd = RegExp(r'^  \);[ \t]*$');

  final List<ExerciseInfo> exercises = <ExerciseInfo>[];
  final List<String> declared = <String>[];
  final List<String> registered = <String>[];
  _ExerciseBuilder? cur;
  String coll = '';
  bool inAll = false;

  void close() {
    final _ExerciseBuilder? c = cur;
    if (c == null) {
      return;
    }
    exercises.add(c.build());
    declared.add(c.variable);
    cur = null;
    coll = '';
  }

  for (final String line in lines) {
    if (reAllStart.hasMatch(line)) {
      inAll = true;
      continue;
    }
    if (inAll) {
      if (reAllEnd.hasMatch(line)) {
        inAll = false;
        continue;
      }
      final RegExpMatch? em = reAllEntry.firstMatch(line);
      if (em != null) {
        registered.add(em.group(1)!);
      }
      continue;
    }
    final RegExpMatch? dm = reDecl.firstMatch(line);
    if (dm != null) {
      close();
      cur = _ExerciseBuilder(dm.group(1)!, dm.group(2) == '_movement');
      coll = '';
      continue;
    }
    final _ExerciseBuilder? c = cur;
    if (c == null) {
      continue;
    }

    if (c.id.isEmpty && reIdKey.hasMatch(line)) {
      c.id = getQuoted(line, 'id');
    }
    if (c.name.isEmpty && reNameKey.hasMatch(line)) {
      c.name = getQuoted(line, 'name');
    }

    String k = '';
    if (reRegion.hasMatch(line)) {
      k = 'region';
    } else if (rePattern.hasMatch(line)) {
      k = 'pattern';
    } else if (rePrimary.hasMatch(line)) {
      k = 'primary';
    } else if (reEquip.hasMatch(line)) {
      k = 'equip';
      c.hasEquip = true;
    }
    if (k.isNotEmpty) {
      coll = k;
    }
    if (coll.isNotEmpty) {
      for (final RegExpMatch tm in reTok.allMatches(line)) {
        c.lists[coll]!.add(tm.group(2)!);
      }
      if (line.contains(']')) {
        coll = '';
      }
    }

    if (reSetup.hasMatch(line)) {
      c.hasSetup = true;
    }
    if (reExec.hasMatch(line)) {
      c.hasExec = true;
    }
    if (reCues.hasMatch(line)) {
      c.hasCues = true;
    }
    if (reBreath.hasMatch(line)) {
      c.hasBreath = true;
    }

    if (reDeclEnd.hasMatch(line)) {
      close();
    }
  }
  close();
  return ParsedExercises(exercises, declared, registered);
}

// ---------------------------------------------------------------------------
// Template seed file parsing
// ---------------------------------------------------------------------------
class TemplateInfo({
  required final int index,
  required final String variable,
  required final String id,
  required final String name,
  required final String currentRevision,
  required final String revisionId,
  required final String revisionTemplateId,
  required final int blocks,
  required final int items,
  required final int sets,
  required final int uniqueExercises,
});

class RefInfo(final int index, final String template, final String exerciseId);

class NestedId(final String kind, final String id);

class ZeroSet(final int index, final String template);

class _TemplateBuilder(final int index, final String variable) {
  String id = '';
  String name = '';
  String currentRevision = '';
  String revisionId = '';
  String revisionTemplateId = '';
  String state = '';
  int blocks = 0;
  int items = 0;
  int sets = 0;
  final Set<String> seen = <String>{};

  TemplateInfo build() {
    return TemplateInfo(
      index: index,
      variable: variable,
      id: id,
      name: name,
      currentRevision: currentRevision,
      revisionId: revisionId,
      revisionTemplateId: revisionTemplateId,
      blocks: blocks,
      items: items,
      sets: sets,
      uniqueExercises: seen.length,
    );
  }
}

class ParsedTemplates(
  final List<TemplateInfo> templates,
  final List<RefInfo> refs,
  final List<NestedId> nested,
  final List<ZeroSet> zero,
  final List<String> declared,
  final List<String> registered,
);

ParsedTemplates parseTemplates(List<String> lines) {
  final RegExp reDecl = RegExp(
    r'static final (_[A-Za-z0-9_]+) = TemplateSeedBundle\(',
  );
  final RegExp reAllStart = RegExp(r'get all => \[');
  final RegExp reAllEnd = RegExp(r'^  \];');
  final RegExp reAllEntry = RegExp(r'^[ \t]*(_[A-Za-z0-9_]+),');
  final RegExp reRevision = RegExp(r'WorkoutTemplateRevision\(');
  final RegExp reTemplate = RegExp(r'WorkoutTemplate\(');
  final RegExp reBlock = RegExp(r'WorkoutBlock\(');
  final RegExp reItem = RegExp(r'TemplateItem\(');
  final RegExp reSet = RegExp(r'TargetSet\(');
  final RegExp reNested = RegExp(
    r'id:[ \t]*\x27((block|item|ts)-[^\x27]*)\x27',
  );
  final RegExp reZero = RegExp(r'targetReps:[ \t]*0([^0-9.]|$)');
  final RegExp reDeclEnd = RegExp(r'^  \);[ \t]*$');

  final List<TemplateInfo> templates = <TemplateInfo>[];
  final List<RefInfo> refs = <RefInfo>[];
  final List<NestedId> nested = <NestedId>[];
  final List<ZeroSet> zero = <ZeroSet>[];
  final List<String> declared = <String>[];
  final List<String> registered = <String>[];
  _TemplateBuilder? cur;
  int count = 0;
  bool inAll = false;

  void close() {
    final _TemplateBuilder? c = cur;
    if (c == null) {
      return;
    }
    templates.add(c.build());
    declared.add(c.variable);
    cur = null;
  }

  for (final String line in lines) {
    if (reAllStart.hasMatch(line)) {
      inAll = true;
      continue;
    }
    if (inAll) {
      if (reAllEnd.hasMatch(line)) {
        inAll = false;
        continue;
      }
      final RegExpMatch? em = reAllEntry.firstMatch(line);
      if (em != null) {
        registered.add(em.group(1)!);
      }
      continue;
    }
    final RegExpMatch? dm = reDecl.firstMatch(line);
    if (dm != null) {
      close();
      count++;
      cur = _TemplateBuilder(count, dm.group(1)!);
      continue;
    }
    final _TemplateBuilder? c = cur;
    if (c == null) {
      continue;
    }

    if (reRevision.hasMatch(line)) {
      c.state = 'rev';
    } else if (reTemplate.hasMatch(line)) {
      c.state = 'tpl';
    }
    if (reBlock.hasMatch(line)) {
      c.state = 'blk';
    }
    if (c.state == 'tpl') {
      if (c.id.isEmpty) {
        c.id = getQuoted(line, 'id');
      }
      if (c.name.isEmpty) {
        c.name = getQuoted(line, 'name');
      }
      if (c.currentRevision.isEmpty) {
        c.currentRevision = getQuoted(line, 'currentRevisionId');
      }
    } else if (c.state == 'rev') {
      if (c.revisionId.isEmpty) {
        c.revisionId = getQuoted(line, 'id');
      }
      if (c.revisionTemplateId.isEmpty) {
        c.revisionTemplateId = getQuoted(line, 'templateId');
      }
    }

    c.blocks += countMatches(reBlock, line);
    c.items += countMatches(reItem, line);
    c.sets += countMatches(reSet, line);

    for (final RegExpMatch nm in reNested.allMatches(line)) {
      nested.add(NestedId(nm.group(2)!, nm.group(1)!));
    }

    final String ex = getQuoted(line, 'exerciseId');
    if (ex.isNotEmpty) {
      refs.add(RefInfo(c.index, c.name, ex));
      c.seen.add(ex);
    }
    if (reZero.hasMatch(line)) {
      zero.add(ZeroSet(c.index, c.name));
    }

    if (reDeclEnd.hasMatch(line)) {
      close();
    }
  }
  close();
  return ParsedTemplates(templates, refs, nested, zero, declared, registered);
}

// ---------------------------------------------------------------------------
// Main logic
// ---------------------------------------------------------------------------
int _run(List<String> arguments) {
  final Options opts = parseArgs(arguments);
  if (opts.help) {
    stdout.writeln(kUsage);
    return 0;
  }
  if (opts.unknown != null) {
    stdout.writeln('[ERROR] Unknown option: ${opts.unknown}');
    stdout.writeln(kUsage);
    return 2;
  }

  String exercisePath = opts.exercisePath ?? kDefaultExerciseFile;
  String templatePath = opts.templatePath ?? kDefaultTemplateFile;
  if (!File(exercisePath).existsSync() && opts.exercisePath == null) {
    final String? found = findSeed('exercise_seed_data.dart');
    if (found != null) {
      exercisePath = found;
    }
  }
  if (!File(templatePath).existsSync() && opts.templatePath == null) {
    final String? found = findSeed('workout_template_seed_data.dart');
    if (found != null) {
      templatePath = found;
    }
  }
  final bool exerciseFound = File(exercisePath).existsSync();
  final bool templateFound = File(templatePath).existsSync();
  if (!exerciseFound || !templateFound) {
    final String exStatus = exerciseFound ? '(found)' : '(NOT FOUND)';
    final String tpStatus = templateFound ? '(found)' : '(NOT FOUND)';
    stdout.writeln('[ERROR] Could not find input files.');
    stdout.writeln(
      '        Exercise file: ${displayPath(exercisePath)} $exStatus',
    );
    stdout.writeln(
      '        Template file: ${displayPath(templatePath)} $tpStatus',
    );
    stdout.writeln(
      'Usage: validateTemplates [exercise_file] [template_file] [--strict] [--show-all] [--no-color]',
    );
    return 2;
  }

  // Colours: only on a real terminal that supports ANSI, and only when enabled.
  bool useColor = false;
  try {
    useColor =
        !opts.noColor &&
        (Platform.environment['NO_COLOR'] ?? '').isEmpty &&
        stdout.hasTerminal &&
        stdout.supportsAnsiEscapes;
  } catch (_) {
    useColor = false;
  }
  String paint(String code, String text) =>
      useColor ? '\u001B[${code}m$text\u001B[0m' : text;
  String cyan(String t) => paint('36', t);
  String red(String t) => paint('31', t);
  String green(String t) => paint('32', t);

  final ParsedExercises exData = parseExercises(readLines(exercisePath));
  final ParsedTemplates tpData = parseTemplates(readLines(templatePath));
  final List<ExerciseInfo> exercises = exData.exercises;
  final List<TemplateInfo> templates = tpData.templates;
  final List<RefInfo> refs = tpData.refs;

  if (exercises.isEmpty) {
    stdout.writeln(
      '[ERROR] No exercise definitions were found in: ${displayPath(exercisePath)}',
    );
    return 2;
  }
  if (templates.isEmpty) {
    stdout.writeln(
      '[ERROR] No template definitions were found in: ${displayPath(templatePath)}',
    );
    return 2;
  }

  // ---- Core analysis ------------------------------------------------------
  final Set<String> defSet = exercises
      .map((ExerciseInfo e) => e.id)
      .where((String s) => s.isNotEmpty)
      .toSet();
  final Set<String> usedSet = refs.map((RefInfo r) => r.exerciseId).toSet();
  final List<String> defIds = defSet.toList()..sort();
  final List<String> usedIds = usedSet.toList()..sort();
  final List<String> missingIds = usedIds
      .where((String id) => !defSet.contains(id))
      .toList();
  final List<String> orphanIds = defIds
      .where((String id) => !usedSet.contains(id))
      .toList();

  final int exRows = exercises.length;
  final int defCount = defIds.length;
  final int usedCount = usedIds.length;
  final int missingCount = missingIds.length;
  final int orphanCount = orphanIds.length;
  final int tplCount = templates.length;
  final int missingRefs = refs
      .where((RefInfo r) => !defSet.contains(r.exerciseId))
      .length;
  int blocks = 0;
  int items = 0;
  int sets = 0;
  for (final TemplateInfo t in templates) {
    blocks += t.blocks;
    items += t.items;
    sets += t.sets;
  }

  // ---- Integrity issues (Issue, Value, Detail) ---------------------------
  final List<List<String>> issues = <List<String>>[];
  int dupGroupsOf(String label, Iterable<String> values) {
    final List<MapEntry<String, int>> groups = duplicateGroups(values);
    for (final MapEntry<String, int> g in groups) {
      issues.add(<String>[label, g.key, '${g.value} occurrences']);
    }
    return groups.length;
  }

  final int dupExId = dupGroupsOf(
    'Exercise ID',
    exercises.map((ExerciseInfo e) => e.id),
  );
  final int dupExName = dupGroupsOf(
    'Exercise name',
    exercises.map((ExerciseInfo e) => e.name),
  );
  final int dupTplId = dupGroupsOf(
    'Template ID',
    templates.map((TemplateInfo t) => t.id),
  );
  final int dupTplName = dupGroupsOf(
    'Template name',
    templates.map((TemplateInfo t) => t.name),
  );
  final int dupRev = dupGroupsOf(
    'Revision ID',
    templates.map((TemplateInfo t) => t.revisionId),
  );
  int dupNested = 0;
  for (final String kind in <String>['block', 'item', 'ts']) {
    dupNested += dupGroupsOf(
      'Nested ID ($kind)',
      tpData.nested
          .where((NestedId n) => n.kind == kind)
          .map((NestedId n) => n.id),
    );
  }
  final int dupVars = dupGroupsOf('Static variable', <String>[
    ...exData.declared,
    ...tpData.declared,
  ]);

  final int revMismatch = templates
      .where(
        (TemplateInfo t) =>
            t.currentRevision != t.revisionId || t.id != t.revisionTemplateId,
      )
      .length;

  final List<String> exUnreg = multisetDiff(exData.declared, exData.registered);
  final List<String> exUndecl = multisetDiff(
    exData.registered,
    exData.declared,
  );
  final List<String> tpUnreg = multisetDiff(tpData.declared, tpData.registered);
  final List<String> tpUndecl = multisetDiff(
    tpData.registered,
    tpData.declared,
  );
  for (final String v in exUnreg) {
    issues.add(<String>[
      'Exercise not in all[]',
      v,
      'declared but never registered',
    ]);
  }
  for (final String v in exUndecl) {
    issues.add(<String>[
      'Exercise all[] entry',
      v,
      'registered but not declared',
    ]);
  }
  for (final String v in tpUnreg) {
    issues.add(<String>[
      'Template not in all[]',
      v,
      'declared but never registered',
    ]);
  }
  for (final String v in tpUndecl) {
    issues.add(<String>[
      'Template all[] entry',
      v,
      'registered but not declared',
    ]);
  }

  final List<ExerciseInfo> incomplete = exercises
      .where((ExerciseInfo e) => e.missing.isNotEmpty)
      .toList();
  final int incompleteCount = incomplete.length;
  final int zeroSets = tpData.zero.length;

  // ---- Validation checks --------------------------------------------------
  int errors = 0;
  int warnings = 0;
  final List<List<String>> checks = <List<String>>[
    <String>['Check', 'Type', 'Result', 'Count', 'Details'],
  ];
  void addCheck(
    String name,
    String type,
    int count,
    String failDetail,
    String okDetail,
  ) {
    String result = 'PASS';
    String detail = okDetail;
    if (count > 0) {
      detail = failDetail;
      if (type == 'ERROR') {
        result = 'FAIL';
        errors++;
      } else if (type == 'WARN') {
        result = 'WARN';
        warnings++;
      } else {
        result = 'INFO';
      }
    }
    checks.add(<String>[name, type, result, '$count', detail]);
  }

  addCheck(
    'Template exercise refs exist in catalog',
    'ERROR',
    missingCount,
    '$missingCount missing ID(s) across $missingRefs reference(s)',
    'All $usedCount referenced IDs resolve',
  );
  addCheck(
    'Exercise IDs unique',
    'ERROR',
    dupExId,
    'Duplicate exercise IDs found',
    'No duplicates',
  );
  addCheck(
    'Exercise definitions registered in all[]',
    'ERROR',
    exUnreg.length + exUndecl.length,
    '${exUnreg.length} unregistered, ${exUndecl.length} undeclared',
    '$exRows declared = registered',
  );
  addCheck(
    'Template IDs unique',
    'ERROR',
    dupTplId,
    'Duplicate template IDs found',
    'No duplicates',
  );
  addCheck(
    'Revision IDs unique and consistent',
    'ERROR',
    dupRev + revMismatch,
    '$dupRev duplicate, $revMismatch inconsistent',
    'Revision links are consistent',
  );
  addCheck(
    'Block/item/set IDs unique',
    'ERROR',
    dupNested,
    'Duplicate nested IDs found',
    'No duplicates',
  );
  addCheck(
    'Template definitions registered in all[]',
    'ERROR',
    tpUnreg.length + tpUndecl.length,
    '${tpUnreg.length} unregistered, ${tpUndecl.length} undeclared',
    '$tplCount declared = registered',
  );
  addCheck(
    'Static variable names unique',
    'ERROR',
    dupVars,
    'Duplicate declarations (compile error)',
    'No duplicates',
  );
  addCheck(
    'Template names unique',
    'WARN',
    dupTplName,
    'Duplicate template names found',
    'No duplicates',
  );
  addCheck(
    'Exercise names unique',
    'WARN',
    dupExName,
    'Duplicate exercise names found',
    'No duplicates',
  );
  addCheck(
    'Exercises used by templates',
    'INFO',
    orphanCount,
    '$orphanCount selectable catalog exercise(s) are not in a seeded template',
    'Every catalog exercise appears in a seeded template',
  );
  addCheck(
    'Exercise execution profiles complete',
    'WARN',
    incompleteCount,
    '$incompleteCount exercise(s) missing setup/execution/cues/breathing',
    'All profiles complete',
  );
  addCheck(
    'Sets with targetReps: 0',
    'WARN',
    zeroSets,
    '$zeroSets set(s) have a zero rep target',
    'None found',
  );

  // ---- Output -------------------------------------------------------------
  final String banner = '=' * 72;
  final StringBuffer out = StringBuffer();
  out.writeln(cyan(banner));
  out.writeln(cyan(' EXERCISE & TEMPLATE VALIDATION SUMMARY'));
  out.writeln(cyan(banner));
  out.writeln(' Exercise file : ${displayPath(exercisePath)}');
  out.writeln(' Template file : ${displayPath(templatePath)}');

  out.write(renderTable('VALIDATION CHECKS', checks, 'lllrl', 60));

  out.write(
    renderTable(
      'DATA OVERVIEW',
      <List<String>>[
        <String>['Metric', 'Count', 'Details'],
        <String>[
          'Exercises defined (catalog)',
          '$defCount',
          'Unique IDs in exercise seed data',
        ],
        <String>[
          'Exercises referenced (distinct)',
          '$usedCount',
          'Unique IDs used across workout templates',
        ],
        <String>[
          'Missing exercises',
          '$missingCount',
          if (missingCount > 0)
            'Action required: referenced but not in catalog'
          else
            'All referenced exercises exist',
        ],
        <String>[
          'Orphan exercises',
          '$orphanCount',
          'Defined in catalog but not used by any template',
        ],
        <String>[
          'Workout templates',
          '$tplCount',
          'Template bundles in template seed data',
        ],
        <String>['Workout blocks', '$blocks', 'Across all templates'],
        <String>[
          'Exercise slots (items)',
          '$items',
          'Total exercise references, including repeats',
        ],
        <String>['Target sets', '$sets', 'Across all templates'],
      ],
      'lrl',
      60,
    ),
  );

  // Category breakdowns: Category | Exercises | Used | Unused
  void categoryTable(
    String title,
    String label,
    List<String> Function(ExerciseInfo) pick,
  ) {
    final Map<String, int> total = <String, int>{};
    final Map<String, int> usedCounts = <String, int>{};
    for (final ExerciseInfo e in exercises) {
      final List<String> tokens = pick(e).isEmpty ? <String>['-'] : pick(e);
      for (final String t in tokens) {
        total[t] = (total[t] ?? 0) + 1;
        if (usedSet.contains(e.id)) {
          usedCounts[t] = (usedCounts[t] ?? 0) + 1;
        }
      }
    }
    final List<String> names = total.keys.toList();
    names.sort((String a, String b) {
      final int c = total[b]!.compareTo(total[a]!);
      return c != 0 ? c : a.compareTo(b);
    });
    final List<List<String>> rows = <List<String>>[
      <String>[label, 'Exercises', 'Used', 'Unused'],
    ];
    for (final String n in names) {
      final int u = usedCounts[n] ?? 0;
      rows.add(<String>[n, '${total[n]}', '$u', '${total[n]! - u}']);
    }
    out.write(renderTable(title, rows, 'lrrr', 40));
  }

  categoryTable(
    'EXERCISE CATALOG BY EQUIPMENT (an exercise counts once per equipment type)',
    'Equipment',
    (ExerciseInfo e) => e.equipment,
  );
  categoryTable(
    'EXERCISE CATALOG BY BODY REGION',
    'Body Region',
    (ExerciseInfo e) => e.regions,
  );
  categoryTable(
    'EXERCISE CATALOG BY MOVEMENT PATTERN',
    'Movement Pattern',
    (ExerciseInfo e) => e.patterns,
  );
  categoryTable(
    'EXERCISE CATALOG BY PRIMARY MUSCLE',
    'Primary Muscle',
    (ExerciseInfo e) => e.primary,
  );

  // Template summary
  final Map<int, int> missingPerTemplate = <int, int>{};
  for (final RefInfo r in refs) {
    if (!defSet.contains(r.exerciseId)) {
      missingPerTemplate[r.index] = (missingPerTemplate[r.index] ?? 0) + 1;
    }
  }
  final List<List<String>> tplRows = <List<String>>[
    <String>['#', 'Template', 'Blocks', 'Items', 'Sets', 'Unique Ex', 'Refs'],
  ];
  for (final TemplateInfo t in templates) {
    final int m = missingPerTemplate[t.index] ?? 0;
    tplRows.add(<String>[
      '${t.index}',
      t.name,
      '${t.blocks}',
      '${t.items}',
      '${t.sets}',
      '${t.uniqueExercises}',
      if (m > 0) '$m missing' else 'OK',
    ]);
  }
  out.write(renderTable('WORKOUT TEMPLATES', tplRows, 'rlrrrrl', 46));

  // Missing exercises with closest-match suggestions
  if (missingCount > 0) {
    final List<List<String>> missRows = <List<String>>[];
    for (final String id in missingIds) {
      final List<RefInfo> refList = refs
          .where((RefInfo r) => r.exerciseId == id)
          .toList();
      final List<String> names = <String>[];
      for (final RefInfo r in refList) {
        if (!names.contains(r.template)) {
          names.add(r.template);
        }
      }
      String shown = names.take(2).join('; ');
      if (names.length > 2) {
        shown = '$shown (+${names.length - 2} more)';
      }

      final List<String> mt = tokensOf(id);
      int bestShared = 0;
      int bestUnion = 1;
      String best = '';
      for (final ExerciseInfo d in exercises) {
        final List<String> dt = tokensOf(d.id);
        int shared = 0;
        for (final String a in mt) {
          if (dt.contains(a)) {
            shared++;
          }
        }
        final int union = mt.length + dt.length - shared;
        if (union > 0 && shared * bestUnion > bestShared * union) {
          bestShared = shared;
          bestUnion = union;
          best = d.id;
        }
      }
      if (bestShared == 0 || bestShared * 10 < 4 * bestUnion) {
        best = '-';
      }
      missRows.add(<String>[id, '${refList.length}', shown, best]);
    }
    out.write(
      renderTable(
        'MISSING EXERCISES (referenced by templates, absent from catalog)',
        <List<String>>[
          <String>[
            'Missing Exercise ID',
            'Refs',
            'Referenced By',
            'Closest Catalog Match',
          ],
          ...sortRows(missRows),
        ],
        'lrll',
        56,
      ),
    );
  }

  // Integrity issues
  if (issues.isNotEmpty) {
    out.write(
      renderTable(
        'INTEGRITY ISSUES',
        <List<String>>[
          <String>['Issue', 'Value', 'Detail'],
          ...sortRows(issues),
        ],
        'lll',
        56,
      ),
    );
  }

  // Incomplete execution profiles
  if (incompleteCount > 0) {
    out.write(
      renderTable(
        'INCOMPLETE EXECUTION PROFILES',
        <List<String>>[
          <String>['Exercise ID', 'Missing Fields'],
          ...sortRows(
            incomplete
                .map((ExerciseInfo e) => <String>[e.id, e.missing.join(',')])
                .toList(),
          ),
        ],
        'll',
        56,
      ),
    );
  }

  // Zero-rep sets per template
  if (zeroSets > 0) {
    final Map<String, int> perTemplate = countMap(
      tpData.zero.map((ZeroSet z) => z.template),
    );
    out.write(
      renderTable(
        'SETS WITH ZERO REP TARGET (review)',
        <List<String>>[
          <String>['Template', 'Sets with targetReps: 0'],
          ...sortRows(
            perTemplate.entries
                .map((MapEntry<String, int> e) => <String>[e.key, '${e.value}'])
                .toList(),
          ),
        ],
        'lr',
        56,
      ),
    );
  }

  // Usage per exercise: orphans (default) or everything (--show-all)
  final Map<String, Set<int>> templatesPerExercise = <String, Set<int>>{};
  for (final RefInfo r in refs) {
    templatesPerExercise.putIfAbsent(r.exerciseId, () => <int>{}).add(r.index);
  }
  final List<List<String>> usageRows = sortRows(
    exercises
        .map(
          (ExerciseInfo e) => <String>[
            e.id,
            e.name,
            dash(e.equipment),
            '${templatesPerExercise[e.id]?.length ?? 0}',
          ],
        )
        .toList(),
  );
  const List<String> usageHeader = <String>[
    'Exercise ID',
    'Name',
    'Equipment',
    'Templates',
  ];
  if (opts.showAll) {
    out.write(
      renderTable(
        'EXERCISE USAGE (all exercises)',
        <List<String>>[usageHeader, ...usageRows],
        'lllr',
        44,
      ),
    );
  } else if (orphanCount > 0) {
    const int limit = 25;
    final List<List<String>> orphanRows = usageRows
        .where((List<String> r) => r[3] == '0')
        .take(limit)
        .toList();
    out.write(
      renderTable(
        'ORPHAN EXERCISES (defined, not used in any template)',
        <List<String>>[usageHeader, ...orphanRows],
        'lllr',
        44,
      ),
    );
    if (orphanCount > limit) {
      out.writeln(
        ' ... and ${orphanCount - limit} more (use --show-all to list every exercise)',
      );
    }
  }

  out.writeln();
  out.writeln(cyan(banner));
  final String strictNote = opts.strict
      ? '   (strict mode: warnings fail the run)'
      : '';
  out.writeln(' Errors: $errors   Warnings: $warnings$strictNote');
  out.writeln(cyan(banner));

  // ---- Exit status --------------------------------------------------------
  if (missingCount > 0) {
    out.writeln(
      red(
        'VALIDATION FAILED: The following exercise IDs are missing from the catalog:',
      ),
    );
    for (final String id in missingIds) {
      out.writeln('   - $id');
    }
  }
  int code = 0;
  if (errors > 0 || (opts.strict && warnings > 0)) {
    if (missingCount == 0) {
      final String what = opts.strict ? 'FAIL / WARN' : 'FAIL';
      out.writeln(red('VALIDATION FAILED: see the checks marked $what above.'));
    }
    code = 1;
  } else {
    out.writeln(green('VALIDATION PASSED: Every template reference is valid!'));
  }
  stdout.write(out.toString());
  return code;
}
