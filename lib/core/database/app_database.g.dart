// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $DocumentsTable extends Documents
    with TableInfo<$DocumentsTable, Document> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $DocumentsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _collectionMeta = const VerificationMeta(
    'collection',
  );
  @override
  late final GeneratedColumn<String> collection = GeneratedColumn<String>(
    'collection',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _jsonDataMeta = const VerificationMeta(
    'jsonData',
  );
  @override
  late final GeneratedColumn<String> jsonData = GeneratedColumn<String>(
    'json_data',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _schemaVersionMeta = const VerificationMeta(
    'schemaVersion',
  );
  @override
  late final GeneratedColumn<int> schemaVersion = GeneratedColumn<int>(
    'schema_version',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(1),
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    collection,
    id,
    jsonData,
    schemaVersion,
    createdAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'documents';
  @override
  VerificationContext validateIntegrity(
    Insertable<Document> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('collection')) {
      context.handle(
        _collectionMeta,
        collection.isAcceptableOrUnknown(data['collection']!, _collectionMeta),
      );
    } else if (isInserting) {
      context.missing(_collectionMeta);
    }
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('json_data')) {
      context.handle(
        _jsonDataMeta,
        jsonData.isAcceptableOrUnknown(data['json_data']!, _jsonDataMeta),
      );
    } else if (isInserting) {
      context.missing(_jsonDataMeta);
    }
    if (data.containsKey('schema_version')) {
      context.handle(
        _schemaVersionMeta,
        schemaVersion.isAcceptableOrUnknown(
          data['schema_version']!,
          _schemaVersionMeta,
        ),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {collection, id};
  @override
  Document map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Document(
      collection: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}collection'],
      )!,
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      jsonData: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}json_data'],
      )!,
      schemaVersion: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}schema_version'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $DocumentsTable createAlias(String alias) {
    return $DocumentsTable(attachedDatabase, alias);
  }
}

class Document extends DataClass implements Insertable<Document> {
  /// The collection or namespace (e.g. 'users', 'exercises', 'templates', 'sessions').
  final String collection;

  /// The unique aggregate identifier (UUIDv4 or stable ID).
  final String id;

  /// Complete JSON payload of the aggregate root.
  final String jsonData;

  /// Schema version of the stored JSON document.
  final int schemaVersion;

  /// UTC creation timestamp.
  final DateTime createdAt;

  /// UTC update timestamp.
  final DateTime updatedAt;
  const Document({
    required this.collection,
    required this.id,
    required this.jsonData,
    required this.schemaVersion,
    required this.createdAt,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['collection'] = Variable<String>(collection);
    map['id'] = Variable<String>(id);
    map['json_data'] = Variable<String>(jsonData);
    map['schema_version'] = Variable<int>(schemaVersion);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  DocumentsCompanion toCompanion(bool nullToAbsent) {
    return DocumentsCompanion(
      collection: Value(collection),
      id: Value(id),
      jsonData: Value(jsonData),
      schemaVersion: Value(schemaVersion),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory Document.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Document(
      collection: serializer.fromJson<String>(json['collection']),
      id: serializer.fromJson<String>(json['id']),
      jsonData: serializer.fromJson<String>(json['jsonData']),
      schemaVersion: serializer.fromJson<int>(json['schemaVersion']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'collection': serializer.toJson<String>(collection),
      'id': serializer.toJson<String>(id),
      'jsonData': serializer.toJson<String>(jsonData),
      'schemaVersion': serializer.toJson<int>(schemaVersion),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  Document copyWith({
    String? collection,
    String? id,
    String? jsonData,
    int? schemaVersion,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) => Document(
    collection: collection ?? this.collection,
    id: id ?? this.id,
    jsonData: jsonData ?? this.jsonData,
    schemaVersion: schemaVersion ?? this.schemaVersion,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  Document copyWithCompanion(DocumentsCompanion data) {
    return Document(
      collection: data.collection.present
          ? data.collection.value
          : this.collection,
      id: data.id.present ? data.id.value : this.id,
      jsonData: data.jsonData.present ? data.jsonData.value : this.jsonData,
      schemaVersion: data.schemaVersion.present
          ? data.schemaVersion.value
          : this.schemaVersion,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Document(')
          ..write('collection: $collection, ')
          ..write('id: $id, ')
          ..write('jsonData: $jsonData, ')
          ..write('schemaVersion: $schemaVersion, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    collection,
    id,
    jsonData,
    schemaVersion,
    createdAt,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Document &&
          other.collection == this.collection &&
          other.id == this.id &&
          other.jsonData == this.jsonData &&
          other.schemaVersion == this.schemaVersion &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class DocumentsCompanion extends UpdateCompanion<Document> {
  final Value<String> collection;
  final Value<String> id;
  final Value<String> jsonData;
  final Value<int> schemaVersion;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<int> rowid;
  const DocumentsCompanion({
    this.collection = const Value.absent(),
    this.id = const Value.absent(),
    this.jsonData = const Value.absent(),
    this.schemaVersion = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  DocumentsCompanion.insert({
    required String collection,
    required String id,
    required String jsonData,
    this.schemaVersion = const Value.absent(),
    required DateTime createdAt,
    required DateTime updatedAt,
    this.rowid = const Value.absent(),
  }) : collection = Value(collection),
       id = Value(id),
       jsonData = Value(jsonData),
       createdAt = Value(createdAt),
       updatedAt = Value(updatedAt);
  static Insertable<Document> custom({
    Expression<String>? collection,
    Expression<String>? id,
    Expression<String>? jsonData,
    Expression<int>? schemaVersion,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (collection != null) 'collection': collection,
      if (id != null) 'id': id,
      if (jsonData != null) 'json_data': jsonData,
      if (schemaVersion != null) 'schema_version': schemaVersion,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  DocumentsCompanion copyWith({
    Value<String>? collection,
    Value<String>? id,
    Value<String>? jsonData,
    Value<int>? schemaVersion,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<int>? rowid,
  }) {
    return DocumentsCompanion(
      collection: collection ?? this.collection,
      id: id ?? this.id,
      jsonData: jsonData ?? this.jsonData,
      schemaVersion: schemaVersion ?? this.schemaVersion,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (collection.present) {
      map['collection'] = Variable<String>(collection.value);
    }
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (jsonData.present) {
      map['json_data'] = Variable<String>(jsonData.value);
    }
    if (schemaVersion.present) {
      map['schema_version'] = Variable<int>(schemaVersion.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('DocumentsCompanion(')
          ..write('collection: $collection, ')
          ..write('id: $id, ')
          ..write('jsonData: $jsonData, ')
          ..write('schemaVersion: $schemaVersion, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $DailyWorkoutSummariesTable extends DailyWorkoutSummaries
    with TableInfo<$DailyWorkoutSummariesTable, DailyWorkoutSummaryRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $DailyWorkoutSummariesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _dateMeta = const VerificationMeta('date');
  @override
  late final GeneratedColumn<DateTime> date = GeneratedColumn<DateTime>(
    'date',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _sessionIdMeta = const VerificationMeta(
    'sessionId',
  );
  @override
  late final GeneratedColumn<String> sessionId = GeneratedColumn<String>(
    'session_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _userIdMeta = const VerificationMeta('userId');
  @override
  late final GeneratedColumn<String> userId = GeneratedColumn<String>(
    'user_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _templateNameMeta = const VerificationMeta(
    'templateName',
  );
  @override
  late final GeneratedColumn<String> templateName = GeneratedColumn<String>(
    'template_name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _durationSecondsMeta = const VerificationMeta(
    'durationSeconds',
  );
  @override
  late final GeneratedColumn<int> durationSeconds = GeneratedColumn<int>(
    'duration_seconds',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _activeSecondsMeta = const VerificationMeta(
    'activeSeconds',
  );
  @override
  late final GeneratedColumn<int> activeSeconds = GeneratedColumn<int>(
    'active_seconds',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _volumeLoadKgMeta = const VerificationMeta(
    'volumeLoadKg',
  );
  @override
  late final GeneratedColumn<double> volumeLoadKg = GeneratedColumn<double>(
    'volume_load_kg',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _totalCompletedSetsMeta =
      const VerificationMeta('totalCompletedSets');
  @override
  late final GeneratedColumn<int> totalCompletedSets = GeneratedColumn<int>(
    'total_completed_sets',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _totalCompletedRepsMeta =
      const VerificationMeta('totalCompletedReps');
  @override
  late final GeneratedColumn<int> totalCompletedReps = GeneratedColumn<int>(
    'total_completed_reps',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _averageRpeMeta = const VerificationMeta(
    'averageRpe',
  );
  @override
  late final GeneratedColumn<double> averageRpe = GeneratedColumn<double>(
    'average_rpe',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    date,
    sessionId,
    userId,
    templateName,
    durationSeconds,
    activeSeconds,
    volumeLoadKg,
    totalCompletedSets,
    totalCompletedReps,
    averageRpe,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'daily_workout_summaries';
  @override
  VerificationContext validateIntegrity(
    Insertable<DailyWorkoutSummaryRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('date')) {
      context.handle(
        _dateMeta,
        date.isAcceptableOrUnknown(data['date']!, _dateMeta),
      );
    } else if (isInserting) {
      context.missing(_dateMeta);
    }
    if (data.containsKey('session_id')) {
      context.handle(
        _sessionIdMeta,
        sessionId.isAcceptableOrUnknown(data['session_id']!, _sessionIdMeta),
      );
    } else if (isInserting) {
      context.missing(_sessionIdMeta);
    }
    if (data.containsKey('user_id')) {
      context.handle(
        _userIdMeta,
        userId.isAcceptableOrUnknown(data['user_id']!, _userIdMeta),
      );
    } else if (isInserting) {
      context.missing(_userIdMeta);
    }
    if (data.containsKey('template_name')) {
      context.handle(
        _templateNameMeta,
        templateName.isAcceptableOrUnknown(
          data['template_name']!,
          _templateNameMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_templateNameMeta);
    }
    if (data.containsKey('duration_seconds')) {
      context.handle(
        _durationSecondsMeta,
        durationSeconds.isAcceptableOrUnknown(
          data['duration_seconds']!,
          _durationSecondsMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_durationSecondsMeta);
    }
    if (data.containsKey('active_seconds')) {
      context.handle(
        _activeSecondsMeta,
        activeSeconds.isAcceptableOrUnknown(
          data['active_seconds']!,
          _activeSecondsMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_activeSecondsMeta);
    }
    if (data.containsKey('volume_load_kg')) {
      context.handle(
        _volumeLoadKgMeta,
        volumeLoadKg.isAcceptableOrUnknown(
          data['volume_load_kg']!,
          _volumeLoadKgMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_volumeLoadKgMeta);
    }
    if (data.containsKey('total_completed_sets')) {
      context.handle(
        _totalCompletedSetsMeta,
        totalCompletedSets.isAcceptableOrUnknown(
          data['total_completed_sets']!,
          _totalCompletedSetsMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_totalCompletedSetsMeta);
    }
    if (data.containsKey('total_completed_reps')) {
      context.handle(
        _totalCompletedRepsMeta,
        totalCompletedReps.isAcceptableOrUnknown(
          data['total_completed_reps']!,
          _totalCompletedRepsMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_totalCompletedRepsMeta);
    }
    if (data.containsKey('average_rpe')) {
      context.handle(
        _averageRpeMeta,
        averageRpe.isAcceptableOrUnknown(data['average_rpe']!, _averageRpeMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  DailyWorkoutSummaryRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return DailyWorkoutSummaryRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      date: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}date'],
      )!,
      sessionId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}session_id'],
      )!,
      userId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}user_id'],
      )!,
      templateName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}template_name'],
      )!,
      durationSeconds: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}duration_seconds'],
      )!,
      activeSeconds: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}active_seconds'],
      )!,
      volumeLoadKg: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}volume_load_kg'],
      )!,
      totalCompletedSets: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}total_completed_sets'],
      )!,
      totalCompletedReps: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}total_completed_reps'],
      )!,
      averageRpe: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}average_rpe'],
      ),
    );
  }

  @override
  $DailyWorkoutSummariesTable createAlias(String alias) {
    return $DailyWorkoutSummariesTable(attachedDatabase, alias);
  }
}

class DailyWorkoutSummaryRow extends DataClass
    implements Insertable<DailyWorkoutSummaryRow> {
  /// Primary key: composite of sessionId and summary tag.
  final String id;

  /// Session wall-clock date, normalized to midnight UTC.
  final DateTime date;

  /// Foreign reference to the source WorkoutSession ID.
  final String sessionId;

  /// ID of the user who performed the session.
  final String userId;

  /// Template name for display purposes.
  final String templateName;

  /// Total wall-clock elapsed seconds.
  final int durationSeconds;

  /// Total active training seconds (wall-clock minus interruptions).
  final int activeSeconds;

  /// Total volume load in kg (sum of weightKg * reps over all completed sets).
  final double volumeLoadKg;

  /// Total number of completed sets.
  final int totalCompletedSets;

  /// Total number of completed reps.
  final int totalCompletedReps;

  /// Average RPE across all sets that recorded one, or null if none did.
  final double? averageRpe;
  const DailyWorkoutSummaryRow({
    required this.id,
    required this.date,
    required this.sessionId,
    required this.userId,
    required this.templateName,
    required this.durationSeconds,
    required this.activeSeconds,
    required this.volumeLoadKg,
    required this.totalCompletedSets,
    required this.totalCompletedReps,
    this.averageRpe,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['date'] = Variable<DateTime>(date);
    map['session_id'] = Variable<String>(sessionId);
    map['user_id'] = Variable<String>(userId);
    map['template_name'] = Variable<String>(templateName);
    map['duration_seconds'] = Variable<int>(durationSeconds);
    map['active_seconds'] = Variable<int>(activeSeconds);
    map['volume_load_kg'] = Variable<double>(volumeLoadKg);
    map['total_completed_sets'] = Variable<int>(totalCompletedSets);
    map['total_completed_reps'] = Variable<int>(totalCompletedReps);
    if (!nullToAbsent || averageRpe != null) {
      map['average_rpe'] = Variable<double>(averageRpe);
    }
    return map;
  }

  DailyWorkoutSummariesCompanion toCompanion(bool nullToAbsent) {
    return DailyWorkoutSummariesCompanion(
      id: Value(id),
      date: Value(date),
      sessionId: Value(sessionId),
      userId: Value(userId),
      templateName: Value(templateName),
      durationSeconds: Value(durationSeconds),
      activeSeconds: Value(activeSeconds),
      volumeLoadKg: Value(volumeLoadKg),
      totalCompletedSets: Value(totalCompletedSets),
      totalCompletedReps: Value(totalCompletedReps),
      averageRpe: averageRpe == null && nullToAbsent
          ? const Value.absent()
          : Value(averageRpe),
    );
  }

  factory DailyWorkoutSummaryRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return DailyWorkoutSummaryRow(
      id: serializer.fromJson<String>(json['id']),
      date: serializer.fromJson<DateTime>(json['date']),
      sessionId: serializer.fromJson<String>(json['sessionId']),
      userId: serializer.fromJson<String>(json['userId']),
      templateName: serializer.fromJson<String>(json['templateName']),
      durationSeconds: serializer.fromJson<int>(json['durationSeconds']),
      activeSeconds: serializer.fromJson<int>(json['activeSeconds']),
      volumeLoadKg: serializer.fromJson<double>(json['volumeLoadKg']),
      totalCompletedSets: serializer.fromJson<int>(json['totalCompletedSets']),
      totalCompletedReps: serializer.fromJson<int>(json['totalCompletedReps']),
      averageRpe: serializer.fromJson<double?>(json['averageRpe']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'date': serializer.toJson<DateTime>(date),
      'sessionId': serializer.toJson<String>(sessionId),
      'userId': serializer.toJson<String>(userId),
      'templateName': serializer.toJson<String>(templateName),
      'durationSeconds': serializer.toJson<int>(durationSeconds),
      'activeSeconds': serializer.toJson<int>(activeSeconds),
      'volumeLoadKg': serializer.toJson<double>(volumeLoadKg),
      'totalCompletedSets': serializer.toJson<int>(totalCompletedSets),
      'totalCompletedReps': serializer.toJson<int>(totalCompletedReps),
      'averageRpe': serializer.toJson<double?>(averageRpe),
    };
  }

  DailyWorkoutSummaryRow copyWith({
    String? id,
    DateTime? date,
    String? sessionId,
    String? userId,
    String? templateName,
    int? durationSeconds,
    int? activeSeconds,
    double? volumeLoadKg,
    int? totalCompletedSets,
    int? totalCompletedReps,
    Value<double?> averageRpe = const Value.absent(),
  }) => DailyWorkoutSummaryRow(
    id: id ?? this.id,
    date: date ?? this.date,
    sessionId: sessionId ?? this.sessionId,
    userId: userId ?? this.userId,
    templateName: templateName ?? this.templateName,
    durationSeconds: durationSeconds ?? this.durationSeconds,
    activeSeconds: activeSeconds ?? this.activeSeconds,
    volumeLoadKg: volumeLoadKg ?? this.volumeLoadKg,
    totalCompletedSets: totalCompletedSets ?? this.totalCompletedSets,
    totalCompletedReps: totalCompletedReps ?? this.totalCompletedReps,
    averageRpe: averageRpe.present ? averageRpe.value : this.averageRpe,
  );
  DailyWorkoutSummaryRow copyWithCompanion(
    DailyWorkoutSummariesCompanion data,
  ) {
    return DailyWorkoutSummaryRow(
      id: data.id.present ? data.id.value : this.id,
      date: data.date.present ? data.date.value : this.date,
      sessionId: data.sessionId.present ? data.sessionId.value : this.sessionId,
      userId: data.userId.present ? data.userId.value : this.userId,
      templateName: data.templateName.present
          ? data.templateName.value
          : this.templateName,
      durationSeconds: data.durationSeconds.present
          ? data.durationSeconds.value
          : this.durationSeconds,
      activeSeconds: data.activeSeconds.present
          ? data.activeSeconds.value
          : this.activeSeconds,
      volumeLoadKg: data.volumeLoadKg.present
          ? data.volumeLoadKg.value
          : this.volumeLoadKg,
      totalCompletedSets: data.totalCompletedSets.present
          ? data.totalCompletedSets.value
          : this.totalCompletedSets,
      totalCompletedReps: data.totalCompletedReps.present
          ? data.totalCompletedReps.value
          : this.totalCompletedReps,
      averageRpe: data.averageRpe.present
          ? data.averageRpe.value
          : this.averageRpe,
    );
  }

  @override
  String toString() {
    return (StringBuffer('DailyWorkoutSummaryRow(')
          ..write('id: $id, ')
          ..write('date: $date, ')
          ..write('sessionId: $sessionId, ')
          ..write('userId: $userId, ')
          ..write('templateName: $templateName, ')
          ..write('durationSeconds: $durationSeconds, ')
          ..write('activeSeconds: $activeSeconds, ')
          ..write('volumeLoadKg: $volumeLoadKg, ')
          ..write('totalCompletedSets: $totalCompletedSets, ')
          ..write('totalCompletedReps: $totalCompletedReps, ')
          ..write('averageRpe: $averageRpe')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    date,
    sessionId,
    userId,
    templateName,
    durationSeconds,
    activeSeconds,
    volumeLoadKg,
    totalCompletedSets,
    totalCompletedReps,
    averageRpe,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is DailyWorkoutSummaryRow &&
          other.id == this.id &&
          other.date == this.date &&
          other.sessionId == this.sessionId &&
          other.userId == this.userId &&
          other.templateName == this.templateName &&
          other.durationSeconds == this.durationSeconds &&
          other.activeSeconds == this.activeSeconds &&
          other.volumeLoadKg == this.volumeLoadKg &&
          other.totalCompletedSets == this.totalCompletedSets &&
          other.totalCompletedReps == this.totalCompletedReps &&
          other.averageRpe == this.averageRpe);
}

class DailyWorkoutSummariesCompanion
    extends UpdateCompanion<DailyWorkoutSummaryRow> {
  final Value<String> id;
  final Value<DateTime> date;
  final Value<String> sessionId;
  final Value<String> userId;
  final Value<String> templateName;
  final Value<int> durationSeconds;
  final Value<int> activeSeconds;
  final Value<double> volumeLoadKg;
  final Value<int> totalCompletedSets;
  final Value<int> totalCompletedReps;
  final Value<double?> averageRpe;
  final Value<int> rowid;
  const DailyWorkoutSummariesCompanion({
    this.id = const Value.absent(),
    this.date = const Value.absent(),
    this.sessionId = const Value.absent(),
    this.userId = const Value.absent(),
    this.templateName = const Value.absent(),
    this.durationSeconds = const Value.absent(),
    this.activeSeconds = const Value.absent(),
    this.volumeLoadKg = const Value.absent(),
    this.totalCompletedSets = const Value.absent(),
    this.totalCompletedReps = const Value.absent(),
    this.averageRpe = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  DailyWorkoutSummariesCompanion.insert({
    required String id,
    required DateTime date,
    required String sessionId,
    required String userId,
    required String templateName,
    required int durationSeconds,
    required int activeSeconds,
    required double volumeLoadKg,
    required int totalCompletedSets,
    required int totalCompletedReps,
    this.averageRpe = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       date = Value(date),
       sessionId = Value(sessionId),
       userId = Value(userId),
       templateName = Value(templateName),
       durationSeconds = Value(durationSeconds),
       activeSeconds = Value(activeSeconds),
       volumeLoadKg = Value(volumeLoadKg),
       totalCompletedSets = Value(totalCompletedSets),
       totalCompletedReps = Value(totalCompletedReps);
  static Insertable<DailyWorkoutSummaryRow> custom({
    Expression<String>? id,
    Expression<DateTime>? date,
    Expression<String>? sessionId,
    Expression<String>? userId,
    Expression<String>? templateName,
    Expression<int>? durationSeconds,
    Expression<int>? activeSeconds,
    Expression<double>? volumeLoadKg,
    Expression<int>? totalCompletedSets,
    Expression<int>? totalCompletedReps,
    Expression<double>? averageRpe,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (date != null) 'date': date,
      if (sessionId != null) 'session_id': sessionId,
      if (userId != null) 'user_id': userId,
      if (templateName != null) 'template_name': templateName,
      if (durationSeconds != null) 'duration_seconds': durationSeconds,
      if (activeSeconds != null) 'active_seconds': activeSeconds,
      if (volumeLoadKg != null) 'volume_load_kg': volumeLoadKg,
      if (totalCompletedSets != null)
        'total_completed_sets': totalCompletedSets,
      if (totalCompletedReps != null)
        'total_completed_reps': totalCompletedReps,
      if (averageRpe != null) 'average_rpe': averageRpe,
      if (rowid != null) 'rowid': rowid,
    });
  }

  DailyWorkoutSummariesCompanion copyWith({
    Value<String>? id,
    Value<DateTime>? date,
    Value<String>? sessionId,
    Value<String>? userId,
    Value<String>? templateName,
    Value<int>? durationSeconds,
    Value<int>? activeSeconds,
    Value<double>? volumeLoadKg,
    Value<int>? totalCompletedSets,
    Value<int>? totalCompletedReps,
    Value<double?>? averageRpe,
    Value<int>? rowid,
  }) {
    return DailyWorkoutSummariesCompanion(
      id: id ?? this.id,
      date: date ?? this.date,
      sessionId: sessionId ?? this.sessionId,
      userId: userId ?? this.userId,
      templateName: templateName ?? this.templateName,
      durationSeconds: durationSeconds ?? this.durationSeconds,
      activeSeconds: activeSeconds ?? this.activeSeconds,
      volumeLoadKg: volumeLoadKg ?? this.volumeLoadKg,
      totalCompletedSets: totalCompletedSets ?? this.totalCompletedSets,
      totalCompletedReps: totalCompletedReps ?? this.totalCompletedReps,
      averageRpe: averageRpe ?? this.averageRpe,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (date.present) {
      map['date'] = Variable<DateTime>(date.value);
    }
    if (sessionId.present) {
      map['session_id'] = Variable<String>(sessionId.value);
    }
    if (userId.present) {
      map['user_id'] = Variable<String>(userId.value);
    }
    if (templateName.present) {
      map['template_name'] = Variable<String>(templateName.value);
    }
    if (durationSeconds.present) {
      map['duration_seconds'] = Variable<int>(durationSeconds.value);
    }
    if (activeSeconds.present) {
      map['active_seconds'] = Variable<int>(activeSeconds.value);
    }
    if (volumeLoadKg.present) {
      map['volume_load_kg'] = Variable<double>(volumeLoadKg.value);
    }
    if (totalCompletedSets.present) {
      map['total_completed_sets'] = Variable<int>(totalCompletedSets.value);
    }
    if (totalCompletedReps.present) {
      map['total_completed_reps'] = Variable<int>(totalCompletedReps.value);
    }
    if (averageRpe.present) {
      map['average_rpe'] = Variable<double>(averageRpe.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('DailyWorkoutSummariesCompanion(')
          ..write('id: $id, ')
          ..write('date: $date, ')
          ..write('sessionId: $sessionId, ')
          ..write('userId: $userId, ')
          ..write('templateName: $templateName, ')
          ..write('durationSeconds: $durationSeconds, ')
          ..write('activeSeconds: $activeSeconds, ')
          ..write('volumeLoadKg: $volumeLoadKg, ')
          ..write('totalCompletedSets: $totalCompletedSets, ')
          ..write('totalCompletedReps: $totalCompletedReps, ')
          ..write('averageRpe: $averageRpe, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $ExerciseSetMetricsTable extends ExerciseSetMetrics
    with TableInfo<$ExerciseSetMetricsTable, ExerciseSetMetricRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ExerciseSetMetricsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _sessionIdMeta = const VerificationMeta(
    'sessionId',
  );
  @override
  late final GeneratedColumn<String> sessionId = GeneratedColumn<String>(
    'session_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _exerciseIdMeta = const VerificationMeta(
    'exerciseId',
  );
  @override
  late final GeneratedColumn<String> exerciseId = GeneratedColumn<String>(
    'exercise_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _userIdMeta = const VerificationMeta('userId');
  @override
  late final GeneratedColumn<String> userId = GeneratedColumn<String>(
    'user_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _timestampMeta = const VerificationMeta(
    'timestamp',
  );
  @override
  late final GeneratedColumn<DateTime> timestamp = GeneratedColumn<DateTime>(
    'timestamp',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _weightKgMeta = const VerificationMeta(
    'weightKg',
  );
  @override
  late final GeneratedColumn<double> weightKg = GeneratedColumn<double>(
    'weight_kg',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _repsMeta = const VerificationMeta('reps');
  @override
  late final GeneratedColumn<int> reps = GeneratedColumn<int>(
    'reps',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _volumeLoadMeta = const VerificationMeta(
    'volumeLoad',
  );
  @override
  late final GeneratedColumn<double> volumeLoad = GeneratedColumn<double>(
    'volume_load',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _estimated1RmMeta = const VerificationMeta(
    'estimated1Rm',
  );
  @override
  late final GeneratedColumn<double> estimated1Rm = GeneratedColumn<double>(
    'estimated1_rm',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _rpeMeta = const VerificationMeta('rpe');
  @override
  late final GeneratedColumn<double> rpe = GeneratedColumn<double>(
    'rpe',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _rirMeta = const VerificationMeta('rir');
  @override
  late final GeneratedColumn<int> rir = GeneratedColumn<int>(
    'rir',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _setTypeMeta = const VerificationMeta(
    'setType',
  );
  @override
  late final GeneratedColumn<String> setType = GeneratedColumn<String>(
    'set_type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    sessionId,
    exerciseId,
    userId,
    timestamp,
    weightKg,
    reps,
    volumeLoad,
    estimated1Rm,
    rpe,
    rir,
    setType,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'exercise_set_metrics';
  @override
  VerificationContext validateIntegrity(
    Insertable<ExerciseSetMetricRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('session_id')) {
      context.handle(
        _sessionIdMeta,
        sessionId.isAcceptableOrUnknown(data['session_id']!, _sessionIdMeta),
      );
    } else if (isInserting) {
      context.missing(_sessionIdMeta);
    }
    if (data.containsKey('exercise_id')) {
      context.handle(
        _exerciseIdMeta,
        exerciseId.isAcceptableOrUnknown(data['exercise_id']!, _exerciseIdMeta),
      );
    } else if (isInserting) {
      context.missing(_exerciseIdMeta);
    }
    if (data.containsKey('user_id')) {
      context.handle(
        _userIdMeta,
        userId.isAcceptableOrUnknown(data['user_id']!, _userIdMeta),
      );
    } else if (isInserting) {
      context.missing(_userIdMeta);
    }
    if (data.containsKey('timestamp')) {
      context.handle(
        _timestampMeta,
        timestamp.isAcceptableOrUnknown(data['timestamp']!, _timestampMeta),
      );
    } else if (isInserting) {
      context.missing(_timestampMeta);
    }
    if (data.containsKey('weight_kg')) {
      context.handle(
        _weightKgMeta,
        weightKg.isAcceptableOrUnknown(data['weight_kg']!, _weightKgMeta),
      );
    }
    if (data.containsKey('reps')) {
      context.handle(
        _repsMeta,
        reps.isAcceptableOrUnknown(data['reps']!, _repsMeta),
      );
    }
    if (data.containsKey('volume_load')) {
      context.handle(
        _volumeLoadMeta,
        volumeLoad.isAcceptableOrUnknown(data['volume_load']!, _volumeLoadMeta),
      );
    }
    if (data.containsKey('estimated1_rm')) {
      context.handle(
        _estimated1RmMeta,
        estimated1Rm.isAcceptableOrUnknown(
          data['estimated1_rm']!,
          _estimated1RmMeta,
        ),
      );
    }
    if (data.containsKey('rpe')) {
      context.handle(
        _rpeMeta,
        rpe.isAcceptableOrUnknown(data['rpe']!, _rpeMeta),
      );
    }
    if (data.containsKey('rir')) {
      context.handle(
        _rirMeta,
        rir.isAcceptableOrUnknown(data['rir']!, _rirMeta),
      );
    }
    if (data.containsKey('set_type')) {
      context.handle(
        _setTypeMeta,
        setType.isAcceptableOrUnknown(data['set_type']!, _setTypeMeta),
      );
    } else if (isInserting) {
      context.missing(_setTypeMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ExerciseSetMetricRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ExerciseSetMetricRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      sessionId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}session_id'],
      )!,
      exerciseId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}exercise_id'],
      )!,
      userId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}user_id'],
      )!,
      timestamp: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}timestamp'],
      )!,
      weightKg: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}weight_kg'],
      ),
      reps: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}reps'],
      ),
      volumeLoad: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}volume_load'],
      ),
      estimated1Rm: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}estimated1_rm'],
      ),
      rpe: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}rpe'],
      ),
      rir: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}rir'],
      ),
      setType: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}set_type'],
      )!,
    );
  }

  @override
  $ExerciseSetMetricsTable createAlias(String alias) {
    return $ExerciseSetMetricsTable(attachedDatabase, alias);
  }
}

class ExerciseSetMetricRow extends DataClass
    implements Insertable<ExerciseSetMetricRow> {
  /// ExecutionSet ID (matches the session document).
  final String id;

  /// Session this set belongs to.
  final String sessionId;

  /// Catalog exercise ID.
  final String exerciseId;

  /// User who performed the session.
  final String userId;

  /// Wall-clock timestamp when the set was completed.
  final DateTime timestamp;

  /// Weight lifted in canonical kg (null for bodyweight/time sets).
  final double? weightKg;

  /// Actual reps completed (null for time/distance sets).
  final int? reps;

  /// Volume load: weightKg * reps (null when either is absent).
  final double? volumeLoad;

  /// Epley estimated 1RM: weight * (1 + reps/30). Null if reps < 1.
  final double? estimated1Rm;

  /// Recorded Rate of Perceived Exertion (1–10 scale).
  final double? rpe;

  /// Recorded Reps In Reserve.
  final int? rir;

  /// Set type string matching [SetType] enum name.
  final String setType;
  const ExerciseSetMetricRow({
    required this.id,
    required this.sessionId,
    required this.exerciseId,
    required this.userId,
    required this.timestamp,
    this.weightKg,
    this.reps,
    this.volumeLoad,
    this.estimated1Rm,
    this.rpe,
    this.rir,
    required this.setType,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['session_id'] = Variable<String>(sessionId);
    map['exercise_id'] = Variable<String>(exerciseId);
    map['user_id'] = Variable<String>(userId);
    map['timestamp'] = Variable<DateTime>(timestamp);
    if (!nullToAbsent || weightKg != null) {
      map['weight_kg'] = Variable<double>(weightKg);
    }
    if (!nullToAbsent || reps != null) {
      map['reps'] = Variable<int>(reps);
    }
    if (!nullToAbsent || volumeLoad != null) {
      map['volume_load'] = Variable<double>(volumeLoad);
    }
    if (!nullToAbsent || estimated1Rm != null) {
      map['estimated1_rm'] = Variable<double>(estimated1Rm);
    }
    if (!nullToAbsent || rpe != null) {
      map['rpe'] = Variable<double>(rpe);
    }
    if (!nullToAbsent || rir != null) {
      map['rir'] = Variable<int>(rir);
    }
    map['set_type'] = Variable<String>(setType);
    return map;
  }

  ExerciseSetMetricsCompanion toCompanion(bool nullToAbsent) {
    return ExerciseSetMetricsCompanion(
      id: Value(id),
      sessionId: Value(sessionId),
      exerciseId: Value(exerciseId),
      userId: Value(userId),
      timestamp: Value(timestamp),
      weightKg: weightKg == null && nullToAbsent
          ? const Value.absent()
          : Value(weightKg),
      reps: reps == null && nullToAbsent ? const Value.absent() : Value(reps),
      volumeLoad: volumeLoad == null && nullToAbsent
          ? const Value.absent()
          : Value(volumeLoad),
      estimated1Rm: estimated1Rm == null && nullToAbsent
          ? const Value.absent()
          : Value(estimated1Rm),
      rpe: rpe == null && nullToAbsent ? const Value.absent() : Value(rpe),
      rir: rir == null && nullToAbsent ? const Value.absent() : Value(rir),
      setType: Value(setType),
    );
  }

  factory ExerciseSetMetricRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ExerciseSetMetricRow(
      id: serializer.fromJson<String>(json['id']),
      sessionId: serializer.fromJson<String>(json['sessionId']),
      exerciseId: serializer.fromJson<String>(json['exerciseId']),
      userId: serializer.fromJson<String>(json['userId']),
      timestamp: serializer.fromJson<DateTime>(json['timestamp']),
      weightKg: serializer.fromJson<double?>(json['weightKg']),
      reps: serializer.fromJson<int?>(json['reps']),
      volumeLoad: serializer.fromJson<double?>(json['volumeLoad']),
      estimated1Rm: serializer.fromJson<double?>(json['estimated1Rm']),
      rpe: serializer.fromJson<double?>(json['rpe']),
      rir: serializer.fromJson<int?>(json['rir']),
      setType: serializer.fromJson<String>(json['setType']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'sessionId': serializer.toJson<String>(sessionId),
      'exerciseId': serializer.toJson<String>(exerciseId),
      'userId': serializer.toJson<String>(userId),
      'timestamp': serializer.toJson<DateTime>(timestamp),
      'weightKg': serializer.toJson<double?>(weightKg),
      'reps': serializer.toJson<int?>(reps),
      'volumeLoad': serializer.toJson<double?>(volumeLoad),
      'estimated1Rm': serializer.toJson<double?>(estimated1Rm),
      'rpe': serializer.toJson<double?>(rpe),
      'rir': serializer.toJson<int?>(rir),
      'setType': serializer.toJson<String>(setType),
    };
  }

  ExerciseSetMetricRow copyWith({
    String? id,
    String? sessionId,
    String? exerciseId,
    String? userId,
    DateTime? timestamp,
    Value<double?> weightKg = const Value.absent(),
    Value<int?> reps = const Value.absent(),
    Value<double?> volumeLoad = const Value.absent(),
    Value<double?> estimated1Rm = const Value.absent(),
    Value<double?> rpe = const Value.absent(),
    Value<int?> rir = const Value.absent(),
    String? setType,
  }) => ExerciseSetMetricRow(
    id: id ?? this.id,
    sessionId: sessionId ?? this.sessionId,
    exerciseId: exerciseId ?? this.exerciseId,
    userId: userId ?? this.userId,
    timestamp: timestamp ?? this.timestamp,
    weightKg: weightKg.present ? weightKg.value : this.weightKg,
    reps: reps.present ? reps.value : this.reps,
    volumeLoad: volumeLoad.present ? volumeLoad.value : this.volumeLoad,
    estimated1Rm: estimated1Rm.present ? estimated1Rm.value : this.estimated1Rm,
    rpe: rpe.present ? rpe.value : this.rpe,
    rir: rir.present ? rir.value : this.rir,
    setType: setType ?? this.setType,
  );
  ExerciseSetMetricRow copyWithCompanion(ExerciseSetMetricsCompanion data) {
    return ExerciseSetMetricRow(
      id: data.id.present ? data.id.value : this.id,
      sessionId: data.sessionId.present ? data.sessionId.value : this.sessionId,
      exerciseId: data.exerciseId.present
          ? data.exerciseId.value
          : this.exerciseId,
      userId: data.userId.present ? data.userId.value : this.userId,
      timestamp: data.timestamp.present ? data.timestamp.value : this.timestamp,
      weightKg: data.weightKg.present ? data.weightKg.value : this.weightKg,
      reps: data.reps.present ? data.reps.value : this.reps,
      volumeLoad: data.volumeLoad.present
          ? data.volumeLoad.value
          : this.volumeLoad,
      estimated1Rm: data.estimated1Rm.present
          ? data.estimated1Rm.value
          : this.estimated1Rm,
      rpe: data.rpe.present ? data.rpe.value : this.rpe,
      rir: data.rir.present ? data.rir.value : this.rir,
      setType: data.setType.present ? data.setType.value : this.setType,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ExerciseSetMetricRow(')
          ..write('id: $id, ')
          ..write('sessionId: $sessionId, ')
          ..write('exerciseId: $exerciseId, ')
          ..write('userId: $userId, ')
          ..write('timestamp: $timestamp, ')
          ..write('weightKg: $weightKg, ')
          ..write('reps: $reps, ')
          ..write('volumeLoad: $volumeLoad, ')
          ..write('estimated1Rm: $estimated1Rm, ')
          ..write('rpe: $rpe, ')
          ..write('rir: $rir, ')
          ..write('setType: $setType')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    sessionId,
    exerciseId,
    userId,
    timestamp,
    weightKg,
    reps,
    volumeLoad,
    estimated1Rm,
    rpe,
    rir,
    setType,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ExerciseSetMetricRow &&
          other.id == this.id &&
          other.sessionId == this.sessionId &&
          other.exerciseId == this.exerciseId &&
          other.userId == this.userId &&
          other.timestamp == this.timestamp &&
          other.weightKg == this.weightKg &&
          other.reps == this.reps &&
          other.volumeLoad == this.volumeLoad &&
          other.estimated1Rm == this.estimated1Rm &&
          other.rpe == this.rpe &&
          other.rir == this.rir &&
          other.setType == this.setType);
}

class ExerciseSetMetricsCompanion
    extends UpdateCompanion<ExerciseSetMetricRow> {
  final Value<String> id;
  final Value<String> sessionId;
  final Value<String> exerciseId;
  final Value<String> userId;
  final Value<DateTime> timestamp;
  final Value<double?> weightKg;
  final Value<int?> reps;
  final Value<double?> volumeLoad;
  final Value<double?> estimated1Rm;
  final Value<double?> rpe;
  final Value<int?> rir;
  final Value<String> setType;
  final Value<int> rowid;
  const ExerciseSetMetricsCompanion({
    this.id = const Value.absent(),
    this.sessionId = const Value.absent(),
    this.exerciseId = const Value.absent(),
    this.userId = const Value.absent(),
    this.timestamp = const Value.absent(),
    this.weightKg = const Value.absent(),
    this.reps = const Value.absent(),
    this.volumeLoad = const Value.absent(),
    this.estimated1Rm = const Value.absent(),
    this.rpe = const Value.absent(),
    this.rir = const Value.absent(),
    this.setType = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ExerciseSetMetricsCompanion.insert({
    required String id,
    required String sessionId,
    required String exerciseId,
    required String userId,
    required DateTime timestamp,
    this.weightKg = const Value.absent(),
    this.reps = const Value.absent(),
    this.volumeLoad = const Value.absent(),
    this.estimated1Rm = const Value.absent(),
    this.rpe = const Value.absent(),
    this.rir = const Value.absent(),
    required String setType,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       sessionId = Value(sessionId),
       exerciseId = Value(exerciseId),
       userId = Value(userId),
       timestamp = Value(timestamp),
       setType = Value(setType);
  static Insertable<ExerciseSetMetricRow> custom({
    Expression<String>? id,
    Expression<String>? sessionId,
    Expression<String>? exerciseId,
    Expression<String>? userId,
    Expression<DateTime>? timestamp,
    Expression<double>? weightKg,
    Expression<int>? reps,
    Expression<double>? volumeLoad,
    Expression<double>? estimated1Rm,
    Expression<double>? rpe,
    Expression<int>? rir,
    Expression<String>? setType,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (sessionId != null) 'session_id': sessionId,
      if (exerciseId != null) 'exercise_id': exerciseId,
      if (userId != null) 'user_id': userId,
      if (timestamp != null) 'timestamp': timestamp,
      if (weightKg != null) 'weight_kg': weightKg,
      if (reps != null) 'reps': reps,
      if (volumeLoad != null) 'volume_load': volumeLoad,
      if (estimated1Rm != null) 'estimated1_rm': estimated1Rm,
      if (rpe != null) 'rpe': rpe,
      if (rir != null) 'rir': rir,
      if (setType != null) 'set_type': setType,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ExerciseSetMetricsCompanion copyWith({
    Value<String>? id,
    Value<String>? sessionId,
    Value<String>? exerciseId,
    Value<String>? userId,
    Value<DateTime>? timestamp,
    Value<double?>? weightKg,
    Value<int?>? reps,
    Value<double?>? volumeLoad,
    Value<double?>? estimated1Rm,
    Value<double?>? rpe,
    Value<int?>? rir,
    Value<String>? setType,
    Value<int>? rowid,
  }) {
    return ExerciseSetMetricsCompanion(
      id: id ?? this.id,
      sessionId: sessionId ?? this.sessionId,
      exerciseId: exerciseId ?? this.exerciseId,
      userId: userId ?? this.userId,
      timestamp: timestamp ?? this.timestamp,
      weightKg: weightKg ?? this.weightKg,
      reps: reps ?? this.reps,
      volumeLoad: volumeLoad ?? this.volumeLoad,
      estimated1Rm: estimated1Rm ?? this.estimated1Rm,
      rpe: rpe ?? this.rpe,
      rir: rir ?? this.rir,
      setType: setType ?? this.setType,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (sessionId.present) {
      map['session_id'] = Variable<String>(sessionId.value);
    }
    if (exerciseId.present) {
      map['exercise_id'] = Variable<String>(exerciseId.value);
    }
    if (userId.present) {
      map['user_id'] = Variable<String>(userId.value);
    }
    if (timestamp.present) {
      map['timestamp'] = Variable<DateTime>(timestamp.value);
    }
    if (weightKg.present) {
      map['weight_kg'] = Variable<double>(weightKg.value);
    }
    if (reps.present) {
      map['reps'] = Variable<int>(reps.value);
    }
    if (volumeLoad.present) {
      map['volume_load'] = Variable<double>(volumeLoad.value);
    }
    if (estimated1Rm.present) {
      map['estimated1_rm'] = Variable<double>(estimated1Rm.value);
    }
    if (rpe.present) {
      map['rpe'] = Variable<double>(rpe.value);
    }
    if (rir.present) {
      map['rir'] = Variable<int>(rir.value);
    }
    if (setType.present) {
      map['set_type'] = Variable<String>(setType.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ExerciseSetMetricsCompanion(')
          ..write('id: $id, ')
          ..write('sessionId: $sessionId, ')
          ..write('exerciseId: $exerciseId, ')
          ..write('userId: $userId, ')
          ..write('timestamp: $timestamp, ')
          ..write('weightKg: $weightKg, ')
          ..write('reps: $reps, ')
          ..write('volumeLoad: $volumeLoad, ')
          ..write('estimated1Rm: $estimated1Rm, ')
          ..write('rpe: $rpe, ')
          ..write('rir: $rir, ')
          ..write('setType: $setType, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $PersonalRecordsTable extends PersonalRecords
    with TableInfo<$PersonalRecordsTable, PersonalRecordRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PersonalRecordsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _exerciseIdMeta = const VerificationMeta(
    'exerciseId',
  );
  @override
  late final GeneratedColumn<String> exerciseId = GeneratedColumn<String>(
    'exercise_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _userIdMeta = const VerificationMeta('userId');
  @override
  late final GeneratedColumn<String> userId = GeneratedColumn<String>(
    'user_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _prTypeMeta = const VerificationMeta('prType');
  @override
  late final GeneratedColumn<String> prType = GeneratedColumn<String>(
    'pr_type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _valueMeta = const VerificationMeta('value');
  @override
  late final GeneratedColumn<double> value = GeneratedColumn<double>(
    'value',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _sessionIdMeta = const VerificationMeta(
    'sessionId',
  );
  @override
  late final GeneratedColumn<String> sessionId = GeneratedColumn<String>(
    'session_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _setIdMeta = const VerificationMeta('setId');
  @override
  late final GeneratedColumn<String> setId = GeneratedColumn<String>(
    'set_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _achievedAtMeta = const VerificationMeta(
    'achievedAt',
  );
  @override
  late final GeneratedColumn<DateTime> achievedAt = GeneratedColumn<DateTime>(
    'achieved_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _replacesRecordIdMeta = const VerificationMeta(
    'replacesRecordId',
  );
  @override
  late final GeneratedColumn<String> replacesRecordId = GeneratedColumn<String>(
    'replaces_record_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    exerciseId,
    userId,
    prType,
    value,
    sessionId,
    setId,
    achievedAt,
    replacesRecordId,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'personal_records';
  @override
  VerificationContext validateIntegrity(
    Insertable<PersonalRecordRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('exercise_id')) {
      context.handle(
        _exerciseIdMeta,
        exerciseId.isAcceptableOrUnknown(data['exercise_id']!, _exerciseIdMeta),
      );
    } else if (isInserting) {
      context.missing(_exerciseIdMeta);
    }
    if (data.containsKey('user_id')) {
      context.handle(
        _userIdMeta,
        userId.isAcceptableOrUnknown(data['user_id']!, _userIdMeta),
      );
    } else if (isInserting) {
      context.missing(_userIdMeta);
    }
    if (data.containsKey('pr_type')) {
      context.handle(
        _prTypeMeta,
        prType.isAcceptableOrUnknown(data['pr_type']!, _prTypeMeta),
      );
    } else if (isInserting) {
      context.missing(_prTypeMeta);
    }
    if (data.containsKey('value')) {
      context.handle(
        _valueMeta,
        value.isAcceptableOrUnknown(data['value']!, _valueMeta),
      );
    } else if (isInserting) {
      context.missing(_valueMeta);
    }
    if (data.containsKey('session_id')) {
      context.handle(
        _sessionIdMeta,
        sessionId.isAcceptableOrUnknown(data['session_id']!, _sessionIdMeta),
      );
    } else if (isInserting) {
      context.missing(_sessionIdMeta);
    }
    if (data.containsKey('set_id')) {
      context.handle(
        _setIdMeta,
        setId.isAcceptableOrUnknown(data['set_id']!, _setIdMeta),
      );
    }
    if (data.containsKey('achieved_at')) {
      context.handle(
        _achievedAtMeta,
        achievedAt.isAcceptableOrUnknown(data['achieved_at']!, _achievedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_achievedAtMeta);
    }
    if (data.containsKey('replaces_record_id')) {
      context.handle(
        _replacesRecordIdMeta,
        replacesRecordId.isAcceptableOrUnknown(
          data['replaces_record_id']!,
          _replacesRecordIdMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  PersonalRecordRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return PersonalRecordRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      exerciseId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}exercise_id'],
      )!,
      userId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}user_id'],
      )!,
      prType: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}pr_type'],
      )!,
      value: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}value'],
      )!,
      sessionId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}session_id'],
      )!,
      setId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}set_id'],
      ),
      achievedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}achieved_at'],
      )!,
      replacesRecordId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}replaces_record_id'],
      ),
    );
  }

  @override
  $PersonalRecordsTable createAlias(String alias) {
    return $PersonalRecordsTable(attachedDatabase, alias);
  }
}

class PersonalRecordRow extends DataClass
    implements Insertable<PersonalRecordRow> {
  /// UUID generated at projection time.
  final String id;

  /// Catalog exercise this record belongs to.
  final String exerciseId;

  /// User who achieved the record.
  final String userId;

  /// PR type string matching [PrType] enum name.
  /// e.g. 'maxWeight', 'estimated1Rm', 'maxRepsAtWeight', 'maxVolumeSet', 'maxVolumeSession'
  final String prType;

  /// The numeric record value (kg, reps, or kg*reps depending on prType).
  final double value;

  /// Session where this record was achieved.
  final String sessionId;

  /// The specific [ExecutionSet] that achieved this record (null for session-level PRs).
  final String? setId;

  /// Wall-clock timestamp of the session completion.
  final DateTime achievedAt;

  /// ID of the previous best record this one replaced (null if first ever).
  final String? replacesRecordId;
  const PersonalRecordRow({
    required this.id,
    required this.exerciseId,
    required this.userId,
    required this.prType,
    required this.value,
    required this.sessionId,
    this.setId,
    required this.achievedAt,
    this.replacesRecordId,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['exercise_id'] = Variable<String>(exerciseId);
    map['user_id'] = Variable<String>(userId);
    map['pr_type'] = Variable<String>(prType);
    map['value'] = Variable<double>(value);
    map['session_id'] = Variable<String>(sessionId);
    if (!nullToAbsent || setId != null) {
      map['set_id'] = Variable<String>(setId);
    }
    map['achieved_at'] = Variable<DateTime>(achievedAt);
    if (!nullToAbsent || replacesRecordId != null) {
      map['replaces_record_id'] = Variable<String>(replacesRecordId);
    }
    return map;
  }

  PersonalRecordsCompanion toCompanion(bool nullToAbsent) {
    return PersonalRecordsCompanion(
      id: Value(id),
      exerciseId: Value(exerciseId),
      userId: Value(userId),
      prType: Value(prType),
      value: Value(value),
      sessionId: Value(sessionId),
      setId: setId == null && nullToAbsent
          ? const Value.absent()
          : Value(setId),
      achievedAt: Value(achievedAt),
      replacesRecordId: replacesRecordId == null && nullToAbsent
          ? const Value.absent()
          : Value(replacesRecordId),
    );
  }

  factory PersonalRecordRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return PersonalRecordRow(
      id: serializer.fromJson<String>(json['id']),
      exerciseId: serializer.fromJson<String>(json['exerciseId']),
      userId: serializer.fromJson<String>(json['userId']),
      prType: serializer.fromJson<String>(json['prType']),
      value: serializer.fromJson<double>(json['value']),
      sessionId: serializer.fromJson<String>(json['sessionId']),
      setId: serializer.fromJson<String?>(json['setId']),
      achievedAt: serializer.fromJson<DateTime>(json['achievedAt']),
      replacesRecordId: serializer.fromJson<String?>(json['replacesRecordId']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'exerciseId': serializer.toJson<String>(exerciseId),
      'userId': serializer.toJson<String>(userId),
      'prType': serializer.toJson<String>(prType),
      'value': serializer.toJson<double>(value),
      'sessionId': serializer.toJson<String>(sessionId),
      'setId': serializer.toJson<String?>(setId),
      'achievedAt': serializer.toJson<DateTime>(achievedAt),
      'replacesRecordId': serializer.toJson<String?>(replacesRecordId),
    };
  }

  PersonalRecordRow copyWith({
    String? id,
    String? exerciseId,
    String? userId,
    String? prType,
    double? value,
    String? sessionId,
    Value<String?> setId = const Value.absent(),
    DateTime? achievedAt,
    Value<String?> replacesRecordId = const Value.absent(),
  }) => PersonalRecordRow(
    id: id ?? this.id,
    exerciseId: exerciseId ?? this.exerciseId,
    userId: userId ?? this.userId,
    prType: prType ?? this.prType,
    value: value ?? this.value,
    sessionId: sessionId ?? this.sessionId,
    setId: setId.present ? setId.value : this.setId,
    achievedAt: achievedAt ?? this.achievedAt,
    replacesRecordId: replacesRecordId.present
        ? replacesRecordId.value
        : this.replacesRecordId,
  );
  PersonalRecordRow copyWithCompanion(PersonalRecordsCompanion data) {
    return PersonalRecordRow(
      id: data.id.present ? data.id.value : this.id,
      exerciseId: data.exerciseId.present
          ? data.exerciseId.value
          : this.exerciseId,
      userId: data.userId.present ? data.userId.value : this.userId,
      prType: data.prType.present ? data.prType.value : this.prType,
      value: data.value.present ? data.value.value : this.value,
      sessionId: data.sessionId.present ? data.sessionId.value : this.sessionId,
      setId: data.setId.present ? data.setId.value : this.setId,
      achievedAt: data.achievedAt.present
          ? data.achievedAt.value
          : this.achievedAt,
      replacesRecordId: data.replacesRecordId.present
          ? data.replacesRecordId.value
          : this.replacesRecordId,
    );
  }

  @override
  String toString() {
    return (StringBuffer('PersonalRecordRow(')
          ..write('id: $id, ')
          ..write('exerciseId: $exerciseId, ')
          ..write('userId: $userId, ')
          ..write('prType: $prType, ')
          ..write('value: $value, ')
          ..write('sessionId: $sessionId, ')
          ..write('setId: $setId, ')
          ..write('achievedAt: $achievedAt, ')
          ..write('replacesRecordId: $replacesRecordId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    exerciseId,
    userId,
    prType,
    value,
    sessionId,
    setId,
    achievedAt,
    replacesRecordId,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is PersonalRecordRow &&
          other.id == this.id &&
          other.exerciseId == this.exerciseId &&
          other.userId == this.userId &&
          other.prType == this.prType &&
          other.value == this.value &&
          other.sessionId == this.sessionId &&
          other.setId == this.setId &&
          other.achievedAt == this.achievedAt &&
          other.replacesRecordId == this.replacesRecordId);
}

class PersonalRecordsCompanion extends UpdateCompanion<PersonalRecordRow> {
  final Value<String> id;
  final Value<String> exerciseId;
  final Value<String> userId;
  final Value<String> prType;
  final Value<double> value;
  final Value<String> sessionId;
  final Value<String?> setId;
  final Value<DateTime> achievedAt;
  final Value<String?> replacesRecordId;
  final Value<int> rowid;
  const PersonalRecordsCompanion({
    this.id = const Value.absent(),
    this.exerciseId = const Value.absent(),
    this.userId = const Value.absent(),
    this.prType = const Value.absent(),
    this.value = const Value.absent(),
    this.sessionId = const Value.absent(),
    this.setId = const Value.absent(),
    this.achievedAt = const Value.absent(),
    this.replacesRecordId = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  PersonalRecordsCompanion.insert({
    required String id,
    required String exerciseId,
    required String userId,
    required String prType,
    required double value,
    required String sessionId,
    this.setId = const Value.absent(),
    required DateTime achievedAt,
    this.replacesRecordId = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       exerciseId = Value(exerciseId),
       userId = Value(userId),
       prType = Value(prType),
       value = Value(value),
       sessionId = Value(sessionId),
       achievedAt = Value(achievedAt);
  static Insertable<PersonalRecordRow> custom({
    Expression<String>? id,
    Expression<String>? exerciseId,
    Expression<String>? userId,
    Expression<String>? prType,
    Expression<double>? value,
    Expression<String>? sessionId,
    Expression<String>? setId,
    Expression<DateTime>? achievedAt,
    Expression<String>? replacesRecordId,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (exerciseId != null) 'exercise_id': exerciseId,
      if (userId != null) 'user_id': userId,
      if (prType != null) 'pr_type': prType,
      if (value != null) 'value': value,
      if (sessionId != null) 'session_id': sessionId,
      if (setId != null) 'set_id': setId,
      if (achievedAt != null) 'achieved_at': achievedAt,
      if (replacesRecordId != null) 'replaces_record_id': replacesRecordId,
      if (rowid != null) 'rowid': rowid,
    });
  }

  PersonalRecordsCompanion copyWith({
    Value<String>? id,
    Value<String>? exerciseId,
    Value<String>? userId,
    Value<String>? prType,
    Value<double>? value,
    Value<String>? sessionId,
    Value<String?>? setId,
    Value<DateTime>? achievedAt,
    Value<String?>? replacesRecordId,
    Value<int>? rowid,
  }) {
    return PersonalRecordsCompanion(
      id: id ?? this.id,
      exerciseId: exerciseId ?? this.exerciseId,
      userId: userId ?? this.userId,
      prType: prType ?? this.prType,
      value: value ?? this.value,
      sessionId: sessionId ?? this.sessionId,
      setId: setId ?? this.setId,
      achievedAt: achievedAt ?? this.achievedAt,
      replacesRecordId: replacesRecordId ?? this.replacesRecordId,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (exerciseId.present) {
      map['exercise_id'] = Variable<String>(exerciseId.value);
    }
    if (userId.present) {
      map['user_id'] = Variable<String>(userId.value);
    }
    if (prType.present) {
      map['pr_type'] = Variable<String>(prType.value);
    }
    if (value.present) {
      map['value'] = Variable<double>(value.value);
    }
    if (sessionId.present) {
      map['session_id'] = Variable<String>(sessionId.value);
    }
    if (setId.present) {
      map['set_id'] = Variable<String>(setId.value);
    }
    if (achievedAt.present) {
      map['achieved_at'] = Variable<DateTime>(achievedAt.value);
    }
    if (replacesRecordId.present) {
      map['replaces_record_id'] = Variable<String>(replacesRecordId.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PersonalRecordsCompanion(')
          ..write('id: $id, ')
          ..write('exerciseId: $exerciseId, ')
          ..write('userId: $userId, ')
          ..write('prType: $prType, ')
          ..write('value: $value, ')
          ..write('sessionId: $sessionId, ')
          ..write('setId: $setId, ')
          ..write('achievedAt: $achievedAt, ')
          ..write('replacesRecordId: $replacesRecordId, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $MuscleVolumeBreakdownsTable extends MuscleVolumeBreakdowns
    with TableInfo<$MuscleVolumeBreakdownsTable, MuscleVolumeBreakdownRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $MuscleVolumeBreakdownsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _userIdMeta = const VerificationMeta('userId');
  @override
  late final GeneratedColumn<String> userId = GeneratedColumn<String>(
    'user_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _muscleGroupMeta = const VerificationMeta(
    'muscleGroup',
  );
  @override
  late final GeneratedColumn<String> muscleGroup = GeneratedColumn<String>(
    'muscle_group',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _isoYearMeta = const VerificationMeta(
    'isoYear',
  );
  @override
  late final GeneratedColumn<int> isoYear = GeneratedColumn<int>(
    'iso_year',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _isoWeekMeta = const VerificationMeta(
    'isoWeek',
  );
  @override
  late final GeneratedColumn<int> isoWeek = GeneratedColumn<int>(
    'iso_week',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _weekStartDateMeta = const VerificationMeta(
    'weekStartDate',
  );
  @override
  late final GeneratedColumn<DateTime> weekStartDate =
      GeneratedColumn<DateTime>(
        'week_start_date',
        aliasedName,
        false,
        type: DriftSqlType.dateTime,
        requiredDuringInsert: true,
      );
  static const VerificationMeta _totalVolumeKgMeta = const VerificationMeta(
    'totalVolumeKg',
  );
  @override
  late final GeneratedColumn<double> totalVolumeKg = GeneratedColumn<double>(
    'total_volume_kg',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _totalSetsMeta = const VerificationMeta(
    'totalSets',
  );
  @override
  late final GeneratedColumn<int> totalSets = GeneratedColumn<int>(
    'total_sets',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    userId,
    muscleGroup,
    isoYear,
    isoWeek,
    weekStartDate,
    totalVolumeKg,
    totalSets,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'muscle_volume_breakdowns';
  @override
  VerificationContext validateIntegrity(
    Insertable<MuscleVolumeBreakdownRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('user_id')) {
      context.handle(
        _userIdMeta,
        userId.isAcceptableOrUnknown(data['user_id']!, _userIdMeta),
      );
    } else if (isInserting) {
      context.missing(_userIdMeta);
    }
    if (data.containsKey('muscle_group')) {
      context.handle(
        _muscleGroupMeta,
        muscleGroup.isAcceptableOrUnknown(
          data['muscle_group']!,
          _muscleGroupMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_muscleGroupMeta);
    }
    if (data.containsKey('iso_year')) {
      context.handle(
        _isoYearMeta,
        isoYear.isAcceptableOrUnknown(data['iso_year']!, _isoYearMeta),
      );
    } else if (isInserting) {
      context.missing(_isoYearMeta);
    }
    if (data.containsKey('iso_week')) {
      context.handle(
        _isoWeekMeta,
        isoWeek.isAcceptableOrUnknown(data['iso_week']!, _isoWeekMeta),
      );
    } else if (isInserting) {
      context.missing(_isoWeekMeta);
    }
    if (data.containsKey('week_start_date')) {
      context.handle(
        _weekStartDateMeta,
        weekStartDate.isAcceptableOrUnknown(
          data['week_start_date']!,
          _weekStartDateMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_weekStartDateMeta);
    }
    if (data.containsKey('total_volume_kg')) {
      context.handle(
        _totalVolumeKgMeta,
        totalVolumeKg.isAcceptableOrUnknown(
          data['total_volume_kg']!,
          _totalVolumeKgMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_totalVolumeKgMeta);
    }
    if (data.containsKey('total_sets')) {
      context.handle(
        _totalSetsMeta,
        totalSets.isAcceptableOrUnknown(data['total_sets']!, _totalSetsMeta),
      );
    } else if (isInserting) {
      context.missing(_totalSetsMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  MuscleVolumeBreakdownRow map(
    Map<String, dynamic> data, {
    String? tablePrefix,
  }) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return MuscleVolumeBreakdownRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      userId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}user_id'],
      )!,
      muscleGroup: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}muscle_group'],
      )!,
      isoYear: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}iso_year'],
      )!,
      isoWeek: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}iso_week'],
      )!,
      weekStartDate: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}week_start_date'],
      )!,
      totalVolumeKg: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}total_volume_kg'],
      )!,
      totalSets: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}total_sets'],
      )!,
    );
  }

  @override
  $MuscleVolumeBreakdownsTable createAlias(String alias) {
    return $MuscleVolumeBreakdownsTable(attachedDatabase, alias);
  }
}

class MuscleVolumeBreakdownRow extends DataClass
    implements Insertable<MuscleVolumeBreakdownRow> {
  /// Composite key: "{userId}_{muscleGroup}_{isoYear}_{isoWeek}"
  final String id;
  final String userId;

  /// Muscle group string matching [MuscleGroup] enum name.
  final String muscleGroup;

  /// ISO 8601 year number of the week.
  final int isoYear;

  /// ISO 8601 week number (1–53).
  final int isoWeek;

  /// Monday midnight UTC for this ISO week (for date-range filtering).
  final DateTime weekStartDate;

  /// Total volume load in kg for this muscle group in this week.
  final double totalVolumeKg;

  /// Total working sets for this muscle group in this week.
  final int totalSets;
  const MuscleVolumeBreakdownRow({
    required this.id,
    required this.userId,
    required this.muscleGroup,
    required this.isoYear,
    required this.isoWeek,
    required this.weekStartDate,
    required this.totalVolumeKg,
    required this.totalSets,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['user_id'] = Variable<String>(userId);
    map['muscle_group'] = Variable<String>(muscleGroup);
    map['iso_year'] = Variable<int>(isoYear);
    map['iso_week'] = Variable<int>(isoWeek);
    map['week_start_date'] = Variable<DateTime>(weekStartDate);
    map['total_volume_kg'] = Variable<double>(totalVolumeKg);
    map['total_sets'] = Variable<int>(totalSets);
    return map;
  }

  MuscleVolumeBreakdownsCompanion toCompanion(bool nullToAbsent) {
    return MuscleVolumeBreakdownsCompanion(
      id: Value(id),
      userId: Value(userId),
      muscleGroup: Value(muscleGroup),
      isoYear: Value(isoYear),
      isoWeek: Value(isoWeek),
      weekStartDate: Value(weekStartDate),
      totalVolumeKg: Value(totalVolumeKg),
      totalSets: Value(totalSets),
    );
  }

  factory MuscleVolumeBreakdownRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return MuscleVolumeBreakdownRow(
      id: serializer.fromJson<String>(json['id']),
      userId: serializer.fromJson<String>(json['userId']),
      muscleGroup: serializer.fromJson<String>(json['muscleGroup']),
      isoYear: serializer.fromJson<int>(json['isoYear']),
      isoWeek: serializer.fromJson<int>(json['isoWeek']),
      weekStartDate: serializer.fromJson<DateTime>(json['weekStartDate']),
      totalVolumeKg: serializer.fromJson<double>(json['totalVolumeKg']),
      totalSets: serializer.fromJson<int>(json['totalSets']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'userId': serializer.toJson<String>(userId),
      'muscleGroup': serializer.toJson<String>(muscleGroup),
      'isoYear': serializer.toJson<int>(isoYear),
      'isoWeek': serializer.toJson<int>(isoWeek),
      'weekStartDate': serializer.toJson<DateTime>(weekStartDate),
      'totalVolumeKg': serializer.toJson<double>(totalVolumeKg),
      'totalSets': serializer.toJson<int>(totalSets),
    };
  }

  MuscleVolumeBreakdownRow copyWith({
    String? id,
    String? userId,
    String? muscleGroup,
    int? isoYear,
    int? isoWeek,
    DateTime? weekStartDate,
    double? totalVolumeKg,
    int? totalSets,
  }) => MuscleVolumeBreakdownRow(
    id: id ?? this.id,
    userId: userId ?? this.userId,
    muscleGroup: muscleGroup ?? this.muscleGroup,
    isoYear: isoYear ?? this.isoYear,
    isoWeek: isoWeek ?? this.isoWeek,
    weekStartDate: weekStartDate ?? this.weekStartDate,
    totalVolumeKg: totalVolumeKg ?? this.totalVolumeKg,
    totalSets: totalSets ?? this.totalSets,
  );
  MuscleVolumeBreakdownRow copyWithCompanion(
    MuscleVolumeBreakdownsCompanion data,
  ) {
    return MuscleVolumeBreakdownRow(
      id: data.id.present ? data.id.value : this.id,
      userId: data.userId.present ? data.userId.value : this.userId,
      muscleGroup: data.muscleGroup.present
          ? data.muscleGroup.value
          : this.muscleGroup,
      isoYear: data.isoYear.present ? data.isoYear.value : this.isoYear,
      isoWeek: data.isoWeek.present ? data.isoWeek.value : this.isoWeek,
      weekStartDate: data.weekStartDate.present
          ? data.weekStartDate.value
          : this.weekStartDate,
      totalVolumeKg: data.totalVolumeKg.present
          ? data.totalVolumeKg.value
          : this.totalVolumeKg,
      totalSets: data.totalSets.present ? data.totalSets.value : this.totalSets,
    );
  }

  @override
  String toString() {
    return (StringBuffer('MuscleVolumeBreakdownRow(')
          ..write('id: $id, ')
          ..write('userId: $userId, ')
          ..write('muscleGroup: $muscleGroup, ')
          ..write('isoYear: $isoYear, ')
          ..write('isoWeek: $isoWeek, ')
          ..write('weekStartDate: $weekStartDate, ')
          ..write('totalVolumeKg: $totalVolumeKg, ')
          ..write('totalSets: $totalSets')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    userId,
    muscleGroup,
    isoYear,
    isoWeek,
    weekStartDate,
    totalVolumeKg,
    totalSets,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is MuscleVolumeBreakdownRow &&
          other.id == this.id &&
          other.userId == this.userId &&
          other.muscleGroup == this.muscleGroup &&
          other.isoYear == this.isoYear &&
          other.isoWeek == this.isoWeek &&
          other.weekStartDate == this.weekStartDate &&
          other.totalVolumeKg == this.totalVolumeKg &&
          other.totalSets == this.totalSets);
}

class MuscleVolumeBreakdownsCompanion
    extends UpdateCompanion<MuscleVolumeBreakdownRow> {
  final Value<String> id;
  final Value<String> userId;
  final Value<String> muscleGroup;
  final Value<int> isoYear;
  final Value<int> isoWeek;
  final Value<DateTime> weekStartDate;
  final Value<double> totalVolumeKg;
  final Value<int> totalSets;
  final Value<int> rowid;
  const MuscleVolumeBreakdownsCompanion({
    this.id = const Value.absent(),
    this.userId = const Value.absent(),
    this.muscleGroup = const Value.absent(),
    this.isoYear = const Value.absent(),
    this.isoWeek = const Value.absent(),
    this.weekStartDate = const Value.absent(),
    this.totalVolumeKg = const Value.absent(),
    this.totalSets = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  MuscleVolumeBreakdownsCompanion.insert({
    required String id,
    required String userId,
    required String muscleGroup,
    required int isoYear,
    required int isoWeek,
    required DateTime weekStartDate,
    required double totalVolumeKg,
    required int totalSets,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       userId = Value(userId),
       muscleGroup = Value(muscleGroup),
       isoYear = Value(isoYear),
       isoWeek = Value(isoWeek),
       weekStartDate = Value(weekStartDate),
       totalVolumeKg = Value(totalVolumeKg),
       totalSets = Value(totalSets);
  static Insertable<MuscleVolumeBreakdownRow> custom({
    Expression<String>? id,
    Expression<String>? userId,
    Expression<String>? muscleGroup,
    Expression<int>? isoYear,
    Expression<int>? isoWeek,
    Expression<DateTime>? weekStartDate,
    Expression<double>? totalVolumeKg,
    Expression<int>? totalSets,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (userId != null) 'user_id': userId,
      if (muscleGroup != null) 'muscle_group': muscleGroup,
      if (isoYear != null) 'iso_year': isoYear,
      if (isoWeek != null) 'iso_week': isoWeek,
      if (weekStartDate != null) 'week_start_date': weekStartDate,
      if (totalVolumeKg != null) 'total_volume_kg': totalVolumeKg,
      if (totalSets != null) 'total_sets': totalSets,
      if (rowid != null) 'rowid': rowid,
    });
  }

  MuscleVolumeBreakdownsCompanion copyWith({
    Value<String>? id,
    Value<String>? userId,
    Value<String>? muscleGroup,
    Value<int>? isoYear,
    Value<int>? isoWeek,
    Value<DateTime>? weekStartDate,
    Value<double>? totalVolumeKg,
    Value<int>? totalSets,
    Value<int>? rowid,
  }) {
    return MuscleVolumeBreakdownsCompanion(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      muscleGroup: muscleGroup ?? this.muscleGroup,
      isoYear: isoYear ?? this.isoYear,
      isoWeek: isoWeek ?? this.isoWeek,
      weekStartDate: weekStartDate ?? this.weekStartDate,
      totalVolumeKg: totalVolumeKg ?? this.totalVolumeKg,
      totalSets: totalSets ?? this.totalSets,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (userId.present) {
      map['user_id'] = Variable<String>(userId.value);
    }
    if (muscleGroup.present) {
      map['muscle_group'] = Variable<String>(muscleGroup.value);
    }
    if (isoYear.present) {
      map['iso_year'] = Variable<int>(isoYear.value);
    }
    if (isoWeek.present) {
      map['iso_week'] = Variable<int>(isoWeek.value);
    }
    if (weekStartDate.present) {
      map['week_start_date'] = Variable<DateTime>(weekStartDate.value);
    }
    if (totalVolumeKg.present) {
      map['total_volume_kg'] = Variable<double>(totalVolumeKg.value);
    }
    if (totalSets.present) {
      map['total_sets'] = Variable<int>(totalSets.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('MuscleVolumeBreakdownsCompanion(')
          ..write('id: $id, ')
          ..write('userId: $userId, ')
          ..write('muscleGroup: $muscleGroup, ')
          ..write('isoYear: $isoYear, ')
          ..write('isoWeek: $isoWeek, ')
          ..write('weekStartDate: $weekStartDate, ')
          ..write('totalVolumeKg: $totalVolumeKg, ')
          ..write('totalSets: $totalSets, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $RestIntervalMetricsTable extends RestIntervalMetrics
    with TableInfo<$RestIntervalMetricsTable, RestIntervalMetricRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $RestIntervalMetricsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _sessionIdMeta = const VerificationMeta(
    'sessionId',
  );
  @override
  late final GeneratedColumn<String> sessionId = GeneratedColumn<String>(
    'session_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _executionSetIdMeta = const VerificationMeta(
    'executionSetId',
  );
  @override
  late final GeneratedColumn<String> executionSetId = GeneratedColumn<String>(
    'execution_set_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _exerciseIdMeta = const VerificationMeta(
    'exerciseId',
  );
  @override
  late final GeneratedColumn<String> exerciseId = GeneratedColumn<String>(
    'exercise_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _userIdMeta = const VerificationMeta('userId');
  @override
  late final GeneratedColumn<String> userId = GeneratedColumn<String>(
    'user_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _startedAtMeta = const VerificationMeta(
    'startedAt',
  );
  @override
  late final GeneratedColumn<DateTime> startedAt = GeneratedColumn<DateTime>(
    'started_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _endedAtMeta = const VerificationMeta(
    'endedAt',
  );
  @override
  late final GeneratedColumn<DateTime> endedAt = GeneratedColumn<DateTime>(
    'ended_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _plannedDurationSecondsMeta =
      const VerificationMeta('plannedDurationSeconds');
  @override
  late final GeneratedColumn<int> plannedDurationSeconds = GeneratedColumn<int>(
    'planned_duration_seconds',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _actualDurationSecondsMeta =
      const VerificationMeta('actualDurationSeconds');
  @override
  late final GeneratedColumn<int> actualDurationSeconds = GeneratedColumn<int>(
    'actual_duration_seconds',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _wasSkippedMeta = const VerificationMeta(
    'wasSkipped',
  );
  @override
  late final GeneratedColumn<bool> wasSkipped = GeneratedColumn<bool>(
    'was_skipped',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("was_skipped" IN (0, 1))',
    ),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    sessionId,
    executionSetId,
    exerciseId,
    userId,
    startedAt,
    endedAt,
    plannedDurationSeconds,
    actualDurationSeconds,
    wasSkipped,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'rest_interval_metrics';
  @override
  VerificationContext validateIntegrity(
    Insertable<RestIntervalMetricRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('session_id')) {
      context.handle(
        _sessionIdMeta,
        sessionId.isAcceptableOrUnknown(data['session_id']!, _sessionIdMeta),
      );
    } else if (isInserting) {
      context.missing(_sessionIdMeta);
    }
    if (data.containsKey('execution_set_id')) {
      context.handle(
        _executionSetIdMeta,
        executionSetId.isAcceptableOrUnknown(
          data['execution_set_id']!,
          _executionSetIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_executionSetIdMeta);
    }
    if (data.containsKey('exercise_id')) {
      context.handle(
        _exerciseIdMeta,
        exerciseId.isAcceptableOrUnknown(data['exercise_id']!, _exerciseIdMeta),
      );
    } else if (isInserting) {
      context.missing(_exerciseIdMeta);
    }
    if (data.containsKey('user_id')) {
      context.handle(
        _userIdMeta,
        userId.isAcceptableOrUnknown(data['user_id']!, _userIdMeta),
      );
    } else if (isInserting) {
      context.missing(_userIdMeta);
    }
    if (data.containsKey('started_at')) {
      context.handle(
        _startedAtMeta,
        startedAt.isAcceptableOrUnknown(data['started_at']!, _startedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_startedAtMeta);
    }
    if (data.containsKey('ended_at')) {
      context.handle(
        _endedAtMeta,
        endedAt.isAcceptableOrUnknown(data['ended_at']!, _endedAtMeta),
      );
    }
    if (data.containsKey('planned_duration_seconds')) {
      context.handle(
        _plannedDurationSecondsMeta,
        plannedDurationSeconds.isAcceptableOrUnknown(
          data['planned_duration_seconds']!,
          _plannedDurationSecondsMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_plannedDurationSecondsMeta);
    }
    if (data.containsKey('actual_duration_seconds')) {
      context.handle(
        _actualDurationSecondsMeta,
        actualDurationSeconds.isAcceptableOrUnknown(
          data['actual_duration_seconds']!,
          _actualDurationSecondsMeta,
        ),
      );
    }
    if (data.containsKey('was_skipped')) {
      context.handle(
        _wasSkippedMeta,
        wasSkipped.isAcceptableOrUnknown(data['was_skipped']!, _wasSkippedMeta),
      );
    } else if (isInserting) {
      context.missing(_wasSkippedMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  RestIntervalMetricRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return RestIntervalMetricRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      sessionId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}session_id'],
      )!,
      executionSetId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}execution_set_id'],
      )!,
      exerciseId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}exercise_id'],
      )!,
      userId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}user_id'],
      )!,
      startedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}started_at'],
      )!,
      endedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}ended_at'],
      ),
      plannedDurationSeconds: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}planned_duration_seconds'],
      )!,
      actualDurationSeconds: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}actual_duration_seconds'],
      ),
      wasSkipped: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}was_skipped'],
      )!,
    );
  }

  @override
  $RestIntervalMetricsTable createAlias(String alias) {
    return $RestIntervalMetricsTable(attachedDatabase, alias);
  }
}

class RestIntervalMetricRow extends DataClass
    implements Insertable<RestIntervalMetricRow> {
  /// RestInterval ID (matches the session document).
  final String id;
  final String sessionId;
  final String executionSetId;
  final String exerciseId;
  final String userId;
  final DateTime startedAt;

  /// Null if the interval has not yet ended (defensive — projector only writes closed intervals).
  final DateTime? endedAt;

  /// Prescribed rest duration from the template set.
  final int plannedDurationSeconds;

  /// Actual rest duration taken (null if skipped before expiry).
  final int? actualDurationSeconds;

  /// True if the rest was skipped before the planned duration elapsed.
  final bool wasSkipped;
  const RestIntervalMetricRow({
    required this.id,
    required this.sessionId,
    required this.executionSetId,
    required this.exerciseId,
    required this.userId,
    required this.startedAt,
    this.endedAt,
    required this.plannedDurationSeconds,
    this.actualDurationSeconds,
    required this.wasSkipped,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['session_id'] = Variable<String>(sessionId);
    map['execution_set_id'] = Variable<String>(executionSetId);
    map['exercise_id'] = Variable<String>(exerciseId);
    map['user_id'] = Variable<String>(userId);
    map['started_at'] = Variable<DateTime>(startedAt);
    if (!nullToAbsent || endedAt != null) {
      map['ended_at'] = Variable<DateTime>(endedAt);
    }
    map['planned_duration_seconds'] = Variable<int>(plannedDurationSeconds);
    if (!nullToAbsent || actualDurationSeconds != null) {
      map['actual_duration_seconds'] = Variable<int>(actualDurationSeconds);
    }
    map['was_skipped'] = Variable<bool>(wasSkipped);
    return map;
  }

  RestIntervalMetricsCompanion toCompanion(bool nullToAbsent) {
    return RestIntervalMetricsCompanion(
      id: Value(id),
      sessionId: Value(sessionId),
      executionSetId: Value(executionSetId),
      exerciseId: Value(exerciseId),
      userId: Value(userId),
      startedAt: Value(startedAt),
      endedAt: endedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(endedAt),
      plannedDurationSeconds: Value(plannedDurationSeconds),
      actualDurationSeconds: actualDurationSeconds == null && nullToAbsent
          ? const Value.absent()
          : Value(actualDurationSeconds),
      wasSkipped: Value(wasSkipped),
    );
  }

  factory RestIntervalMetricRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return RestIntervalMetricRow(
      id: serializer.fromJson<String>(json['id']),
      sessionId: serializer.fromJson<String>(json['sessionId']),
      executionSetId: serializer.fromJson<String>(json['executionSetId']),
      exerciseId: serializer.fromJson<String>(json['exerciseId']),
      userId: serializer.fromJson<String>(json['userId']),
      startedAt: serializer.fromJson<DateTime>(json['startedAt']),
      endedAt: serializer.fromJson<DateTime?>(json['endedAt']),
      plannedDurationSeconds: serializer.fromJson<int>(
        json['plannedDurationSeconds'],
      ),
      actualDurationSeconds: serializer.fromJson<int?>(
        json['actualDurationSeconds'],
      ),
      wasSkipped: serializer.fromJson<bool>(json['wasSkipped']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'sessionId': serializer.toJson<String>(sessionId),
      'executionSetId': serializer.toJson<String>(executionSetId),
      'exerciseId': serializer.toJson<String>(exerciseId),
      'userId': serializer.toJson<String>(userId),
      'startedAt': serializer.toJson<DateTime>(startedAt),
      'endedAt': serializer.toJson<DateTime?>(endedAt),
      'plannedDurationSeconds': serializer.toJson<int>(plannedDurationSeconds),
      'actualDurationSeconds': serializer.toJson<int?>(actualDurationSeconds),
      'wasSkipped': serializer.toJson<bool>(wasSkipped),
    };
  }

  RestIntervalMetricRow copyWith({
    String? id,
    String? sessionId,
    String? executionSetId,
    String? exerciseId,
    String? userId,
    DateTime? startedAt,
    Value<DateTime?> endedAt = const Value.absent(),
    int? plannedDurationSeconds,
    Value<int?> actualDurationSeconds = const Value.absent(),
    bool? wasSkipped,
  }) => RestIntervalMetricRow(
    id: id ?? this.id,
    sessionId: sessionId ?? this.sessionId,
    executionSetId: executionSetId ?? this.executionSetId,
    exerciseId: exerciseId ?? this.exerciseId,
    userId: userId ?? this.userId,
    startedAt: startedAt ?? this.startedAt,
    endedAt: endedAt.present ? endedAt.value : this.endedAt,
    plannedDurationSeconds:
        plannedDurationSeconds ?? this.plannedDurationSeconds,
    actualDurationSeconds: actualDurationSeconds.present
        ? actualDurationSeconds.value
        : this.actualDurationSeconds,
    wasSkipped: wasSkipped ?? this.wasSkipped,
  );
  RestIntervalMetricRow copyWithCompanion(RestIntervalMetricsCompanion data) {
    return RestIntervalMetricRow(
      id: data.id.present ? data.id.value : this.id,
      sessionId: data.sessionId.present ? data.sessionId.value : this.sessionId,
      executionSetId: data.executionSetId.present
          ? data.executionSetId.value
          : this.executionSetId,
      exerciseId: data.exerciseId.present
          ? data.exerciseId.value
          : this.exerciseId,
      userId: data.userId.present ? data.userId.value : this.userId,
      startedAt: data.startedAt.present ? data.startedAt.value : this.startedAt,
      endedAt: data.endedAt.present ? data.endedAt.value : this.endedAt,
      plannedDurationSeconds: data.plannedDurationSeconds.present
          ? data.plannedDurationSeconds.value
          : this.plannedDurationSeconds,
      actualDurationSeconds: data.actualDurationSeconds.present
          ? data.actualDurationSeconds.value
          : this.actualDurationSeconds,
      wasSkipped: data.wasSkipped.present
          ? data.wasSkipped.value
          : this.wasSkipped,
    );
  }

  @override
  String toString() {
    return (StringBuffer('RestIntervalMetricRow(')
          ..write('id: $id, ')
          ..write('sessionId: $sessionId, ')
          ..write('executionSetId: $executionSetId, ')
          ..write('exerciseId: $exerciseId, ')
          ..write('userId: $userId, ')
          ..write('startedAt: $startedAt, ')
          ..write('endedAt: $endedAt, ')
          ..write('plannedDurationSeconds: $plannedDurationSeconds, ')
          ..write('actualDurationSeconds: $actualDurationSeconds, ')
          ..write('wasSkipped: $wasSkipped')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    sessionId,
    executionSetId,
    exerciseId,
    userId,
    startedAt,
    endedAt,
    plannedDurationSeconds,
    actualDurationSeconds,
    wasSkipped,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is RestIntervalMetricRow &&
          other.id == this.id &&
          other.sessionId == this.sessionId &&
          other.executionSetId == this.executionSetId &&
          other.exerciseId == this.exerciseId &&
          other.userId == this.userId &&
          other.startedAt == this.startedAt &&
          other.endedAt == this.endedAt &&
          other.plannedDurationSeconds == this.plannedDurationSeconds &&
          other.actualDurationSeconds == this.actualDurationSeconds &&
          other.wasSkipped == this.wasSkipped);
}

class RestIntervalMetricsCompanion
    extends UpdateCompanion<RestIntervalMetricRow> {
  final Value<String> id;
  final Value<String> sessionId;
  final Value<String> executionSetId;
  final Value<String> exerciseId;
  final Value<String> userId;
  final Value<DateTime> startedAt;
  final Value<DateTime?> endedAt;
  final Value<int> plannedDurationSeconds;
  final Value<int?> actualDurationSeconds;
  final Value<bool> wasSkipped;
  final Value<int> rowid;
  const RestIntervalMetricsCompanion({
    this.id = const Value.absent(),
    this.sessionId = const Value.absent(),
    this.executionSetId = const Value.absent(),
    this.exerciseId = const Value.absent(),
    this.userId = const Value.absent(),
    this.startedAt = const Value.absent(),
    this.endedAt = const Value.absent(),
    this.plannedDurationSeconds = const Value.absent(),
    this.actualDurationSeconds = const Value.absent(),
    this.wasSkipped = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  RestIntervalMetricsCompanion.insert({
    required String id,
    required String sessionId,
    required String executionSetId,
    required String exerciseId,
    required String userId,
    required DateTime startedAt,
    this.endedAt = const Value.absent(),
    required int plannedDurationSeconds,
    this.actualDurationSeconds = const Value.absent(),
    required bool wasSkipped,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       sessionId = Value(sessionId),
       executionSetId = Value(executionSetId),
       exerciseId = Value(exerciseId),
       userId = Value(userId),
       startedAt = Value(startedAt),
       plannedDurationSeconds = Value(plannedDurationSeconds),
       wasSkipped = Value(wasSkipped);
  static Insertable<RestIntervalMetricRow> custom({
    Expression<String>? id,
    Expression<String>? sessionId,
    Expression<String>? executionSetId,
    Expression<String>? exerciseId,
    Expression<String>? userId,
    Expression<DateTime>? startedAt,
    Expression<DateTime>? endedAt,
    Expression<int>? plannedDurationSeconds,
    Expression<int>? actualDurationSeconds,
    Expression<bool>? wasSkipped,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (sessionId != null) 'session_id': sessionId,
      if (executionSetId != null) 'execution_set_id': executionSetId,
      if (exerciseId != null) 'exercise_id': exerciseId,
      if (userId != null) 'user_id': userId,
      if (startedAt != null) 'started_at': startedAt,
      if (endedAt != null) 'ended_at': endedAt,
      if (plannedDurationSeconds != null)
        'planned_duration_seconds': plannedDurationSeconds,
      if (actualDurationSeconds != null)
        'actual_duration_seconds': actualDurationSeconds,
      if (wasSkipped != null) 'was_skipped': wasSkipped,
      if (rowid != null) 'rowid': rowid,
    });
  }

  RestIntervalMetricsCompanion copyWith({
    Value<String>? id,
    Value<String>? sessionId,
    Value<String>? executionSetId,
    Value<String>? exerciseId,
    Value<String>? userId,
    Value<DateTime>? startedAt,
    Value<DateTime?>? endedAt,
    Value<int>? plannedDurationSeconds,
    Value<int?>? actualDurationSeconds,
    Value<bool>? wasSkipped,
    Value<int>? rowid,
  }) {
    return RestIntervalMetricsCompanion(
      id: id ?? this.id,
      sessionId: sessionId ?? this.sessionId,
      executionSetId: executionSetId ?? this.executionSetId,
      exerciseId: exerciseId ?? this.exerciseId,
      userId: userId ?? this.userId,
      startedAt: startedAt ?? this.startedAt,
      endedAt: endedAt ?? this.endedAt,
      plannedDurationSeconds:
          plannedDurationSeconds ?? this.plannedDurationSeconds,
      actualDurationSeconds:
          actualDurationSeconds ?? this.actualDurationSeconds,
      wasSkipped: wasSkipped ?? this.wasSkipped,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (sessionId.present) {
      map['session_id'] = Variable<String>(sessionId.value);
    }
    if (executionSetId.present) {
      map['execution_set_id'] = Variable<String>(executionSetId.value);
    }
    if (exerciseId.present) {
      map['exercise_id'] = Variable<String>(exerciseId.value);
    }
    if (userId.present) {
      map['user_id'] = Variable<String>(userId.value);
    }
    if (startedAt.present) {
      map['started_at'] = Variable<DateTime>(startedAt.value);
    }
    if (endedAt.present) {
      map['ended_at'] = Variable<DateTime>(endedAt.value);
    }
    if (plannedDurationSeconds.present) {
      map['planned_duration_seconds'] = Variable<int>(
        plannedDurationSeconds.value,
      );
    }
    if (actualDurationSeconds.present) {
      map['actual_duration_seconds'] = Variable<int>(
        actualDurationSeconds.value,
      );
    }
    if (wasSkipped.present) {
      map['was_skipped'] = Variable<bool>(wasSkipped.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('RestIntervalMetricsCompanion(')
          ..write('id: $id, ')
          ..write('sessionId: $sessionId, ')
          ..write('executionSetId: $executionSetId, ')
          ..write('exerciseId: $exerciseId, ')
          ..write('userId: $userId, ')
          ..write('startedAt: $startedAt, ')
          ..write('endedAt: $endedAt, ')
          ..write('plannedDurationSeconds: $plannedDurationSeconds, ')
          ..write('actualDurationSeconds: $actualDurationSeconds, ')
          ..write('wasSkipped: $wasSkipped, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $DocumentsTable documents = $DocumentsTable(this);
  late final $DailyWorkoutSummariesTable dailyWorkoutSummaries =
      $DailyWorkoutSummariesTable(this);
  late final $ExerciseSetMetricsTable exerciseSetMetrics =
      $ExerciseSetMetricsTable(this);
  late final $PersonalRecordsTable personalRecords = $PersonalRecordsTable(
    this,
  );
  late final $MuscleVolumeBreakdownsTable muscleVolumeBreakdowns =
      $MuscleVolumeBreakdownsTable(this);
  late final $RestIntervalMetricsTable restIntervalMetrics =
      $RestIntervalMetricsTable(this);
  late final Index muscleVolumeUserWeekStart = Index(
    'muscle_volume_user_week_start',
    'CREATE INDEX muscle_volume_user_week_start ON muscle_volume_breakdowns (user_id, week_start_date)',
  );
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    documents,
    dailyWorkoutSummaries,
    exerciseSetMetrics,
    personalRecords,
    muscleVolumeBreakdowns,
    restIntervalMetrics,
    muscleVolumeUserWeekStart,
  ];
}

typedef $$DocumentsTableCreateCompanionBuilder = DocumentsCompanion Function({
  required String collection,
  required String id,
  required String jsonData,
  Value<int> schemaVersion,
  required DateTime createdAt,
  required DateTime updatedAt,
  Value<int> rowid,
});
typedef $$DocumentsTableUpdateCompanionBuilder = DocumentsCompanion Function({
  Value<String> collection,
  Value<String> id,
  Value<String> jsonData,
  Value<int> schemaVersion,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
  Value<int> rowid,
});

class $$DocumentsTableFilterComposer
    extends Composer<_$AppDatabase, $DocumentsTable> {
  $$DocumentsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get collection => $composableBuilder(
    column: $table.collection,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get jsonData => $composableBuilder(
    column: $table.jsonData,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get schemaVersion => $composableBuilder(
    column: $table.schemaVersion,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$DocumentsTableOrderingComposer
    extends Composer<_$AppDatabase, $DocumentsTable> {
  $$DocumentsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get collection => $composableBuilder(
    column: $table.collection,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get jsonData => $composableBuilder(
    column: $table.jsonData,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get schemaVersion => $composableBuilder(
    column: $table.schemaVersion,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$DocumentsTableAnnotationComposer
    extends Composer<_$AppDatabase, $DocumentsTable> {
  $$DocumentsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get collection => $composableBuilder(
    column: $table.collection,
    builder: (column) => column,
  );

  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get jsonData =>
      $composableBuilder(column: $table.jsonData, builder: (column) => column);

  GeneratedColumn<int> get schemaVersion => $composableBuilder(
    column: $table.schemaVersion,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$DocumentsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $DocumentsTable,
          Document,
          $$DocumentsTableFilterComposer,
          $$DocumentsTableOrderingComposer,
          $$DocumentsTableAnnotationComposer,
          $$DocumentsTableCreateCompanionBuilder,
          $$DocumentsTableUpdateCompanionBuilder,
          (Document, BaseReferences<_$AppDatabase, $DocumentsTable, Document>),
          Document,
          PrefetchHooks Function()
        > {
  $$DocumentsTableTableManager(_$AppDatabase db, $DocumentsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$DocumentsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$DocumentsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$DocumentsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> collection = const Value.absent(),
                Value<String> id = const Value.absent(),
                Value<String> jsonData = const Value.absent(),
                Value<int> schemaVersion = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => DocumentsCompanion(
                collection: collection,
                id: id,
                jsonData: jsonData,
                schemaVersion: schemaVersion,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String collection,
                required String id,
                required String jsonData,
                Value<int> schemaVersion = const Value.absent(),
                required DateTime createdAt,
                required DateTime updatedAt,
                Value<int> rowid = const Value.absent(),
              }) => DocumentsCompanion.insert(
                collection: collection,
                id: id,
                jsonData: jsonData,
                schemaVersion: schemaVersion,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$DocumentsTable, Document>(table),
                  BaseReferences<_$AppDatabase, $DocumentsTable, Document>(
                    db,
                    table,
                    e,
                  ),
                ),
              )
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$DocumentsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $DocumentsTable,
      Document,
      $$DocumentsTableFilterComposer,
      $$DocumentsTableOrderingComposer,
      $$DocumentsTableAnnotationComposer,
      $$DocumentsTableCreateCompanionBuilder,
      $$DocumentsTableUpdateCompanionBuilder,
      (Document, BaseReferences<_$AppDatabase, $DocumentsTable, Document>),
      Document,
      PrefetchHooks Function()
    >;
typedef $$DailyWorkoutSummariesTableCreateCompanionBuilder =
    DailyWorkoutSummariesCompanion Function({
      required String id,
      required DateTime date,
      required String sessionId,
      required String userId,
      required String templateName,
      required int durationSeconds,
      required int activeSeconds,
      required double volumeLoadKg,
      required int totalCompletedSets,
      required int totalCompletedReps,
      Value<double?> averageRpe,
      Value<int> rowid,
    });
typedef $$DailyWorkoutSummariesTableUpdateCompanionBuilder =
    DailyWorkoutSummariesCompanion Function({
      Value<String> id,
      Value<DateTime> date,
      Value<String> sessionId,
      Value<String> userId,
      Value<String> templateName,
      Value<int> durationSeconds,
      Value<int> activeSeconds,
      Value<double> volumeLoadKg,
      Value<int> totalCompletedSets,
      Value<int> totalCompletedReps,
      Value<double?> averageRpe,
      Value<int> rowid,
    });

class $$DailyWorkoutSummariesTableFilterComposer
    extends Composer<_$AppDatabase, $DailyWorkoutSummariesTable> {
  $$DailyWorkoutSummariesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get date => $composableBuilder(
    column: $table.date,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get sessionId => $composableBuilder(
    column: $table.sessionId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get userId => $composableBuilder(
    column: $table.userId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get templateName => $composableBuilder(
    column: $table.templateName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get durationSeconds => $composableBuilder(
    column: $table.durationSeconds,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get activeSeconds => $composableBuilder(
    column: $table.activeSeconds,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get volumeLoadKg => $composableBuilder(
    column: $table.volumeLoadKg,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get totalCompletedSets => $composableBuilder(
    column: $table.totalCompletedSets,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get totalCompletedReps => $composableBuilder(
    column: $table.totalCompletedReps,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get averageRpe => $composableBuilder(
    column: $table.averageRpe,
    builder: (column) => ColumnFilters(column),
  );
}

class $$DailyWorkoutSummariesTableOrderingComposer
    extends Composer<_$AppDatabase, $DailyWorkoutSummariesTable> {
  $$DailyWorkoutSummariesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get date => $composableBuilder(
    column: $table.date,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get sessionId => $composableBuilder(
    column: $table.sessionId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get userId => $composableBuilder(
    column: $table.userId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get templateName => $composableBuilder(
    column: $table.templateName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get durationSeconds => $composableBuilder(
    column: $table.durationSeconds,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get activeSeconds => $composableBuilder(
    column: $table.activeSeconds,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get volumeLoadKg => $composableBuilder(
    column: $table.volumeLoadKg,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get totalCompletedSets => $composableBuilder(
    column: $table.totalCompletedSets,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get totalCompletedReps => $composableBuilder(
    column: $table.totalCompletedReps,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get averageRpe => $composableBuilder(
    column: $table.averageRpe,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$DailyWorkoutSummariesTableAnnotationComposer
    extends Composer<_$AppDatabase, $DailyWorkoutSummariesTable> {
  $$DailyWorkoutSummariesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<DateTime> get date =>
      $composableBuilder(column: $table.date, builder: (column) => column);

  GeneratedColumn<String> get sessionId =>
      $composableBuilder(column: $table.sessionId, builder: (column) => column);

  GeneratedColumn<String> get userId =>
      $composableBuilder(column: $table.userId, builder: (column) => column);

  GeneratedColumn<String> get templateName => $composableBuilder(
    column: $table.templateName,
    builder: (column) => column,
  );

  GeneratedColumn<int> get durationSeconds => $composableBuilder(
    column: $table.durationSeconds,
    builder: (column) => column,
  );

  GeneratedColumn<int> get activeSeconds => $composableBuilder(
    column: $table.activeSeconds,
    builder: (column) => column,
  );

  GeneratedColumn<double> get volumeLoadKg => $composableBuilder(
    column: $table.volumeLoadKg,
    builder: (column) => column,
  );

  GeneratedColumn<int> get totalCompletedSets => $composableBuilder(
    column: $table.totalCompletedSets,
    builder: (column) => column,
  );

  GeneratedColumn<int> get totalCompletedReps => $composableBuilder(
    column: $table.totalCompletedReps,
    builder: (column) => column,
  );

  GeneratedColumn<double> get averageRpe => $composableBuilder(
    column: $table.averageRpe,
    builder: (column) => column,
  );
}

class $$DailyWorkoutSummariesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $DailyWorkoutSummariesTable,
          DailyWorkoutSummaryRow,
          $$DailyWorkoutSummariesTableFilterComposer,
          $$DailyWorkoutSummariesTableOrderingComposer,
          $$DailyWorkoutSummariesTableAnnotationComposer,
          $$DailyWorkoutSummariesTableCreateCompanionBuilder,
          $$DailyWorkoutSummariesTableUpdateCompanionBuilder,
          (
            DailyWorkoutSummaryRow,
            BaseReferences<
              _$AppDatabase,
              $DailyWorkoutSummariesTable,
              DailyWorkoutSummaryRow
            >,
          ),
          DailyWorkoutSummaryRow,
          PrefetchHooks Function()
        > {
  $$DailyWorkoutSummariesTableTableManager(
    _$AppDatabase db,
    $DailyWorkoutSummariesTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$DailyWorkoutSummariesTableFilterComposer(
                $db: db,
                $table: table,
              ),
          createOrderingComposer: () =>
              $$DailyWorkoutSummariesTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer: () =>
              $$DailyWorkoutSummariesTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<DateTime> date = const Value.absent(),
                Value<String> sessionId = const Value.absent(),
                Value<String> userId = const Value.absent(),
                Value<String> templateName = const Value.absent(),
                Value<int> durationSeconds = const Value.absent(),
                Value<int> activeSeconds = const Value.absent(),
                Value<double> volumeLoadKg = const Value.absent(),
                Value<int> totalCompletedSets = const Value.absent(),
                Value<int> totalCompletedReps = const Value.absent(),
                Value<double?> averageRpe = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => DailyWorkoutSummariesCompanion(
                id: id,
                date: date,
                sessionId: sessionId,
                userId: userId,
                templateName: templateName,
                durationSeconds: durationSeconds,
                activeSeconds: activeSeconds,
                volumeLoadKg: volumeLoadKg,
                totalCompletedSets: totalCompletedSets,
                totalCompletedReps: totalCompletedReps,
                averageRpe: averageRpe,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required DateTime date,
                required String sessionId,
                required String userId,
                required String templateName,
                required int durationSeconds,
                required int activeSeconds,
                required double volumeLoadKg,
                required int totalCompletedSets,
                required int totalCompletedReps,
                Value<double?> averageRpe = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => DailyWorkoutSummariesCompanion.insert(
                id: id,
                date: date,
                sessionId: sessionId,
                userId: userId,
                templateName: templateName,
                durationSeconds: durationSeconds,
                activeSeconds: activeSeconds,
                volumeLoadKg: volumeLoadKg,
                totalCompletedSets: totalCompletedSets,
                totalCompletedReps: totalCompletedReps,
                averageRpe: averageRpe,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<
                    $DailyWorkoutSummariesTable,
                    DailyWorkoutSummaryRow
                  >(table),
                  BaseReferences<
                    _$AppDatabase,
                    $DailyWorkoutSummariesTable,
                    DailyWorkoutSummaryRow
                  >(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$DailyWorkoutSummariesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $DailyWorkoutSummariesTable,
      DailyWorkoutSummaryRow,
      $$DailyWorkoutSummariesTableFilterComposer,
      $$DailyWorkoutSummariesTableOrderingComposer,
      $$DailyWorkoutSummariesTableAnnotationComposer,
      $$DailyWorkoutSummariesTableCreateCompanionBuilder,
      $$DailyWorkoutSummariesTableUpdateCompanionBuilder,
      (
        DailyWorkoutSummaryRow,
        BaseReferences<
          _$AppDatabase,
          $DailyWorkoutSummariesTable,
          DailyWorkoutSummaryRow
        >,
      ),
      DailyWorkoutSummaryRow,
      PrefetchHooks Function()
    >;
typedef $$ExerciseSetMetricsTableCreateCompanionBuilder =
    ExerciseSetMetricsCompanion Function({
      required String id,
      required String sessionId,
      required String exerciseId,
      required String userId,
      required DateTime timestamp,
      Value<double?> weightKg,
      Value<int?> reps,
      Value<double?> volumeLoad,
      Value<double?> estimated1Rm,
      Value<double?> rpe,
      Value<int?> rir,
      required String setType,
      Value<int> rowid,
    });
typedef $$ExerciseSetMetricsTableUpdateCompanionBuilder =
    ExerciseSetMetricsCompanion Function({
      Value<String> id,
      Value<String> sessionId,
      Value<String> exerciseId,
      Value<String> userId,
      Value<DateTime> timestamp,
      Value<double?> weightKg,
      Value<int?> reps,
      Value<double?> volumeLoad,
      Value<double?> estimated1Rm,
      Value<double?> rpe,
      Value<int?> rir,
      Value<String> setType,
      Value<int> rowid,
    });

class $$ExerciseSetMetricsTableFilterComposer
    extends Composer<_$AppDatabase, $ExerciseSetMetricsTable> {
  $$ExerciseSetMetricsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get sessionId => $composableBuilder(
    column: $table.sessionId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get exerciseId => $composableBuilder(
    column: $table.exerciseId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get userId => $composableBuilder(
    column: $table.userId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get timestamp => $composableBuilder(
    column: $table.timestamp,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get weightKg => $composableBuilder(
    column: $table.weightKg,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get reps => $composableBuilder(
    column: $table.reps,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get volumeLoad => $composableBuilder(
    column: $table.volumeLoad,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get estimated1Rm => $composableBuilder(
    column: $table.estimated1Rm,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get rpe => $composableBuilder(
    column: $table.rpe,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get rir => $composableBuilder(
    column: $table.rir,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get setType => $composableBuilder(
    column: $table.setType,
    builder: (column) => ColumnFilters(column),
  );
}

class $$ExerciseSetMetricsTableOrderingComposer
    extends Composer<_$AppDatabase, $ExerciseSetMetricsTable> {
  $$ExerciseSetMetricsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get sessionId => $composableBuilder(
    column: $table.sessionId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get exerciseId => $composableBuilder(
    column: $table.exerciseId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get userId => $composableBuilder(
    column: $table.userId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get timestamp => $composableBuilder(
    column: $table.timestamp,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get weightKg => $composableBuilder(
    column: $table.weightKg,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get reps => $composableBuilder(
    column: $table.reps,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get volumeLoad => $composableBuilder(
    column: $table.volumeLoad,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get estimated1Rm => $composableBuilder(
    column: $table.estimated1Rm,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get rpe => $composableBuilder(
    column: $table.rpe,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get rir => $composableBuilder(
    column: $table.rir,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get setType => $composableBuilder(
    column: $table.setType,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$ExerciseSetMetricsTableAnnotationComposer
    extends Composer<_$AppDatabase, $ExerciseSetMetricsTable> {
  $$ExerciseSetMetricsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get sessionId =>
      $composableBuilder(column: $table.sessionId, builder: (column) => column);

  GeneratedColumn<String> get exerciseId => $composableBuilder(
    column: $table.exerciseId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get userId =>
      $composableBuilder(column: $table.userId, builder: (column) => column);

  GeneratedColumn<DateTime> get timestamp =>
      $composableBuilder(column: $table.timestamp, builder: (column) => column);

  GeneratedColumn<double> get weightKg =>
      $composableBuilder(column: $table.weightKg, builder: (column) => column);

  GeneratedColumn<int> get reps =>
      $composableBuilder(column: $table.reps, builder: (column) => column);

  GeneratedColumn<double> get volumeLoad => $composableBuilder(
    column: $table.volumeLoad,
    builder: (column) => column,
  );

  GeneratedColumn<double> get estimated1Rm => $composableBuilder(
    column: $table.estimated1Rm,
    builder: (column) => column,
  );

  GeneratedColumn<double> get rpe =>
      $composableBuilder(column: $table.rpe, builder: (column) => column);

  GeneratedColumn<int> get rir =>
      $composableBuilder(column: $table.rir, builder: (column) => column);

  GeneratedColumn<String> get setType =>
      $composableBuilder(column: $table.setType, builder: (column) => column);
}

class $$ExerciseSetMetricsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ExerciseSetMetricsTable,
          ExerciseSetMetricRow,
          $$ExerciseSetMetricsTableFilterComposer,
          $$ExerciseSetMetricsTableOrderingComposer,
          $$ExerciseSetMetricsTableAnnotationComposer,
          $$ExerciseSetMetricsTableCreateCompanionBuilder,
          $$ExerciseSetMetricsTableUpdateCompanionBuilder,
          (
            ExerciseSetMetricRow,
            BaseReferences<
              _$AppDatabase,
              $ExerciseSetMetricsTable,
              ExerciseSetMetricRow
            >,
          ),
          ExerciseSetMetricRow,
          PrefetchHooks Function()
        > {
  $$ExerciseSetMetricsTableTableManager(
    _$AppDatabase db,
    $ExerciseSetMetricsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ExerciseSetMetricsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ExerciseSetMetricsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ExerciseSetMetricsTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> sessionId = const Value.absent(),
                Value<String> exerciseId = const Value.absent(),
                Value<String> userId = const Value.absent(),
                Value<DateTime> timestamp = const Value.absent(),
                Value<double?> weightKg = const Value.absent(),
                Value<int?> reps = const Value.absent(),
                Value<double?> volumeLoad = const Value.absent(),
                Value<double?> estimated1Rm = const Value.absent(),
                Value<double?> rpe = const Value.absent(),
                Value<int?> rir = const Value.absent(),
                Value<String> setType = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ExerciseSetMetricsCompanion(
                id: id,
                sessionId: sessionId,
                exerciseId: exerciseId,
                userId: userId,
                timestamp: timestamp,
                weightKg: weightKg,
                reps: reps,
                volumeLoad: volumeLoad,
                estimated1Rm: estimated1Rm,
                rpe: rpe,
                rir: rir,
                setType: setType,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String sessionId,
                required String exerciseId,
                required String userId,
                required DateTime timestamp,
                Value<double?> weightKg = const Value.absent(),
                Value<int?> reps = const Value.absent(),
                Value<double?> volumeLoad = const Value.absent(),
                Value<double?> estimated1Rm = const Value.absent(),
                Value<double?> rpe = const Value.absent(),
                Value<int?> rir = const Value.absent(),
                required String setType,
                Value<int> rowid = const Value.absent(),
              }) => ExerciseSetMetricsCompanion.insert(
                id: id,
                sessionId: sessionId,
                exerciseId: exerciseId,
                userId: userId,
                timestamp: timestamp,
                weightKg: weightKg,
                reps: reps,
                volumeLoad: volumeLoad,
                estimated1Rm: estimated1Rm,
                rpe: rpe,
                rir: rir,
                setType: setType,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$ExerciseSetMetricsTable, ExerciseSetMetricRow>(
                    table,
                  ),
                  BaseReferences<
                    _$AppDatabase,
                    $ExerciseSetMetricsTable,
                    ExerciseSetMetricRow
                  >(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$ExerciseSetMetricsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ExerciseSetMetricsTable,
      ExerciseSetMetricRow,
      $$ExerciseSetMetricsTableFilterComposer,
      $$ExerciseSetMetricsTableOrderingComposer,
      $$ExerciseSetMetricsTableAnnotationComposer,
      $$ExerciseSetMetricsTableCreateCompanionBuilder,
      $$ExerciseSetMetricsTableUpdateCompanionBuilder,
      (
        ExerciseSetMetricRow,
        BaseReferences<
          _$AppDatabase,
          $ExerciseSetMetricsTable,
          ExerciseSetMetricRow
        >,
      ),
      ExerciseSetMetricRow,
      PrefetchHooks Function()
    >;
typedef $$PersonalRecordsTableCreateCompanionBuilder =
    PersonalRecordsCompanion Function({
      required String id,
      required String exerciseId,
      required String userId,
      required String prType,
      required double value,
      required String sessionId,
      Value<String?> setId,
      required DateTime achievedAt,
      Value<String?> replacesRecordId,
      Value<int> rowid,
    });
typedef $$PersonalRecordsTableUpdateCompanionBuilder =
    PersonalRecordsCompanion Function({
      Value<String> id,
      Value<String> exerciseId,
      Value<String> userId,
      Value<String> prType,
      Value<double> value,
      Value<String> sessionId,
      Value<String?> setId,
      Value<DateTime> achievedAt,
      Value<String?> replacesRecordId,
      Value<int> rowid,
    });

class $$PersonalRecordsTableFilterComposer
    extends Composer<_$AppDatabase, $PersonalRecordsTable> {
  $$PersonalRecordsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get exerciseId => $composableBuilder(
    column: $table.exerciseId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get userId => $composableBuilder(
    column: $table.userId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get prType => $composableBuilder(
    column: $table.prType,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get value => $composableBuilder(
    column: $table.value,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get sessionId => $composableBuilder(
    column: $table.sessionId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get setId => $composableBuilder(
    column: $table.setId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get achievedAt => $composableBuilder(
    column: $table.achievedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get replacesRecordId => $composableBuilder(
    column: $table.replacesRecordId,
    builder: (column) => ColumnFilters(column),
  );
}

class $$PersonalRecordsTableOrderingComposer
    extends Composer<_$AppDatabase, $PersonalRecordsTable> {
  $$PersonalRecordsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get exerciseId => $composableBuilder(
    column: $table.exerciseId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get userId => $composableBuilder(
    column: $table.userId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get prType => $composableBuilder(
    column: $table.prType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get value => $composableBuilder(
    column: $table.value,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get sessionId => $composableBuilder(
    column: $table.sessionId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get setId => $composableBuilder(
    column: $table.setId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get achievedAt => $composableBuilder(
    column: $table.achievedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get replacesRecordId => $composableBuilder(
    column: $table.replacesRecordId,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$PersonalRecordsTableAnnotationComposer
    extends Composer<_$AppDatabase, $PersonalRecordsTable> {
  $$PersonalRecordsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get exerciseId => $composableBuilder(
    column: $table.exerciseId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get userId =>
      $composableBuilder(column: $table.userId, builder: (column) => column);

  GeneratedColumn<String> get prType =>
      $composableBuilder(column: $table.prType, builder: (column) => column);

  GeneratedColumn<double> get value =>
      $composableBuilder(column: $table.value, builder: (column) => column);

  GeneratedColumn<String> get sessionId =>
      $composableBuilder(column: $table.sessionId, builder: (column) => column);

  GeneratedColumn<String> get setId =>
      $composableBuilder(column: $table.setId, builder: (column) => column);

  GeneratedColumn<DateTime> get achievedAt => $composableBuilder(
    column: $table.achievedAt,
    builder: (column) => column,
  );

  GeneratedColumn<String> get replacesRecordId => $composableBuilder(
    column: $table.replacesRecordId,
    builder: (column) => column,
  );
}

class $$PersonalRecordsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $PersonalRecordsTable,
          PersonalRecordRow,
          $$PersonalRecordsTableFilterComposer,
          $$PersonalRecordsTableOrderingComposer,
          $$PersonalRecordsTableAnnotationComposer,
          $$PersonalRecordsTableCreateCompanionBuilder,
          $$PersonalRecordsTableUpdateCompanionBuilder,
          (
            PersonalRecordRow,
            BaseReferences<
              _$AppDatabase,
              $PersonalRecordsTable,
              PersonalRecordRow
            >,
          ),
          PersonalRecordRow,
          PrefetchHooks Function()
        > {
  $$PersonalRecordsTableTableManager(
    _$AppDatabase db,
    $PersonalRecordsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$PersonalRecordsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$PersonalRecordsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$PersonalRecordsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> exerciseId = const Value.absent(),
                Value<String> userId = const Value.absent(),
                Value<String> prType = const Value.absent(),
                Value<double> value = const Value.absent(),
                Value<String> sessionId = const Value.absent(),
                Value<String?> setId = const Value.absent(),
                Value<DateTime> achievedAt = const Value.absent(),
                Value<String?> replacesRecordId = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => PersonalRecordsCompanion(
                id: id,
                exerciseId: exerciseId,
                userId: userId,
                prType: prType,
                value: value,
                sessionId: sessionId,
                setId: setId,
                achievedAt: achievedAt,
                replacesRecordId: replacesRecordId,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String exerciseId,
                required String userId,
                required String prType,
                required double value,
                required String sessionId,
                Value<String?> setId = const Value.absent(),
                required DateTime achievedAt,
                Value<String?> replacesRecordId = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => PersonalRecordsCompanion.insert(
                id: id,
                exerciseId: exerciseId,
                userId: userId,
                prType: prType,
                value: value,
                sessionId: sessionId,
                setId: setId,
                achievedAt: achievedAt,
                replacesRecordId: replacesRecordId,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$PersonalRecordsTable, PersonalRecordRow>(table),
                  BaseReferences<
                    _$AppDatabase,
                    $PersonalRecordsTable,
                    PersonalRecordRow
                  >(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$PersonalRecordsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $PersonalRecordsTable,
      PersonalRecordRow,
      $$PersonalRecordsTableFilterComposer,
      $$PersonalRecordsTableOrderingComposer,
      $$PersonalRecordsTableAnnotationComposer,
      $$PersonalRecordsTableCreateCompanionBuilder,
      $$PersonalRecordsTableUpdateCompanionBuilder,
      (
        PersonalRecordRow,
        BaseReferences<_$AppDatabase, $PersonalRecordsTable, PersonalRecordRow>,
      ),
      PersonalRecordRow,
      PrefetchHooks Function()
    >;
typedef $$MuscleVolumeBreakdownsTableCreateCompanionBuilder =
    MuscleVolumeBreakdownsCompanion Function({
      required String id,
      required String userId,
      required String muscleGroup,
      required int isoYear,
      required int isoWeek,
      required DateTime weekStartDate,
      required double totalVolumeKg,
      required int totalSets,
      Value<int> rowid,
    });
typedef $$MuscleVolumeBreakdownsTableUpdateCompanionBuilder =
    MuscleVolumeBreakdownsCompanion Function({
      Value<String> id,
      Value<String> userId,
      Value<String> muscleGroup,
      Value<int> isoYear,
      Value<int> isoWeek,
      Value<DateTime> weekStartDate,
      Value<double> totalVolumeKg,
      Value<int> totalSets,
      Value<int> rowid,
    });

class $$MuscleVolumeBreakdownsTableFilterComposer
    extends Composer<_$AppDatabase, $MuscleVolumeBreakdownsTable> {
  $$MuscleVolumeBreakdownsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get userId => $composableBuilder(
    column: $table.userId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get muscleGroup => $composableBuilder(
    column: $table.muscleGroup,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get isoYear => $composableBuilder(
    column: $table.isoYear,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get isoWeek => $composableBuilder(
    column: $table.isoWeek,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get weekStartDate => $composableBuilder(
    column: $table.weekStartDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get totalVolumeKg => $composableBuilder(
    column: $table.totalVolumeKg,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get totalSets => $composableBuilder(
    column: $table.totalSets,
    builder: (column) => ColumnFilters(column),
  );
}

class $$MuscleVolumeBreakdownsTableOrderingComposer
    extends Composer<_$AppDatabase, $MuscleVolumeBreakdownsTable> {
  $$MuscleVolumeBreakdownsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get userId => $composableBuilder(
    column: $table.userId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get muscleGroup => $composableBuilder(
    column: $table.muscleGroup,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get isoYear => $composableBuilder(
    column: $table.isoYear,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get isoWeek => $composableBuilder(
    column: $table.isoWeek,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get weekStartDate => $composableBuilder(
    column: $table.weekStartDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get totalVolumeKg => $composableBuilder(
    column: $table.totalVolumeKg,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get totalSets => $composableBuilder(
    column: $table.totalSets,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$MuscleVolumeBreakdownsTableAnnotationComposer
    extends Composer<_$AppDatabase, $MuscleVolumeBreakdownsTable> {
  $$MuscleVolumeBreakdownsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get userId =>
      $composableBuilder(column: $table.userId, builder: (column) => column);

  GeneratedColumn<String> get muscleGroup => $composableBuilder(
    column: $table.muscleGroup,
    builder: (column) => column,
  );

  GeneratedColumn<int> get isoYear =>
      $composableBuilder(column: $table.isoYear, builder: (column) => column);

  GeneratedColumn<int> get isoWeek =>
      $composableBuilder(column: $table.isoWeek, builder: (column) => column);

  GeneratedColumn<DateTime> get weekStartDate => $composableBuilder(
    column: $table.weekStartDate,
    builder: (column) => column,
  );

  GeneratedColumn<double> get totalVolumeKg => $composableBuilder(
    column: $table.totalVolumeKg,
    builder: (column) => column,
  );

  GeneratedColumn<int> get totalSets =>
      $composableBuilder(column: $table.totalSets, builder: (column) => column);
}

class $$MuscleVolumeBreakdownsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $MuscleVolumeBreakdownsTable,
          MuscleVolumeBreakdownRow,
          $$MuscleVolumeBreakdownsTableFilterComposer,
          $$MuscleVolumeBreakdownsTableOrderingComposer,
          $$MuscleVolumeBreakdownsTableAnnotationComposer,
          $$MuscleVolumeBreakdownsTableCreateCompanionBuilder,
          $$MuscleVolumeBreakdownsTableUpdateCompanionBuilder,
          (
            MuscleVolumeBreakdownRow,
            BaseReferences<
              _$AppDatabase,
              $MuscleVolumeBreakdownsTable,
              MuscleVolumeBreakdownRow
            >,
          ),
          MuscleVolumeBreakdownRow,
          PrefetchHooks Function()
        > {
  $$MuscleVolumeBreakdownsTableTableManager(
    _$AppDatabase db,
    $MuscleVolumeBreakdownsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$MuscleVolumeBreakdownsTableFilterComposer(
                $db: db,
                $table: table,
              ),
          createOrderingComposer: () =>
              $$MuscleVolumeBreakdownsTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer: () =>
              $$MuscleVolumeBreakdownsTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> userId = const Value.absent(),
                Value<String> muscleGroup = const Value.absent(),
                Value<int> isoYear = const Value.absent(),
                Value<int> isoWeek = const Value.absent(),
                Value<DateTime> weekStartDate = const Value.absent(),
                Value<double> totalVolumeKg = const Value.absent(),
                Value<int> totalSets = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => MuscleVolumeBreakdownsCompanion(
                id: id,
                userId: userId,
                muscleGroup: muscleGroup,
                isoYear: isoYear,
                isoWeek: isoWeek,
                weekStartDate: weekStartDate,
                totalVolumeKg: totalVolumeKg,
                totalSets: totalSets,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String userId,
                required String muscleGroup,
                required int isoYear,
                required int isoWeek,
                required DateTime weekStartDate,
                required double totalVolumeKg,
                required int totalSets,
                Value<int> rowid = const Value.absent(),
              }) => MuscleVolumeBreakdownsCompanion.insert(
                id: id,
                userId: userId,
                muscleGroup: muscleGroup,
                isoYear: isoYear,
                isoWeek: isoWeek,
                weekStartDate: weekStartDate,
                totalVolumeKg: totalVolumeKg,
                totalSets: totalSets,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<
                    $MuscleVolumeBreakdownsTable,
                    MuscleVolumeBreakdownRow
                  >(table),
                  BaseReferences<
                    _$AppDatabase,
                    $MuscleVolumeBreakdownsTable,
                    MuscleVolumeBreakdownRow
                  >(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$MuscleVolumeBreakdownsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $MuscleVolumeBreakdownsTable,
      MuscleVolumeBreakdownRow,
      $$MuscleVolumeBreakdownsTableFilterComposer,
      $$MuscleVolumeBreakdownsTableOrderingComposer,
      $$MuscleVolumeBreakdownsTableAnnotationComposer,
      $$MuscleVolumeBreakdownsTableCreateCompanionBuilder,
      $$MuscleVolumeBreakdownsTableUpdateCompanionBuilder,
      (
        MuscleVolumeBreakdownRow,
        BaseReferences<
          _$AppDatabase,
          $MuscleVolumeBreakdownsTable,
          MuscleVolumeBreakdownRow
        >,
      ),
      MuscleVolumeBreakdownRow,
      PrefetchHooks Function()
    >;
typedef $$RestIntervalMetricsTableCreateCompanionBuilder =
    RestIntervalMetricsCompanion Function({
      required String id,
      required String sessionId,
      required String executionSetId,
      required String exerciseId,
      required String userId,
      required DateTime startedAt,
      Value<DateTime?> endedAt,
      required int plannedDurationSeconds,
      Value<int?> actualDurationSeconds,
      required bool wasSkipped,
      Value<int> rowid,
    });
typedef $$RestIntervalMetricsTableUpdateCompanionBuilder =
    RestIntervalMetricsCompanion Function({
      Value<String> id,
      Value<String> sessionId,
      Value<String> executionSetId,
      Value<String> exerciseId,
      Value<String> userId,
      Value<DateTime> startedAt,
      Value<DateTime?> endedAt,
      Value<int> plannedDurationSeconds,
      Value<int?> actualDurationSeconds,
      Value<bool> wasSkipped,
      Value<int> rowid,
    });

class $$RestIntervalMetricsTableFilterComposer
    extends Composer<_$AppDatabase, $RestIntervalMetricsTable> {
  $$RestIntervalMetricsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get sessionId => $composableBuilder(
    column: $table.sessionId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get executionSetId => $composableBuilder(
    column: $table.executionSetId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get exerciseId => $composableBuilder(
    column: $table.exerciseId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get userId => $composableBuilder(
    column: $table.userId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get startedAt => $composableBuilder(
    column: $table.startedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get endedAt => $composableBuilder(
    column: $table.endedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get plannedDurationSeconds => $composableBuilder(
    column: $table.plannedDurationSeconds,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get actualDurationSeconds => $composableBuilder(
    column: $table.actualDurationSeconds,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get wasSkipped => $composableBuilder(
    column: $table.wasSkipped,
    builder: (column) => ColumnFilters(column),
  );
}

class $$RestIntervalMetricsTableOrderingComposer
    extends Composer<_$AppDatabase, $RestIntervalMetricsTable> {
  $$RestIntervalMetricsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get sessionId => $composableBuilder(
    column: $table.sessionId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get executionSetId => $composableBuilder(
    column: $table.executionSetId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get exerciseId => $composableBuilder(
    column: $table.exerciseId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get userId => $composableBuilder(
    column: $table.userId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get startedAt => $composableBuilder(
    column: $table.startedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get endedAt => $composableBuilder(
    column: $table.endedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get plannedDurationSeconds => $composableBuilder(
    column: $table.plannedDurationSeconds,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get actualDurationSeconds => $composableBuilder(
    column: $table.actualDurationSeconds,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get wasSkipped => $composableBuilder(
    column: $table.wasSkipped,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$RestIntervalMetricsTableAnnotationComposer
    extends Composer<_$AppDatabase, $RestIntervalMetricsTable> {
  $$RestIntervalMetricsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get sessionId =>
      $composableBuilder(column: $table.sessionId, builder: (column) => column);

  GeneratedColumn<String> get executionSetId => $composableBuilder(
    column: $table.executionSetId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get exerciseId => $composableBuilder(
    column: $table.exerciseId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get userId =>
      $composableBuilder(column: $table.userId, builder: (column) => column);

  GeneratedColumn<DateTime> get startedAt =>
      $composableBuilder(column: $table.startedAt, builder: (column) => column);

  GeneratedColumn<DateTime> get endedAt =>
      $composableBuilder(column: $table.endedAt, builder: (column) => column);

  GeneratedColumn<int> get plannedDurationSeconds => $composableBuilder(
    column: $table.plannedDurationSeconds,
    builder: (column) => column,
  );

  GeneratedColumn<int> get actualDurationSeconds => $composableBuilder(
    column: $table.actualDurationSeconds,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get wasSkipped => $composableBuilder(
    column: $table.wasSkipped,
    builder: (column) => column,
  );
}

class $$RestIntervalMetricsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $RestIntervalMetricsTable,
          RestIntervalMetricRow,
          $$RestIntervalMetricsTableFilterComposer,
          $$RestIntervalMetricsTableOrderingComposer,
          $$RestIntervalMetricsTableAnnotationComposer,
          $$RestIntervalMetricsTableCreateCompanionBuilder,
          $$RestIntervalMetricsTableUpdateCompanionBuilder,
          (
            RestIntervalMetricRow,
            BaseReferences<
              _$AppDatabase,
              $RestIntervalMetricsTable,
              RestIntervalMetricRow
            >,
          ),
          RestIntervalMetricRow,
          PrefetchHooks Function()
        > {
  $$RestIntervalMetricsTableTableManager(
    _$AppDatabase db,
    $RestIntervalMetricsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$RestIntervalMetricsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$RestIntervalMetricsTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer: () =>
              $$RestIntervalMetricsTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> sessionId = const Value.absent(),
                Value<String> executionSetId = const Value.absent(),
                Value<String> exerciseId = const Value.absent(),
                Value<String> userId = const Value.absent(),
                Value<DateTime> startedAt = const Value.absent(),
                Value<DateTime?> endedAt = const Value.absent(),
                Value<int> plannedDurationSeconds = const Value.absent(),
                Value<int?> actualDurationSeconds = const Value.absent(),
                Value<bool> wasSkipped = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => RestIntervalMetricsCompanion(
                id: id,
                sessionId: sessionId,
                executionSetId: executionSetId,
                exerciseId: exerciseId,
                userId: userId,
                startedAt: startedAt,
                endedAt: endedAt,
                plannedDurationSeconds: plannedDurationSeconds,
                actualDurationSeconds: actualDurationSeconds,
                wasSkipped: wasSkipped,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String sessionId,
                required String executionSetId,
                required String exerciseId,
                required String userId,
                required DateTime startedAt,
                Value<DateTime?> endedAt = const Value.absent(),
                required int plannedDurationSeconds,
                Value<int?> actualDurationSeconds = const Value.absent(),
                required bool wasSkipped,
                Value<int> rowid = const Value.absent(),
              }) => RestIntervalMetricsCompanion.insert(
                id: id,
                sessionId: sessionId,
                executionSetId: executionSetId,
                exerciseId: exerciseId,
                userId: userId,
                startedAt: startedAt,
                endedAt: endedAt,
                plannedDurationSeconds: plannedDurationSeconds,
                actualDurationSeconds: actualDurationSeconds,
                wasSkipped: wasSkipped,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$RestIntervalMetricsTable, RestIntervalMetricRow>(
                    table,
                  ),
                  BaseReferences<
                    _$AppDatabase,
                    $RestIntervalMetricsTable,
                    RestIntervalMetricRow
                  >(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$RestIntervalMetricsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $RestIntervalMetricsTable,
      RestIntervalMetricRow,
      $$RestIntervalMetricsTableFilterComposer,
      $$RestIntervalMetricsTableOrderingComposer,
      $$RestIntervalMetricsTableAnnotationComposer,
      $$RestIntervalMetricsTableCreateCompanionBuilder,
      $$RestIntervalMetricsTableUpdateCompanionBuilder,
      (
        RestIntervalMetricRow,
        BaseReferences<
          _$AppDatabase,
          $RestIntervalMetricsTable,
          RestIntervalMetricRow
        >,
      ),
      RestIntervalMetricRow,
      PrefetchHooks Function()
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$DocumentsTableTableManager get documents =>
      $$DocumentsTableTableManager(_db, _db.documents);
  $$DailyWorkoutSummariesTableTableManager get dailyWorkoutSummaries =>
      $$DailyWorkoutSummariesTableTableManager(_db, _db.dailyWorkoutSummaries);
  $$ExerciseSetMetricsTableTableManager get exerciseSetMetrics =>
      $$ExerciseSetMetricsTableTableManager(_db, _db.exerciseSetMetrics);
  $$PersonalRecordsTableTableManager get personalRecords =>
      $$PersonalRecordsTableTableManager(_db, _db.personalRecords);
  $$MuscleVolumeBreakdownsTableTableManager get muscleVolumeBreakdowns =>
      $$MuscleVolumeBreakdownsTableTableManager(
        _db,
        _db.muscleVolumeBreakdowns,
      );
  $$RestIntervalMetricsTableTableManager get restIntervalMetrics =>
      $$RestIntervalMetricsTableTableManager(_db, _db.restIntervalMetrics);
}
