// dart format width=80

/// GENERATED CODE - DO NOT MODIFY BY HAND
/// *****************************************************
///  FlutterGen
/// *****************************************************

// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: deprecated_member_use,directives_ordering,implicit_dynamic_list_literal,unnecessary_import

import 'package:flutter/widgets.dart';

class $AssetsAnimationsGen {
  const $AssetsAnimationsGen();

  /// File path: assets/animations/counters.json
  String get counters => 'assets/animations/counters.json';

  /// File path: assets/animations/timers.json
  String get timers => 'assets/animations/timers.json';

  /// File path: assets/animations/welcome.json
  String get welcome => 'assets/animations/welcome.json';

  /// List of all assets
  List<String> get values => [counters, timers, welcome];
}

class $AssetsImagesGen {
  const $AssetsImagesGen();

  /// Directory path: assets/images/png
  $AssetsImagesPngGen get png => const $AssetsImagesPngGen();
}

class $AssetsSoundsGen {
  const $AssetsSoundsGen();

  /// Directory path: assets/sounds/beep
  $AssetsSoundsBeepGen get beep => const $AssetsSoundsBeepGen();

  /// Directory path: assets/sounds/bell
  $AssetsSoundsBellGen get bell => const $AssetsSoundsBellGen();

  /// Directory path: assets/sounds/ding
  $AssetsSoundsDingGen get ding => const $AssetsSoundsDingGen();

  /// Directory path: assets/sounds/horn
  $AssetsSoundsHornGen get horn => const $AssetsSoundsHornGen();

  /// Directory path: assets/sounds/notification
  $AssetsSoundsNotificationGen get notification =>
      const $AssetsSoundsNotificationGen();

  /// Directory path: assets/sounds/thunk
  $AssetsSoundsThunkGen get thunk => const $AssetsSoundsThunkGen();

  /// Directory path: assets/sounds/whistle
  $AssetsSoundsWhistleGen get whistle => const $AssetsSoundsWhistleGen();
}

class $AssetsImagesPngGen {
  const $AssetsImagesPngGen();

  /// File path: assets/images/png/icon.png
  AssetGenImage get icon => const AssetGenImage('assets/images/png/icon.png');

  /// File path: assets/images/png/pattern.png
  AssetGenImage get pattern =>
      const AssetGenImage('assets/images/png/pattern.png');

  /// List of all assets
  List<AssetGenImage> get values => [icon, pattern];
}

class $AssetsSoundsBeepGen {
  const $AssetsSoundsBeepGen();

  /// File path: assets/sounds/beep/countdown.mp3
  String get countdown => 'assets/sounds/beep/countdown.mp3';

  /// File path: assets/sounds/beep/halfway.mp3
  String get halfway => 'assets/sounds/beep/halfway.mp3';

  /// File path: assets/sounds/beep/harsh_beep.mp3
  String get harshBeep => 'assets/sounds/beep/harsh_beep.mp3';

  /// File path: assets/sounds/beep/harsh_sequence.mp3
  String get harshSequence => 'assets/sounds/beep/harsh_sequence.mp3';

  /// File path: assets/sounds/beep/long_halfway.mp3
  String get longHalfway => 'assets/sounds/beep/long_halfway.mp3';

  /// File path: assets/sounds/beep/long_rest.mp3
  String get longRest => 'assets/sounds/beep/long_rest.mp3';

  /// File path: assets/sounds/beep/short_halfway.mp3
  String get shortHalfway => 'assets/sounds/beep/short_halfway.mp3';

  /// File path: assets/sounds/beep/shortest.mp3
  String get shortest => 'assets/sounds/beep/shortest.mp3';

  /// List of all assets
  List<String> get values => [
    countdown,
    halfway,
    harshBeep,
    harshSequence,
    longHalfway,
    longRest,
    shortHalfway,
    shortest,
  ];
}

class $AssetsSoundsBellGen {
  const $AssetsSoundsBellGen();

  /// File path: assets/sounds/bell/regular.mp3
  String get regular => 'assets/sounds/bell/regular.mp3';

  /// List of all assets
  List<String> get values => [regular];
}

class $AssetsSoundsDingGen {
  const $AssetsSoundsDingGen();

  /// File path: assets/sounds/ding/regular.mp3
  String get regular => 'assets/sounds/ding/regular.mp3';

  /// File path: assets/sounds/ding/sequence.mp3
  String get sequence => 'assets/sounds/ding/sequence.mp3';

  /// List of all assets
  List<String> get values => [regular, sequence];
}

class $AssetsSoundsHornGen {
  const $AssetsSoundsHornGen();

  /// File path: assets/sounds/horn/regular.mp3
  String get regular => 'assets/sounds/horn/regular.mp3';

  /// List of all assets
  List<String> get values => [regular];
}

class $AssetsSoundsNotificationGen {
  const $AssetsSoundsNotificationGen();

  /// File path: assets/sounds/notification/regular.mp3
  String get regular => 'assets/sounds/notification/regular.mp3';

  /// List of all assets
  List<String> get values => [regular];
}

class $AssetsSoundsThunkGen {
  const $AssetsSoundsThunkGen();

  /// File path: assets/sounds/thunk/regular.mp3
  String get regular => 'assets/sounds/thunk/regular.mp3';

  /// List of all assets
  List<String> get values => [regular];
}

class $AssetsSoundsWhistleGen {
  const $AssetsSoundsWhistleGen();

  /// File path: assets/sounds/whistle/long.mp3
  String get long => 'assets/sounds/whistle/long.mp3';

  /// File path: assets/sounds/whistle/short.mp3
  String get short => 'assets/sounds/whistle/short.mp3';

  /// List of all assets
  List<String> get values => [long, short];
}

abstract final class Assets {
  static const $AssetsAnimationsGen animations = $AssetsAnimationsGen();
  static const $AssetsImagesGen images = $AssetsImagesGen();
  static const $AssetsSoundsGen sounds = $AssetsSoundsGen();
}

class AssetGenImage {
  const AssetGenImage(
    this._assetName, {
    this.size,
    this.flavors = const {},
    this.animation,
  });

  final String _assetName;

  final Size? size;
  final Set<String> flavors;
  final AssetGenImageAnimation? animation;

  Image image({
    Key? key,
    AssetBundle? bundle,
    ImageFrameBuilder? frameBuilder,
    ImageErrorWidgetBuilder? errorBuilder,
    String? semanticLabel,
    bool excludeFromSemantics = false,
    double? scale,
    double? width,
    double? height,
    Color? color,
    Animation<double>? opacity,
    BlendMode? colorBlendMode,
    BoxFit? fit,
    AlignmentGeometry alignment = Alignment.center,
    ImageRepeat repeat = ImageRepeat.noRepeat,
    Rect? centerSlice,
    bool matchTextDirection = false,
    bool gaplessPlayback = true,
    bool isAntiAlias = false,
    String? package,
    FilterQuality filterQuality = FilterQuality.medium,
    int? cacheWidth,
    int? cacheHeight,
  }) {
    return Image.asset(
      _assetName,
      key: key,
      bundle: bundle,
      frameBuilder: frameBuilder,
      errorBuilder: errorBuilder,
      semanticLabel: semanticLabel,
      excludeFromSemantics: excludeFromSemantics,
      scale: scale,
      width: width,
      height: height,
      color: color,
      opacity: opacity,
      colorBlendMode: colorBlendMode,
      fit: fit,
      alignment: alignment,
      repeat: repeat,
      centerSlice: centerSlice,
      matchTextDirection: matchTextDirection,
      gaplessPlayback: gaplessPlayback,
      isAntiAlias: isAntiAlias,
      package: package,
      filterQuality: filterQuality,
      cacheWidth: cacheWidth,
      cacheHeight: cacheHeight,
    );
  }

  ImageProvider provider({AssetBundle? bundle, String? package}) {
    return AssetImage(_assetName, bundle: bundle, package: package);
  }

  String get path => _assetName;

  String get keyName => _assetName;
}

class AssetGenImageAnimation {
  const AssetGenImageAnimation({
    required this.isAnimation,
    required this.duration,
    required this.frames,
  });

  final bool isAnimation;
  final Duration duration;
  final int frames;
}
