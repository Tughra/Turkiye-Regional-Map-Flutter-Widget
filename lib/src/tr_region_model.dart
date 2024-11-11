import 'package:flutter/material.dart';

typedef OnSelectRegionCallBack = void Function(TurkeyRegionType type, Offset tappedPosition,Offset centerRegionPosition);

enum TurkeyRegionType {
  marmara(0),
  ege(1),
  blackSea(2),
  easternAnatolia(3),
  southeasternAnatolia(4),
  mediterranean(5),
  centralAnatolia(6),
  istanbulAnatolia(7),
  istanbulEurope(7);

  const TurkeyRegionType(this.id);

  final int id;
}

class TurkeyRegionModel {
  TurkeyRegionType? selectedRegion;
  bool showIstanbulAnatoliaRegion;
  bool showIstanbulEuropeRegion;
  Color? egeColor;
  Color? marmaraColor;
  Color? blackSeaColor;
  Color? easternAnatoliaColor;
  Color? southeasternAnatoliaColor;
  Color? centralAnatoliaColor;
  Color? mediterraneanColor;
  Color? istanbulAnatoliaColor;
  Color? istAvrColor;
  Color unSelectedRegionColor;
  Color selectedRegionColor;
  Color borderColor;
  Color selectedBorderColor;
  double unSelectedWidthFactor;
  double selectedWidthFactor;

  TurkeyRegionModel({
    this.selectedRegion,
    this.showIstanbulAnatoliaRegion = false,
    this.showIstanbulEuropeRegion = false,
    this.egeColor,
    this.marmaraColor,
    this.blackSeaColor,
    this.easternAnatoliaColor,
    this.southeasternAnatoliaColor,
    this.centralAnatoliaColor,
    this.mediterraneanColor,
    this.istanbulAnatoliaColor,
    this.istAvrColor,
    this.unSelectedRegionColor = const Color.fromRGBO(183, 179, 179, 1),
    this.selectedRegionColor = const Color.fromRGBO(236, 5, 5, 1),
    this.borderColor = Colors.white,
    this.selectedBorderColor = Colors.white,
    this.unSelectedWidthFactor = 0.1,
    this.selectedWidthFactor = 1,
  })  : assert(0 < unSelectedWidthFactor),
        assert(0 < selectedWidthFactor);

  TurkeyRegionModel copyWith({
    TurkeyRegionType? selectedRegion,
    Color? egeColor,
    bool showIstanbulAnatoliaRegion = false,
    bool showIstanbulEuropeRegion = false,
    Color? marmaraColor,
    Color? blackSeaColor,
    Color? easternAnatoliaColor,
    Color? southeasternAnatoliaColor,
    Color? centralAnatoliaColor,
    Color? mediterraneanColor,
    Color? istanbulAnatoliaColor,
    Color? istAvrColor,
    Color? unSelectedRegionColor,
    Color? selectedRegionColor,
    Color? borderColor,
    Color? selectedBorderColor,
    double? unSelectedWidthFactor,
    double? selectedWidthFactor,
  }) {
    return TurkeyRegionModel(
      selectedRegion: selectedRegion ?? this.selectedRegion,
      egeColor: egeColor ?? this.egeColor,
      showIstanbulAnatoliaRegion: showIstanbulAnatoliaRegion,
      showIstanbulEuropeRegion: showIstanbulEuropeRegion,
      marmaraColor: marmaraColor ?? this.marmaraColor,
      blackSeaColor: blackSeaColor ?? this.blackSeaColor,
      easternAnatoliaColor: easternAnatoliaColor ?? this.easternAnatoliaColor,
      southeasternAnatoliaColor: southeasternAnatoliaColor ?? this.southeasternAnatoliaColor,
      centralAnatoliaColor: centralAnatoliaColor ?? this.centralAnatoliaColor,
      mediterraneanColor: mediterraneanColor ?? this.mediterraneanColor,
      istanbulAnatoliaColor: istanbulAnatoliaColor ?? this.istanbulAnatoliaColor,
      istAvrColor: istAvrColor ?? this.istAvrColor,
      unSelectedRegionColor: unSelectedRegionColor ?? this.unSelectedRegionColor,
      selectedRegionColor: selectedRegionColor ?? this.selectedRegionColor,
      borderColor: borderColor ?? this.borderColor,
      selectedBorderColor: selectedBorderColor ?? this.selectedBorderColor,
      unSelectedWidthFactor: unSelectedWidthFactor ?? this.unSelectedWidthFactor,
      selectedWidthFactor: selectedWidthFactor ?? this.selectedWidthFactor,
    );
  }
}
