/// GENERATED CODE - DO NOT MODIFY BY HAND
/// *****************************************************
///  FlutterGen
/// *****************************************************

// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: directives_ordering,unnecessary_import,implicit_dynamic_list_literal,deprecated_member_use

import 'package:flutter/widgets.dart';

class $AssetsIconsGen {
  const $AssetsIconsGen();

  /// File path: assets/icons/back_icon.svg
  String get backIcon => 'assets/icons/back_icon.svg';

  /// File path: assets/icons/check_radio_icon.svg
  String get checkRadioIcon => 'assets/icons/check_radio_icon.svg';

  /// File path: assets/icons/connects_icon.svg
  String get connectsIcon => 'assets/icons/connects_icon.svg';

  /// File path: assets/icons/drawer_icon.svg
  String get drawerIcon => 'assets/icons/drawer_icon.svg';

  /// File path: assets/icons/engagements_icon.svg
  String get engagementsIcon => 'assets/icons/engagements_icon.svg';

  /// File path: assets/icons/leaderboard_icon.svg
  String get leaderboardIcon => 'assets/icons/leaderboard_icon.svg';

  /// File path: assets/icons/search_icon.svg
  String get searchIcon => 'assets/icons/search_icon.svg';

  /// File path: assets/icons/teams_icon.svg
  String get teamsIcon => 'assets/icons/teams_icon.svg';

  /// File path: assets/icons/uncheck_radio_icon.svg
  String get uncheckRadioIcon => 'assets/icons/uncheck_radio_icon.svg';

  /// List of all assets
  List<String> get values => [
        backIcon,
        checkRadioIcon,
        connectsIcon,
        drawerIcon,
        engagementsIcon,
        leaderboardIcon,
        searchIcon,
        teamsIcon,
        uncheckRadioIcon
      ];
}

class $AssetsImagesGen {
  const $AssetsImagesGen();

  /// File path: assets/images/first_trophy.svg
  String get firstTrophy => 'assets/images/first_trophy.svg';

  /// File path: assets/images/forth_trophy.svg
  String get forthTrophy => 'assets/images/forth_trophy.svg';

  /// File path: assets/images/line_image.png
  AssetGenImage get lineImage =>
      const AssetGenImage('assets/images/line_image.png');

  /// File path: assets/images/no_team.svg
  String get noTeam => 'assets/images/no_team.svg';

  /// File path: assets/images/sample_image.png
  AssetGenImage get sampleImage =>
      const AssetGenImage('assets/images/sample_image.png');

  /// File path: assets/images/second_trophy.svg
  String get secondTrophy => 'assets/images/second_trophy.svg';

  /// File path: assets/images/splash_image.png
  AssetGenImage get splashImage =>
      const AssetGenImage('assets/images/splash_image.png');

  /// File path: assets/images/third_trophy.svg
  String get thirdTrophy => 'assets/images/third_trophy.svg';

  /// File path: assets/images/upload_image.svg
  String get uploadImage => 'assets/images/upload_image.svg';

  /// File path: assets/images/winner_trophy.png
  AssetGenImage get winnerTrophyPng =>
      const AssetGenImage('assets/images/winner_trophy.png');

  /// File path: assets/images/winner_trophy.svg
  String get winnerTrophySvg => 'assets/images/winner_trophy.svg';

  /// List of all assets
  List<dynamic> get values => [
        firstTrophy,
        forthTrophy,
        lineImage,
        noTeam,
        sampleImage,
        secondTrophy,
        splashImage,
        thirdTrophy,
        uploadImage,
        winnerTrophyPng,
        winnerTrophySvg
      ];
}

class Assets {
  Assets._();

  static const $AssetsIconsGen icons = $AssetsIconsGen();
  static const $AssetsImagesGen images = $AssetsImagesGen();
}

class AssetGenImage {
  const AssetGenImage(this._assetName);

  final String _assetName;

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
    bool gaplessPlayback = false,
    bool isAntiAlias = false,
    String? package,
    FilterQuality filterQuality = FilterQuality.low,
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

  ImageProvider provider({
    AssetBundle? bundle,
    String? package,
  }) {
    return AssetImage(
      _assetName,
      bundle: bundle,
      package: package,
    );
  }

  String get path => _assetName;

  String get keyName => _assetName;
}
