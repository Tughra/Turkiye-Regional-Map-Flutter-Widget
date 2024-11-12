import 'package:flutter/material.dart';
import 'tr_region_model.dart';



class TurkiyeRegionPainter extends CustomPainter {
  final OnSelectRegionCallBack regionSelectCallback;
  final void Function(Offset position)? selectedRegionCenter;
  final TurkeyRegionModel regionModel;

  TurkiyeRegionPainter({required this.regionModel, required this.regionSelectCallback, this.selectedRegionCenter}) {
    //selectedRegion=regionModel.selectedRegion;
  }

  List<Path> pathList = [];

  late Color egeColor = regionModel.egeColor ?? regionModel.unSelectedRegionColor;
  late Color marmaraColor = regionModel.marmaraColor ?? regionModel.unSelectedRegionColor;
  late Color blackSeaColor = regionModel.blackSeaColor ?? regionModel.unSelectedRegionColor;
  late Color easternAnatoliaColor = regionModel.easternAnatoliaColor ?? regionModel.unSelectedRegionColor;
  late Color southeasternAnatoliaColor = regionModel.southeasternAnatoliaColor ?? regionModel.unSelectedRegionColor;
  late Color centralAnatoliaColor = regionModel.centralAnatoliaColor ?? regionModel.unSelectedRegionColor;
  late Color mediterraneanColor = regionModel.mediterraneanColor ?? regionModel.unSelectedRegionColor;

  void selectRegion(Canvas canvas, Size size) {
    if (regionModel.selectedRegion != null) {
      Paint paintStroke = Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = regionModel.selectedWidthFactor;
      paintStroke.color = regionModel.selectedBorderColor;
      paintStroke.strokeCap = StrokeCap.butt;
      paintStroke.strokeJoin = StrokeJoin.miter;
      switch (regionModel.selectedRegion!) {
        case TurkeyRegionType.ege:
          canvas.drawPath(pathList.first, paintStroke);
          canvas.drawPath(
              pathList.first,
              Paint()
                ..style = PaintingStyle.fill
                ..color = regionModel.selectedRegionColor);
          selectedRegionCenter?.call(pathList.first.getBounds().center);
          break;
        case TurkeyRegionType.marmara:
          marmaraColor = regionModel.selectedRegionColor;
          for (int a = 1; a <= 5; a++) {
            canvas.drawPath(pathList[a], paintStroke);
            canvas.drawPath(
                pathList[a],
                Paint()
                  ..style = PaintingStyle.fill
                  ..color = regionModel.selectedRegionColor);
          }
          selectedRegionCenter?.call(pathList[3].getBounds().center);
          break;
        case TurkeyRegionType.blackSea:
          canvas.drawPath(pathList[6], paintStroke);
          canvas.drawPath(
              pathList[6],
              Paint()
                ..style = PaintingStyle.fill
                ..color = regionModel.selectedRegionColor);
          selectedRegionCenter?.call(pathList[6].getBounds().center);
          break;
        case TurkeyRegionType.easternAnatolia:
          canvas.drawPath(pathList[7], paintStroke);
          canvas.drawPath(
              pathList[7],
              Paint()
                ..style = PaintingStyle.fill
                ..color = regionModel.selectedRegionColor);
          selectedRegionCenter?.call(pathList[7].getBounds().center);
          break;
        case TurkeyRegionType.southeasternAnatolia:
          canvas.drawPath(pathList[8], paintStroke);
          canvas.drawPath(
              pathList[8],
              Paint()
                ..style = PaintingStyle.fill
                ..color = regionModel.selectedRegionColor);
          selectedRegionCenter?.call(pathList[8].getBounds().center);
          break;
        case TurkeyRegionType.mediterranean:
          canvas.drawPath(pathList[9], paintStroke);
          canvas.drawPath(
              pathList[9],
              Paint()
                ..style = PaintingStyle.fill
                ..color = regionModel.selectedRegionColor);
          final pathRect = pathList[9].getBounds();
          selectedRegionCenter?.call(Offset(pathRect.center.dx, pathRect.center.dy + pathRect.height / 4));
          break;
        case TurkeyRegionType.centralAnatolia:
          canvas.drawPath(pathList[10], paintStroke);
          canvas.drawPath(
              pathList[10],
              Paint()
                ..style = PaintingStyle.fill
                ..color = regionModel.selectedRegionColor);
          selectedRegionCenter?.call(pathList[10].getBounds().center);
          break;
        case TurkeyRegionType.istanbulAnatolia:
          canvas.drawPath(pathList[11], paintStroke);
          canvas.drawPath(
              pathList[11],
              Paint()
                ..style = PaintingStyle.fill
                ..color = regionModel.selectedRegionColor);
          final position = pathList[11].getBounds().center;
          selectedRegionCenter?.call(pathList[11].getBounds().center);
        case TurkeyRegionType.istanbulEurope:
          canvas.drawPath(pathList[12], paintStroke);
          canvas.drawPath(
              pathList[12],
              Paint()
                ..style = PaintingStyle.fill
                ..color = regionModel.selectedRegionColor);
          selectedRegionCenter?.call(pathList[12].getBounds().center);
          break;
      }
    }
  }

  @override
  bool shouldRepaint(covariant TurkiyeRegionPainter oldDelegate) {
    return true;
  }

//Offset(108.6, 130.3)
//Offset(97.9, 167.6)
  @override
  bool hitTest(Offset position) {
    for (int a = 0; a < pathList.length; a++) {
      if (pathList[a].contains(position)) {
        if (a < 1) {
          regionSelectCallback.call(TurkeyRegionType.ege, position,pathList.first.getBounds().center);
        }
        if (a >= 1 && a <= 5) {
          if (pathList[12].contains(position) && regionModel.showIstanbulEuropeRegion) {
            regionSelectCallback.call(TurkeyRegionType.istanbulEurope, position,pathList[12].getBounds().center);
            return true;
          }
          if (pathList[11].contains(position) && regionModel.showIstanbulAnatoliaRegion) {
            regionSelectCallback.call(TurkeyRegionType.istanbulAnatolia, position,pathList[11].getBounds().center);
            return true;
          } else {
            regionSelectCallback.call(TurkeyRegionType.marmara, position,pathList[3].getBounds().center);
          }
        }
        if (a == 6) {
          regionSelectCallback.call(TurkeyRegionType.blackSea, position,pathList[6].getBounds().center);

        }
        if (a == 7) {
          regionSelectCallback.call(TurkeyRegionType.easternAnatolia, position,pathList[7].getBounds().center);
        }
        if (a == 8) {
          regionSelectCallback.call(TurkeyRegionType.southeasternAnatolia, position,pathList[8].getBounds().center);
        }
        if (a == 9) {
          final pathRect = pathList[9].getBounds();
          regionSelectCallback.call(TurkeyRegionType.mediterranean, position,
              Offset(pathRect.center.dx, pathRect.center.dy + pathRect.height / 4));
        }

        if (a == 10) {
          regionSelectCallback.call(TurkeyRegionType.centralAnatolia, position, pathList[10].getBounds().center);
        }
        return true;
      }
    }
    return false;
  }

  @override
  void paint(Canvas canvas, Size size) {
    ///Ege Bölgesi Başlangıç
    Path path_0 = Path();
    path_0.moveTo(size.width * 0.08510047, size.height * 0.5819736);
    path_0.cubicTo(size.width * 0.08401148, size.height * 0.5803230, size.width * 0.08217642, size.height * 0.5789327,
        size.width * 0.08039278, size.height * 0.5782836);
    path_0.cubicTo(size.width * 0.07874339, size.height * 0.5776833, size.width * 0.07738047, size.height * 0.5757377,
        size.width * 0.07568510, size.height * 0.5751207);
    path_0.cubicTo(size.width * 0.07445807, size.height * 0.5746741, size.width * 0.07290432, size.height * 0.5723060,
        size.width * 0.07170167, size.height * 0.5714307);
    path_0.cubicTo(size.width * 0.07018560, size.height * 0.5703272, size.width * 0.06886496, size.height * 0.5703544,
        size.width * 0.06735611, size.height * 0.5709035);
    path_0.cubicTo(size.width * 0.06593964, size.height * 0.5714190, size.width * 0.06471397, size.height * 0.5681117,
        size.width * 0.06409695, size.height * 0.5672135);
    path_0.cubicTo(size.width * 0.06290090, size.height * 0.5654724, size.width * 0.06275809, size.height * 0.5642103,
        size.width * 0.06156204, size.height * 0.5624692);
    path_0.cubicTo(size.width * 0.06041995, size.height * 0.5608067, size.width * 0.05993611, size.height * 0.5594891,
        size.width * 0.05902713, size.height * 0.5577249);
    path_0.cubicTo(size.width * 0.05817606, size.height * 0.5560730, size.width * 0.05426160, size.height * 0.5590849,
        size.width * 0.05395732, size.height * 0.5593063);
    path_0.cubicTo(size.width * 0.05199324, size.height * 0.5607359, size.width * 0.05152692, size.height * 0.5618606,
        size.width * 0.05106028, size.height * 0.5645778);
    path_0.cubicTo(size.width * 0.05036263, size.height * 0.5686400, size.width * 0.05018475, size.height * 0.5675538,
        size.width * 0.04780111, size.height * 0.5666864);
    path_0.cubicTo(size.width * 0.04627447, size.height * 0.5661308, size.width * 0.04527946, size.height * 0.5651242,
        size.width * 0.04417982, size.height * 0.5635235);
    path_0.cubicTo(size.width * 0.04297262, size.height * 0.5617662, size.width * 0.04299366, size.height * 0.5596882,
        size.width * 0.04200704, size.height * 0.5582520);
    path_0.cubicTo(size.width * 0.04117329, size.height * 0.5570384, size.width * 0.03841452, size.height * 0.5570764,
        size.width * 0.03729935, size.height * 0.5566706);
    path_0.cubicTo(size.width * 0.03519464, size.height * 0.5559046, size.width * 0.03490914, size.height * 0.5552998,
        size.width * 0.03367806, size.height * 0.5535077);
    path_0.cubicTo(size.width * 0.03297433, size.height * 0.5524833, size.width * 0.03240846, size.height * 0.5482238,
        size.width * 0.03222954, size.height * 0.5471820);
    path_0.cubicTo(size.width * 0.03165250, size.height * 0.5438220, size.width * 0.03281462, size.height * 0.5421131,
        size.width * 0.03367806, size.height * 0.5408562);
    path_0.cubicTo(size.width * 0.03410990, size.height * 0.5402276, size.width * 0.03690693, size.height * 0.5432063,
        size.width * 0.03729935, size.height * 0.5434920);
    path_0.cubicTo(size.width * 0.03926948, size.height * 0.5449259, size.width * 0.03997544, size.height * 0.5432865,
        size.width * 0.04092065, size.height * 0.5419105);
    path_0.cubicTo(size.width * 0.04209571, size.height * 0.5402000, size.width * 0.04312395, size.height * 0.5392304,
        size.width * 0.04417982, size.height * 0.5376934);
    path_0.cubicTo(size.width * 0.04571815, size.height * 0.5354540, size.width * 0.04466710, size.height * 0.5342049,
        size.width * 0.04454195, size.height * 0.5334762);
    path_0.cubicTo(size.width * 0.04426121, size.height * 0.5318415, size.width * 0.04109399, size.height * 0.5320953,
        size.width * 0.04019639, size.height * 0.5324219);
    path_0.cubicTo(size.width * 0.03864876, size.height * 0.5329851, size.width * 0.03729935, size.height * 0.5369568,
        size.width * 0.03729935, size.height * 0.5318948);
    path_0.cubicTo(size.width * 0.03729935, size.height * 0.5294791, size.width * 0.03762269, size.height * 0.5273763,
        size.width * 0.03802361, size.height * 0.5250419);
    path_0.cubicTo(size.width * 0.03836437, size.height * 0.5230577, size.width * 0.03692552, size.height * 0.5192092,
        size.width * 0.03657509, size.height * 0.5181890);
    path_0.cubicTo(size.width * 0.03569422, size.height * 0.5156244, size.width * 0.03624482, size.height * 0.5135649,
        size.width * 0.03802361, size.height * 0.5129175);
    path_0.cubicTo(size.width * 0.03973242, size.height * 0.5122956, size.width * 0.04122914, size.height * 0.5123709,
        size.width * 0.04273130, size.height * 0.5129175);
    path_0.cubicTo(size.width * 0.04420510, size.height * 0.5134539, size.width * 0.04597905, size.height * 0.5147542,
        size.width * 0.04707685, size.height * 0.5155533);
    path_0.cubicTo(size.width * 0.04877230, size.height * 0.5167873, size.width * 0.04952304, size.height * 0.5176724,
        size.width * 0.04997389, size.height * 0.5202976);
    path_0.cubicTo(size.width * 0.05034121, size.height * 0.5224363, size.width * 0.05027049, size.height * 0.5251875,
        size.width * 0.05069815, size.height * 0.5276776);
    path_0.cubicTo(size.width * 0.05128205, size.height * 0.5310775, size.width * 0.05064885, size.height * 0.5324937,
        size.width * 0.04997389, size.height * 0.5334762);
    path_0.cubicTo(size.width * 0.04898824, size.height * 0.5349110, size.width * 0.05092850, size.height * 0.5404726,
        size.width * 0.05106028, size.height * 0.5408562);
    path_0.cubicTo(size.width * 0.05197392, size.height * 0.5435162, size.width * 0.05164169, size.height * 0.5441787,
        size.width * 0.05359519, size.height * 0.5456005);
    path_0.cubicTo(size.width * 0.05499875, size.height * 0.5466221, size.width * 0.05429697, size.height * 0.5407908,
        size.width * 0.05359519, size.height * 0.5387476);
    path_0.cubicTo(size.width * 0.05248800, size.height * 0.5355242, size.width * 0.05456193, size.height * 0.5345305,
        size.width * 0.05613010, size.height * 0.5345305);
    path_0.cubicTo(size.width * 0.05801755, size.height * 0.5345305, size.width * 0.05757780, size.height * 0.5376886,
        size.width * 0.05794074, size.height * 0.5398019);
    path_0.cubicTo(size.width * 0.05834435, size.height * 0.5421520, size.width * 0.06003249, size.height * 0.5418869,
        size.width * 0.06192417, size.height * 0.5424377);
    path_0.cubicTo(size.width * 0.06413645, size.height * 0.5430817, size.width * 0.06601300, size.height * 0.5413067,
        size.width * 0.06735611, size.height * 0.5403291);
    path_0.cubicTo(size.width * 0.06872378, size.height * 0.5393336, size.width * 0.07036483, size.height * 0.5378756,
        size.width * 0.07206380, size.height * 0.5366391);
    path_0.cubicTo(size.width * 0.07359286, size.height * 0.5355262, size.width * 0.07516464, size.height * 0.5356589,
        size.width * 0.07640936, size.height * 0.5361119);
    path_0.cubicTo(size.width * 0.07881368, size.height * 0.5369869, size.width * 0.07705492, size.height * 0.5334189,
        size.width * 0.07568510, size.height * 0.5324219);
    path_0.cubicTo(size.width * 0.07405610, size.height * 0.5312363, size.width * 0.07276579, size.height * 0.5308405,
        size.width * 0.07061528, size.height * 0.5308405);
    path_0.cubicTo(size.width * 0.06811792, size.height * 0.5308405, size.width * 0.06730024, size.height * 0.5324016,
        size.width * 0.06590760, size.height * 0.5318948);
    path_0.cubicTo(size.width * 0.06477116, size.height * 0.5314812, size.width * 0.06369827, size.height * 0.5284852,
        size.width * 0.06301056, size.height * 0.5271504);
    path_0.cubicTo(size.width * 0.06199400, size.height * 0.5251774, size.width * 0.06116492, size.height * 0.5244129,
        size.width * 0.06047565, size.height * 0.5224061);
    path_0.cubicTo(size.width * 0.05967693, size.height * 0.5200808, size.width * 0.05910051, size.height * 0.5194569,
        size.width * 0.05830287, size.height * 0.5171347);
    path_0.cubicTo(size.width * 0.05744722, size.height * 0.5146436, size.width * 0.05696209, size.height * 0.5124905,
        size.width * 0.05649222, size.height * 0.5097546);
    path_0.cubicTo(size.width * 0.05578074, size.height * 0.5056119, size.width * 0.05869821, size.height * 0.5053694,
        size.width * 0.06047565, size.height * 0.5034289);
    path_0.cubicTo(size.width * 0.06211653, size.height * 0.5016375, size.width * 0.06377447, size.height * 0.5010279,
        size.width * 0.06554547, size.height * 0.4997389);
    path_0.cubicTo(size.width * 0.06755413, size.height * 0.4982769, size.width * 0.06764476, size.height * 0.4966295,
        size.width * 0.06916676, size.height * 0.4955217);
    path_0.cubicTo(size.width * 0.07052631, size.height * 0.4945322, size.width * 0.07175585, size.height * 0.4931101,
        size.width * 0.07278806, size.height * 0.4923588);
    path_0.cubicTo(size.width * 0.07469778, size.height * 0.4909689, size.width * 0.07329504, size.height * 0.4880626,
        size.width * 0.07206380, size.height * 0.4876145);
    path_0.cubicTo(size.width * 0.07009155, size.height * 0.4868968, size.width * 0.06800915, size.height * 0.4862448,
        size.width * 0.06626973, size.height * 0.4849788);
    path_0.cubicTo(size.width * 0.06389796, size.height * 0.4832525, size.width * 0.06394698, size.height * 0.4898136,
        size.width * 0.06228630, size.height * 0.4849788);
    path_0.cubicTo(size.width * 0.06184312, size.height * 0.4836886, size.width * 0.06067522, size.height * 0.4818698,
        size.width * 0.06011352, size.height * 0.4802345);
    path_0.cubicTo(size.width * 0.05891733, size.height * 0.4767520, size.width * 0.06002106, size.height * 0.4756556,
        size.width * 0.06192417, size.height * 0.4749630);
    path_0.cubicTo(size.width * 0.06381485, size.height * 0.4742750, size.width * 0.06337269, size.height * 0.4720290,
        size.width * 0.06337269, size.height * 0.4691644);
    path_0.cubicTo(size.width * 0.06337269, size.height * 0.4667944, size.width * 0.06181269, size.height * 0.4659204,
        size.width * 0.06047565, size.height * 0.4649473);
    path_0.cubicTo(size.width * 0.05834861, size.height * 0.4633991, size.width * 0.06071931, size.height * 0.4630136,
        size.width * 0.06264843, size.height * 0.4623115);
    path_0.cubicTo(size.width * 0.06425702, size.height * 0.4617261, size.width * 0.06598901, size.height * 0.4590302,
        size.width * 0.06699398, size.height * 0.4575672);
    path_0.cubicTo(size.width * 0.06827619, size.height * 0.4557008, size.width * 0.06928575, size.height * 0.4537040,
        size.width * 0.07025315, size.height * 0.4522958);
    path_0.cubicTo(size.width * 0.07148804, size.height * 0.4504982, size.width * 0.07215233, size.height * 0.4483480,
        size.width * 0.07278806, size.height * 0.4464972);
    path_0.cubicTo(size.width * 0.07345059, size.height * 0.4445683, size.width * 0.07461613, size.height * 0.4433089,
        size.width * 0.07568510, size.height * 0.4417529);
    path_0.cubicTo(size.width * 0.07703831, size.height * 0.4397830, size.width * 0.07758720, size.height * 0.4391171,
        size.width * 0.08003066, size.height * 0.4391171);
    path_0.cubicTo(size.width * 0.08202559, size.height * 0.4391171, size.width * 0.08336262, size.height * 0.4388801,
        size.width * 0.08546260, size.height * 0.4396443);
    path_0.cubicTo(size.width * 0.08691799, size.height * 0.4401739, size.width * 0.08750794, size.height * 0.4417065,
        size.width * 0.08908390, size.height * 0.4422800);
    path_0.cubicTo(size.width * 0.09089732, size.height * 0.4429400, size.width * 0.09289842, size.height * 0.4416825,
        size.width * 0.09415371, size.height * 0.4412257);
    path_0.cubicTo(size.width * 0.09602225, size.height * 0.4405457, size.width * 0.09577408, size.height * 0.4392422,
        size.width * 0.09777500, size.height * 0.4406986);
    path_0.cubicTo(size.width * 0.09921675, size.height * 0.4417479, size.width * 0.1001079, size.height * 0.4431179,
        size.width * 0.1010342, size.height * 0.4449157);
    path_0.cubicTo(size.width * 0.1019472, size.height * 0.4466878, size.width * 0.1034404, size.height * 0.4475515,
        size.width * 0.1053797, size.height * 0.4475515);
    path_0.cubicTo(size.width * 0.1068007, size.height * 0.4475515, size.width * 0.1083976, size.height * 0.4445642,
        size.width * 0.1093632, size.height * 0.4438615);
    path_0.cubicTo(size.width * 0.1108623, size.height * 0.4427703, size.width * 0.1134332, size.height * 0.4450791,
        size.width * 0.1144330, size.height * 0.4454429);
    path_0.cubicTo(size.width * 0.1162921, size.height * 0.4461195, size.width * 0.1169293, size.height * 0.4473270,
        size.width * 0.1173300, size.height * 0.4496601);
    path_0.cubicTo(size.width * 0.1178499, size.height * 0.4526870, size.width * 0.1162436, size.height * 0.4533539,
        size.width * 0.1162436, size.height * 0.4565129);
    path_0.cubicTo(size.width * 0.1162436, size.height * 0.4596631, size.width * 0.1201644, size.height * 0.4576128,
        size.width * 0.1209513, size.height * 0.4570401);
    path_0.cubicTo(size.width * 0.1229504, size.height * 0.4555851, size.width * 0.1238418, size.height * 0.4570021,
        size.width * 0.1242105, size.height * 0.4591487);
    path_0.cubicTo(size.width * 0.1245442, size.height * 0.4610918, size.width * 0.1254762, size.height * 0.4628338,
        size.width * 0.1260211, size.height * 0.4644201);
    path_0.cubicTo(size.width * 0.1267726, size.height * 0.4666081, size.width * 0.1274134, size.height * 0.4692310,
        size.width * 0.1281939, size.height * 0.4707459);
    path_0.cubicTo(size.width * 0.1293316, size.height * 0.4729541, size.width * 0.1294412, size.height * 0.4737037,
        size.width * 0.1314531, size.height * 0.4744359);
    path_0.cubicTo(size.width * 0.1334087, size.height * 0.4751476, size.width * 0.1356254, size.height * 0.4732441,
        size.width * 0.1368850, size.height * 0.4723273);
    path_0.cubicTo(size.width * 0.1384048, size.height * 0.4712211, size.width * 0.1394469, size.height * 0.4704627,
        size.width * 0.1412306, size.height * 0.4691644);
    path_0.cubicTo(size.width * 0.1430089, size.height * 0.4678701, size.width * 0.1444582, size.height * 0.4668153,
        size.width * 0.1463004, size.height * 0.4654744);
    path_0.cubicTo(size.width * 0.1477636, size.height * 0.4644094, size.width * 0.1492876, size.height * 0.4634648,
        size.width * 0.1510081, size.height * 0.4628387);
    path_0.cubicTo(size.width * 0.1526993, size.height * 0.4622232, size.width * 0.1529102, size.height * 0.4608286,
        size.width * 0.1546294, size.height * 0.4602030);
    path_0.cubicTo(size.width * 0.1563394, size.height * 0.4595807, size.width * 0.1546699, size.height * 0.4679920,
        size.width * 0.1568021, size.height * 0.4617844);
    path_0.cubicTo(size.width * 0.1576065, size.height * 0.4594426, size.width * 0.1573353, size.height * 0.4565422,
        size.width * 0.1578885, size.height * 0.4549315);
    path_0.cubicTo(size.width * 0.1584709, size.height * 0.4532360, size.width * 0.1611104, size.height * 0.4523229,
        size.width * 0.1618720, size.height * 0.4517686);
    path_0.cubicTo(size.width * 0.1635346, size.height * 0.4505585, size.width * 0.1646540, size.height * 0.4493003,
        size.width * 0.1658554, size.height * 0.4475515);
    path_0.cubicTo(size.width * 0.1672210, size.height * 0.4455635, size.width * 0.1682362, size.height * 0.4447586,
        size.width * 0.1687524, size.height * 0.4417529);
    path_0.cubicTo(size.width * 0.1690827, size.height * 0.4398298, size.width * 0.1698371, size.height * 0.4375454,
        size.width * 0.1702009, size.height * 0.4354271);
    path_0.cubicTo(size.width * 0.1705838, size.height * 0.4331975, size.width * 0.1702856, size.height * 0.4296624,
        size.width * 0.1705631, size.height * 0.4280471);
    path_0.cubicTo(size.width * 0.1709879, size.height * 0.4255734, size.width * 0.1716754, size.height * 0.4239523,
        size.width * 0.1734601, size.height * 0.4233028);
    path_0.cubicTo(size.width * 0.1752131, size.height * 0.4226648, size.width * 0.1768530, size.height * 0.4253283,
        size.width * 0.1785299, size.height * 0.4259385);
    path_0.cubicTo(size.width * 0.1801090, size.height * 0.4265132, size.width * 0.1823245, size.height * 0.4259385,
        size.width * 0.1839619, size.height * 0.4259385);
    path_0.cubicTo(size.width * 0.1853547, size.height * 0.4259385, size.width * 0.1872243, size.height * 0.4230357,
        size.width * 0.1879453, size.height * 0.4222485);
    path_0.cubicTo(size.width * 0.1894544, size.height * 0.4206009, size.width * 0.1892853, size.height * 0.4181360,
        size.width * 0.1897559, size.height * 0.4153956);
    path_0.cubicTo(size.width * 0.1901152, size.height * 0.4133036, size.width * 0.1909823, size.height * 0.4107710,
        size.width * 0.1915666, size.height * 0.4090699);
    path_0.cubicTo(size.width * 0.1923166, size.height * 0.4068862, size.width * 0.1926378, size.height * 0.4049410,
        size.width * 0.1930151, size.height * 0.4027441);
    path_0.cubicTo(size.width * 0.1934231, size.height * 0.4003685, size.width * 0.1936572, size.height * 0.3984782,
        size.width * 0.1941015, size.height * 0.3958912);
    path_0.cubicTo(size.width * 0.1945557, size.height * 0.3932465, size.width * 0.1946506, size.height * 0.3919290,
        size.width * 0.1959121, size.height * 0.3900926);
    path_0.cubicTo(size.width * 0.1968487, size.height * 0.3887293, size.width * 0.2008730, size.height * 0.3908437,
        size.width * 0.2017062, size.height * 0.3911469);
    path_0.cubicTo(size.width * 0.2035458, size.height * 0.3918164, size.width * 0.2040757, size.height * 0.3930635,
        size.width * 0.2060518, size.height * 0.3937826);
    path_0.cubicTo(size.width * 0.2085306, size.height * 0.3946847, size.width * 0.2087779, size.height * 0.3914253,
        size.width * 0.2107595, size.height * 0.3943098);
    path_0.cubicTo(size.width * 0.2119546, size.height * 0.3960495, size.width * 0.2122080, size.height * 0.3982900,
        size.width * 0.2122080, size.height * 0.4011627);
    path_0.cubicTo(size.width * 0.2122080, size.height * 0.4039596, size.width * 0.2118315, size.height * 0.4063508,
        size.width * 0.2122080, size.height * 0.4085427);
    path_0.cubicTo(size.width * 0.2122563, size.height * 0.4088243, size.width * 0.2166779, size.height * 0.4100376,
        size.width * 0.2169157, size.height * 0.4101241);
    path_0.cubicTo(size.width * 0.2186567, size.height * 0.4107577, size.width * 0.2203917, size.height * 0.4107302,
        size.width * 0.2216233, size.height * 0.4111784);
    path_0.cubicTo(size.width * 0.2234727, size.height * 0.4118514, size.width * 0.2240859, size.height * 0.4127335,
        size.width * 0.2256068, size.height * 0.4132870);
    path_0.cubicTo(size.width * 0.2273552, size.height * 0.4139233, size.width * 0.2286038, size.height * 0.4121963,
        size.width * 0.2299523, size.height * 0.4117056);
    path_0.cubicTo(size.width * 0.2319622, size.height * 0.4109741, size.width * 0.2330775, size.height * 0.4124133,
        size.width * 0.2350221, size.height * 0.4117056);
    path_0.cubicTo(size.width * 0.2374814, size.height * 0.4108106, size.width * 0.2356721, size.height * 0.4129042,
        size.width * 0.2346600, size.height * 0.4148684);
    path_0.cubicTo(size.width * 0.2335084, size.height * 0.4171036, size.width * 0.2335570, size.height * 0.4185100,
        size.width * 0.2342979, size.height * 0.4206670);
    path_0.cubicTo(size.width * 0.2347601, size.height * 0.4220129, size.width * 0.2371594, size.height * 0.4234216,
        size.width * 0.2382813, size.height * 0.4238299);
    path_0.cubicTo(size.width * 0.2396470, size.height * 0.4243269, size.width * 0.2394587, size.height * 0.4276524,
        size.width * 0.2404541, size.height * 0.4291014);
    path_0.cubicTo(size.width * 0.2413026, size.height * 0.4303365, size.width * 0.2418347, size.height * 0.4329230,
        size.width * 0.2422647, size.height * 0.4354271);
    path_0.cubicTo(size.width * 0.2426528, size.height * 0.4376866, size.width * 0.2432203, size.height * 0.4388827,
        size.width * 0.2437133, size.height * 0.4417529);
    path_0.cubicTo(size.width * 0.2441558, size.height * 0.4443299, size.width * 0.2444951, size.height * 0.4465810,
        size.width * 0.2455239, size.height * 0.4480786);
    path_0.cubicTo(size.width * 0.2467298, size.height * 0.4498340, size.width * 0.2474022, size.height * 0.4509113,
        size.width * 0.2480588, size.height * 0.4528229);
    path_0.cubicTo(size.width * 0.2487030, size.height * 0.4546983, size.width * 0.2493947, size.height * 0.4567122,
        size.width * 0.2498695, size.height * 0.4580944);
    path_0.cubicTo(size.width * 0.2504634, size.height * 0.4598236, size.width * 0.2518720, size.height * 0.4604822,
        size.width * 0.2527665, size.height * 0.4617844);
    path_0.cubicTo(size.width * 0.2538781, size.height * 0.4634025, size.width * 0.2542736, size.height * 0.4658154,
        size.width * 0.2545771, size.height * 0.4675830);
    path_0.cubicTo(size.width * 0.2546290, size.height * 0.4678852, size.width * 0.2574539, size.height * 0.4712139,
        size.width * 0.2574742, size.height * 0.4712730);
    path_0.cubicTo(size.width * 0.2575957, size.height * 0.4716269, size.width * 0.2621976, size.height * 0.4699437,
        size.width * 0.2625440, size.height * 0.4696916);
    path_0.cubicTo(size.width * 0.2642539, size.height * 0.4684471, size.width * 0.2652496, size.height * 0.4671952,
        size.width * 0.2668895, size.height * 0.4660016);
    path_0.cubicTo(size.width * 0.2681484, size.height * 0.4650853, size.width * 0.2696341, size.height * 0.4625335,
        size.width * 0.2705108, size.height * 0.4612573);
    path_0.cubicTo(size.width * 0.2721528, size.height * 0.4588671, size.width * 0.2728277, size.height * 0.4600442,
        size.width * 0.2744943, size.height * 0.4612573);
    path_0.cubicTo(size.width * 0.2760109, size.height * 0.4623611, size.width * 0.2763791, size.height * 0.4632611,
        size.width * 0.2781156, size.height * 0.4638930);
    path_0.cubicTo(size.width * 0.2786407, size.height * 0.4640841, size.width * 0.2816493, size.height * 0.4598033,
        size.width * 0.2817369, size.height * 0.4596758);
    path_0.cubicTo(size.width * 0.2828788, size.height * 0.4580135, size.width * 0.2841669, size.height * 0.4571164,
        size.width * 0.2857203, size.height * 0.4559858);
    path_0.cubicTo(size.width * 0.2870757, size.height * 0.4549993, size.width * 0.2885887, size.height * 0.4542830,
        size.width * 0.2897037, size.height * 0.4538772);
    path_0.cubicTo(size.width * 0.2912989, size.height * 0.4532967, size.width * 0.2931666, size.height * 0.4534242,
        size.width * 0.2944114, size.height * 0.4538772);
    path_0.cubicTo(size.width * 0.2957280, size.height * 0.4543563, size.width * 0.2962717, size.height * 0.4568020,
        size.width * 0.2965842, size.height * 0.4586215);
    path_0.cubicTo(size.width * 0.2970672, size.height * 0.4614343, size.width * 0.2976482, size.height * 0.4627086,
        size.width * 0.2980327, size.height * 0.4649473);
    path_0.cubicTo(size.width * 0.2983438, size.height * 0.4667585, size.width * 0.2997274, size.height * 0.4693540,
        size.width * 0.3002055, size.height * 0.4707459);
    path_0.cubicTo(size.width * 0.3008920, size.height * 0.4727446, size.width * 0.3036919, size.height * 0.4715857,
        size.width * 0.3045510, size.height * 0.4712730);
    path_0.cubicTo(size.width * 0.3063821, size.height * 0.4706066, size.width * 0.3068782, size.height * 0.4696916,
        size.width * 0.3088966, size.height * 0.4696916);
    path_0.cubicTo(size.width * 0.3106994, size.height * 0.4696916, size.width * 0.3116362, size.height * 0.4695025,
        size.width * 0.3136043, size.height * 0.4702187);
    path_0.cubicTo(size.width * 0.3157862, size.height * 0.4710128, size.width * 0.3153986, size.height * 0.4740038,
        size.width * 0.3150528, size.height * 0.4760173);
    path_0.cubicTo(size.width * 0.3146263, size.height * 0.4785008, size.width * 0.3150528, size.height * 0.4800501,
        size.width * 0.3150528, size.height * 0.4828702);
    path_0.cubicTo(size.width * 0.3150528, size.height * 0.4852887, size.width * 0.3154149, size.height * 0.4881605,
        size.width * 0.3154149, size.height * 0.4907774);
    path_0.cubicTo(size.width * 0.3154149, size.height * 0.4934928, size.width * 0.3147018, size.height * 0.4955055,
        size.width * 0.3136043, size.height * 0.4971031);
    path_0.cubicTo(size.width * 0.3125759, size.height * 0.4986002, size.width * 0.3115162, size.height * 0.5002773,
        size.width * 0.3107072, size.height * 0.5018475);
    path_0.cubicTo(size.width * 0.3100029, size.height * 0.5032144, size.width * 0.3099830, size.height * 0.5065388,
        size.width * 0.3099830, size.height * 0.5087004);
    path_0.cubicTo(size.width * 0.3099830, size.height * 0.5117810, size.width * 0.3103652, size.height * 0.5135618,
        size.width * 0.3107072, size.height * 0.5155533);
    path_0.cubicTo(size.width * 0.3111840, size.height * 0.5183291, size.width * 0.3149078, size.height * 0.5141829,
        size.width * 0.3114315, size.height * 0.5192433);
    path_0.cubicTo(size.width * 0.3100690, size.height * 0.5212266, size.width * 0.3087864, size.height * 0.5225265,
        size.width * 0.3074481, size.height * 0.5239876);
    path_0.cubicTo(size.width * 0.3062420, size.height * 0.5253043, size.width * 0.3047654, size.height * 0.5268384,
        size.width * 0.3038268, size.height * 0.5282047);
    path_0.cubicTo(size.width * 0.3027814, size.height * 0.5297264, size.width * 0.3016286, size.height * 0.5307364,
        size.width * 0.3005676, size.height * 0.5318948);
    path_0.cubicTo(size.width * 0.2994315, size.height * 0.5331351, size.width * 0.2980660, size.height * 0.5334520,
        size.width * 0.2965842, size.height * 0.5345305);
    path_0.cubicTo(size.width * 0.2951501, size.height * 0.5355743, size.width * 0.2939122, size.height * 0.5363115,
        size.width * 0.2929629, size.height * 0.5376934);
    path_0.cubicTo(size.width * 0.2923471, size.height * 0.5385898, size.width * 0.2900992, size.height * 0.5340518,
        size.width * 0.2897037, size.height * 0.5334762);
    path_0.cubicTo(size.width * 0.2884321, size.height * 0.5316252, size.width * 0.2884951, size.height * 0.5296528,
        size.width * 0.2871688, size.height * 0.5282047);
    path_0.cubicTo(size.width * 0.2856956, size.height * 0.5265963, size.width * 0.2849496, size.height * 0.5263935,
        size.width * 0.2831854, size.height * 0.5276776);
    path_0.cubicTo(size.width * 0.2814799, size.height * 0.5289189, size.width * 0.2810704, size.height * 0.5307563,
        size.width * 0.2799262, size.height * 0.5324219);
    path_0.cubicTo(size.width * 0.2787463, size.height * 0.5341395, size.width * 0.2779574, size.height * 0.5358150,
        size.width * 0.2770292, size.height * 0.5371662);
    path_0.cubicTo(size.width * 0.2756362, size.height * 0.5391939, size.width * 0.2748227, size.height * 0.5403781,
        size.width * 0.2734079, size.height * 0.5424377);
    path_0.cubicTo(size.width * 0.2721281, size.height * 0.5443006, size.width * 0.2713728, size.height * 0.5448730,
        size.width * 0.2701487, size.height * 0.5466548);
    path_0.cubicTo(size.width * 0.2688690, size.height * 0.5485177, size.width * 0.2684758, size.height * 0.5496173,
        size.width * 0.2672517, size.height * 0.5513991);
    path_0.cubicTo(size.width * 0.2659059, size.height * 0.5533582, size.width * 0.2638447, size.height * 0.5535077,
        size.width * 0.2618197, size.height * 0.5535077);
    path_0.cubicTo(size.width * 0.2591263, size.height * 0.5535077, size.width * 0.2578783, size.height * 0.5542091,
        size.width * 0.2556635, size.height * 0.5561435);
    path_0.cubicTo(size.width * 0.2537717, size.height * 0.5577958, size.width * 0.2528695, size.height * 0.5590065,
        size.width * 0.2520422, size.height * 0.5614149);
    path_0.cubicTo(size.width * 0.2513577, size.height * 0.5634078, size.width * 0.2499327, size.height * 0.5644857,
        size.width * 0.2491452, size.height * 0.5656321);
    path_0.cubicTo(size.width * 0.2480955, size.height * 0.5671601, size.width * 0.2471476, size.height * 0.5685399,
        size.width * 0.2462482, size.height * 0.5698492);
    path_0.cubicTo(size.width * 0.2447095, size.height * 0.5720891, size.width * 0.2440565, size.height * 0.5730396,
        size.width * 0.2429890, size.height * 0.5745935);
    path_0.cubicTo(size.width * 0.2417929, size.height * 0.5763346, size.width * 0.2409259, size.height * 0.5765425,
        size.width * 0.2397298, size.height * 0.5782836);
    path_0.cubicTo(size.width * 0.2381590, size.height * 0.5805702, size.width * 0.2373381, size.height * 0.5811685,
        size.width * 0.2361085, size.height * 0.5835550);
    path_0.cubicTo(size.width * 0.2349061, size.height * 0.5858888, size.width * 0.2372125, size.height * 0.5878748,
        size.width * 0.2375570, size.height * 0.5898808);
    path_0.cubicTo(size.width * 0.2380529, size.height * 0.5927680, size.width * 0.2352467, size.height * 0.5941981,
        size.width * 0.2339358, size.height * 0.5951522);
    path_0.cubicTo(size.width * 0.2323968, size.height * 0.5962723, size.width * 0.2316731, size.height * 0.5983805,
        size.width * 0.2303145, size.height * 0.5993694);
    path_0.cubicTo(size.width * 0.2289503, size.height * 0.6003623, size.width * 0.2268650, size.height * 0.5998965,
        size.width * 0.2252446, size.height * 0.5998965);
    path_0.cubicTo(size.width * 0.2231858, size.height * 0.5998965, size.width * 0.2213741, size.height * 0.6004237,
        size.width * 0.2194506, size.height * 0.6004237);
    path_0.cubicTo(size.width * 0.2177297, size.height * 0.6004237, size.width * 0.2155673, size.height * 0.6027229,
        size.width * 0.2143807, size.height * 0.6035866);
    path_0.cubicTo(size.width * 0.2129216, size.height * 0.6046486, size.width * 0.2116902, size.height * 0.6058651,
        size.width * 0.2103973, size.height * 0.6072766);
    path_0.cubicTo(size.width * 0.2091566, size.height * 0.6086312, size.width * 0.2080935, size.height * 0.6105825,
        size.width * 0.2067760, size.height * 0.6120209);
    path_0.cubicTo(size.width * 0.2053364, size.height * 0.6135926, size.width * 0.2038542, size.height * 0.6151928,
        size.width * 0.2024305, size.height * 0.6157109);
    path_0.cubicTo(size.width * 0.2019969, size.height * 0.6158687, size.width * 0.2017062, size.height * 0.6225304,
        size.width * 0.2017062, size.height * 0.6236181);
    path_0.cubicTo(size.width * 0.2017062, size.height * 0.6253839, size.width * 0.2025107, size.height * 0.6283026,
        size.width * 0.2027926, size.height * 0.6299438);
    path_0.cubicTo(size.width * 0.2028932, size.height * 0.6305297, size.width * 0.2052801, size.height * 0.6312490,
        size.width * 0.2056896, size.height * 0.6336339);
    path_0.cubicTo(size.width * 0.2060715, size.height * 0.6358574, size.width * 0.2038223, size.height * 0.6384607,
        size.width * 0.2027926, size.height * 0.6399596);
    path_0.cubicTo(size.width * 0.2013348, size.height * 0.6420817, size.width * 0.1999143, size.height * 0.6441495,
        size.width * 0.1988092, size.height * 0.6457582);
    path_0.cubicTo(size.width * 0.1980948, size.height * 0.6467982, size.width * 0.1979813, size.height * 0.6508041,
        size.width * 0.1973607, size.height * 0.6526111);
    path_0.cubicTo(size.width * 0.1965716, size.height * 0.6549084, size.width * 0.1962743, size.height * 0.6568733,
        size.width * 0.1962743, size.height * 0.6599911);
    path_0.cubicTo(size.width * 0.1962743, size.height * 0.6628186, size.width * 0.1958940, size.height * 0.6648411,
        size.width * 0.1955500, size.height * 0.6668440);
    path_0.cubicTo(size.width * 0.1949509, size.height * 0.6703322, size.width * 0.1959121, size.height * 0.6698641,
        size.width * 0.1959121, size.height * 0.6731698);
    path_0.cubicTo(size.width * 0.1959121, size.height * 0.6749141, size.width * 0.1939192, size.height * 0.6776523,
        size.width * 0.1937394, size.height * 0.6779141);
    path_0.cubicTo(size.width * 0.1933793, size.height * 0.6784382, size.width * 0.1977857, size.height * 0.6786590,
        size.width * 0.1980849, size.height * 0.6784412);
    path_0.cubicTo(size.width * 0.1995530, size.height * 0.6773727, size.width * 0.2000835, size.height * 0.6749414,
        size.width * 0.2017062, size.height * 0.6731698);
    path_0.cubicTo(size.width * 0.2030116, size.height * 0.6717445, size.width * 0.2044512, size.height * 0.6714217,
        size.width * 0.2056896, size.height * 0.6710612);
    path_0.cubicTo(size.width * 0.2071634, size.height * 0.6706321, size.width * 0.2080849, size.height * 0.6734936,
        size.width * 0.2089488, size.height * 0.6747512);
    path_0.cubicTo(size.width * 0.2097956, size.height * 0.6759839, size.width * 0.2100352, size.height * 0.6786634,
        size.width * 0.2100352, size.height * 0.6810769);
    path_0.cubicTo(size.width * 0.2100352, size.height * 0.6841165, size.width * 0.2099029, size.height * 0.6862064,
        size.width * 0.2093109, size.height * 0.6879298);
    path_0.cubicTo(size.width * 0.2084343, size.height * 0.6904821, size.width * 0.2080713, size.height * 0.6915388,
        size.width * 0.2071382, size.height * 0.6942556);
    path_0.cubicTo(size.width * 0.2065329, size.height * 0.6960178, size.width * 0.2058388, size.height * 0.6965499,
        size.width * 0.2053275, size.height * 0.6995270);
    path_0.cubicTo(size.width * 0.2049214, size.height * 0.7018918, size.width * 0.2045810, size.height * 0.7038738,
        size.width * 0.2042411, size.height * 0.7058528);
    path_0.cubicTo(size.width * 0.2038142, size.height * 0.7083386, size.width * 0.2038790, size.height * 0.7110096,
        size.width * 0.2038790, size.height * 0.7137600);
    path_0.cubicTo(size.width * 0.2038790, size.height * 0.7150646, size.width * 0.1998904, size.height * 0.7166630,
        size.width * 0.1995334, size.height * 0.7169228);
    path_0.cubicTo(size.width * 0.1981068, size.height * 0.7179612, size.width * 0.1978615, size.height * 0.7193566,
        size.width * 0.1966364, size.height * 0.7211400);
    path_0.cubicTo(size.width * 0.1954040, size.height * 0.7229340, size.width * 0.1948666, size.height * 0.7236567,
        size.width * 0.1941015, size.height * 0.7258843);
    path_0.cubicTo(size.width * 0.1934007, size.height * 0.7279244, size.width * 0.1926544, size.height * 0.7295661,
        size.width * 0.1922908, size.height * 0.7316829);
    path_0.cubicTo(size.width * 0.1918938, size.height * 0.7339946, size.width * 0.1922253, size.height * 0.7373358,
        size.width * 0.1919287, size.height * 0.7390630);
    path_0.cubicTo(size.width * 0.1914365, size.height * 0.7419289, size.width * 0.1899749, size.height * 0.7416987,
        size.width * 0.1879453, size.height * 0.7416987);
    path_0.cubicTo(size.width * 0.1866163, size.height * 0.7416987, size.width * 0.1849685, size.height * 0.7397956,
        size.width * 0.1839619, size.height * 0.7390630);
    path_0.cubicTo(size.width * 0.1821654, size.height * 0.7377554, size.width * 0.1816322, size.height * 0.7361988,
        size.width * 0.1807027, size.height * 0.7348458);
    path_0.cubicTo(size.width * 0.1795831, size.height * 0.7332160, size.width * 0.1792898, size.height * 0.7313633,
        size.width * 0.1788920, size.height * 0.7290472);
    path_0.cubicTo(size.width * 0.1786040, size.height * 0.7273701, size.width * 0.1804651, size.height * 0.7235777,
        size.width * 0.1807027, size.height * 0.7221943);
    path_0.cubicTo(size.width * 0.1812692, size.height * 0.7188959, size.width * 0.1819483, size.height * 0.7184304,
        size.width * 0.1792542, size.height * 0.7174500);
    path_0.cubicTo(size.width * 0.1767085, size.height * 0.7165236, size.width * 0.1763457, size.height * 0.7174333,
        size.width * 0.1749086, size.height * 0.7153414);
    path_0.cubicTo(size.width * 0.1731920, size.height * 0.7128426, size.width * 0.1774710, size.height * 0.7105771,
        size.width * 0.1781678, size.height * 0.7100700);
    path_0.cubicTo(size.width * 0.1798602, size.height * 0.7088381, size.width * 0.1778145, size.height * 0.7058785,
        size.width * 0.1774435, size.height * 0.7047985);
    path_0.cubicTo(size.width * 0.1769568, size.height * 0.7033816, size.width * 0.1742747, size.height * 0.7017014,
        size.width * 0.1734601, size.height * 0.7011085);
    path_0.cubicTo(size.width * 0.1714518, size.height * 0.6996467, size.width * 0.1715515, size.height * 0.6984479,
        size.width * 0.1691145, size.height * 0.7011085);
    path_0.cubicTo(size.width * 0.1672234, size.height * 0.7031732, size.width * 0.1674719, size.height * 0.7045540,
        size.width * 0.1662175, size.height * 0.7063799);
    path_0.cubicTo(size.width * 0.1652246, size.height * 0.7078254, size.width * 0.1632077, size.height * 0.7051528,
        size.width * 0.1622341, size.height * 0.7047985);
    path_0.cubicTo(size.width * 0.1607828, size.height * 0.7042703, size.width * 0.1587656, size.height * 0.7031409,
        size.width * 0.1575264, size.height * 0.7026899);
    path_0.cubicTo(size.width * 0.1557722, size.height * 0.7020515, size.width * 0.1554301, size.height * 0.6981684,
        size.width * 0.1549915, size.height * 0.6968913);
    path_0.cubicTo(size.width * 0.1540584, size.height * 0.6941747, size.width * 0.1527771, size.height * 0.6930801,
        size.width * 0.1517323, size.height * 0.6900384);
    path_0.cubicTo(size.width * 0.1510619, size.height * 0.6880867, size.width * 0.1498983, size.height * 0.6868586,
        size.width * 0.1484732, size.height * 0.6858213);
    path_0.cubicTo(size.width * 0.1466358, size.height * 0.6844839, size.width * 0.1449216, size.height * 0.6861405,
        size.width * 0.1437655, size.height * 0.6874027);
    path_0.cubicTo(size.width * 0.1426988, size.height * 0.6885672, size.width * 0.1450704, size.height * 0.6918289,
        size.width * 0.1441276, size.height * 0.6932013);
    path_0.cubicTo(size.width * 0.1425974, size.height * 0.6954288, size.width * 0.1423865, size.height * 0.6954112,
        size.width * 0.1408684, size.height * 0.6932013);
    path_0.cubicTo(size.width * 0.1394144, size.height * 0.6910847, size.width * 0.1388817, size.height * 0.6893191,
        size.width * 0.1376093, size.height * 0.6879298);
    path_0.cubicTo(size.width * 0.1363726, size.height * 0.6865797, size.width * 0.1347122, size.height * 0.6909510,
        size.width * 0.1347122, size.height * 0.6932013);
    path_0.cubicTo(size.width * 0.1347122, size.height * 0.6958298, size.width * 0.1365165, size.height * 0.6984635,
        size.width * 0.1372471, size.height * 0.6995270);
    path_0.cubicTo(size.width * 0.1391590, size.height * 0.7023101, size.width * 0.1375162, size.height * 0.7040755,
        size.width * 0.1357986, size.height * 0.7053256);
    path_0.cubicTo(size.width * 0.1341662, size.height * 0.7065137, size.width * 0.1329317, size.height * 0.7071487,
        size.width * 0.1310909, size.height * 0.7084885);
    path_0.cubicTo(size.width * 0.1293235, size.height * 0.7097749, size.width * 0.1279348, size.height * 0.7108799,
        size.width * 0.1267454, size.height * 0.7121785);
    path_0.cubicTo(size.width * 0.1253578, size.height * 0.7136935, size.width * 0.1241700, size.height * 0.7148731,
        size.width * 0.1231241, size.height * 0.7163957);
    path_0.cubicTo(size.width * 0.1219015, size.height * 0.7181754, size.width * 0.1196810, size.height * 0.7190151,
        size.width * 0.1191407, size.height * 0.7158686);
    path_0.cubicTo(size.width * 0.1185277, size.height * 0.7122993, size.width * 0.1192217, size.height * 0.7127057,
        size.width * 0.1216756, size.height * 0.7127057);
    path_0.cubicTo(size.width * 0.1239498, size.height * 0.7127057, size.width * 0.1246647, size.height * 0.7115172,
        size.width * 0.1256590, size.height * 0.7100700);
    path_0.cubicTo(size.width * 0.1272171, size.height * 0.7078018, size.width * 0.1244877, size.height * 0.7050312,
        size.width * 0.1238483, size.height * 0.7047985);
    path_0.cubicTo(size.width * 0.1217004, size.height * 0.7040168, size.width * 0.1219582, size.height * 0.7017963,
        size.width * 0.1238483, size.height * 0.7011085);
    path_0.cubicTo(size.width * 0.1254811, size.height * 0.7005143, size.width * 0.1267303, size.height * 0.7011195,
        size.width * 0.1281939, size.height * 0.7000542);
    path_0.cubicTo(size.width * 0.1292774, size.height * 0.6992655, size.width * 0.1290386, size.height * 0.6972445,
        size.width * 0.1292803, size.height * 0.6958370);
    path_0.cubicTo(size.width * 0.1308072, size.height * 0.6947257, size.width * 0.1255761, size.height * 0.6954003,
        size.width * 0.1242105, size.height * 0.6968913);
    path_0.cubicTo(size.width * 0.1228335, size.height * 0.6983946, size.width * 0.1209389, size.height * 0.6979547,
        size.width * 0.1195028, size.height * 0.6989999);
    path_0.cubicTo(size.width * 0.1179692, size.height * 0.7001161, size.width * 0.1155813, size.height * 0.6984727,
        size.width * 0.1137087, size.height * 0.6984727);
    path_0.cubicTo(size.width * 0.1122920, size.height * 0.6984727, size.width * 0.1103865, size.height * 0.6974414,
        size.width * 0.1090010, size.height * 0.6979456);
    path_0.cubicTo(size.width * 0.1066646, size.height * 0.6987959, size.width * 0.1082320, size.height * 0.7021954,
        size.width * 0.1061040, size.height * 0.7037442);
    path_0.cubicTo(size.width * 0.1046015, size.height * 0.7048378, size.width * 0.1023510, size.height * 0.7042714,
        size.width * 0.1006720, size.height * 0.7042714);
    path_0.cubicTo(size.width * 0.09898962, size.height * 0.7042714, size.width * 0.09740171, size.height * 0.7058690,
        size.width * 0.09668862, size.height * 0.7069071);
    path_0.cubicTo(size.width * 0.09541082, size.height * 0.7087671, size.width * 0.09313570, size.height * 0.7064297,
        size.width * 0.09234306, size.height * 0.7058528);
    path_0.cubicTo(size.width * 0.09077291, size.height * 0.7047100, size.width * 0.08999825, size.height * 0.7036190,
        size.width * 0.08872176, size.height * 0.7026899);
    path_0.cubicTo(size.width * 0.08612500, size.height * 0.7007999, size.width * 0.08962993, size.height * 0.6988012,
        size.width * 0.09053241, size.height * 0.6984727);
    path_0.cubicTo(size.width * 0.09213890, size.height * 0.6978881, size.width * 0.09404327, size.height * 0.6974506,
        size.width * 0.09596436, size.height * 0.6968913);
    path_0.cubicTo(size.width * 0.09772590, size.height * 0.6963785, size.width * 0.09959781, size.height * 0.6958326,
        size.width * 0.1010342, size.height * 0.6953099);
    path_0.cubicTo(size.width * 0.1031888, size.height * 0.6945258, size.width * 0.1053863, size.height * 0.6939896,
        size.width * 0.1075525, size.height * 0.6932013);
    path_0.cubicTo(size.width * 0.1089960, size.height * 0.6926760, size.width * 0.1104503, size.height * 0.6921467,
        size.width * 0.1118981, size.height * 0.6916199);
    path_0.cubicTo(size.width * 0.1134772, size.height * 0.6910452, size.width * 0.1156927, size.height * 0.6916199,
        size.width * 0.1173300, size.height * 0.6916199);
    path_0.cubicTo(size.width * 0.1191567, size.height * 0.6916199, size.width * 0.1212817, size.height * 0.6917632,
        size.width * 0.1216756, size.height * 0.6916199);
    path_0.cubicTo(size.width * 0.1240269, size.height * 0.6907642, size.width * 0.1247458, size.height * 0.6894656,
        size.width * 0.1242105, size.height * 0.6863484);
    path_0.cubicTo(size.width * 0.1237432, size.height * 0.6836274, size.width * 0.1258962, size.height * 0.6817860,
        size.width * 0.1267454, size.height * 0.6805498);
    path_0.cubicTo(size.width * 0.1276663, size.height * 0.6792092, size.width * 0.1297307, size.height * 0.6781134,
        size.width * 0.1307288, size.height * 0.6773869);
    path_0.cubicTo(size.width * 0.1320500, size.height * 0.6764253, size.width * 0.1333516, size.height * 0.6760051,
        size.width * 0.1350744, size.height * 0.6747512);
    path_0.cubicTo(size.width * 0.1364912, size.height * 0.6737200, size.width * 0.1375054, size.height * 0.6724546,
        size.width * 0.1386957, size.height * 0.6715883);
    path_0.cubicTo(size.width * 0.1413354, size.height * 0.6696670, size.width * 0.1371623, size.height * 0.6712239,
        size.width * 0.1361607, size.height * 0.6715883);
    path_0.cubicTo(size.width * 0.1341725, size.height * 0.6723119, size.width * 0.1319249, size.height * 0.6714166,
        size.width * 0.1300045, size.height * 0.6721155);
    path_0.cubicTo(size.width * 0.1281431, size.height * 0.6727929, size.width * 0.1254221, size.height * 0.6721155,
        size.width * 0.1234862, size.height * 0.6721155);
    path_0.cubicTo(size.width * 0.1216756, size.height * 0.6721155, size.width * 0.1198649, size.height * 0.6721155,
        size.width * 0.1180543, size.height * 0.6721155);
    path_0.cubicTo(size.width * 0.1163795, size.height * 0.6721155, size.width * 0.1135133, size.height * 0.6728049,
        size.width * 0.1122602, size.height * 0.6731698);
    path_0.cubicTo(size.width * 0.1103719, size.height * 0.6737195, size.width * 0.1083400, size.height * 0.6731514,
        size.width * 0.1064661, size.height * 0.6736969);
    path_0.cubicTo(size.width * 0.1043908, size.height * 0.6743011, size.width * 0.1025986, size.height * 0.6752783,
        size.width * 0.1006720, size.height * 0.6752783);
    path_0.cubicTo(size.width * 0.09839506, size.height * 0.6752783, size.width * 0.09807325, size.height * 0.6762396,
        size.width * 0.09668862, size.height * 0.6742241);
    path_0.cubicTo(size.width * 0.09573617, size.height * 0.6728376, size.width * 0.09380081, size.height * 0.6719870,
        size.width * 0.09270519, size.height * 0.6715883);
    path_0.cubicTo(size.width * 0.09067010, size.height * 0.6708477, size.width * 0.08924423, size.height * 0.6722623,
        size.width * 0.08799750, size.height * 0.6731698);
    path_0.cubicTo(size.width * 0.08643088, size.height * 0.6743100, size.width * 0.08589372, size.height * 0.6772865,
        size.width * 0.08473834, size.height * 0.6789684);
    path_0.cubicTo(size.width * 0.08450300, size.height * 0.6793110, size.width * 0.08302494, size.height * 0.6737360,
        size.width * 0.08292769, size.height * 0.6731698);
    path_0.cubicTo(size.width * 0.08251019, size.height * 0.6707388, size.width * 0.08256411, size.height * 0.6673796,
        size.width * 0.08292769, size.height * 0.6652626);
    path_0.cubicTo(size.width * 0.08339219, size.height * 0.6625580, size.width * 0.08416005, size.height * 0.6612028,
        size.width * 0.08582472, size.height * 0.6599911);
    path_0.cubicTo(size.width * 0.08704491, size.height * 0.6591030, size.width * 0.08917699, size.height * 0.6594640,
        size.width * 0.09089454, size.height * 0.6594640);
    path_0.cubicTo(size.width * 0.09251393, size.height * 0.6594640, size.width * 0.09380080, size.height * 0.6618428,
        size.width * 0.09487797, size.height * 0.6626269);
    path_0.cubicTo(size.width * 0.09654569, size.height * 0.6638407, size.width * 0.09882578, size.height * 0.6615985,
        size.width * 0.09958565, size.height * 0.6610454);
    path_0.cubicTo(size.width * 0.1006540, size.height * 0.6602678, size.width * 0.1011101, size.height * 0.6558593,
        size.width * 0.1013963, size.height * 0.6541925);
    path_0.cubicTo(size.width * 0.1017078, size.height * 0.6523787, size.width * 0.1000069, size.height * 0.6496204,
        size.width * 0.09958565, size.height * 0.6483939);
    path_0.cubicTo(size.width * 0.09866035, size.height * 0.6457000, size.width * 0.09825234, size.height * 0.6466388,
        size.width * 0.09632649, size.height * 0.6473396);
    path_0.cubicTo(size.width * 0.09448238, size.height * 0.6480107, size.width * 0.09367417, size.height * 0.6454164,
        size.width * 0.09306732, size.height * 0.6436496);
    path_0.cubicTo(size.width * 0.09231659, size.height * 0.6414640, size.width * 0.09198093, size.height * 0.6407824,
        size.width * 0.09198093, size.height * 0.6373239);
    path_0.cubicTo(size.width * 0.09198093, size.height * 0.6335326, size.width * 0.09363746, size.height * 0.6338217,
        size.width * 0.08980815, size.height * 0.6352153);
    path_0.cubicTo(size.width * 0.08898053, size.height * 0.6355165, size.width * 0.08723623, size.height * 0.6407343,
        size.width * 0.08654899, size.height * 0.6420682);
    path_0.cubicTo(size.width * 0.08527948, size.height * 0.6445322, size.width * 0.08362695, size.height * 0.6425589,
        size.width * 0.08292769, size.height * 0.6415410);
    path_0.cubicTo(size.width * 0.08188030, size.height * 0.6400164, size.width * 0.08220343, size.height * 0.6371753,
        size.width * 0.08220343, size.height * 0.6346881);
    path_0.cubicTo(size.width * 0.08220343, size.height * 0.6320352, size.width * 0.08258643, size.height * 0.6300654,
        size.width * 0.08220343, size.height * 0.6278352);
    path_0.cubicTo(size.width * 0.08177112, size.height * 0.6253180, size.width * 0.08150678, size.height * 0.6232919,
        size.width * 0.08111704, size.height * 0.6204552);
    path_0.cubicTo(size.width * 0.08076500, size.height * 0.6178929, size.width * 0.08039278, size.height * 0.6165309,
        size.width * 0.08039278, size.height * 0.6136023);
    path_0.cubicTo(size.width * 0.08039278, size.height * 0.6108281, size.width * 0.08113265, size.height * 0.6087671,
        size.width * 0.08147917, size.height * 0.6067494);
    path_0.cubicTo(size.width * 0.08190215, size.height * 0.6042865, size.width * 0.08223186, size.height * 0.6013125,
        size.width * 0.08256556, size.height * 0.5993694);
    path_0.cubicTo(size.width * 0.08296034, size.height * 0.5970707, size.width * 0.08256556, size.height * 0.5938457,
        size.width * 0.08256556, size.height * 0.5914622);
    path_0.cubicTo(size.width * 0.08256556, size.height * 0.5884374, size.width * 0.08272251, size.height * 0.5862610,
        size.width * 0.08328982, size.height * 0.5846093);
    path_0.cubicTo(size.width * 0.08392187, size.height * 0.5827692, size.width * 0.08343602, size.height * 0.5837908,
        size.width * 0.08510047, size.height * 0.5819736);
    path_0.close();
    Paint paint0Fill = Paint()..style = PaintingStyle.fill;
    paint0Fill.color = egeColor;
    canvas.drawPath(path_0, paint0Fill);

    ///Ege Bölgesi Bitiş

    ///Marmara Bölgesi Başlangıç
    ///istanbul baskangıc
    Path pathIst = Path();
    pathIst.moveTo(size.width * 0.1830151, size.height * 0.2595459);
    pathIst.cubicTo(size.width * 0.1830151, size.height * 0.2595459, size.width * 0.1820635, size.height * 0.2604553,
        size.width * 0.1814256, size.height * 0.2620028);
    pathIst.cubicTo(size.width * 0.1807155, size.height * 0.2637257, size.width * 0.1799863, size.height * 0.2660339,
        size.width * 0.1799863, size.height * 0.2683239);
    pathIst.cubicTo(size.width * 0.1799863, size.height * 0.2705836, size.width * 0.1788926, size.height * 0.2725439,
        size.width * 0.1778152, size.height * 0.2741122);
    pathIst.cubicTo(size.width * 0.1772036, size.height * 0.2750025, size.width * 0.1765603, size.height * 0.2787199,
        size.width * 0.1763515, size.height * 0.2799361);
    pathIst.cubicTo(size.width * 0.1758285, size.height * 0.2829810, size.width * 0.1745463, size.height * 0.2826941,
        size.width * 0.1745463, size.height * 0.2862571);
    pathIst.cubicTo(size.width * 0.1745462, size.height * 0.2884405, size.width * 0.1765873, size.height * 0.2898201,
        size.width * 0.1774493, size.height * 0.2904474);
    pathIst.cubicTo(size.width * 0.1787160, size.height * 0.2913694, size.width * 0.1807752, size.height * 0.2923711,
        size.width * 0.1817916, size.height * 0.2931108);

    pathIst.cubicTo(size.width * 0.1831127, size.height * 0.2940723, size.width * 0.1843191, size.height * 0.2946787,
        size.width * 0.1857680, size.height * 0.2952060);
    pathIst.cubicTo(size.width * 0.1881270, size.height * 0.2960645, size.width * 0.1865321, size.height * 0.2984813,
        size.width * 0.1857680, size.height * 0.2999645);
    pathIst.cubicTo(size.width * 0.1839482, size.height * 0.3034965, size.width * 0.1870583, size.height * 0.3019018,
        size.width * 0.1883050, size.height * 0.3009943);
    pathIst.cubicTo(size.width * 0.1897332, size.height * 0.2999548, size.width * 0.1910790, size.height * 0.3034343,
        size.width * 0.1915740, size.height * 0.3041548);

    pathIst.cubicTo(size.width * 0.1929790, size.height * 0.3062000, size.width * 0.1943865, size.height * 0.3055346,
        size.width * 0.1955504, size.height * 0.3046875);
    pathIst.cubicTo(size.width * 0.1969144, size.height * 0.3036947, size.width * 0.1987508, size.height * 0.3026084,
        size.width * 0.2002586, size.height * 0.3020597);
    pathIst.cubicTo(size.width * 0.2025582, size.height * 0.3012228, size.width * 0.2037828, size.height * 0.3018986,
        size.width * 0.2053327, size.height * 0.3041548);

    pathIst.cubicTo(size.width * 0.2069169, size.height * 0.3064608, size.width * 0.2051623, size.height * 0.3083807,
        size.width * 0.2089432, size.height * 0.3083807);
    pathIst.cubicTo(size.width * 0.2106945, size.height * 0.3083807, size.width * 0.2123497, size.height * 0.3068182,
        size.width * 0.2143833, size.height * 0.3068182);
    //İst centralAnatolia
    pathIst.moveTo(size.width * 0.1830151, size.height * 0.2595459);
    pathIst.cubicTo(size.width * 0.1830151, size.height * 0.2595459, size.width * 0.1820635, size.height * 0.2604553,
        size.width * 0.1814256, size.height * 0.2620028);
    pathIst.cubicTo(size.width * 0.1807155, size.height * 0.2637257, size.width * 0.1799863, size.height * 0.2660339,
        size.width * 0.1799863, size.height * 0.2683239);

    pathIst.cubicTo(size.width * 0.1799863, size.height * 0.2705836, size.width * 0.1788926, size.height * 0.2725439,
        size.width * 0.1778152, size.height * 0.2741122);
    pathIst.cubicTo(size.width * 0.1772036, size.height * 0.2750025, size.width * 0.1765603, size.height * 0.2787199,
        size.width * 0.1763515, size.height * 0.2799361);
    pathIst.cubicTo(size.width * 0.1758285, size.height * 0.2829810, size.width * 0.1745463, size.height * 0.2826941,
        size.width * 0.1745463, size.height * 0.2862571);

    pathIst.cubicTo(size.width * 0.1745462, size.height * 0.2884405, size.width * 0.1765873, size.height * 0.2898201,
        size.width * 0.1774493, size.height * 0.2904474);
    pathIst.cubicTo(size.width * 0.1787160, size.height * 0.2913694, size.width * 0.1807752, size.height * 0.2923711,
        size.width * 0.1817916, size.height * 0.2931108);
    pathIst.cubicTo(size.width * 0.1831127, size.height * 0.2940723, size.width * 0.1843191, size.height * 0.2946787,
        size.width * 0.1857680, size.height * 0.2952060);

    pathIst.cubicTo(size.width * 0.1881270, size.height * 0.2960645, size.width * 0.1865321, size.height * 0.2984813,
        size.width * 0.1857680, size.height * 0.2999645);
    pathIst.cubicTo(size.width * 0.1839482, size.height * 0.3034965, size.width * 0.1870583, size.height * 0.3019018,
        size.width * 0.1883050, size.height * 0.3009943);
    pathIst.cubicTo(size.width * 0.1897332, size.height * 0.2999548, size.width * 0.1910790, size.height * 0.3034343,
        size.width * 0.1915740, size.height * 0.3041548);

    pathIst.cubicTo(size.width * 0.1929790, size.height * 0.3062000, size.width * 0.1943865, size.height * 0.3055346,
        size.width * 0.1955504, size.height * 0.3046875);
    pathIst.cubicTo(size.width * 0.1969144, size.height * 0.3036947, size.width * 0.1987508, size.height * 0.3026084,
        size.width * 0.2002586, size.height * 0.3020597);

    pathIst.cubicTo(size.width * 0.2025582, size.height * 0.3012228, size.width * 0.2037828, size.height * 0.3018986,
        size.width * 0.2053327, size.height * 0.3041548);
    pathIst.cubicTo(size.width * 0.2069169, size.height * 0.3064608, size.width * 0.2051623, size.height * 0.3083807,
        size.width * 0.2089432, size.height * 0.3083807);
    pathIst.cubicTo(size.width * 0.2106945, size.height * 0.3083807, size.width * 0.2123497, size.height * 0.3068182,
        size.width * 0.2143833, size.height * 0.3068182);

    //kocaeli tarafı
    pathIst.cubicTo(size.width * 0.2350637, size.height * 0.2717135, size.width * 0.2333194, size.height * 0.2739100,
        size.width * 0.2310451, size.height * 0.2730824);
    pathIst.cubicTo(size.width * 0.2289724, size.height * 0.2723281, size.width * 0.2272826, size.height * 0.2720170,
        size.width * 0.2252391, size.height * 0.2720170);

    pathIst.cubicTo(size.width * 0.2240913, size.height * 0.2720170, size.width * 0.2212709, size.height * 0.2713542,
        size.width * 0.2201649, size.height * 0.2709517);
    pathIst.cubicTo(size.width * 0.2180903, size.height * 0.2701967, size.width * 0.2175218, size.height * 0.2688565,
        size.width * 0.2151151, size.height * 0.2688565);
    pathIst.cubicTo(size.width * 0.2126298, size.height * 0.2688565, size.width * 0.2113754, size.height * 0.2683239,
        size.width * 0.2089432, size.height * 0.2683239);
    pathIst.cubicTo(size.width * 0.2067032, size.height * 0.2683239, size.width * 0.2046814, size.height * 0.2677912,
        size.width * 0.2020638, size.height * 0.2677912);
    pathIst.cubicTo(size.width * 0.2001124, size.height * 0.2677912, size.width * 0.1983135, size.height * 0.2673319,
        size.width * 0.1966481, size.height * 0.2667259);
    pathIst.cubicTo(size.width * 0.1947065, size.height * 0.2660193, size.width * 0.1925869, size.height * 0.2651325,
        size.width * 0.1912080, size.height * 0.2646307);
    pathIst.cubicTo(size.width * 0.1893295, size.height * 0.2639470, size.width * 0.1881910, size.height * 0.2623843,
        size.width * 0.1868657, size.height * 0.2609375);
    pathIst.cubicTo(size.width * 0.1859013, size.height * 0.2598846, size.width * 0.1849600, size.height * 0.2594315,
        size.width * 0.1841091, size.height * 0.2594815);
    pathIst.close();

    Path pathAvIst = Path();
    pathAvIst.moveTo(size.width * 0.1680282, size.height * 0.2867721);
    pathAvIst.cubicTo(size.width * 0.1686660, size.height * 0.2880101, size.width * 0.1634908, size.height * 0.2886791,
        size.width * 0.1625962, size.height * 0.2883535);
    pathAvIst.cubicTo(size.width * 0.1609634, size.height * 0.2877593, size.width * 0.1593048, size.height * 0.2875863,
        size.width * 0.1575264, size.height * 0.2888807);
    pathAvIst.cubicTo(size.width * 0.1558040, size.height * 0.2901343, size.width * 0.1550732, size.height * 0.2900539,
        size.width * 0.1539051, size.height * 0.2883535);
    pathAvIst.cubicTo(size.width * 0.1525103, size.height * 0.2863231, size.width * 0.1541892, size.height * 0.2839295,
        size.width * 0.1517323, size.height * 0.2857178);
    pathAvIst.cubicTo(size.width * 0.1503232, size.height * 0.2867434, size.width * 0.1483632, size.height * 0.2844917,
        size.width * 0.1473868, size.height * 0.2841364);
    pathAvIst.cubicTo(size.width * 0.1460362, size.height * 0.2836449, size.width * 0.1451334, size.height * 0.2816031,
        size.width * 0.1434033, size.height * 0.2809735);
    pathAvIst.cubicTo(size.width * 0.1417854, size.height * 0.2803847, size.width * 0.1411570, size.height * 0.2788649,
        size.width * 0.1390578, size.height * 0.2788649);
    pathAvIst.cubicTo(size.width * 0.1376822, size.height * 0.2788649, size.width * 0.1357972, size.height * 0.2778106,
        size.width * 0.1339880, size.height * 0.2778106);
    pathAvIst.cubicTo(size.width * 0.1320006, size.height * 0.2778106, size.width * 0.1300806, size.height * 0.2777829,
        size.width * 0.1285560, size.height * 0.2783377);
    pathAvIst.cubicTo(size.width * 0.1266741, size.height * 0.2790226, size.width * 0.1261043, size.height * 0.2809432,
        size.width * 0.1245726, size.height * 0.2815006);
    pathAvIst.cubicTo(size.width * 0.1232891, size.height * 0.2819677, size.width * 0.1219110, size.height * 0.2847557,
        size.width * 0.1205892, size.height * 0.2857178);
    pathAvIst.cubicTo(size.width * 0.1188875, size.height * 0.2869563, size.width * 0.1192837, size.height * 0.2888807,
        size.width * 0.1169679, size.height * 0.2888807);
    pathAvIst.cubicTo(size.width * 0.1385591, size.height * 0.2391302, size.width * 0.1399019, size.height * 0.2402069,
        size.width * 0.1408684, size.height * 0.2409104);
    pathAvIst.cubicTo(size.width * 0.1425733, size.height * 0.2421513, size.width * 0.1439213, size.height * 0.2430757,
        size.width * 0.1452140, size.height * 0.2435461);
    pathAvIst.cubicTo(size.width * 0.1468205, size.height * 0.2441308, size.width * 0.1479364, size.height * 0.2454594,
        size.width * 0.1499217, size.height * 0.2461819);
    pathAvIst.cubicTo(size.width * 0.1515397, size.height * 0.2467707, size.width * 0.1528504, size.height * 0.2485771,
        size.width * 0.1539051, size.height * 0.2493448);
    pathAvIst.cubicTo(size.width * 0.1552605, size.height * 0.2503313, size.width * 0.1564220, size.height * 0.2509196,
        size.width * 0.1578885, size.height * 0.2514533);
    pathAvIst.cubicTo(size.width * 0.1596300, size.height * 0.2520871, size.width * 0.1601695, size.height * 0.2534695,
        size.width * 0.1618720, size.height * 0.2540891);
    pathAvIst.cubicTo(size.width * 0.1632632, size.height * 0.2545953, size.width * 0.1646129, size.height * 0.2568747,
        size.width * 0.1658554, size.height * 0.2577791);
    pathAvIst.cubicTo(size.width * 0.1670705, size.height * 0.2586635, size.width * 0.1690184, size.height * 0.2593605,
        size.width * 0.1705631, size.height * 0.2593605);
    pathAvIst.cubicTo(size.width * 0.1721158, size.height * 0.2593605, size.width * 0.1729089, size.height * 0.2614691,
        size.width * 0.1749086, size.height * 0.2614691);
    pathAvIst.cubicTo(size.width * 0.1769806, size.height * 0.2614691, size.width * 0.1759777, size.height * 0.2646572,
        size.width * 0.1778057, size.height * 0.2619962);
    pathAvIst.cubicTo(size.width * 0.1783757, size.height * 0.2611665, size.width * 0.1785005, size.height * 0.2668262,
        size.width * 0.1781678, size.height * 0.2677948);
    pathAvIst.cubicTo(size.width * 0.1774048, size.height * 0.2700161, size.width * 0.1767193, size.height * 0.2707036,
        size.width * 0.1767193, size.height * 0.2735934);
    pathAvIst.cubicTo(size.width * 0.1767193, size.height * 0.2753710, size.width * 0.1750199, size.height * 0.2785410,
        size.width * 0.1745465, size.height * 0.2799192);
    pathAvIst.cubicTo(size.width * 0.1740309, size.height * 0.2814201, size.width * 0.1726944, size.height * 0.2831424,
        size.width * 0.1720116, size.height * 0.2841364);
    pathAvIst.cubicTo(size.width * 0.1704863, size.height * 0.2863567, size.width * 0.1702491, size.height * 0.2874187,
        size.width * 0.1680282, size.height * 0.2867721);
    pathAvIst.close();

    ///instanbul bitis

    Path path_1 = Path();
    path_1.moveTo(size.width * 0.02208991, size.height * 0.4037984);
    path_1.cubicTo(size.width * 0.02118532, size.height * 0.4036945, size.width * 0.01858052, size.height * 0.4020348,
        size.width * 0.01738222, size.height * 0.4011627);
    path_1.cubicTo(size.width * 0.01563227, size.height * 0.3998890, size.width * 0.01563689, size.height * 0.3974726,
        size.width * 0.01810648, size.height * 0.3974726);
    path_1.cubicTo(size.width * 0.02018539, size.height * 0.3974726, size.width * 0.02165620, size.height * 0.3977102,
        size.width * 0.02245204, size.height * 0.3979998);
    path_1.cubicTo(size.width * 0.02374551, size.height * 0.3984705, size.width * 0.02235139, size.height * 0.4018952,
        size.width * 0.02208991, size.height * 0.4037984);

    path_1.close();
    Paint paint1Fill = Paint()..style = PaintingStyle.fill;
    paint1Fill.color = marmaraColor;
    canvas.drawPath(path_1, paint1Fill);

    Path path_2 = Path();
    path_2.moveTo(size.width * 0.1841091, size.height * 0.2594815);
    path_2.cubicTo(size.width * 0.1830151, size.height * 0.2595459, size.width * 0.1820635, size.height * 0.2604553,
        size.width * 0.1814256, size.height * 0.2620028);
    path_2.cubicTo(size.width * 0.1807155, size.height * 0.2637257, size.width * 0.1799863, size.height * 0.2660339,
        size.width * 0.1799863, size.height * 0.2683239);
    path_2.cubicTo(size.width * 0.1799863, size.height * 0.2705836, size.width * 0.1788926, size.height * 0.2725439,
        size.width * 0.1778152, size.height * 0.2741122);
    path_2.cubicTo(size.width * 0.1772036, size.height * 0.2750025, size.width * 0.1765603, size.height * 0.2787199,
        size.width * 0.1763515, size.height * 0.2799361);
    path_2.cubicTo(size.width * 0.1758285, size.height * 0.2829810, size.width * 0.1745463, size.height * 0.2826941,
        size.width * 0.1745463, size.height * 0.2862571);
    path_2.cubicTo(size.width * 0.1745462, size.height * 0.2884405, size.width * 0.1765873, size.height * 0.2898201,
        size.width * 0.1774493, size.height * 0.2904474);
    path_2.cubicTo(size.width * 0.1787160, size.height * 0.2913694, size.width * 0.1807752, size.height * 0.2923711,
        size.width * 0.1817916, size.height * 0.2931108);
    path_2.cubicTo(size.width * 0.1831127, size.height * 0.2940723, size.width * 0.1843191, size.height * 0.2946787,
        size.width * 0.1857680, size.height * 0.2952060);
    path_2.cubicTo(size.width * 0.1881270, size.height * 0.2960645, size.width * 0.1865321, size.height * 0.2984813,
        size.width * 0.1857680, size.height * 0.2999645);
    path_2.cubicTo(size.width * 0.1839482, size.height * 0.3034965, size.width * 0.1870583, size.height * 0.3019018,
        size.width * 0.1883050, size.height * 0.3009943);
    path_2.cubicTo(size.width * 0.1897332, size.height * 0.2999548, size.width * 0.1910790, size.height * 0.3034343,
        size.width * 0.1915740, size.height * 0.3041548);
    path_2.cubicTo(size.width * 0.1929790, size.height * 0.3062000, size.width * 0.1943865, size.height * 0.3055346,
        size.width * 0.1955504, size.height * 0.3046875);
    path_2.cubicTo(size.width * 0.1969144, size.height * 0.3036947, size.width * 0.1987508, size.height * 0.3026084,
        size.width * 0.2002586, size.height * 0.3020597);
    path_2.cubicTo(size.width * 0.2025582, size.height * 0.3012228, size.width * 0.2037828, size.height * 0.3018986,
        size.width * 0.2053327, size.height * 0.3041548);
    path_2.cubicTo(size.width * 0.2069169, size.height * 0.3064608, size.width * 0.2051623, size.height * 0.3083807,
        size.width * 0.2089432, size.height * 0.3083807);
    path_2.cubicTo(size.width * 0.2106945, size.height * 0.3083807, size.width * 0.2123497, size.height * 0.3068182,
        size.width * 0.2143833, size.height * 0.3068182);

    path_2.cubicTo(size.width * 0.2163575, size.height * 0.3068182, size.width * 0.2179449, size.height * 0.3073153,
        size.width * 0.2198234, size.height * 0.3073153);
    path_2.cubicTo(size.width * 0.2211687, size.height * 0.3073153, size.width * 0.2224606, size.height * 0.3096273,
        size.width * 0.2230679, size.height * 0.3105114);
    path_2.cubicTo(size.width * 0.2247837, size.height * 0.3130091, size.width * 0.2197152, size.height * 0.3144747,
        size.width * 0.2190915, size.height * 0.3147017);
    path_2.cubicTo(size.width * 0.2166943, size.height * 0.3155741, size.width * 0.2132670, size.height * 0.3157670,
        size.width * 0.2107484, size.height * 0.3157670);
    path_2.cubicTo(size.width * 0.2083883, size.height * 0.3157670, size.width * 0.2081036, size.height * 0.3165180,
        size.width * 0.2060402, size.height * 0.3157670);
    path_2.cubicTo(size.width * 0.2050771, size.height * 0.3154165, size.width * 0.2034246, size.height * 0.3129893,
        size.width * 0.2027957, size.height * 0.3120739);
    path_2.cubicTo(size.width * 0.2019651, size.height * 0.3108648, size.width * 0.2002364, size.height * 0.3099787,
        size.width * 0.1984534, size.height * 0.3099787);
    path_2.cubicTo(size.width * 0.1973263, size.height * 0.3099787, size.width * 0.1955713, size.height * 0.3136058,
        size.width * 0.1948185, size.height * 0.3147017);
    path_2.cubicTo(size.width * 0.1938404, size.height * 0.3161255, size.width * 0.1917166, size.height * 0.3162478,
        size.width * 0.1901103, size.height * 0.3168324);
    path_2.cubicTo(size.width * 0.1883556, size.height * 0.3174709, size.width * 0.1878756, size.height * 0.3183949,
        size.width * 0.1857680, size.height * 0.3183949);
    path_2.cubicTo(size.width * 0.1843624, size.height * 0.3183949, size.width * 0.1823452, size.height * 0.3189276,
        size.width * 0.1806938, size.height * 0.3189276);
    path_2.cubicTo(size.width * 0.1789179, size.height * 0.3189276, size.width * 0.1768913, size.height * 0.3195390,
        size.width * 0.1756440, size.height * 0.3199929);
    path_2.cubicTo(size.width * 0.1737814, size.height * 0.3206708, size.width * 0.1725736, size.height * 0.3222099,
        size.width * 0.1712773, size.height * 0.3231534);
    path_2.cubicTo(size.width * 0.1694554, size.height * 0.3244795, size.width * 0.1689575, size.height * 0.3257111,
        size.width * 0.1673009, size.height * 0.3263139);
    path_2.cubicTo(size.width * 0.1650324, size.height * 0.3271395, size.width * 0.1648422, size.height * 0.3295154,
        size.width * 0.1643979, size.height * 0.3321023);
    path_2.cubicTo(size.width * 0.1641151, size.height * 0.3337489, size.width * 0.1683815, size.height * 0.3349991,
        size.width * 0.1691062, size.height * 0.3352628);
    path_2.cubicTo(size.width * 0.1709744, size.height * 0.3359427, size.width * 0.1729324, size.height * 0.3357955,
        size.width * 0.1749122, size.height * 0.3357955);
    path_2.cubicTo(size.width * 0.1771288, size.height * 0.3357955, size.width * 0.1779533, size.height * 0.3344340,
        size.width * 0.1796204, size.height * 0.3368608);
    path_2.cubicTo(size.width * 0.1804101, size.height * 0.3380103, size.width * 0.1804922, size.height * 0.3384886,
        size.width * 0.1810597, size.height * 0.3405540);
    path_2.cubicTo(size.width * 0.1804399, size.height * 0.3423317, size.width * 0.1786544, size.height * 0.3450266,
        size.width * 0.1774493, size.height * 0.3463423);
    path_2.cubicTo(size.width * 0.1761000, size.height * 0.3478154, size.width * 0.1741591, size.height * 0.3472556,
        size.width * 0.1723751, size.height * 0.3479048);
    path_2.cubicTo(size.width * 0.1708967, size.height * 0.3484429, size.width * 0.1686275, size.height * 0.3466919,
        size.width * 0.1676669, size.height * 0.3463423);
    path_2.cubicTo(size.width * 0.1658681, size.height * 0.3456877, size.width * 0.1647905, size.height * 0.3442472,
        size.width * 0.1629586, size.height * 0.3442472);
    path_2.cubicTo(size.width * 0.1610063, size.height * 0.3442472, size.width * 0.1596847, size.height * 0.3452984,
        size.width * 0.1582504, size.height * 0.3463423);
    path_2.cubicTo(size.width * 0.1569646, size.height * 0.3472782, size.width * 0.1552595, size.height * 0.3474077,
        size.width * 0.1535422, size.height * 0.3474077);
    path_2.cubicTo(size.width * 0.1527920, size.height * 0.3474077, size.width * 0.1506432, size.height * 0.3444987,
        size.width * 0.1495658, size.height * 0.3437145);
    path_2.cubicTo(size.width * 0.1483038, size.height * 0.3427960, size.width * 0.1461964, size.height * 0.3431818,
        size.width * 0.1444916, size.height * 0.3431818);
    path_2.cubicTo(size.width * 0.1426810, size.height * 0.3431818, size.width * 0.1408622, size.height * 0.3431818,
        size.width * 0.1390515, size.height * 0.3431818);
    path_2.cubicTo(size.width * 0.1372579, size.height * 0.3431818, size.width * 0.1354226, size.height * 0.3442472,
        size.width * 0.1336358, size.height * 0.3442472);
    path_2.cubicTo(size.width * 0.1316674, size.height * 0.3442472, size.width * 0.1301629, size.height * 0.3437145,
        size.width * 0.1281957, size.height * 0.3437145);
    path_2.cubicTo(size.width * 0.1266242, size.height * 0.3437145, size.width * 0.1249457, size.height * 0.3460800,
        size.width * 0.1238534, size.height * 0.3468750);
    path_2.cubicTo(size.width * 0.1232725, size.height * 0.3472978, size.width * 0.1212916, size.height * 0.3474077,
        size.width * 0.1195111, size.height * 0.3474077);
    path_2.cubicTo(size.width * 0.1164969, size.height * 0.3474077, size.width * 0.1191949, size.height * 0.3429079,
        size.width * 0.1198770, size.height * 0.3415838);
    path_2.cubicTo(size.width * 0.1209684, size.height * 0.3394657, size.width * 0.1225372, size.height * 0.3394154,
        size.width * 0.1238534, size.height * 0.3368608);
    path_2.cubicTo(size.width * 0.1253721, size.height * 0.3339132, size.width * 0.1238175, size.height * 0.3337003,
        size.width * 0.1216823, size.height * 0.3337003);
    path_2.cubicTo(size.width * 0.1197205, size.height * 0.3337003, size.width * 0.1182097, size.height * 0.3337505,
        size.width * 0.1166081, size.height * 0.3331676);
    path_2.cubicTo(size.width * 0.1148539, size.height * 0.3325292, size.width * 0.1143109, size.height * 0.3316480,
        size.width * 0.1126317, size.height * 0.3310369);
    path_2.cubicTo(size.width * 0.1105823, size.height * 0.3302911, size.width * 0.1092617, size.height * 0.3297864,
        size.width * 0.1071916, size.height * 0.3305398);
    path_2.cubicTo(size.width * 0.1051850, size.height * 0.3312700, size.width * 0.1074620, size.height * 0.3361890,
        size.width * 0.1075576, size.height * 0.3363281);
    path_2.cubicTo(size.width * 0.1089545, size.height * 0.3383616, size.width * 0.1101319, size.height * 0.3370048,
        size.width * 0.1111680, size.height * 0.3400213);
    path_2.cubicTo(size.width * 0.1119919, size.height * 0.3424198, size.width * 0.1126689, size.height * 0.3426940,
        size.width * 0.1140710, size.height * 0.3437145);
    path_2.cubicTo(size.width * 0.1165367, size.height * 0.3455091, size.width * 0.1152201, size.height * 0.3470685,
        size.width * 0.1133392, size.height * 0.3484375);
    path_2.cubicTo(size.width * 0.1119062, size.height * 0.3494805, size.width * 0.1111700, size.height * 0.3510898,
        size.width * 0.1097287, size.height * 0.3526634);
    path_2.cubicTo(size.width * 0.1085063, size.height * 0.3539979, size.width * 0.1060120, size.height * 0.3530242,
        size.width * 0.1050205, size.height * 0.3526634);
    path_2.cubicTo(size.width * 0.1034402, size.height * 0.3520883, size.width * 0.1029185, size.height * 0.3511009,
        size.width * 0.1006782, size.height * 0.3511009);
    path_2.cubicTo(size.width * 0.09865237, size.height * 0.3511009, size.width * 0.09767684, size.height * 0.3520769,
        size.width * 0.09560402, size.height * 0.3505682);
    path_2.cubicTo(size.width * 0.09413852, size.height * 0.3495015, size.width * 0.09320574, size.height * 0.3488049,
        size.width * 0.09196916, size.height * 0.3479048);
    path_2.cubicTo(size.width * 0.09050727, size.height * 0.3468408, size.width * 0.09021863, size.height * 0.3454212,
        size.width * 0.08835870, size.height * 0.3447443);
    path_2.cubicTo(size.width * 0.08705480, size.height * 0.3442698, size.width * 0.08580377, size.height * 0.3426232,
        size.width * 0.08508977, size.height * 0.3415838);
    path_2.cubicTo(size.width * 0.08357497, size.height * 0.3393787, size.width * 0.08383539, size.height * 0.3386149,
        size.width * 0.08184524, size.height * 0.3378906);
    path_2.cubicTo(size.width * 0.08007827, size.height * 0.3372476, size.width * 0.07731320, size.height * 0.3379597,
        size.width * 0.07603923, size.height * 0.3384233);
    path_2.cubicTo(size.width * 0.07423260, size.height * 0.3390808, size.width * 0.07326210, size.height * 0.3399275,
        size.width * 0.07279469, size.height * 0.3426491);
    path_2.cubicTo(size.width * 0.07246431, size.height * 0.3445729, size.width * 0.06961212, size.height * 0.3452770,
        size.width * 0.06845238, size.height * 0.3452770);
    path_2.cubicTo(size.width * 0.06637917, size.height * 0.3452770, size.width * 0.06544828, size.height * 0.3447443,
        size.width * 0.06337822, size.height * 0.3447443);
    path_2.cubicTo(size.width * 0.06197266, size.height * 0.3447443, size.width * 0.05995546, size.height * 0.3442472,
        size.width * 0.05830406, size.height * 0.3442472);
    path_2.cubicTo(size.width * 0.05676643, size.height * 0.3442472, size.width * 0.05557381, size.height * 0.3461964,
        size.width * 0.05469360, size.height * 0.3479048);
    path_2.cubicTo(size.width * 0.05350316, size.height * 0.3502154, size.width * 0.05284675, size.height * 0.3517192,
        size.width * 0.05215652, size.height * 0.3537287);
    path_2.cubicTo(size.width * 0.05130356, size.height * 0.3562120, size.width * 0.05055389, size.height * 0.3569726,
        size.width * 0.04925351, size.height * 0.3579190);
    path_2.cubicTo(size.width * 0.04787877, size.height * 0.3589196, size.width * 0.04627340, size.height * 0.3601236,
        size.width * 0.04491120, size.height * 0.3611151);
    path_2.cubicTo(size.width * 0.04314114, size.height * 0.3624034, size.width * 0.04197338, size.height * 0.3637505,
        size.width * 0.04056889, size.height * 0.3647727);
    path_2.cubicTo(size.width * 0.03874502, size.height * 0.3661002, size.width * 0.03921348, size.height * 0.3683681,
        size.width * 0.03873927, size.height * 0.3711293);
    path_2.cubicTo(size.width * 0.03838835, size.height * 0.3731725, size.width * 0.03703977, size.height * 0.3755444,
        size.width * 0.03656811, size.height * 0.3769176);
    path_2.cubicTo(size.width * 0.03574696, size.height * 0.3793083, size.width * 0.03566734, size.height * 0.3799525,
        size.width * 0.03403103, size.height * 0.3811435);
    path_2.cubicTo(size.width * 0.03253116, size.height * 0.3822351, size.width * 0.03007566, size.height * 0.3827060,
        size.width * 0.02861534, size.height * 0.3827060);
    path_2.cubicTo(size.width * 0.02728127, size.height * 0.3827060, size.width * 0.02646638, size.height * 0.3868672,
        size.width * 0.02607826, size.height * 0.3879972);
    path_2.cubicTo(size.width * 0.02529978, size.height * 0.3902636, size.width * 0.02534641, size.height * 0.3925391,
        size.width * 0.02534641, size.height * 0.3953480);
    path_2.cubicTo(size.width * 0.02534641, size.height * 0.3978482, size.width * 0.02612690, size.height * 0.4003542,
        size.width * 0.02644418, size.height * 0.4022017);
    path_2.cubicTo(size.width * 0.02684583, size.height * 0.4045404, size.width * 0.02642831, size.height * 0.4080825,
        size.width * 0.02607826, size.height * 0.4101207);
    path_2.cubicTo(size.width * 0.02564427, size.height * 0.4126478, size.width * 0.02603148, size.height * 0.4145835,
        size.width * 0.02571233, size.height * 0.4164418);
    path_2.cubicTo(size.width * 0.02534449, size.height * 0.4185836, size.width * 0.02445720, size.height * 0.4198669,
        size.width * 0.02354118, size.height * 0.4212003);
    path_2.cubicTo(size.width * 0.02212999, size.height * 0.4232545, size.width * 0.02244340, size.height * 0.4257324,
        size.width * 0.02244340, size.height * 0.4285866);
    path_2.cubicTo(size.width * 0.02244340, size.height * 0.4318053, size.width * 0.02253606, size.height * 0.4334445,
        size.width * 0.02390710, size.height * 0.4354403);
    path_2.cubicTo(size.width * 0.02504247, size.height * 0.4370931, size.width * 0.02743897, size.height * 0.4364988,
        size.width * 0.02898126, size.height * 0.4359375);
    path_2.cubicTo(size.width * 0.03095143, size.height * 0.4352205, size.width * 0.03241819, size.height * 0.4344835,
        size.width * 0.03403103, size.height * 0.4333097);
    path_2.cubicTo(size.width * 0.03569986, size.height * 0.4320950, size.width * 0.03702380, size.height * 0.4314393,
        size.width * 0.03910519, size.height * 0.4306818);
    path_2.cubicTo(size.width * 0.04069689, size.height * 0.4301025, size.width * 0.04244442, size.height * 0.4290849,
        size.width * 0.04381343, size.height * 0.4285866);
    path_2.cubicTo(size.width * 0.04554981, size.height * 0.4279548, size.width * 0.04649965, size.height * 0.4270586,
        size.width * 0.04815574, size.height * 0.4264560);
    path_2.cubicTo(size.width * 0.05007870, size.height * 0.4257562, size.width * 0.05238408, size.height * 0.4254261,
        size.width * 0.05432767, size.height * 0.4254261);
    path_2.cubicTo(size.width * 0.05573324, size.height * 0.4254261, size.width * 0.05772604, size.height * 0.4248935,
        size.width * 0.05937744, size.height * 0.4248935);
    path_2.cubicTo(size.width * 0.06115722, size.height * 0.4248935, size.width * 0.06319994, size.height * 0.4248163,
        size.width * 0.06445160, size.height * 0.4243608);
    path_2.cubicTo(size.width * 0.06688756, size.height * 0.4234743, size.width * 0.06759016, size.height * 0.4239457,
        size.width * 0.06845238, size.height * 0.4264560);
    path_2.cubicTo(size.width * 0.06916300, size.height * 0.4285249, size.width * 0.06655406, size.height * 0.4310498,
        size.width * 0.06591530, size.height * 0.4317472);
    path_2.cubicTo(size.width * 0.06473355, size.height * 0.4330374, size.width * 0.06337622, size.height * 0.4343765,
        size.width * 0.06191452, size.height * 0.4354403);
    path_2.cubicTo(size.width * 0.06090900, size.height * 0.4361722, size.width * 0.06029812, size.height * 0.4393558,
        size.width * 0.05937744, size.height * 0.4406960);
    path_2.cubicTo(size.width * 0.05817669, size.height * 0.4424439, size.width * 0.05754069, size.height * 0.4440193,
        size.width * 0.05686475, size.height * 0.4459872);
    path_2.cubicTo(size.width * 0.05605615, size.height * 0.4483413, size.width * 0.05442912, size.height * 0.4493495,
        size.width * 0.05359582, size.height * 0.4517756);
    path_2.cubicTo(size.width * 0.05322070, size.height * 0.4528677, size.width * 0.05291900, size.height * 0.4529709,
        size.width * 0.05276639, size.height * 0.4529119);
    path_2.cubicTo(size.width * 0.05289004, size.height * 0.4530923, size.width * 0.05313383, size.height * 0.4535911,
        size.width * 0.05359582, size.height * 0.4549361);
    path_2.cubicTo(size.width * 0.05431110, size.height * 0.4570185, size.width * 0.05647890, size.height * 0.4570442,
        size.width * 0.05720628, size.height * 0.4591619);
    path_2.cubicTo(size.width * 0.05801618, size.height * 0.4615198, size.width * 0.05830556, size.height * 0.4623058,
        size.width * 0.05974336, size.height * 0.4633523);
    path_2.cubicTo(size.width * 0.05978258, size.height * 0.4633808, size.width * 0.05982571, size.height * 0.4634286,
        size.width * 0.05986534, size.height * 0.4634588);
    path_2.cubicTo(size.width * 0.06034456, size.height * 0.4629961, size.width * 0.06155451, size.height * 0.4627198,
        size.width * 0.06264637, size.height * 0.4623224);
    path_2.cubicTo(size.width * 0.06425496, size.height * 0.4617370, size.width * 0.06598371, size.height * 0.4590268,
        size.width * 0.06698868, size.height * 0.4575639);
    path_2.cubicTo(size.width * 0.06827088, size.height * 0.4556974, size.width * 0.06929021, size.height * 0.4537165,
        size.width * 0.07025761, size.height * 0.4523082);
    path_2.cubicTo(size.width * 0.07149250, size.height * 0.4505106, size.width * 0.07215896, size.height * 0.4483352,
        size.width * 0.07279469, size.height * 0.4464844);
    path_2.cubicTo(size.width * 0.07345722, size.height * 0.4445555, size.width * 0.07460434, size.height * 0.4433174,
        size.width * 0.07567330, size.height * 0.4417614);
    path_2.cubicTo(size.width * 0.07702651, size.height * 0.4397915, size.width * 0.07759655, size.height * 0.4391335,
        size.width * 0.08004001, size.height * 0.4391335);
    path_2.cubicTo(size.width * 0.08203494, size.height * 0.4391335, size.width * 0.08335572, size.height * 0.4388665,
        size.width * 0.08545570, size.height * 0.4396307);
    path_2.cubicTo(size.width * 0.08691109, size.height * 0.4401603, size.width * 0.08751460, size.height * 0.4417205,
        size.width * 0.08909055, size.height * 0.4422940);
    path_2.cubicTo(size.width * 0.09090398, size.height * 0.4429540, size.width * 0.09290943, size.height * 0.4416855,
        size.width * 0.09416472, size.height * 0.4412287);
    path_2.cubicTo(size.width * 0.09603326, size.height * 0.4405487, size.width * 0.09577425, size.height * 0.4392397,
        size.width * 0.09777518, size.height * 0.4406960);
    path_2.cubicTo(size.width * 0.09921692, size.height * 0.4417454, size.width * 0.1001178, size.height * 0.4431241,
        size.width * 0.1010441, size.height * 0.4449219);
    path_2.cubicTo(size.width * 0.1019571, size.height * 0.4466939, size.width * 0.1034471, size.height * 0.4475497,
        size.width * 0.1053864, size.height * 0.4475497);
    path_2.cubicTo(size.width * 0.1068074, size.height * 0.4475497, size.width * 0.1083972, size.height * 0.4445593,
        size.width * 0.1093628, size.height * 0.4438565);
    path_2.cubicTo(size.width * 0.1108620, size.height * 0.4427654, size.width * 0.1134372, size.height * 0.4450907,
        size.width * 0.1144370, size.height * 0.4454545);
    path_2.cubicTo(size.width * 0.1162961, size.height * 0.4461311, size.width * 0.1169393, size.height * 0.4473119,
        size.width * 0.1173400, size.height * 0.4496449);
    path_2.cubicTo(size.width * 0.1178598, size.height * 0.4526718, size.width * 0.1162422, size.height * 0.4533395,
        size.width * 0.1162422, size.height * 0.4564986);
    path_2.cubicTo(size.width * 0.1162422, size.height * 0.4596487, size.width * 0.1201635, size.height * 0.4576040,
        size.width * 0.1209504, size.height * 0.4570313);
    path_2.cubicTo(size.width * 0.1229495, size.height * 0.4555762, size.width * 0.1238507, size.height * 0.4570154,
        size.width * 0.1242194, size.height * 0.4591619);
    path_2.cubicTo(size.width * 0.1245531, size.height * 0.4611050, size.width * 0.1254797, size.height * 0.4628313,
        size.width * 0.1260246, size.height * 0.4644176);
    path_2.cubicTo(size.width * 0.1267761, size.height * 0.4666056, size.width * 0.1274153, size.height * 0.4692238,
        size.width * 0.1281957, size.height * 0.4707386);
    path_2.cubicTo(size.width * 0.1293335, size.height * 0.4729469, size.width * 0.1294528, size.height * 0.4736996,
        size.width * 0.1314647, size.height * 0.4744318);
    path_2.cubicTo(size.width * 0.1334203, size.height * 0.4751435, size.width * 0.1356207, size.height * 0.4732535,
        size.width * 0.1368804, size.height * 0.4723366);
    path_2.cubicTo(size.width * 0.1384002, size.height * 0.4712305, size.width * 0.1394390, size.height * 0.4704744,
        size.width * 0.1412227, size.height * 0.4691761);
    path_2.cubicTo(size.width * 0.1430011, size.height * 0.4678817, size.width * 0.1444546, size.height * 0.4668238,
        size.width * 0.1462968, size.height * 0.4654830);
    path_2.cubicTo(size.width * 0.1477601, size.height * 0.4644180, size.width * 0.1492846, size.height * 0.4634812,
        size.width * 0.1510051, size.height * 0.4628551);
    path_2.cubicTo(size.width * 0.1526963, size.height * 0.4622396, size.width * 0.1529207, size.height * 0.4608174,
        size.width * 0.1546399, size.height * 0.4601918);
    path_2.cubicTo(size.width * 0.1563499, size.height * 0.4595695, size.width * 0.1546789, size.height * 0.4679974,
        size.width * 0.1568111, size.height * 0.4617898);
    path_2.cubicTo(size.width * 0.1576154, size.height * 0.4594480, size.width * 0.1573312, size.height * 0.4565468,
        size.width * 0.1578845, size.height * 0.4549361);
    path_2.cubicTo(size.width * 0.1584668, size.height * 0.4532406, size.width * 0.1610993, size.height * 0.4523298,
        size.width * 0.1618609, size.height * 0.4517756);
    path_2.cubicTo(size.width * 0.1635235, size.height * 0.4505654, size.width * 0.1646602, size.height * 0.4492986,
        size.width * 0.1658616, size.height * 0.4475497);
    path_2.cubicTo(size.width * 0.1672273, size.height * 0.4455617, size.width * 0.1682240, size.height * 0.4447671,
        size.width * 0.1687402, size.height * 0.4417614);
    path_2.cubicTo(size.width * 0.1690705, size.height * 0.4398383, size.width * 0.1698401, size.height * 0.4375586,
        size.width * 0.1702039, size.height * 0.4354403);
    path_2.cubicTo(size.width * 0.1705869, size.height * 0.4332107, size.width * 0.1702925, size.height * 0.4296693,
        size.width * 0.1705699, size.height * 0.4280540);
    path_2.cubicTo(size.width * 0.1709947, size.height * 0.4255803, size.width * 0.1716637, size.height * 0.4239450,
        size.width * 0.1734485, size.height * 0.4232955);
    path_2.cubicTo(size.width * 0.1752015, size.height * 0.4226575, size.width * 0.1768457, size.height * 0.4253130,
        size.width * 0.1785226, size.height * 0.4259233);
    path_2.cubicTo(size.width * 0.1801018, size.height * 0.4264980, size.width * 0.1823254, size.height * 0.4259233,
        size.width * 0.1839627, size.height * 0.4259233);
    path_2.cubicTo(size.width * 0.1853556, size.height * 0.4259233, size.width * 0.1872181, size.height * 0.4230528,
        size.width * 0.1879391, size.height * 0.4222656);
    path_2.cubicTo(size.width * 0.1894483, size.height * 0.4206180, size.width * 0.1892737, size.height * 0.4181524,
        size.width * 0.1897443, size.height * 0.4154119);
    path_2.cubicTo(size.width * 0.1901036, size.height * 0.4133199, size.width * 0.1909896, size.height * 0.4107566,
        size.width * 0.1915740, size.height * 0.4090554);
    path_2.cubicTo(size.width * 0.1923240, size.height * 0.4068717, size.width * 0.1926360, size.height * 0.4049313,
        size.width * 0.1930133, size.height * 0.4027344);
    path_2.cubicTo(size.width * 0.1934212, size.height * 0.4003588, size.width * 0.1936668, size.height * 0.3984677,
        size.width * 0.1941110, size.height * 0.3958807);
    path_2.cubicTo(size.width * 0.1945652, size.height * 0.3932360, size.width * 0.1946547, size.height * 0.3919287,
        size.width * 0.1959163, size.height * 0.3900923);
    path_2.cubicTo(size.width * 0.1968528, size.height * 0.3887290, size.width * 0.2008647, size.height * 0.3908544,
        size.width * 0.2016979, size.height * 0.3911577);
    path_2.cubicTo(size.width * 0.2035375, size.height * 0.3918272, size.width * 0.2040641, size.height * 0.3930664,
        size.width * 0.2060402, size.height * 0.3937855);
    path_2.cubicTo(size.width * 0.2085190, size.height * 0.3946876, size.width * 0.2087669, size.height * 0.3914337,
        size.width * 0.2107484, size.height * 0.3943182);
    path_2.cubicTo(size.width * 0.2119436, size.height * 0.3960579, size.width * 0.2122121, size.height * 0.3982992,
        size.width * 0.2122121, size.height * 0.4011719);
    path_2.cubicTo(size.width * 0.2122121, size.height * 0.4039688, size.width * 0.2118357, size.height * 0.4063664,
        size.width * 0.2122121, size.height * 0.4085582);
    path_2.cubicTo(size.width * 0.2122605, size.height * 0.4088399, size.width * 0.2166826, size.height * 0.4100342,
        size.width * 0.2169204, size.height * 0.4101207);
    path_2.cubicTo(size.width * 0.2186614, size.height * 0.4107544, size.width * 0.2203970, size.height * 0.4107379,
        size.width * 0.2216286, size.height * 0.4111861);
    path_2.cubicTo(size.width * 0.2234779, size.height * 0.4118591, size.width * 0.2240841, size.height * 0.4127278,
        size.width * 0.2256050, size.height * 0.4132812);
    path_2.cubicTo(size.width * 0.2273534, size.height * 0.4139175, size.width * 0.2285988, size.height * 0.4122095,
        size.width * 0.2299473, size.height * 0.4117188);
    path_2.cubicTo(size.width * 0.2300397, size.height * 0.4116851, size.width * 0.2301269, size.height * 0.4116726,
        size.width * 0.2302157, size.height * 0.4116477);
    path_2.cubicTo(size.width * 0.2293473, size.height * 0.4108332, size.width * 0.2282486, size.height * 0.4099723,
        size.width * 0.2277762, size.height * 0.4090554);
    path_2.cubicTo(size.width * 0.2267447, size.height * 0.4070535, size.width * 0.2270339, size.height * 0.4038960,
        size.width * 0.2274102, size.height * 0.4017045);
    path_2.cubicTo(size.width * 0.2280404, size.height * 0.3980354, size.width * 0.2302140, size.height * 0.3974157,
        size.width * 0.2328503, size.height * 0.3958807);
    path_2.cubicTo(size.width * 0.2343250, size.height * 0.3950220, size.width * 0.2362042, size.height * 0.3953480,
        size.width * 0.2379245, size.height * 0.3953480);
    path_2.cubicTo(size.width * 0.2397844, size.height * 0.3953480, size.width * 0.2417438, size.height * 0.3946988,
        size.width * 0.2429986, size.height * 0.3937855);
    path_2.cubicTo(size.width * 0.2441325, size.height * 0.3929603, size.width * 0.2451814, size.height * 0.3905726,
        size.width * 0.2458772, size.height * 0.3895597);
    path_2.cubicTo(size.width * 0.2470755, size.height * 0.3878153, size.width * 0.2487707, size.height * 0.3879864,
        size.width * 0.2502196, size.height * 0.3869318);
    path_2.cubicTo(size.width * 0.2520119, size.height * 0.3856272, size.width * 0.2524959, size.height * 0.3852162,
        size.width * 0.2538544, size.height * 0.3832386);
    path_2.cubicTo(size.width * 0.2544896, size.height * 0.3823140, size.width * 0.2556199, size.height * 0.3780988,
        size.width * 0.2560256, size.height * 0.3769176);
    path_2.cubicTo(size.width * 0.2568741, size.height * 0.3744471, size.width * 0.2574151, size.height * 0.3735497,
        size.width * 0.2578308, size.height * 0.3711293);
    path_2.cubicTo(size.width * 0.2583155, size.height * 0.3683070, size.width * 0.2585642, size.height * 0.3676836,
        size.width * 0.2603679, size.height * 0.3663707);
    path_2.cubicTo(size.width * 0.2623198, size.height * 0.3649501, size.width * 0.2643409, size.height * 0.3654647,
        size.width * 0.2629050, size.height * 0.3626776);
    path_2.cubicTo(size.width * 0.2618332, size.height * 0.3605974, size.width * 0.2614282, size.height * 0.3582692,
        size.width * 0.2610997, size.height * 0.3563565);
    path_2.cubicTo(size.width * 0.2607090, size.height * 0.3540814, size.width * 0.2600971, size.height * 0.3521877,
        size.width * 0.2596360, size.height * 0.3495028);
    path_2.cubicTo(size.width * 0.2590722, size.height * 0.3462200, size.width * 0.2601383, size.height * 0.3454755,
        size.width * 0.2585626, size.height * 0.3431818);
    path_2.cubicTo(size.width * 0.2572148, size.height * 0.3412198, size.width * 0.2574367, size.height * 0.3396062,
        size.width * 0.2581967, size.height * 0.3373935);
    path_2.cubicTo(size.width * 0.2587698, size.height * 0.3357249, size.width * 0.2602822, size.height * 0.3342641,
        size.width * 0.2618316, size.height * 0.3337003);
    path_2.cubicTo(size.width * 0.2634272, size.height * 0.3331196, size.width * 0.2643978, size.height * 0.3315696,
        size.width * 0.2668813, size.height * 0.3315696);
    path_2.cubicTo(size.width * 0.2685802, size.height * 0.3315696, size.width * 0.2701881, size.height * 0.3310271,
        size.width * 0.2715896, size.height * 0.3300071);
    path_2.cubicTo(size.width * 0.2734615, size.height * 0.3286446, size.width * 0.2751327, size.height * 0.3284458,
        size.width * 0.2755904, size.height * 0.3257813);
    path_2.cubicTo(size.width * 0.2757687, size.height * 0.3247428, size.width * 0.2766708, size.height * 0.3210170,
        size.width * 0.2770297, size.height * 0.3189276);
    path_2.cubicTo(size.width * 0.2777107, size.height * 0.3149623, size.width * 0.2785853, size.height * 0.3163379,
        size.width * 0.2781274, size.height * 0.3136719);
    path_2.cubicTo(size.width * 0.2778707, size.height * 0.3121768, size.width * 0.2753730, size.height * 0.3101950,
        size.width * 0.2748585, size.height * 0.3094460);
    path_2.cubicTo(size.width * 0.2733730, size.height * 0.3072836, size.width * 0.2727400, size.height * 0.3060951,
        size.width * 0.2723214, size.height * 0.3036577);
    path_2.cubicTo(size.width * 0.2718391, size.height * 0.3008495, size.width * 0.2728410, size.height * 0.2979548,
        size.width * 0.2734192, size.height * 0.2962713);
    path_2.cubicTo(size.width * 0.2743556, size.height * 0.2935452, size.width * 0.2767206, size.height * 0.2921165,
        size.width * 0.2777615, size.height * 0.2909801);
    path_2.cubicTo(size.width * 0.2790129, size.height * 0.2896139, size.width * 0.2792294, size.height * 0.2871561,
        size.width * 0.2795667, size.height * 0.2851918);
    path_2.cubicTo(size.width * 0.2801468, size.height * 0.2818140, size.width * 0.2790064, size.height * 0.2806829,
        size.width * 0.2781274, size.height * 0.2794034);
    path_2.cubicTo(size.width * 0.2769330, size.height * 0.2776647, size.width * 0.2753594, size.height * 0.2778054,
        size.width * 0.2734192, size.height * 0.2778054);
    path_2.cubicTo(size.width * 0.2703477, size.height * 0.2778054, size.width * 0.2694899, size.height * 0.2791542,
        size.width * 0.2672473, size.height * 0.2783381);
    path_2.cubicTo(size.width * 0.2658840, size.height * 0.2778420, size.width * 0.2640827, size.height * 0.2755312,
        size.width * 0.2632709, size.height * 0.2746449);
    path_2.cubicTo(size.width * 0.2619324, size.height * 0.2731836, size.width * 0.2593605, size.height * 0.2736391,
        size.width * 0.2578308, size.height * 0.2730824);
    path_2.cubicTo(size.width * 0.2558136, size.height * 0.2723483, size.width * 0.2529798, size.height * 0.2720894,
        size.width * 0.2513173, size.height * 0.2714844);
    path_2.cubicTo(size.width * 0.2493346, size.height * 0.2707628, size.width * 0.2479656, size.height * 0.2703765,
        size.width * 0.2466091, size.height * 0.2693892);
    path_2.cubicTo(size.width * 0.2452407, size.height * 0.2683932, size.width * 0.2443168, size.height * 0.2653433,
        size.width * 0.2437061, size.height * 0.2635653);
    path_2.cubicTo(size.width * 0.2429667, size.height * 0.2614129, size.width * 0.2377014, size.height * 0.2688338,
        size.width * 0.2371926, size.height * 0.2693892);
    path_2.cubicTo(size.width * 0.2350637, size.height * 0.2717135, size.width * 0.2333194, size.height * 0.2739100,
        size.width * 0.2310451, size.height * 0.2730824);
    path_2.cubicTo(size.width * 0.2289724, size.height * 0.2723281, size.width * 0.2272826, size.height * 0.2720170,
        size.width * 0.2252391, size.height * 0.2720170);
    path_2.cubicTo(size.width * 0.2240913, size.height * 0.2720170, size.width * 0.2212709, size.height * 0.2713542,
        size.width * 0.2201649, size.height * 0.2709517);
    path_2.cubicTo(size.width * 0.2180903, size.height * 0.2701967, size.width * 0.2175218, size.height * 0.2688565,
        size.width * 0.2151151, size.height * 0.2688565);
    path_2.cubicTo(size.width * 0.2126298, size.height * 0.2688565, size.width * 0.2113754, size.height * 0.2683239,
        size.width * 0.2089432, size.height * 0.2683239);
    path_2.cubicTo(size.width * 0.2067032, size.height * 0.2683239, size.width * 0.2046814, size.height * 0.2677912,
        size.width * 0.2020638, size.height * 0.2677912);
    path_2.cubicTo(size.width * 0.2001124, size.height * 0.2677912, size.width * 0.1983135, size.height * 0.2673319,
        size.width * 0.1966481, size.height * 0.2667259);
    path_2.cubicTo(size.width * 0.1947065, size.height * 0.2660193, size.width * 0.1925869, size.height * 0.2651325,
        size.width * 0.1912080, size.height * 0.2646307);
    path_2.cubicTo(size.width * 0.1893295, size.height * 0.2639470, size.width * 0.1881910, size.height * 0.2623843,
        size.width * 0.1868657, size.height * 0.2609375);
    path_2.cubicTo(size.width * 0.1859013, size.height * 0.2598846, size.width * 0.1849600, size.height * 0.2594315,
        size.width * 0.1841091, size.height * 0.2594815);

    path_2.close();
    path_2.moveTo(size.width * 0.05276639, size.height * 0.4529119);
    path_2.cubicTo(size.width * 0.05264275, size.height * 0.4527316, size.width * 0.05263922, size.height * 0.4528628,
        size.width * 0.05276639, size.height * 0.4529119);
    path_2.close();
    Paint paint2Fill = Paint()..style = PaintingStyle.fill;
    paint2Fill.color = marmaraColor;
    canvas.drawPath(path_2, paint2Fill);

    Path path_3 = Path();
    path_3.moveTo(size.width * 0.1090010, size.height * 0.3220908);
    path_3.cubicTo(size.width * 0.1096117, size.height * 0.3223131, size.width * 0.1054725, size.height * 0.3265378,
        size.width * 0.1046555, size.height * 0.3268351);
    path_3.cubicTo(size.width * 0.1029080, size.height * 0.3274711, size.width * 0.1018803, size.height * 0.3279338,
        size.width * 0.1003099, size.height * 0.3273623);
    path_3.cubicTo(size.width * 0.09821339, size.height * 0.3265993, size.width * 0.09777500, size.height * 0.3240454,
        size.width * 0.09777500, size.height * 0.3210365);
    path_3.cubicTo(size.width * 0.09777500, size.height * 0.3189174, size.width * 0.1013279, size.height * 0.3202209,
        size.width * 0.1021206, size.height * 0.3205094);
    path_3.cubicTo(size.width * 0.1037753, size.height * 0.3211116, size.width * 0.1059855, size.height * 0.3199113,
        size.width * 0.1075525, size.height * 0.3194551);
    path_3.cubicTo(size.width * 0.1095777, size.height * 0.3188655, size.width * 0.1097745, size.height * 0.3192760,
        size.width * 0.1090010, size.height * 0.3220908);
    path_3.close();
    Paint paint3Fill = Paint()..style = PaintingStyle.fill;
    paint3Fill.color = marmaraColor;
    canvas.drawPath(path_3, paint3Fill);

    Path path_4 = Path();
    path_4.moveTo(size.width * 0.01955500, size.height * 0.3684796);
    path_4.cubicTo(size.width * 0.02135789, size.height * 0.3679547, size.width * 0.01632378, size.height * 0.3716425,
        size.width * 0.01448519, size.height * 0.3716425);
    path_4.cubicTo(size.width * 0.01240143, size.height * 0.3716425, size.width * 0.01096453, size.height * 0.3726236,
        size.width * 0.009415371, size.height * 0.3737511);
    path_4.cubicTo(size.width * 0.007797697, size.height * 0.3749285, size.width * 0.006161137, size.height * 0.3748054,
        size.width * 0.004345556, size.height * 0.3748054);
    path_4.cubicTo(size.width * 0.002896713, size.height * 0.3748054, size.width * 0.002141524, size.height * 0.3714061,
        size.width * 0.001448519, size.height * 0.3700611);
    path_4.cubicTo(size.width * 0.00008348365, size.height * 0.3674117, size.width * 0.001181889,
        size.height * 0.3667592, size.width * 0.002172778, size.height * 0.3653168);
    path_4.cubicTo(size.width * 0.002652306, size.height * 0.3646187, size.width * 0.006687660, size.height * 0.3639373,
        size.width * 0.007242593, size.height * 0.3637353);
    path_4.cubicTo(size.width * 0.009171880, size.height * 0.3630332, size.width * 0.009692098, size.height * 0.3612625,
        size.width * 0.01158815, size.height * 0.3605725);
    path_4.cubicTo(size.width * 0.01373795, size.height * 0.3597901, size.width * 0.01325474, size.height * 0.3581479,
        size.width * 0.01557157, size.height * 0.3589910);
    path_4.cubicTo(size.width * 0.01644906, size.height * 0.3593104, size.width * 0.01767097, size.height * 0.3634172,
        size.width * 0.01810648, size.height * 0.3642625);
    path_4.cubicTo(size.width * 0.01903650, size.height * 0.3660675, size.width * 0.01911066, size.height * 0.3652455,
        size.width * 0.01955500, size.height * 0.3684796);

    path_4.close();
    Paint paint4Fill = Paint()..style = PaintingStyle.fill;
    paint4Fill.color = marmaraColor;
    canvas.drawPath(path_4, paint4Fill);

    Path path_5 = Path();
    path_5.moveTo(size.width * 0.1680282, size.height * 0.2867721);
    path_5.cubicTo(size.width * 0.1686660, size.height * 0.2880101, size.width * 0.1634908, size.height * 0.2886791,
        size.width * 0.1625962, size.height * 0.2883535);
    path_5.cubicTo(size.width * 0.1609634, size.height * 0.2877593, size.width * 0.1593048, size.height * 0.2875863,
        size.width * 0.1575264, size.height * 0.2888807);
    path_5.cubicTo(size.width * 0.1558040, size.height * 0.2901343, size.width * 0.1550732, size.height * 0.2900539,
        size.width * 0.1539051, size.height * 0.2883535);
    path_5.cubicTo(size.width * 0.1525103, size.height * 0.2863231, size.width * 0.1541892, size.height * 0.2839295,
        size.width * 0.1517323, size.height * 0.2857178);
    path_5.cubicTo(size.width * 0.1503232, size.height * 0.2867434, size.width * 0.1483632, size.height * 0.2844917,
        size.width * 0.1473868, size.height * 0.2841364);
    path_5.cubicTo(size.width * 0.1460362, size.height * 0.2836449, size.width * 0.1451334, size.height * 0.2816031,
        size.width * 0.1434033, size.height * 0.2809735);
    path_5.cubicTo(size.width * 0.1417854, size.height * 0.2803847, size.width * 0.1411570, size.height * 0.2788649,
        size.width * 0.1390578, size.height * 0.2788649);
    path_5.cubicTo(size.width * 0.1376822, size.height * 0.2788649, size.width * 0.1357972, size.height * 0.2778106,
        size.width * 0.1339880, size.height * 0.2778106);
    path_5.cubicTo(size.width * 0.1320006, size.height * 0.2778106, size.width * 0.1300806, size.height * 0.2777829,
        size.width * 0.1285560, size.height * 0.2783377);
    path_5.cubicTo(size.width * 0.1266741, size.height * 0.2790226, size.width * 0.1261043, size.height * 0.2809432,
        size.width * 0.1245726, size.height * 0.2815006);
    path_5.cubicTo(size.width * 0.1232891, size.height * 0.2819677, size.width * 0.1219110, size.height * 0.2847557,
        size.width * 0.1205892, size.height * 0.2857178);
    path_5.cubicTo(size.width * 0.1188875, size.height * 0.2869563, size.width * 0.1192837, size.height * 0.2888807,
        size.width * 0.1169679, size.height * 0.2888807);

    path_5.cubicTo(size.width * 0.1146681, size.height * 0.2888807, size.width * 0.1146440, size.height * 0.2874528,
        size.width * 0.1129844, size.height * 0.2862449);
    path_5.cubicTo(size.width * 0.1116164, size.height * 0.2852493, size.width * 0.1101285, size.height * 0.2846784,
        size.width * 0.1086389, size.height * 0.2841364);
    path_5.cubicTo(size.width * 0.1072266, size.height * 0.2836224, size.width * 0.1048624, size.height * 0.2860943,
        size.width * 0.1039312, size.height * 0.2867721);
    path_5.cubicTo(size.width * 0.1025801, size.height * 0.2877555, size.width * 0.1011115, size.height * 0.2878039,
        size.width * 0.09922352, size.height * 0.2883535);
    path_5.cubicTo(size.width * 0.09751617, size.height * 0.2888506, size.width * 0.09610523, size.height * 0.2893053,
        size.width * 0.09451584, size.height * 0.2904621);
    path_5.cubicTo(size.width * 0.09299499, size.height * 0.2915690, size.width * 0.09329892, size.height * 0.2939192,
        size.width * 0.09379158, size.height * 0.2967878);
    path_5.cubicTo(size.width * 0.09419976, size.height * 0.2991646, size.width * 0.09296727, size.height * 0.3017333,
        size.width * 0.09270519, size.height * 0.3036407);
    path_5.cubicTo(size.width * 0.09247028, size.height * 0.3053505, size.width * 0.09051895, size.height * 0.3073504,
        size.width * 0.08980815, size.height * 0.3083850);
    path_5.cubicTo(size.width * 0.08859381, size.height * 0.3101527, size.width * 0.08796507, size.height * 0.3116424,
        size.width * 0.08727325, size.height * 0.3136565);
    path_5.cubicTo(size.width * 0.08669797, size.height * 0.3153313, size.width * 0.08536273, size.height * 0.3174555,
        size.width * 0.08401407, size.height * 0.3189280);
    path_5.cubicTo(size.width * 0.08268969, size.height * 0.3203739, size.width * 0.08202424, size.height * 0.3214971,
        size.width * 0.08039278, size.height * 0.3220908);
    path_5.cubicTo(size.width * 0.07876262, size.height * 0.3226841, size.width * 0.07752384, size.height * 0.3240574,
        size.width * 0.07568510, size.height * 0.3247266);
    path_5.cubicTo(size.width * 0.07377126, size.height * 0.3254230, size.width * 0.07230044, size.height * 0.3262219,
        size.width * 0.07061528, size.height * 0.3268351);
    path_5.cubicTo(size.width * 0.06879547, size.height * 0.3274974, size.width * 0.06745017, size.height * 0.3286117,
        size.width * 0.06626973, size.height * 0.3294709);
    path_5.cubicTo(size.width * 0.06458789, size.height * 0.3306950, size.width * 0.06268348, size.height * 0.3318175,
        size.width * 0.06156204, size.height * 0.3326337);
    path_5.cubicTo(size.width * 0.06015398, size.height * 0.3336586, size.width * 0.05919901, size.height * 0.3344921,
        size.width * 0.05794074, size.height * 0.3363238);
    path_5.cubicTo(size.width * 0.05655470, size.height * 0.3383414, size.width * 0.05563332, size.height * 0.3396826,
        size.width * 0.05468158, size.height * 0.3410681);
    path_5.cubicTo(size.width * 0.05336973, size.height * 0.3429777, size.width * 0.05276604, size.height * 0.3438565,
        size.width * 0.05178454, size.height * 0.3452852);
    path_5.cubicTo(size.width * 0.05087922, size.height * 0.3466031, size.width * 0.04979283, size.height * 0.3476574,
        size.width * 0.04888750, size.height * 0.3489753);
    path_5.cubicTo(size.width * 0.04798218, size.height * 0.3502931, size.width * 0.04762005, size.height * 0.3524017,
        size.width * 0.04671472, size.height * 0.3537196);
    path_5.cubicTo(size.width * 0.04561319, size.height * 0.3553231, size.width * 0.04486875, size.height * 0.3564067,
        size.width * 0.04381769, size.height * 0.3579367);
    path_5.cubicTo(size.width * 0.04296360, size.height * 0.3591800, size.width * 0.04141351, size.height * 0.3603822,
        size.width * 0.04055852, size.height * 0.3616267);
    path_5.cubicTo(size.width * 0.03913555, size.height * 0.3636981, size.width * 0.03830537, size.height * 0.3649066,
        size.width * 0.03729935, size.height * 0.3663711);
    path_5.cubicTo(size.width * 0.03629088, size.height * 0.3678391, size.width * 0.03582609, size.height * 0.3702052,
        size.width * 0.03548871, size.height * 0.3721697);
    path_5.cubicTo(size.width * 0.03518885, size.height * 0.3739156, size.width * 0.03253888, size.height * 0.3742782,
        size.width * 0.03114315, size.height * 0.3742782);
    path_5.cubicTo(size.width * 0.03023063, size.height * 0.3742782, size.width * 0.02749632, size.height * 0.3764054,
        size.width * 0.02679759, size.height * 0.3769140);
    path_5.cubicTo(size.width * 0.02528222, size.height * 0.3780169, size.width * 0.02674881, size.height * 0.3719266,
        size.width * 0.02715972, size.height * 0.3695339);
    path_5.cubicTo(size.width * 0.02754246, size.height * 0.3673054, size.width * 0.02840850, size.height * 0.3643169,
        size.width * 0.02897037, size.height * 0.3626810);
    path_5.cubicTo(size.width * 0.02971533, size.height * 0.3605122, size.width * 0.03022367, size.height * 0.3590322,
        size.width * 0.03078102, size.height * 0.3574096);
    path_5.cubicTo(size.width * 0.03164956, size.height * 0.3548810, size.width * 0.02995765, size.height * 0.3526153,
        size.width * 0.02969463, size.height * 0.3510838);
    path_5.cubicTo(size.width * 0.02918261, size.height * 0.3481025, size.width * 0.02872552, size.height * 0.3478783,
        size.width * 0.03150528, size.height * 0.3468667);
    path_5.cubicTo(size.width * 0.03357296, size.height * 0.3461142, size.width * 0.03518764, size.height * 0.3447136,
        size.width * 0.03657509, size.height * 0.3437038);
    path_5.cubicTo(size.width * 0.03819193, size.height * 0.3425270, size.width * 0.03941208, size.height * 0.3419025,
        size.width * 0.04128278, size.height * 0.3405409);
    path_5.cubicTo(size.width * 0.04254818, size.height * 0.3396199, size.width * 0.04406698, size.height * 0.3377238,
        size.width * 0.04526621, size.height * 0.3368509);
    path_5.cubicTo(size.width * 0.04661883, size.height * 0.3358664, size.width * 0.04742510, size.height * 0.3339617,
        size.width * 0.04852537, size.height * 0.3331609);
    path_5.cubicTo(size.width * 0.04955327, size.height * 0.3324127, size.width * 0.05210507, size.height * 0.3321066,
        size.width * 0.05359519, size.height * 0.3321066);
    path_5.cubicTo(size.width * 0.05519901, size.height * 0.3321066, size.width * 0.05602643, size.height * 0.3301489,
        size.width * 0.05685435, size.height * 0.3289437);
    path_5.cubicTo(size.width * 0.05824046, size.height * 0.3269260, size.width * 0.05954859, size.height * 0.3279527,
        size.width * 0.06047565, size.height * 0.3252537);
    path_5.cubicTo(size.width * 0.06143505, size.height * 0.3224605, size.width * 0.06032940, size.height * 0.3208236,
        size.width * 0.05938926, size.height * 0.3194551);
    path_5.cubicTo(size.width * 0.05792557, size.height * 0.3173244, size.width * 0.05630114, size.height * 0.3206485,
        size.width * 0.05504371, size.height * 0.3215637);
    path_5.cubicTo(size.width * 0.05375787, size.height * 0.3224996, size.width * 0.05163391, size.height * 0.3220908,
        size.width * 0.04997389, size.height * 0.3220908);
    path_5.cubicTo(size.width * 0.04816324, size.height * 0.3220908, size.width * 0.04635259, size.height * 0.3220908,
        size.width * 0.04454195, size.height * 0.3220908);
    path_5.cubicTo(size.width * 0.04276216, size.height * 0.3220908, size.width * 0.04072379, size.height * 0.3221625,
        size.width * 0.03947213, size.height * 0.3226180);
    path_5.cubicTo(size.width * 0.03772594, size.height * 0.3232535, size.width * 0.03577505, size.height * 0.3236723,
        size.width * 0.03367806, size.height * 0.3236723);
    path_5.cubicTo(size.width * 0.03204352, size.height * 0.3236723, size.width * 0.02977338, size.height * 0.3241994,
        size.width * 0.02788398, size.height * 0.3241994);
    path_5.cubicTo(size.width * 0.02578951, size.height * 0.3241994, size.width * 0.02443221, size.height * 0.3240592,
        size.width * 0.02317630, size.height * 0.3231451);
    path_5.cubicTo(size.width * 0.02162870, size.height * 0.3220187, size.width * 0.02102930, size.height * 0.3196052,
        size.width * 0.02064139, size.height * 0.3173465);
    path_5.cubicTo(size.width * 0.02024014, size.height * 0.3150102, size.width * 0.01956033, size.height * 0.3126332,
        size.width * 0.01919287, size.height * 0.3104936);
    path_5.cubicTo(size.width * 0.01882255, size.height * 0.3083374, size.width * 0.02245877, size.height * 0.3099567,
        size.width * 0.02353843, size.height * 0.3083850);
    path_5.cubicTo(size.width * 0.02437020, size.height * 0.3071743, size.width * 0.02553164, size.height * 0.3044293,
        size.width * 0.02679759, size.height * 0.3025864);
    path_5.cubicTo(size.width * 0.02819043, size.height * 0.3005589, size.width * 0.02889049, size.height * 0.2996561,
        size.width * 0.02969463, size.height * 0.2973150);
    path_5.cubicTo(size.width * 0.03041561, size.height * 0.2952160, size.width * 0.03213392, size.height * 0.2934310,
        size.width * 0.03331593, size.height * 0.2925707);
    path_5.cubicTo(size.width * 0.03523379, size.height * 0.2911748, size.width * 0.03641600, size.height * 0.2903981,
        size.width * 0.03729935, size.height * 0.2878264);
    path_5.cubicTo(size.width * 0.03804739, size.height * 0.2856486, size.width * 0.03693722, size.height * 0.2824904,
        size.width * 0.03693722, size.height * 0.2804463);
    path_5.cubicTo(size.width * 0.03693722, size.height * 0.2783979, size.width * 0.03614707, size.height * 0.2753183,
        size.width * 0.03585084, size.height * 0.2735934);
    path_5.cubicTo(size.width * 0.03545605, size.height * 0.2712947, size.width * 0.03585084, size.height * 0.2680697,
        size.width * 0.03585084, size.height * 0.2656863);
    path_5.cubicTo(size.width * 0.03585084, size.height * 0.2627816, size.width * 0.03632488, size.height * 0.2613062,
        size.width * 0.03729935, size.height * 0.2598877);
    path_5.cubicTo(size.width * 0.03843038, size.height * 0.2582412, size.width * 0.03944097, size.height * 0.2578018,
        size.width * 0.04092065, size.height * 0.2567248);
    path_5.cubicTo(size.width * 0.04258421, size.height * 0.2555140, size.width * 0.04361798, size.height * 0.2550251,
        size.width * 0.04490408, size.height * 0.2540891);
    path_5.cubicTo(size.width * 0.04662489, size.height * 0.2528366, size.width * 0.04805964, size.height * 0.2537127,
        size.width * 0.04961176, size.height * 0.2514533);
    path_5.cubicTo(size.width * 0.05076671, size.height * 0.2497721, size.width * 0.05184233, size.height * 0.2491765,
        size.width * 0.05250880, size.height * 0.2472362);
    path_5.cubicTo(size.width * 0.05282915, size.height * 0.2463035, size.width * 0.05134354, size.height * 0.2420326,
        size.width * 0.05106028, size.height * 0.2403833);
    path_5.cubicTo(size.width * 0.05074575, size.height * 0.2385519, size.width * 0.05065218, size.height * 0.2353713,
        size.width * 0.05033602, size.height * 0.2335304);
    path_5.cubicTo(size.width * 0.04988384, size.height * 0.2308974, size.width * 0.04984799, size.height * 0.2284195,
        size.width * 0.04924963, size.height * 0.2266775);
    path_5.cubicTo(size.width * 0.04845130, size.height * 0.2243533, size.width * 0.04769331, size.height * 0.2242269,
        size.width * 0.04599047, size.height * 0.2229875);
    path_5.cubicTo(size.width * 0.04444825, size.height * 0.2218650, size.width * 0.04341923, size.height * 0.2213796,
        size.width * 0.04200704, size.height * 0.2203517);
    path_5.cubicTo(size.width * 0.04030636, size.height * 0.2191139, size.width * 0.03924588, size.height * 0.2178149,
        size.width * 0.03766148, size.height * 0.2166617);
    path_5.cubicTo(size.width * 0.03651978, size.height * 0.2158307, size.width * 0.03596121, size.height * 0.2132930,
        size.width * 0.03548871, size.height * 0.2119174);
    path_5.cubicTo(size.width * 0.03449890, size.height * 0.2090357, size.width * 0.03573264, size.height * 0.2079611,
        size.width * 0.03693722, size.height * 0.2066460);
    path_5.cubicTo(size.width * 0.03901015, size.height * 0.2043828, size.width * 0.03840772, size.height * 0.2040102,
        size.width * 0.04164491, size.height * 0.2040102);
    path_5.cubicTo(size.width * 0.04345556, size.height * 0.2040102, size.width * 0.04526621, size.height * 0.2040102,
        size.width * 0.04707685, size.height * 0.2040102);
    path_5.cubicTo(size.width * 0.04759779, size.height * 0.2040102, size.width * 0.04870933, size.height * 0.1981948,
        size.width * 0.04888750, size.height * 0.1971573);
    path_5.cubicTo(size.width * 0.04950300, size.height * 0.1935735, size.width * 0.04904515, size.height * 0.1928254,
        size.width * 0.05106028, size.height * 0.1913587);
    path_5.cubicTo(size.width * 0.05295816, size.height * 0.1899774, size.width * 0.05320963, size.height * 0.1881959,
        size.width * 0.05576797, size.height * 0.1881959);
    path_5.cubicTo(size.width * 0.05798438, size.height * 0.1881959, size.width * 0.05881509, size.height * 0.1886458,
        size.width * 0.06047565, size.height * 0.1892502);
    path_5.cubicTo(size.width * 0.06162136, size.height * 0.1896671, size.width * 0.06637301, size.height * 0.1875332,
        size.width * 0.06771824, size.height * 0.1871416);
    path_5.cubicTo(size.width * 0.06960632, size.height * 0.1865919, size.width * 0.07077819, size.height * 0.1847958,
        size.width * 0.07170167, size.height * 0.1834516);
    path_5.cubicTo(size.width * 0.07324593, size.height * 0.1812036, size.width * 0.07353933, size.height * 0.1800055,
        size.width * 0.07604723, size.height * 0.1781801);
    path_5.cubicTo(size.width * 0.07728514, size.height * 0.1772791, size.width * 0.08039764, size.height * 0.1771258,
        size.width * 0.08184130, size.height * 0.1771258);
    path_5.cubicTo(size.width * 0.08373112, size.height * 0.1771258, size.width * 0.08470297, size.height * 0.1765729,
        size.width * 0.08618685, size.height * 0.1776530);
    path_5.cubicTo(size.width * 0.08815054, size.height * 0.1790822, size.width * 0.08927269, size.height * 0.1792569,
        size.width * 0.09017028, size.height * 0.1818701);
    path_5.cubicTo(size.width * 0.09083393, size.height * 0.1838022, size.width * 0.09145205, size.height * 0.1861290,
        size.width * 0.09198093, size.height * 0.1876687);
    path_5.cubicTo(size.width * 0.09275642, size.height * 0.1899265, size.width * 0.09363600, size.height * 0.1915091,
        size.width * 0.09487797, size.height * 0.1924130);
    path_5.cubicTo(size.width * 0.09652619, size.height * 0.1936127, size.width * 0.09767581, size.height * 0.1943291,
        size.width * 0.09886140, size.height * 0.1966302);
    path_5.cubicTo(size.width * 0.09977511, size.height * 0.1984036, size.width * 0.1016135, size.height * 0.1952597,
        size.width * 0.1024827, size.height * 0.1939945);
    path_5.cubicTo(size.width * 0.1033467, size.height * 0.1927368, size.width * 0.1058326, size.height * 0.1915563,
        size.width * 0.1068282, size.height * 0.1908316);
    path_5.cubicTo(size.width * 0.1080765, size.height * 0.1899231, size.width * 0.1103013, size.height * 0.1903584,
        size.width * 0.1118981, size.height * 0.1897773);
    path_5.cubicTo(size.width * 0.1136736, size.height * 0.1891311, size.width * 0.1151206, size.height * 0.1892502,
        size.width * 0.1169679, size.height * 0.1892502);
    path_5.cubicTo(size.width * 0.1189239, size.height * 0.1892502, size.width * 0.1209472, size.height * 0.1892487,
        size.width * 0.1223998, size.height * 0.1897773);
    path_5.cubicTo(size.width * 0.1239854, size.height * 0.1903543, size.width * 0.1250200, size.height * 0.1919480,
        size.width * 0.1263832, size.height * 0.1929402);
    path_5.cubicTo(size.width * 0.1281971, size.height * 0.1942603, size.width * 0.1284842, size.height * 0.1943125,
        size.width * 0.1292803, size.height * 0.1966302);
    path_5.cubicTo(size.width * 0.1300545, size.height * 0.1988843, size.width * 0.1306642, size.height * 0.1994168,
        size.width * 0.1310909, size.height * 0.2019016);
    path_5.cubicTo(size.width * 0.1317098, size.height * 0.2055050, size.width * 0.1290972, size.height * 0.2018336,
        size.width * 0.1281939, size.height * 0.2008474);
    path_5.cubicTo(size.width * 0.1264326, size.height * 0.1989245, size.width * 0.1256590, size.height * 0.2026083,
        size.width * 0.1256590, size.height * 0.2045374);
    path_5.cubicTo(size.width * 0.1256590, size.height * 0.2068562, size.width * 0.1263659, size.height * 0.2091809,
        size.width * 0.1267454, size.height * 0.2113903);
    path_5.cubicTo(size.width * 0.1270696, size.height * 0.2132782, size.width * 0.1284475, size.height * 0.2147644,
        size.width * 0.1289182, size.height * 0.2161346);
    path_5.cubicTo(size.width * 0.1296355, size.height * 0.2182230, size.width * 0.1299636, size.height * 0.2197651,
        size.width * 0.1310909, size.height * 0.2214060);
    path_5.cubicTo(size.width * 0.1323496, size.height * 0.2232383, size.width * 0.1323905, size.height * 0.2242285,
        size.width * 0.1329016, size.height * 0.2272046);
    path_5.cubicTo(size.width * 0.1333570, size.height * 0.2298565, size.width * 0.1332702, size.height * 0.2314312,
        size.width * 0.1343501, size.height * 0.2330032);
    path_5.cubicTo(size.width * 0.1357821, size.height * 0.2350877, size.width * 0.1363523, size.height * 0.2359178,
        size.width * 0.1376093, size.height * 0.2377475);
    path_5.cubicTo(size.width * 0.1385591, size.height * 0.2391302, size.width * 0.1399019, size.height * 0.2402069,
        size.width * 0.1408684, size.height * 0.2409104);
    path_5.cubicTo(size.width * 0.1425733, size.height * 0.2421513, size.width * 0.1439213, size.height * 0.2430757,
        size.width * 0.1452140, size.height * 0.2435461);
    path_5.cubicTo(size.width * 0.1468205, size.height * 0.2441308, size.width * 0.1479364, size.height * 0.2454594,
        size.width * 0.1499217, size.height * 0.2461819);
    path_5.cubicTo(size.width * 0.1515397, size.height * 0.2467707, size.width * 0.1528504, size.height * 0.2485771,
        size.width * 0.1539051, size.height * 0.2493448);
    path_5.cubicTo(size.width * 0.1552605, size.height * 0.2503313, size.width * 0.1564220, size.height * 0.2509196,
        size.width * 0.1578885, size.height * 0.2514533);
    path_5.cubicTo(size.width * 0.1596300, size.height * 0.2520871, size.width * 0.1601695, size.height * 0.2534695,
        size.width * 0.1618720, size.height * 0.2540891);
    path_5.cubicTo(size.width * 0.1632632, size.height * 0.2545953, size.width * 0.1646129, size.height * 0.2568747,
        size.width * 0.1658554, size.height * 0.2577791);
    path_5.cubicTo(size.width * 0.1670705, size.height * 0.2586635, size.width * 0.1690184, size.height * 0.2593605,
        size.width * 0.1705631, size.height * 0.2593605);
    path_5.cubicTo(size.width * 0.1721158, size.height * 0.2593605, size.width * 0.1729089, size.height * 0.2614691,
        size.width * 0.1749086, size.height * 0.2614691);
    path_5.cubicTo(size.width * 0.1769806, size.height * 0.2614691, size.width * 0.1759777, size.height * 0.2646572,
        size.width * 0.1778057, size.height * 0.2619962);
    path_5.cubicTo(size.width * 0.1783757, size.height * 0.2611665, size.width * 0.1785005, size.height * 0.2668262,
        size.width * 0.1781678, size.height * 0.2677948);
    path_5.cubicTo(size.width * 0.1774048, size.height * 0.2700161, size.width * 0.1767193, size.height * 0.2707036,
        size.width * 0.1767193, size.height * 0.2735934);
    path_5.cubicTo(size.width * 0.1767193, size.height * 0.2753710, size.width * 0.1750199, size.height * 0.2785410,
        size.width * 0.1745465, size.height * 0.2799192);
    path_5.cubicTo(size.width * 0.1740309, size.height * 0.2814201, size.width * 0.1726944, size.height * 0.2831424,
        size.width * 0.1720116, size.height * 0.2841364);
    path_5.cubicTo(size.width * 0.1704863, size.height * 0.2863567, size.width * 0.1702491, size.height * 0.2874187,
        size.width * 0.1680282, size.height * 0.2867721);
    path_5.close();
    Paint paint5Fill = Paint()..style = PaintingStyle.fill;
    paint5Fill.color = marmaraColor;
    canvas.drawPath(path_5, paint5Fill);

    ///Marmara Bölgesi Bitiş

    /// blackSea Bölgesi Başlangıç
    Path path_6 = Path();
    path_6.moveTo(size.width * 0.4854118, size.height * 0.1799716);
    path_6.cubicTo(size.width * 0.4844271, size.height * 0.1799504, size.width * 0.4834387, size.height * 0.1802826,
        size.width * 0.4830699, size.height * 0.1813565);
    path_6.cubicTo(size.width * 0.4821006, size.height * 0.1841783, size.width * 0.4815708, size.height * 0.1846041,
        size.width * 0.4801913, size.height * 0.1866122);
    path_6.cubicTo(size.width * 0.4787639, size.height * 0.1886900, size.width * 0.4773044, size.height * 0.1887164,
        size.width * 0.4758489, size.height * 0.1903054);
    path_6.cubicTo(size.width * 0.4744848, size.height * 0.1917948, size.width * 0.4724929, size.height * 0.1929332,
        size.width * 0.4707748, size.height * 0.1929332);
    path_6.cubicTo(size.width * 0.4688434, size.height * 0.1929332, size.width * 0.4669002, size.height * 0.1929332,
        size.width * 0.4649688, size.height * 0.1929332);
    path_6.cubicTo(size.width * 0.4630374, size.height * 0.1929332, size.width * 0.4611185, size.height * 0.1929332,
        size.width * 0.4591872, size.height * 0.1929332);
    path_6.cubicTo(size.width * 0.4574435, size.height * 0.1929332, size.width * 0.4559006, size.height * 0.1946491,
        size.width * 0.4541130, size.height * 0.1939986);
    path_6.cubicTo(size.width * 0.4528036, size.height * 0.1935221, size.width * 0.4499120, size.height * 0.1924006,
        size.width * 0.4486729, size.height * 0.1924006);
    path_6.cubicTo(size.width * 0.4465500, size.height * 0.1924006, size.width * 0.4451555, size.height * 0.1908381,
        size.width * 0.4432572, size.height * 0.1908381);
    path_6.cubicTo(size.width * 0.4414466, size.height * 0.1908381, size.width * 0.4396278, size.height * 0.1908381,
        size.width * 0.4378171, size.height * 0.1908381);
    path_6.cubicTo(size.width * 0.4361798, size.height * 0.1908381, size.width * 0.4339562, size.height * 0.1914128,
        size.width * 0.4323770, size.height * 0.1908381);
    path_6.cubicTo(size.width * 0.4307774, size.height * 0.1902559, size.width * 0.4291468, size.height * 0.1909764,
        size.width * 0.4273029, size.height * 0.1903054);
    path_6.cubicTo(size.width * 0.4250463, size.height * 0.1894842, size.width * 0.4224221, size.height * 0.1900917,
        size.width * 0.4200820, size.height * 0.1892401);
    path_6.cubicTo(size.width * 0.4184630, size.height * 0.1886509, size.width * 0.4158432, size.height * 0.1876776,
        size.width * 0.4146419, size.height * 0.1876776);
    path_6.cubicTo(size.width * 0.4125512, size.height * 0.1876776, size.width * 0.4101240, size.height * 0.1878711,
        size.width * 0.4081284, size.height * 0.1871449);
    path_6.cubicTo(size.width * 0.4068019, size.height * 0.1866621, size.width * 0.4047333, size.height * 0.1859292,
        size.width * 0.4034202, size.height * 0.1855469);
    path_6.cubicTo(size.width * 0.4006791, size.height * 0.1847489, size.width * 0.3999992, size.height * 0.1843436,
        size.width * 0.3976142, size.height * 0.1860795);
    path_6.cubicTo(size.width * 0.3960791, size.height * 0.1871968, size.width * 0.3942776, size.height * 0.1879754,
        size.width * 0.3925400, size.height * 0.1892401);
    path_6.cubicTo(size.width * 0.3911102, size.height * 0.1902807, size.width * 0.3895943, size.height * 0.1911177,
        size.width * 0.3878318, size.height * 0.1924006);
    path_6.cubicTo(size.width * 0.3863373, size.height * 0.1934883, size.width * 0.3856627, size.height * 0.1950446,
        size.width * 0.3842213, size.height * 0.1960938);
    path_6.cubicTo(size.width * 0.3828542, size.height * 0.1970888, size.width * 0.3811314, size.height * 0.1971028,
        size.width * 0.3795131, size.height * 0.1976918);
    path_6.cubicTo(size.width * 0.3777447, size.height * 0.1983353, size.width * 0.3764914, size.height * 0.1992890,
        size.width * 0.3744389, size.height * 0.1997869);
    path_6.cubicTo(size.width * 0.3722363, size.height * 0.2003213, size.width * 0.3697570, size.height * 0.2013849,
        size.width * 0.3675595, size.height * 0.2013849);
    path_6.cubicTo(size.width * 0.3657123, size.height * 0.2013849, size.width * 0.3642609, size.height * 0.2012715,
        size.width * 0.3624854, size.height * 0.2019176);
    path_6.cubicTo(size.width * 0.3601384, size.height * 0.2027717, size.width * 0.3584003, size.height * 0.2030443,
        size.width * 0.3563378, size.height * 0.2045455);
    path_6.cubicTo(size.width * 0.3553129, size.height * 0.2052914, size.width * 0.3544774, size.height * 0.2077261,
        size.width * 0.3530689, size.height * 0.2082386);
    path_6.cubicTo(size.width * 0.3514232, size.height * 0.2088375, size.width * 0.3505419, size.height * 0.2106106,
        size.width * 0.3487266, size.height * 0.2119318);
    path_6.cubicTo(size.width * 0.3474815, size.height * 0.2128380, size.width * 0.3454919, size.height * 0.2140127,
        size.width * 0.3443843, size.height * 0.2156250);
    path_6.cubicTo(size.width * 0.3432446, size.height * 0.2172840, size.width * 0.3423077, size.height * 0.2180796,
        size.width * 0.3411153, size.height * 0.2198153);
    path_6.cubicTo(size.width * 0.3396750, size.height * 0.2219120, size.width * 0.3391904, size.height * 0.2231856,
        size.width * 0.3378708, size.height * 0.2251065);
    path_6.cubicTo(size.width * 0.3371161, size.height * 0.2262051, size.width * 0.3355537, size.height * 0.2283202,
        size.width * 0.3342359, size.height * 0.2287997);
    path_6.cubicTo(size.width * 0.3326140, size.height * 0.2293900, size.width * 0.3319373, size.height * 0.2308170,
        size.width * 0.3302596, size.height * 0.2314276);
    path_6.cubicTo(size.width * 0.3290315, size.height * 0.2318745, size.width * 0.3267844, size.height * 0.2326252,
        size.width * 0.3255513, size.height * 0.2335227);
    path_6.cubicTo(size.width * 0.3244297, size.height * 0.2343391, size.width * 0.3224118, size.height * 0.2367782,
        size.width * 0.3212090, size.height * 0.2372159);
    path_6.cubicTo(size.width * 0.3193640, size.height * 0.2378874, size.width * 0.3189364, size.height * 0.2395816,
        size.width * 0.3172326, size.height * 0.2414418);
    path_6.cubicTo(size.width * 0.3156292, size.height * 0.2431924, size.width * 0.3145794, size.height * 0.2442387,
        size.width * 0.3135978, size.height * 0.2456676);
    path_6.cubicTo(size.width * 0.3123765, size.height * 0.2474454, size.width * 0.3111173, size.height * 0.2477159,
        size.width * 0.3099873, size.height * 0.2493608);
    path_6.cubicTo(size.width * 0.3091634, size.height * 0.2505602, size.width * 0.3079199, size.height * 0.2523238,
        size.width * 0.3060109, size.height * 0.2530185);
    path_6.cubicTo(size.width * 0.3053945, size.height * 0.2532428, size.width * 0.3010694, size.height * 0.2547631,
        size.width * 0.3005708, size.height * 0.2562145);
    path_6.cubicTo(size.width * 0.2999118, size.height * 0.2581332, size.width * 0.2997840, size.height * 0.2610976,
        size.width * 0.2991071, size.height * 0.2630682);
    path_6.cubicTo(size.width * 0.2984229, size.height * 0.2650602, size.width * 0.2982182, size.height * 0.2690852,
        size.width * 0.2973019, size.height * 0.2704190);
    path_6.cubicTo(size.width * 0.2964230, size.height * 0.2716985, size.width * 0.2949016, size.height * 0.2728833,
        size.width * 0.2940574, size.height * 0.2741122);
    path_6.cubicTo(size.width * 0.2930632, size.height * 0.2755594, size.width * 0.2911579, size.height * 0.2766145,
        size.width * 0.2893491, size.height * 0.2772727);
    path_6.cubicTo(size.width * 0.2882305, size.height * 0.2776798, size.width * 0.2858815, size.height * 0.2783901,
        size.width * 0.2842750, size.height * 0.2778054);
    path_6.cubicTo(size.width * 0.2828620, size.height * 0.2772912, size.width * 0.2804397, size.height * 0.2766887,
        size.width * 0.2788349, size.height * 0.2772727);
    path_6.cubicTo(size.width * 0.2780291, size.height * 0.2775660, size.width * 0.2770368, size.height * 0.2777280,
        size.width * 0.2761027, size.height * 0.2779474);
    path_6.cubicTo(size.width * 0.2768678, size.height * 0.2781348, size.width * 0.2775426, size.height * 0.2785521,
        size.width * 0.2781274, size.height * 0.2794034);
    path_6.cubicTo(size.width * 0.2790064, size.height * 0.2806829, size.width * 0.2801468, size.height * 0.2818140,
        size.width * 0.2795667, size.height * 0.2851918);
    path_6.cubicTo(size.width * 0.2792294, size.height * 0.2871561, size.width * 0.2790129, size.height * 0.2896139,
        size.width * 0.2777615, size.height * 0.2909801);
    path_6.cubicTo(size.width * 0.2767206, size.height * 0.2921165, size.width * 0.2743556, size.height * 0.2935452,
        size.width * 0.2734192, size.height * 0.2962713);
    path_6.cubicTo(size.width * 0.2728410, size.height * 0.2979548, size.width * 0.2718391, size.height * 0.3008495,
        size.width * 0.2723214, size.height * 0.3036577);
    path_6.cubicTo(size.width * 0.2727400, size.height * 0.3060951, size.width * 0.2733730, size.height * 0.3072836,
        size.width * 0.2748585, size.height * 0.3094460);
    path_6.cubicTo(size.width * 0.2753730, size.height * 0.3101950, size.width * 0.2778707, size.height * 0.3121768,
        size.width * 0.2781274, size.height * 0.3136719);
    path_6.cubicTo(size.width * 0.2785853, size.height * 0.3163379, size.width * 0.2777107, size.height * 0.3149623,
        size.width * 0.2770297, size.height * 0.3189276);
    path_6.cubicTo(size.width * 0.2766708, size.height * 0.3210170, size.width * 0.2757687, size.height * 0.3247428,
        size.width * 0.2755904, size.height * 0.3257813);
    path_6.cubicTo(size.width * 0.2751327, size.height * 0.3284458, size.width * 0.2734615, size.height * 0.3286446,
        size.width * 0.2715896, size.height * 0.3300071);
    path_6.cubicTo(size.width * 0.2701881, size.height * 0.3310271, size.width * 0.2685802, size.height * 0.3315696,
        size.width * 0.2668813, size.height * 0.3315696);
    path_6.cubicTo(size.width * 0.2643978, size.height * 0.3315696, size.width * 0.2634272, size.height * 0.3331196,
        size.width * 0.2618316, size.height * 0.3337003);
    path_6.cubicTo(size.width * 0.2602822, size.height * 0.3342641, size.width * 0.2587698, size.height * 0.3357249,
        size.width * 0.2581967, size.height * 0.3373935);
    path_6.cubicTo(size.width * 0.2574367, size.height * 0.3396062, size.width * 0.2572148, size.height * 0.3412198,
        size.width * 0.2585626, size.height * 0.3431818);
    path_6.cubicTo(size.width * 0.2601383, size.height * 0.3454755, size.width * 0.2590722, size.height * 0.3462200,
        size.width * 0.2596360, size.height * 0.3495028);
    path_6.cubicTo(size.width * 0.2600971, size.height * 0.3521877, size.width * 0.2607090, size.height * 0.3540814,
        size.width * 0.2610997, size.height * 0.3563565);
    path_6.cubicTo(size.width * 0.2614282, size.height * 0.3582692, size.width * 0.2618332, size.height * 0.3605974,
        size.width * 0.2629050, size.height * 0.3626776);
    path_6.cubicTo(size.width * 0.2639756, size.height * 0.3647556, size.width * 0.2631186, size.height * 0.3650117,
        size.width * 0.2618072, size.height * 0.3655895);
    path_6.cubicTo(size.width * 0.2630370, size.height * 0.3662643, size.width * 0.2642338, size.height * 0.3668632,
        size.width * 0.2658080, size.height * 0.3674361);
    path_6.cubicTo(size.width * 0.2672086, size.height * 0.3679458, size.width * 0.2681812, size.height * 0.3689986,
        size.width * 0.2701503, size.height * 0.3689986);
    path_6.cubicTo(size.width * 0.2733115, size.height * 0.3689986, size.width * 0.2720023, size.height * 0.3683652,
        size.width * 0.2730533, size.height * 0.3653054);
    path_6.cubicTo(size.width * 0.2738791, size.height * 0.3629011, size.width * 0.2750083, size.height * 0.3623200,
        size.width * 0.2766637, size.height * 0.3611151);
    path_6.cubicTo(size.width * 0.2770247, size.height * 0.3608524, size.width * 0.2809456, size.height * 0.3588039,
        size.width * 0.2810060, size.height * 0.3584517);
    path_6.cubicTo(size.width * 0.2813554, size.height * 0.3564174, size.width * 0.2814744, size.height * 0.3550922,
        size.width * 0.2806401, size.height * 0.3526634);
    path_6.cubicTo(size.width * 0.2800122, size.height * 0.3508351, size.width * 0.2799327, size.height * 0.3488585,
        size.width * 0.2799327, size.height * 0.3458097);
    path_6.cubicTo(size.width * 0.2799327, size.height * 0.3411774, size.width * 0.2802496, size.height * 0.3417169,
        size.width * 0.2828113, size.height * 0.3426491);
    path_6.cubicTo(size.width * 0.2843116, size.height * 0.3431952, size.width * 0.2855610, size.height * 0.3434558,
        size.width * 0.2868121, size.height * 0.3452770);
    path_6.cubicTo(size.width * 0.2881322, size.height * 0.3471987, size.width * 0.2893573, size.height * 0.3471177,
        size.width * 0.2915203, size.height * 0.3479048);
    path_6.cubicTo(size.width * 0.2925994, size.height * 0.3482975, size.width * 0.2951585, size.height * 0.3489702,
        size.width * 0.2965945, size.height * 0.3489702);
    path_6.cubicTo(size.width * 0.2984324, size.height * 0.3489702, size.width * 0.2992760, size.height * 0.3499638,
        size.width * 0.3009368, size.height * 0.3505682);
    path_6.cubicTo(size.width * 0.3020405, size.height * 0.3509699, size.width * 0.3047779, size.height * 0.3540935,
        size.width * 0.3052791, size.height * 0.3537287);
    path_6.cubicTo(size.width * 0.3062520, size.height * 0.3530205, size.width * 0.3075845, size.height * 0.3503773,
        size.width * 0.3085236, size.height * 0.3500355);
    path_6.cubicTo(size.width * 0.3104522, size.height * 0.3493337, size.width * 0.3116820, size.height * 0.3479048,
        size.width * 0.3139637, size.height * 0.3479048);
    path_6.cubicTo(size.width * 0.3158970, size.height * 0.3479048, size.width * 0.3174214, size.height * 0.3484375,
        size.width * 0.3194038, size.height * 0.3484375);
    path_6.cubicTo(size.width * 0.3213842, size.height * 0.3484375, size.width * 0.3233169, size.height * 0.3485848,
        size.width * 0.3251854, size.height * 0.3479048);
    path_6.cubicTo(size.width * 0.3265709, size.height * 0.3474006, size.width * 0.3283349, size.height * 0.3458443,
        size.width * 0.3298936, size.height * 0.3452770);
    path_6.cubicTo(size.width * 0.3314350, size.height * 0.3447160, size.width * 0.3327308, size.height * 0.3438628,
        size.width * 0.3346019, size.height * 0.3431818);
    path_6.cubicTo(size.width * 0.3358782, size.height * 0.3427173, size.width * 0.3373602, size.height * 0.3410511,
        size.width * 0.3393101, size.height * 0.3410511);
    path_6.cubicTo(size.width * 0.3416370, size.height * 0.3410511, size.width * 0.3427682, size.height * 0.3421165,
        size.width * 0.3447502, size.height * 0.3421165);
    path_6.cubicTo(size.width * 0.3468771, size.height * 0.3421165, size.width * 0.3479427, size.height * 0.3416028,
        size.width * 0.3494584, size.height * 0.3410511);
    path_6.cubicTo(size.width * 0.3521569, size.height * 0.3400691, size.width * 0.3509542, size.height * 0.3399391,
        size.width * 0.3527030, size.height * 0.3373935);
    path_6.cubicTo(size.width * 0.3533671, size.height * 0.3364267, size.width * 0.3549464, size.height * 0.3343446,
        size.width * 0.3552400, size.height * 0.3326349);
    path_6.cubicTo(size.width * 0.3557756, size.height * 0.3295163, size.width * 0.3554689, size.height * 0.3291026,
        size.width * 0.3548985, size.height * 0.3257813);
    path_6.cubicTo(size.width * 0.3545899, size.height * 0.3239841, size.width * 0.3533168, size.height * 0.3222780,
        size.width * 0.3538007, size.height * 0.3194602);
    path_6.cubicTo(size.width * 0.3543356, size.height * 0.3163458, size.width * 0.3553747, size.height * 0.3149095,
        size.width * 0.3567037, size.height * 0.3136719);
    path_6.cubicTo(size.width * 0.3588008, size.height * 0.3112298, size.width * 0.3585090, size.height * 0.3111400,
        size.width * 0.3585090, size.height * 0.3078480);
    path_6.cubicTo(size.width * 0.3585090, size.height * 0.3065196, size.width * 0.3579329, size.height * 0.3010735,
        size.width * 0.3581431, size.height * 0.3004616);
    path_6.cubicTo(size.width * 0.3591260, size.height * 0.2975998, size.width * 0.3602872, size.height * 0.2979086,
        size.width * 0.3614120, size.height * 0.2962713);
    path_6.cubicTo(size.width * 0.3623481, size.height * 0.2949086, size.width * 0.3637223, size.height * 0.2929322,
        size.width * 0.3650224, size.height * 0.2915128);
    path_6.cubicTo(size.width * 0.3663389, size.height * 0.2900756, size.width * 0.3676185, size.height * 0.2884551,
        size.width * 0.3693648, size.height * 0.2878196);
    path_6.cubicTo(size.width * 0.3706206, size.height * 0.2873626, size.width * 0.3723135, size.height * 0.2862571,
        size.width * 0.3740730, size.height * 0.2862571);
    path_6.cubicTo(size.width * 0.3758836, size.height * 0.2862571, size.width * 0.3777024, size.height * 0.2862571,
        size.width * 0.3795131, size.height * 0.2862571);
    path_6.cubicTo(size.width * 0.3817270, size.height * 0.2862571, size.width * 0.3823103, size.height * 0.2857837,
        size.width * 0.3838554, size.height * 0.2846591);
    path_6.cubicTo(size.width * 0.3853640, size.height * 0.2835611, size.width * 0.3860265, size.height * 0.2820983,
        size.width * 0.3860265, size.height * 0.2794034);
    path_6.cubicTo(size.width * 0.3860265, size.height * 0.2779324, size.width * 0.3855682, size.height * 0.2721166,
        size.width * 0.3867584, size.height * 0.2725497);
    path_6.cubicTo(size.width * 0.3883806, size.height * 0.2731401, size.width * 0.3893106, size.height * 0.2744073,
        size.width * 0.3911007, size.height * 0.2757102);
    path_6.cubicTo(size.width * 0.3928178, size.height * 0.2769600, size.width * 0.3942096, size.height * 0.2771247,
        size.width * 0.3958089, size.height * 0.2788707);
    path_6.cubicTo(size.width * 0.3970416, size.height * 0.2802165, size.width * 0.3984000, size.height * 0.2811231,
        size.width * 0.3990779, size.height * 0.2830966);
    path_6.cubicTo(size.width * 0.3992296, size.height * 0.2835385, size.width * 0.4010071, size.height * 0.2890973,
        size.width * 0.4015906, size.height * 0.2888849);
    path_6.cubicTo(size.width * 0.4034763, size.height * 0.2881987, size.width * 0.4050620, size.height * 0.2884535,
        size.width * 0.4066647, size.height * 0.2872869);
    path_6.cubicTo(size.width * 0.4081931, size.height * 0.2861745, size.width * 0.4096331, size.height * 0.2856591,
        size.width * 0.4110070, size.height * 0.2846591);
    path_6.cubicTo(size.width * 0.4122255, size.height * 0.2837722, size.width * 0.4133708, size.height * 0.2832227,
        size.width * 0.4150078, size.height * 0.2820313);
    path_6.cubicTo(size.width * 0.4164043, size.height * 0.2810148, size.width * 0.4177811, size.height * 0.2797464,
        size.width * 0.4189842, size.height * 0.2788707);
    path_6.cubicTo(size.width * 0.4202983, size.height * 0.2779143, size.width * 0.4219639, size.height * 0.2762061,
        size.width * 0.4233265, size.height * 0.2757102);
    path_6.cubicTo(size.width * 0.4246035, size.height * 0.2752455, size.width * 0.4266925, size.height * 0.2735470,
        size.width * 0.4262295, size.height * 0.2762429);
    path_6.cubicTo(size.width * 0.4257304, size.height * 0.2791492, size.width * 0.4252093, size.height * 0.2797458,
        size.width * 0.4244243, size.height * 0.2820313);
    path_6.cubicTo(size.width * 0.4239047, size.height * 0.2835438, size.width * 0.4232179, size.height * 0.2859054,
        size.width * 0.4240584, size.height * 0.2883523);
    path_6.cubicTo(size.width * 0.4250231, size.height * 0.2911611, size.width * 0.4260755, size.height * 0.2902587,
        size.width * 0.4273029, size.height * 0.2920455);
    path_6.cubicTo(size.width * 0.4281536, size.height * 0.2932839, size.width * 0.4292421, size.height * 0.2942381,
        size.width * 0.4305718, size.height * 0.2952060);
    path_6.cubicTo(size.width * 0.4308227, size.height * 0.2953886, size.width * 0.4360119, size.height * 0.2986923,
        size.width * 0.4360119, size.height * 0.2994318);
    path_6.cubicTo(size.width * 0.4362272, size.height * 0.2996669, size.width * 0.4374512, size.height * 0.3002460,
        size.width * 0.4374512, size.height * 0.3009943);
    path_6.cubicTo(size.width * 0.4374512, size.height * 0.3037288, size.width * 0.4378171, size.height * 0.3060396,
        size.width * 0.4378171, size.height * 0.3089134);
    path_6.cubicTo(size.width * 0.4378171, size.height * 0.3112968, size.width * 0.4374223, size.height * 0.3145337,
        size.width * 0.4378171, size.height * 0.3168324);
    path_6.cubicTo(size.width * 0.4382952, size.height * 0.3196160, size.width * 0.4388433, size.height * 0.3207479,
        size.width * 0.4392564, size.height * 0.3231534);
    path_6.cubicTo(size.width * 0.4396556, size.height * 0.3254775, size.width * 0.4399231, size.height * 0.3274966,
        size.width * 0.4403542, size.height * 0.3300071);
    path_6.cubicTo(size.width * 0.4407132, size.height * 0.3320975, size.width * 0.4413797, size.height * 0.3333857,
        size.width * 0.4417935, size.height * 0.3357955);
    path_6.cubicTo(size.width * 0.4420980, size.height * 0.3375681, size.width * 0.4425697, size.height * 0.3407931,
        size.width * 0.4421594, size.height * 0.3431818);
    path_6.cubicTo(size.width * 0.4417887, size.height * 0.3453406, size.width * 0.4415757, size.height * 0.3486138,
        size.width * 0.4403542, size.height * 0.3495028);
    path_6.cubicTo(size.width * 0.4386239, size.height * 0.3507622, size.width * 0.4376107, size.height * 0.3514013,
        size.width * 0.4363778, size.height * 0.3531960);
    path_6.cubicTo(size.width * 0.4341817, size.height * 0.3563928, size.width * 0.4344984, size.height * 0.3570838,
        size.width * 0.4363778, size.height * 0.3584517);
    path_6.cubicTo(size.width * 0.4379470, size.height * 0.3595938, size.width * 0.4388130, size.height * 0.3600953,
        size.width * 0.4392564, size.height * 0.3626776);
    path_6.cubicTo(size.width * 0.4395650, size.height * 0.3644741, size.width * 0.4401393, size.height * 0.3667749,
        size.width * 0.4407201, size.height * 0.3684659);
    path_6.cubicTo(size.width * 0.4412969, size.height * 0.3701452, size.width * 0.4421412, size.height * 0.3720527,
        size.width * 0.4425254, size.height * 0.3742898);
    path_6.cubicTo(size.width * 0.4431542, size.height * 0.3779510, size.width * 0.4440110, size.height * 0.3773829,
        size.width * 0.4417935, size.height * 0.3806108);
    path_6.cubicTo(size.width * 0.4406971, size.height * 0.3822069, size.width * 0.4399674, size.height * 0.3837662,
        size.width * 0.4388905, size.height * 0.3853338);
    path_6.cubicTo(size.width * 0.4388073, size.height * 0.3854550, size.width * 0.4363581, size.height * 0.3911577,
        size.width * 0.4370853, size.height * 0.3911577);
    path_6.cubicTo(size.width * 0.4385549, size.height * 0.3911577, size.width * 0.4392310, size.height * 0.3902348,
        size.width * 0.4410861, size.height * 0.3895597);
    path_6.cubicTo(size.width * 0.4428280, size.height * 0.3889257, size.width * 0.4447351, size.height * 0.3891373,
        size.width * 0.4465018, size.height * 0.3884943);
    path_6.cubicTo(size.width * 0.4482869, size.height * 0.3878447, size.width * 0.4498161, size.height * 0.3874137,
        size.width * 0.4512100, size.height * 0.3863991);
    path_6.cubicTo(size.width * 0.4527005, size.height * 0.3853143, size.width * 0.4539884, size.height * 0.3849825,
        size.width * 0.4551864, size.height * 0.3832386);
    path_6.cubicTo(size.width * 0.4559554, size.height * 0.3821191, size.width * 0.4576995, size.height * 0.3797944,
        size.width * 0.4595531, size.height * 0.3811435);
    path_6.cubicTo(size.width * 0.4607215, size.height * 0.3819939, size.width * 0.4619951, size.height * 0.3827060,
        size.width * 0.4638954, size.height * 0.3827060);
    path_6.cubicTo(size.width * 0.4657060, size.height * 0.3827060, size.width * 0.4675004, size.height * 0.3827060,
        size.width * 0.4693111, size.height * 0.3827060);
    path_6.cubicTo(size.width * 0.4708044, size.height * 0.3827060, size.width * 0.4734843, size.height * 0.3830953,
        size.width * 0.4747512, size.height * 0.3821733);
    path_6.cubicTo(size.width * 0.4762804, size.height * 0.3810603, size.width * 0.4769874, size.height * 0.3800130,
        size.width * 0.4783616, size.height * 0.3790128);
    path_6.cubicTo(size.width * 0.4789055, size.height * 0.3786169, size.width * 0.4822345, size.height * 0.3762052,
        size.width * 0.4827283, size.height * 0.3763849);
    path_6.cubicTo(size.width * 0.4847846, size.height * 0.3771333, size.width * 0.4843525, size.height * 0.3783661,
        size.width * 0.4859729, size.height * 0.3795455);
    path_6.cubicTo(size.width * 0.4870185, size.height * 0.3803065, size.width * 0.4893407, size.height * 0.3823854,
        size.width * 0.4910470, size.height * 0.3811435);
    path_6.cubicTo(size.width * 0.4919781, size.height * 0.3804658, size.width * 0.4942540, size.height * 0.3792671,
        size.width * 0.4946575, size.height * 0.3769176);
    path_6.cubicTo(size.width * 0.4949210, size.height * 0.3753832, size.width * 0.4971301, size.height * 0.3716771,
        size.width * 0.4968530, size.height * 0.3700639);
    path_6.cubicTo(size.width * 0.4966005, size.height * 0.3685936, size.width * 0.4950520, size.height * 0.3652577,
        size.width * 0.4957553, size.height * 0.3632102);
    path_6.cubicTo(size.width * 0.4965725, size.height * 0.3608310, size.width * 0.4973796, size.height * 0.3617389,
        size.width * 0.4993657, size.height * 0.3605824);
    path_6.cubicTo(size.width * 0.5019408, size.height * 0.3590830, size.width * 0.5022873, size.height * 0.3598146,
        size.width * 0.5040740, size.height * 0.3611151);
    path_6.cubicTo(size.width * 0.5057341, size.height * 0.3623234, size.width * 0.5066056, size.height * 0.3618855,
        size.width * 0.5087822, size.height * 0.3626776);
    path_6.cubicTo(size.width * 0.5102354, size.height * 0.3632064, size.width * 0.5110746, size.height * 0.3643283,
        size.width * 0.5124171, size.height * 0.3653054);
    path_6.cubicTo(size.width * 0.5145762, size.height * 0.3668769, size.width * 0.5135981, size.height * 0.3680900,
        size.width * 0.5149541, size.height * 0.3700639);
    path_6.cubicTo(size.width * 0.5157732, size.height * 0.3712562, size.width * 0.5166801, size.height * 0.3737571,
        size.width * 0.5181987, size.height * 0.3737571);
    path_6.cubicTo(size.width * 0.5198950, size.height * 0.3737571, size.width * 0.5220748, size.height * 0.3724495,
        size.width * 0.5229069, size.height * 0.3726918);
    path_6.cubicTo(size.width * 0.5244942, size.height * 0.3731539, size.width * 0.5267038, size.height * 0.3737571,
        size.width * 0.5283470, size.height * 0.3737571);
    path_6.cubicTo(size.width * 0.5292074, size.height * 0.3737571, size.width * 0.5332459, size.height * 0.3729693,
        size.width * 0.5337871, size.height * 0.3737571);
    path_6.cubicTo(size.width * 0.5349209, size.height * 0.3754075, size.width * 0.5346563, size.height * 0.3768202,
        size.width * 0.5355923, size.height * 0.3795455);
    path_6.cubicTo(size.width * 0.5363237, size.height * 0.3816749, size.width * 0.5367355, size.height * 0.3833047,
        size.width * 0.5381294, size.height * 0.3853338);
    path_6.cubicTo(size.width * 0.5391405, size.height * 0.3868056, size.width * 0.5402334, size.height * 0.3882791,
        size.width * 0.5424717, size.height * 0.3874645);
    path_6.cubicTo(size.width * 0.5441247, size.height * 0.3868629, size.width * 0.5461759, size.height * 0.3858665,
        size.width * 0.5479118, size.height * 0.3858665);
    path_6.cubicTo(size.width * 0.5499036, size.height * 0.3858665, size.width * 0.5513160, size.height * 0.3863992,
        size.width * 0.5529616, size.height * 0.3863991);
    path_6.cubicTo(size.width * 0.5550317, size.height * 0.3863991, size.width * 0.5562020, size.height * 0.3869318,
        size.width * 0.5580357, size.height * 0.3869318);
    path_6.cubicTo(size.width * 0.5597533, size.height * 0.3869318, size.width * 0.5618897, size.height * 0.3872873,
        size.width * 0.5631099, size.height * 0.3863991);
    path_6.cubicTo(size.width * 0.5644346, size.height * 0.3854349, size.width * 0.5660003, size.height * 0.3839002,
        size.width * 0.5678181, size.height * 0.3832386);
    path_6.cubicTo(size.width * 0.5689133, size.height * 0.3828401, size.width * 0.5716794, size.height * 0.3818437,
        size.width * 0.5725263, size.height * 0.3806108);
    path_6.cubicTo(size.width * 0.5729896, size.height * 0.3799365, size.width * 0.5750634, size.height * 0.3767711,
        size.width * 0.5750634, size.height * 0.3748224);
    path_6.cubicTo(size.width * 0.5750634, size.height * 0.3724021, size.width * 0.5754293, size.height * 0.3703600,
        size.width * 0.5754294, size.height * 0.3674361);
    path_6.cubicTo(size.width * 0.5754294, size.height * 0.3659743, size.width * 0.5759286, size.height * 0.3609245,
        size.width * 0.5768687, size.height * 0.3605824);
    path_6.cubicTo(size.width * 0.5781855, size.height * 0.3601032, size.width * 0.5804584, size.height * 0.3600346,
        size.width * 0.5819428, size.height * 0.3611151);
    path_6.cubicTo(size.width * 0.5834798, size.height * 0.3622337, size.width * 0.5845588, size.height * 0.3639716,
        size.width * 0.5866511, size.height * 0.3632102);
    path_6.cubicTo(size.width * 0.5883046, size.height * 0.3626085, size.width * 0.5903857, size.height * 0.3611151,
        size.width * 0.5920911, size.height * 0.3611151);
    path_6.cubicTo(size.width * 0.5927750, size.height * 0.3611151, size.width * 0.5952669, size.height * 0.3610545,
        size.width * 0.5967994, size.height * 0.3616122);
    path_6.cubicTo(size.width * 0.5985681, size.height * 0.3622559, size.width * 0.6004570, size.height * 0.3625704,
        size.width * 0.6022151, size.height * 0.3632102);
    path_6.cubicTo(size.width * 0.6040451, size.height * 0.3638762, size.width * 0.6057803, size.height * 0.3646231,
        size.width * 0.6076552, size.height * 0.3653054);
    path_6.cubicTo(size.width * 0.6087231, size.height * 0.3656940, size.width * 0.6110943, size.height * 0.3676854,
        size.width * 0.6123634, size.height * 0.3658381);
    path_6.cubicTo(size.width * 0.6133052, size.height * 0.3644671, size.width * 0.6136232, size.height * 0.3619091,
        size.width * 0.6149005, size.height * 0.3600497);
    path_6.cubicTo(size.width * 0.6161141, size.height * 0.3582831, size.width * 0.6173256, size.height * 0.3580820,
        size.width * 0.6188769, size.height * 0.3558239);
    path_6.cubicTo(size.width * 0.6200798, size.height * 0.3540727, size.width * 0.6203162, size.height * 0.3538290,
        size.width * 0.6203162, size.height * 0.3500355);
    path_6.cubicTo(size.width * 0.6203162, size.height * 0.3470418, size.width * 0.6203913, size.height * 0.3450938,
        size.width * 0.6210480, size.height * 0.3431818);
    path_6.cubicTo(size.width * 0.6213650, size.height * 0.3422589, size.width * 0.6225118, size.height * 0.3379262,
        size.width * 0.6235851, size.height * 0.3394886);
    path_6.cubicTo(size.width * 0.6246850, size.height * 0.3410898, size.width * 0.6249157, size.height * 0.3425135,
        size.width * 0.6253903, size.height * 0.3452770);
    path_6.cubicTo(size.width * 0.6255383, size.height * 0.3461385, size.width * 0.6282153, size.height * 0.3527770,
        size.width * 0.6300986, size.height * 0.3500355);
    path_6.cubicTo(size.width * 0.6311233, size.height * 0.3496626, size.width * 0.6333659, size.height * 0.3489726,
        size.width * 0.6340993, size.height * 0.3479048);
    path_6.cubicTo(size.width * 0.6349202, size.height * 0.3467099, size.width * 0.6369342, size.height * 0.3448117,
        size.width * 0.6384416, size.height * 0.3437145);
    path_6.cubicTo(size.width * 0.6406447, size.height * 0.3421111, size.width * 0.6414978, size.height * 0.3402270,
        size.width * 0.6431499, size.height * 0.3384233);
    path_6.cubicTo(size.width * 0.6447875, size.height * 0.3366354, size.width * 0.6455818, size.height * 0.3350907,
        size.width * 0.6482240, size.height * 0.3331676);
    path_6.cubicTo(size.width * 0.6504044, size.height * 0.3315807, size.width * 0.6502615, size.height * 0.3340936,
        size.width * 0.6507367, size.height * 0.3368608);
    path_6.cubicTo(size.width * 0.6511054, size.height * 0.3390077, size.width * 0.6521264, size.height * 0.3406202,
        size.width * 0.6525664, size.height * 0.3431818);
    path_6.cubicTo(size.width * 0.6529162, size.height * 0.3452190, size.width * 0.6529394, size.height * 0.3485292,
        size.width * 0.6536397, size.height * 0.3505682);
    path_6.cubicTo(size.width * 0.6540901, size.height * 0.3518795, size.width * 0.6551034, size.height * 0.3540135,
        size.width * 0.6551034, size.height * 0.3563565);
    path_6.cubicTo(size.width * 0.6551034, size.height * 0.3588781, size.width * 0.6550908, size.height * 0.3616464,
        size.width * 0.6558109, size.height * 0.3637429);
    path_6.cubicTo(size.width * 0.6568387, size.height * 0.3667353, size.width * 0.6572945, size.height * 0.3665168,
        size.width * 0.6590798, size.height * 0.3684659);
    path_6.cubicTo(size.width * 0.6599176, size.height * 0.3693805, size.width * 0.6620374, size.height * 0.3711293,
        size.width * 0.6637881, size.height * 0.3711293);
    path_6.cubicTo(size.width * 0.6661940, size.height * 0.3711293, size.width * 0.6682864, size.height * 0.3708931,
        size.width * 0.6703015, size.height * 0.3716264);
    path_6.cubicTo(size.width * 0.6715755, size.height * 0.3720900, size.width * 0.6737143, size.height * 0.3720872,
        size.width * 0.6753757, size.height * 0.3726918);
    path_6.cubicTo(size.width * 0.6773879, size.height * 0.3734240, size.width * 0.6778971, size.height * 0.3739943,
        size.width * 0.6797180, size.height * 0.3753196);
    path_6.cubicTo(size.width * 0.6813478, size.height * 0.3765059, size.width * 0.6817471, size.height * 0.3773688,
        size.width * 0.6829869, size.height * 0.3769176);
    path_6.cubicTo(size.width * 0.6848620, size.height * 0.3762352, size.width * 0.6866989, size.height * 0.3758523,
        size.width * 0.6887685, size.height * 0.3758523);
    path_6.cubicTo(size.width * 0.6905779, size.height * 0.3758523, size.width * 0.6919866, size.height * 0.3758330,
        size.width * 0.6934768, size.height * 0.3769176);
    path_6.cubicTo(size.width * 0.6945412, size.height * 0.3776923, size.width * 0.6967781, size.height * 0.3790954,
        size.width * 0.6974532, size.height * 0.3800781);
    path_6.cubicTo(size.width * 0.6985690, size.height * 0.3817025, size.width * 0.6994353, size.height * 0.3831011,
        size.width * 0.7010880, size.height * 0.3843040);
    path_6.cubicTo(size.width * 0.7023087, size.height * 0.3851924, size.width * 0.7031891, size.height * 0.3863659,
        size.width * 0.7046985, size.height * 0.3874645);
    path_6.cubicTo(size.width * 0.7059630, size.height * 0.3883849, size.width * 0.7071163, size.height * 0.3901821,
        size.width * 0.7083333, size.height * 0.3906250);
    path_6.cubicTo(size.width * 0.7099493, size.height * 0.3912131, size.width * 0.7107514, size.height * 0.3921530,
        size.width * 0.7123097, size.height * 0.3927202);
    path_6.cubicTo(size.width * 0.7136238, size.height * 0.3931984, size.width * 0.7150364, size.height * 0.3943182,
        size.width * 0.7170180, size.height * 0.3943182);
    path_6.cubicTo(size.width * 0.7183276, size.height * 0.3943182, size.width * 0.7213167, size.height * 0.3951489,
        size.width * 0.7224580, size.height * 0.3943182);
    path_6.cubicTo(size.width * 0.7240256, size.height * 0.3931772, size.width * 0.7252780, size.height * 0.3930647,
        size.width * 0.7271663, size.height * 0.3916903);
    path_6.cubicTo(size.width * 0.7283654, size.height * 0.3908175, size.width * 0.7305906, size.height * 0.3901512,
        size.width * 0.7322160, size.height * 0.3895597);
    path_6.cubicTo(size.width * 0.7343755, size.height * 0.3887738, size.width * 0.7357533, size.height * 0.3870738,
        size.width * 0.7372902, size.height * 0.3848366);
    path_6.cubicTo(size.width * 0.7388140, size.height * 0.3826185, size.width * 0.7391879, size.height * 0.3816088,
        size.width * 0.7412910, size.height * 0.3800781);
    path_6.cubicTo(size.width * 0.7426233, size.height * 0.3791084, size.width * 0.7445702, size.height * 0.3779703,
        size.width * 0.7459992, size.height * 0.3774503);
    path_6.cubicTo(size.width * 0.7473856, size.height * 0.3769458, size.width * 0.7493004, size.height * 0.3746833,
        size.width * 0.7510490, size.height * 0.3753196);
    path_6.cubicTo(size.width * 0.7526077, size.height * 0.3758868, size.width * 0.7541629, size.height * 0.3757572,
        size.width * 0.7557572, size.height * 0.3769176);
    path_6.cubicTo(size.width * 0.7566645, size.height * 0.3775780, size.width * 0.7583884, size.height * 0.3795797,
        size.width * 0.7597580, size.height * 0.3800781);
    path_6.cubicTo(size.width * 0.7613443, size.height * 0.3806554, size.width * 0.7629482, size.height * 0.3827060,
        size.width * 0.7648078, size.height * 0.3827060);
    path_6.cubicTo(size.width * 0.7668327, size.height * 0.3827060, size.width * 0.7680969, size.height * 0.3826735,
        size.width * 0.7695160, size.height * 0.3816406);
    path_6.cubicTo(size.width * 0.7712261, size.height * 0.3803960, size.width * 0.7713145, size.height * 0.3790580,
        size.width * 0.7724190, size.height * 0.3774503);
    path_6.cubicTo(size.width * 0.7736425, size.height * 0.3756693, size.width * 0.7741946, size.height * 0.3748548,
        size.width * 0.7756879, size.height * 0.3732244);
    path_6.cubicTo(size.width * 0.7768519, size.height * 0.3719537, size.width * 0.7785291, size.height * 0.3711429,
        size.width * 0.7800302, size.height * 0.3705966);
    path_6.cubicTo(size.width * 0.7812784, size.height * 0.3701424, size.width * 0.7831973, size.height * 0.3696441,
        size.width * 0.7840066, size.height * 0.3684659);
    path_6.cubicTo(size.width * 0.7850339, size.height * 0.3669705, size.width * 0.7857973, size.height * 0.3659158,
        size.width * 0.7865437, size.height * 0.3637429);
    path_6.cubicTo(size.width * 0.7870127, size.height * 0.3623775, size.width * 0.7884860, size.height * 0.3589844,
        size.width * 0.7876415, size.height * 0.3589844);
    path_6.cubicTo(size.width * 0.7855714, size.height * 0.3589844, size.width * 0.7846406, size.height * 0.3595171,
        size.width * 0.7825674, size.height * 0.3595170);
    path_6.cubicTo(size.width * 0.7812053, size.height * 0.3595170, size.width * 0.7777454, size.height * 0.3604168,
        size.width * 0.7767613, size.height * 0.3589844);
    path_6.cubicTo(size.width * 0.7755937, size.height * 0.3572847, size.width * 0.7751457, size.height * 0.3569634,
        size.width * 0.7745902, size.height * 0.3537287);
    path_6.cubicTo(size.width * 0.7742478, size.height * 0.3517349, size.width * 0.7742838, size.height * 0.3492104,
        size.width * 0.7738827, size.height * 0.3468750);
    path_6.cubicTo(size.width * 0.7734658, size.height * 0.3444473, size.width * 0.7739534, size.height * 0.3414980,
        size.width * 0.7735168, size.height * 0.3389560);
    path_6.cubicTo(size.width * 0.7730984, size.height * 0.3365197, size.width * 0.7731508, size.height * 0.3337751,
        size.width * 0.7731509, size.height * 0.3310369);
    path_6.cubicTo(size.width * 0.7731509, size.height * 0.3275014, size.width * 0.7741611, size.height * 0.3275354,
        size.width * 0.7760539, size.height * 0.3268466);
    path_6.cubicTo(size.width * 0.7778300, size.height * 0.3262002, size.width * 0.7793797, size.height * 0.3248106,
        size.width * 0.7811037, size.height * 0.3241832);
    path_6.cubicTo(size.width * 0.7824016, size.height * 0.3237109, size.width * 0.7844587, size.height * 0.3230281,
        size.width * 0.7854703, size.height * 0.3215554);
    path_6.cubicTo(size.width * 0.7870308, size.height * 0.3192838, size.width * 0.7888429, size.height * 0.3187412,
        size.width * 0.7898126, size.height * 0.3173295);
    path_6.cubicTo(size.width * 0.7911628, size.height * 0.3153642, size.width * 0.7922106, size.height * 0.3148624,
        size.width * 0.7937891, size.height * 0.3131392);
    path_6.cubicTo(size.width * 0.7948186, size.height * 0.3120152, size.width * 0.7965577, size.height * 0.3092597,
        size.width * 0.7977654, size.height * 0.3083807);
    path_6.cubicTo(size.width * 0.7993424, size.height * 0.3072329, size.width * 0.7997995, size.height * 0.3058526,
        size.width * 0.8014003, size.height * 0.3046875);
    path_6.cubicTo(size.width * 0.8037698, size.height * 0.3029629, size.width * 0.8042571, size.height * 0.3030736,
        size.width * 0.8064745, size.height * 0.3046875);
    path_6.cubicTo(size.width * 0.8077899, size.height * 0.3056450, size.width * 0.8094690, size.height * 0.3050049,
        size.width * 0.8115242, size.height * 0.3057528);
    path_6.cubicTo(size.width * 0.8134016, size.height * 0.3064360, size.width * 0.8168609, size.height * 0.3035527,
        size.width * 0.8173302, size.height * 0.3062855);
    path_6.cubicTo(size.width * 0.8178147, size.height * 0.3091065, size.width * 0.8167069, size.height * 0.3098441,
        size.width * 0.8162325, size.height * 0.3126065);
    path_6.cubicTo(size.width * 0.8159126, size.height * 0.3144691, size.width * 0.8150558, size.height * 0.3172607,
        size.width * 0.8155250, size.height * 0.3199929);
    path_6.cubicTo(size.width * 0.8159108, size.height * 0.3222391, size.width * 0.8162030, size.height * 0.3257812,
        size.width * 0.8176962, size.height * 0.3257813);
    path_6.cubicTo(size.width * 0.8197212, size.height * 0.3257813, size.width * 0.8209854, size.height * 0.3257488,
        size.width * 0.8224044, size.height * 0.3247159);
    path_6.cubicTo(size.width * 0.8242281, size.height * 0.3233885, size.width * 0.8249507, size.height * 0.3223299,
        size.width * 0.8267467, size.height * 0.3210227);
    path_6.cubicTo(size.width * 0.8278034, size.height * 0.3202536, size.width * 0.8295400, size.height * 0.3178622,
        size.width * 0.8310890, size.height * 0.3178622);
    path_6.cubicTo(size.width * 0.8333030, size.height * 0.3178622, size.width * 0.8338862, size.height * 0.3183356,
        size.width * 0.8354313, size.height * 0.3194602);
    path_6.cubicTo(size.width * 0.8366920, size.height * 0.3203778, size.width * 0.8376009, size.height * 0.3215543,
        size.width * 0.8390662, size.height * 0.3226207);
    path_6.cubicTo(size.width * 0.8401189, size.height * 0.3233869, size.width * 0.8420412, size.height * 0.3246111,
        size.width * 0.8434084, size.height * 0.3226207);
    path_6.cubicTo(size.width * 0.8436860, size.height * 0.3222168, size.width * 0.8461009, size.height * 0.3192987,
        size.width * 0.8459455, size.height * 0.3183949);
    path_6.cubicTo(size.width * 0.8456850, size.height * 0.3168773, size.width * 0.8445126, size.height * 0.3135820,
        size.width * 0.8452137, size.height * 0.3115412);
    path_6.cubicTo(size.width * 0.8459780, size.height * 0.3093161, size.width * 0.8461660, size.height * 0.3077035,
        size.width * 0.8470189, size.height * 0.3052202);
    path_6.cubicTo(size.width * 0.8478592, size.height * 0.3027738, size.width * 0.8481151, size.height * 0.2998978,
        size.width * 0.8488242, size.height * 0.2978338);
    path_6.cubicTo(size.width * 0.8495003, size.height * 0.2958652, size.width * 0.8501931, size.height * 0.2953082,
        size.width * 0.8513613, size.height * 0.2936080);
    path_6.cubicTo(size.width * 0.8525489, size.height * 0.2918791, size.width * 0.8538383, size.height * 0.2904475,
        size.width * 0.8560695, size.height * 0.2904474);
    path_6.cubicTo(size.width * 0.8581084, size.height * 0.2904474, size.width * 0.8595472, size.height * 0.2898824,
        size.width * 0.8611436, size.height * 0.2894176);
    path_6.cubicTo(size.width * 0.8626297, size.height * 0.2889850, size.width * 0.8648337, size.height * 0.2886885,
        size.width * 0.8654859, size.height * 0.2867898);
    path_6.cubicTo(size.width * 0.8661805, size.height * 0.2847678, size.width * 0.8669642, size.height * 0.2830399,
        size.width * 0.8683889, size.height * 0.2809659);
    path_6.cubicTo(size.width * 0.8693215, size.height * 0.2796084, size.width * 0.8694537, size.height * 0.2778535,
        size.width * 0.8705601, size.height * 0.2762429);
    path_6.cubicTo(size.width * 0.8716084, size.height * 0.2747169, size.width * 0.8726724, size.height * 0.2725748,
        size.width * 0.8741706, size.height * 0.2714844);
    path_6.cubicTo(size.width * 0.8754024, size.height * 0.2705878, size.width * 0.8772552, size.height * 0.2697236,
        size.width * 0.8785372, size.height * 0.2683239);
    path_6.cubicTo(size.width * 0.8802808, size.height * 0.2664204, size.width * 0.8797712, size.height * 0.2661340,
        size.width * 0.8792447, size.height * 0.2630682);
    path_6.cubicTo(size.width * 0.8789390, size.height * 0.2612883, size.width * 0.8785844, size.height * 0.2568158,
        size.width * 0.8778055, size.height * 0.2556818);
    path_6.cubicTo(size.width * 0.8769419, size.height * 0.2544248, size.width * 0.8761102, size.height * 0.2521322,
        size.width * 0.8756343, size.height * 0.2493608);
    path_6.cubicTo(size.width * 0.8754200, size.height * 0.2481133, size.width * 0.8745398, size.height * 0.2440543,
        size.width * 0.8738290, size.height * 0.2435369);
    path_6.cubicTo(size.width * 0.8727410, size.height * 0.2427450, size.width * 0.8714904, size.height * 0.2409813,
        size.width * 0.8698283, size.height * 0.2403764);
    path_6.cubicTo(size.width * 0.8677050, size.height * 0.2396038, size.width * 0.8669400, size.height * 0.2384110,
        size.width * 0.8651201, size.height * 0.2377486);
    path_6.cubicTo(size.width * 0.8636489, size.height * 0.2372132, size.width * 0.8626105, size.height * 0.2361872,
        size.width * 0.8611436, size.height * 0.2356534);
    path_6.cubicTo(size.width * 0.8596590, size.height * 0.2351131, size.width * 0.8579870, size.height * 0.2351207,
        size.width * 0.8560695, size.height * 0.2351207);
    path_6.cubicTo(size.width * 0.8541800, size.height * 0.2351207, size.width * 0.8526962, size.height * 0.2339691,
        size.width * 0.8509953, size.height * 0.2345881);
    path_6.cubicTo(size.width * 0.8486040, size.height * 0.2354583, size.width * 0.8483543, size.height * 0.2364239,
        size.width * 0.8466530, size.height * 0.2382813);
    path_6.cubicTo(size.width * 0.8458941, size.height * 0.2391098, size.width * 0.8440634, size.height * 0.2418455,
        size.width * 0.8426767, size.height * 0.2414418);
    path_6.cubicTo(size.width * 0.8407363, size.height * 0.2408769, size.width * 0.8397088, size.height * 0.2408472,
        size.width * 0.8383343, size.height * 0.2393466);
    path_6.cubicTo(size.width * 0.8373333, size.height * 0.2382537, size.width * 0.8359625, size.height * 0.2366102,
        size.width * 0.8346995, size.height * 0.2361506);
    path_6.cubicTo(size.width * 0.8334426, size.height * 0.2356932, size.width * 0.8318770, size.height * 0.2356534,
        size.width * 0.8303571, size.height * 0.2356534);
    path_6.cubicTo(size.width * 0.8287840, size.height * 0.2356534, size.width * 0.8263833, size.height * 0.2350815,
        size.width * 0.8252830, size.height * 0.2366832);
    path_6.cubicTo(size.width * 0.8241284, size.height * 0.2383640, size.width * 0.8240108, size.height * 0.2401686,
        size.width * 0.8227703, size.height * 0.2419744);
    path_6.cubicTo(size.width * 0.8218645, size.height * 0.2432930, size.width * 0.8207871, size.height * 0.2448258,
        size.width * 0.8195013, size.height * 0.2466974);
    path_6.cubicTo(size.width * 0.8185163, size.height * 0.2481314, size.width * 0.8171960, size.height * 0.2484554,
        size.width * 0.8158665, size.height * 0.2503906);
    path_6.cubicTo(size.width * 0.8148953, size.height * 0.2518045, size.width * 0.8140598, size.height * 0.2527710,
        size.width * 0.8122560, size.height * 0.2540838);
    path_6.cubicTo(size.width * 0.8110895, size.height * 0.2549328, size.width * 0.8091364, size.height * 0.2559973,
        size.width * 0.8082796, size.height * 0.2572443);
    path_6.cubicTo(size.width * 0.8070295, size.height * 0.2590641, size.width * 0.8059057, size.height * 0.2590283,
        size.width * 0.8046448, size.height * 0.2604048);
    path_6.cubicTo(size.width * 0.8033223, size.height * 0.2618487, size.width * 0.8013291, size.height * 0.2630845,
        size.width * 0.7999366, size.height * 0.2640980);
    path_6.cubicTo(size.width * 0.7988928, size.height * 0.2648577, size.width * 0.7964249, size.height * 0.2671613,
        size.width * 0.7952283, size.height * 0.2667259);
    path_6.cubicTo(size.width * 0.7944061, size.height * 0.2664266, size.width * 0.7914191, size.height * 0.2653258,
        size.width * 0.7901786, size.height * 0.2662287);
    path_6.cubicTo(size.width * 0.7889064, size.height * 0.2671546, size.width * 0.7879031, size.height * 0.2683998,
        size.width * 0.7865437, size.height * 0.2693892);
    path_6.cubicTo(size.width * 0.7850105, size.height * 0.2705052, size.width * 0.7840959, size.height * 0.2708572,
        size.width * 0.7829333, size.height * 0.2725497);
    path_6.cubicTo(size.width * 0.7820629, size.height * 0.2738166, size.width * 0.7805537, size.height * 0.2754453,
        size.width * 0.7792984, size.height * 0.2772727);
    path_6.cubicTo(size.width * 0.7783231, size.height * 0.2786924, size.width * 0.7771328, size.height * 0.2799074,
        size.width * 0.7756879, size.height * 0.2804332);
    path_6.cubicTo(size.width * 0.7743968, size.height * 0.2809031, size.width * 0.7726316, size.height * 0.2820313,
        size.width * 0.7709797, size.height * 0.2820313);
    path_6.cubicTo(size.width * 0.7691812, size.height * 0.2820313, size.width * 0.7673124, size.height * 0.2825698,
        size.width * 0.7659055, size.height * 0.2835937);
    path_6.cubicTo(size.width * 0.7647080, size.height * 0.2844654, size.width * 0.7630998, size.height * 0.2864349,
        size.width * 0.7611973, size.height * 0.2878196);
    path_6.cubicTo(size.width * 0.7595862, size.height * 0.2889923, size.width * 0.7585804, size.height * 0.2897243,
        size.width * 0.7568550, size.height * 0.2909801);
    path_6.cubicTo(size.width * 0.7558878, size.height * 0.2916840, size.width * 0.7539893, size.height * 0.2927160,
        size.width * 0.7521468, size.height * 0.2920455);
    path_6.cubicTo(size.width * 0.7509642, size.height * 0.2916151, size.width * 0.7488448, size.height * 0.2914710,
        size.width * 0.7474385, size.height * 0.2904474);
    path_6.cubicTo(size.width * 0.7460044, size.height * 0.2894037, size.width * 0.7444523, size.height * 0.2888066,
        size.width * 0.7430962, size.height * 0.2878196);
    path_6.cubicTo(size.width * 0.7424529, size.height * 0.2873514, size.width * 0.7395118, size.height * 0.2851918,
        size.width * 0.7387539, size.height * 0.2851918);
    path_6.cubicTo(size.width * 0.7369366, size.height * 0.2851918, size.width * 0.7355756, size.height * 0.2842837,
        size.width * 0.7336797, size.height * 0.2835937);
    path_6.cubicTo(size.width * 0.7322688, size.height * 0.2830803, size.width * 0.7310420, size.height * 0.2821189,
        size.width * 0.7293374, size.height * 0.2814986);
    path_6.cubicTo(size.width * 0.7279504, size.height * 0.2809938, size.width * 0.7253644, size.height * 0.2806055,
        size.width * 0.7242633, size.height * 0.2794034);
    path_6.cubicTo(size.width * 0.7226871, size.height * 0.2776826, size.width * 0.7210057, size.height * 0.2780623,
        size.width * 0.7191891, size.height * 0.2767401);
    path_6.cubicTo(size.width * 0.7179350, size.height * 0.2758272, size.width * 0.7167943, size.height * 0.2755341,
        size.width * 0.7148468, size.height * 0.2762429);
    path_6.cubicTo(size.width * 0.7132308, size.height * 0.2768310, size.width * 0.7124288, size.height * 0.2777709,
        size.width * 0.7108704, size.height * 0.2783381);
    path_6.cubicTo(size.width * 0.7090813, size.height * 0.2789892, size.width * 0.7083419, size.height * 0.2790070,
        size.width * 0.7065037, size.height * 0.2783381);
    path_6.cubicTo(size.width * 0.7049905, size.height * 0.2777874, size.width * 0.7025821, size.height * 0.2772506,
        size.width * 0.7010880, size.height * 0.2783381);
    path_6.cubicTo(size.width * 0.7003956, size.height * 0.2788421, size.width * 0.6978800, size.height * 0.2819114,
        size.width * 0.6967457, size.height * 0.2814986);
    path_6.cubicTo(size.width * 0.6951658, size.height * 0.2809236, size.width * 0.6931751, size.height * 0.2797529,
        size.width * 0.6913056, size.height * 0.2804332);
    path_6.cubicTo(size.width * 0.6894107, size.height * 0.2811229, size.width * 0.6878024, size.height * 0.2818590,
        size.width * 0.6858655, size.height * 0.2825639);
    path_6.cubicTo(size.width * 0.6849455, size.height * 0.2828987, size.width * 0.6817036, size.height * 0.2841414,
        size.width * 0.6815232, size.height * 0.2851918);
    path_6.cubicTo(size.width * 0.6812424, size.height * 0.2868268, size.width * 0.6809145, size.height * 0.2895766,
        size.width * 0.6797180, size.height * 0.2904474);
    path_6.cubicTo(size.width * 0.6781847, size.height * 0.2915635, size.width * 0.6777663, size.height * 0.2918413,
        size.width * 0.6757416, size.height * 0.2925781);
    path_6.cubicTo(size.width * 0.6740490, size.height * 0.2931941, size.width * 0.6721911, size.height * 0.2931108,
        size.width * 0.6703015, size.height * 0.2931108);
    path_6.cubicTo(size.width * 0.6688253, size.height * 0.2931108, size.width * 0.6659970, size.height * 0.2940212,
        size.width * 0.6648614, size.height * 0.2936080);
    path_6.cubicTo(size.width * 0.6639280, size.height * 0.2932683, size.width * 0.6611537, size.height * 0.2925781,
        size.width * 0.6601532, size.height * 0.2925781);
    path_6.cubicTo(size.width * 0.6580389, size.height * 0.2925781, size.width * 0.6564007, size.height * 0.2909801,
        size.width * 0.6543716, size.height * 0.2909801);
    path_6.cubicTo(size.width * 0.6521967, size.height * 0.2909801, size.width * 0.6510538, size.height * 0.2905895,
        size.width * 0.6492974, size.height * 0.2899503);
    path_6.cubicTo(size.width * 0.6480253, size.height * 0.2894873, size.width * 0.6469895, size.height * 0.2877610,
        size.width * 0.6456870, size.height * 0.2872869);
    path_6.cubicTo(size.width * 0.6440717, size.height * 0.2866991, size.width * 0.6432193, size.height * 0.2864155,
        size.width * 0.6413203, size.height * 0.2857244);
    path_6.cubicTo(size.width * 0.6398530, size.height * 0.2851904, size.width * 0.6374075, size.height * 0.2853392,
        size.width * 0.6355386, size.height * 0.2846591);
    path_6.cubicTo(size.width * 0.6328137, size.height * 0.2836674, size.width * 0.6328580, size.height * 0.2833618,
        size.width * 0.6322697, size.height * 0.2799361);
    path_6.cubicTo(size.width * 0.6318105, size.height * 0.2772620, size.width * 0.6317387, size.height * 0.2743096,
        size.width * 0.6297326, size.height * 0.2735795);
    path_6.cubicTo(size.width * 0.6279380, size.height * 0.2729264, size.width * 0.6270574, size.height * 0.2727508,
        size.width * 0.6257562, size.height * 0.2746449);
    path_6.cubicTo(size.width * 0.6255797, size.height * 0.2749019, size.width * 0.6234965, size.height * 0.2778465,
        size.width * 0.6221458, size.height * 0.2783381);
    path_6.cubicTo(size.width * 0.6209133, size.height * 0.2787866, size.width * 0.6184038, size.height * 0.2813176,
        size.width * 0.6174375, size.height * 0.2809659);
    path_6.cubicTo(size.width * 0.6161804, size.height * 0.2805084, size.width * 0.6140373, size.height * 0.2806991,
        size.width * 0.6130952, size.height * 0.2788707);
    path_6.cubicTo(size.width * 0.6121496, size.height * 0.2770354, size.width * 0.6108542, size.height * 0.2761412,
        size.width * 0.6094604, size.height * 0.2741122);
    path_6.cubicTo(size.width * 0.6087445, size.height * 0.2730701, size.width * 0.6073123, size.height * 0.2709517,
        size.width * 0.6058499, size.height * 0.2709517);
    path_6.cubicTo(size.width * 0.6039842, size.height * 0.2709517, size.width * 0.6010196, size.height * 0.2716441,
        size.width * 0.5993365, size.height * 0.2704190);
    path_6.cubicTo(size.width * 0.5987028, size.height * 0.2699578, size.width * 0.5957314, size.height * 0.2699652,
        size.width * 0.5949698, size.height * 0.2688565);
    path_6.cubicTo(size.width * 0.5941284, size.height * 0.2676317, size.width * 0.5931925, size.height * 0.2663918,
        size.width * 0.5927986, size.height * 0.2640980);
    path_6.cubicTo(size.width * 0.5925148, size.height * 0.2624455, size.width * 0.5917812, size.height * 0.2589239,
        size.width * 0.5906274, size.height * 0.2572443);
    path_6.cubicTo(size.width * 0.5899256, size.height * 0.2562227, size.width * 0.5883291, size.height * 0.2541618,
        size.width * 0.5866511, size.height * 0.2535511);
    path_6.cubicTo(size.width * 0.5850149, size.height * 0.2529557, size.width * 0.5843364, size.height * 0.2520607,
        size.width * 0.5826747, size.height * 0.2514560);
    path_6.cubicTo(size.width * 0.5812687, size.height * 0.2509443, size.width * 0.5797877, size.height * 0.2498580,
        size.width * 0.5779664, size.height * 0.2498580);
    path_6.cubicTo(size.width * 0.5762489, size.height * 0.2498580, size.width * 0.5741125, size.height * 0.2495025,
        size.width * 0.5728923, size.height * 0.2503906);
    path_6.cubicTo(size.width * 0.5713101, size.height * 0.2515422, size.width * 0.5709990, size.height * 0.2521241,
        size.width * 0.5699893, size.height * 0.2540838);
    path_6.cubicTo(size.width * 0.5695303, size.height * 0.2549746, size.width * 0.5676756, size.height * 0.2589031,
        size.width * 0.5663788, size.height * 0.2593750);
    path_6.cubicTo(size.width * 0.5647950, size.height * 0.2599514, size.width * 0.5640975, size.height * 0.2608444,
        size.width * 0.5623780, size.height * 0.2614702);
    path_6.cubicTo(size.width * 0.5603190, size.height * 0.2622195, size.width * 0.5601435, size.height * 0.2618750,
        size.width * 0.5587676, size.height * 0.2598722);
    path_6.cubicTo(size.width * 0.5576998, size.height * 0.2583178, size.width * 0.5566216, size.height * 0.2567839,
        size.width * 0.5554986, size.height * 0.2551491);
    path_6.cubicTo(size.width * 0.5546295, size.height * 0.2538840, size.width * 0.5535097, size.height * 0.2522941,
        size.width * 0.5522541, size.height * 0.2509233);
    path_6.cubicTo(size.width * 0.5512437, size.height * 0.2498201, size.width * 0.5487894, size.height * 0.2487909,
        size.width * 0.5482533, size.height * 0.2472301);
    path_6.cubicTo(size.width * 0.5474545, size.height * 0.2449046, size.width * 0.5461743, size.height * 0.2434344,
        size.width * 0.5457406, size.height * 0.2409091);
    path_6.cubicTo(size.width * 0.5452636, size.height * 0.2381314, size.width * 0.5457406, size.height * 0.2357590,
        size.width * 0.5457406, size.height * 0.2329901);
    path_6.cubicTo(size.width * 0.5457406, size.height * 0.2301775, size.width * 0.5453258, size.height * 0.2279820,
        size.width * 0.5450088, size.height * 0.2261364);
    path_6.cubicTo(size.width * 0.5445109, size.height * 0.2232375, size.width * 0.5438924, size.height * 0.2224161,
        size.width * 0.5428376, size.height * 0.2208807);
    path_6.cubicTo(size.width * 0.5418554, size.height * 0.2194509, size.width * 0.5410691, size.height * 0.2188255,
        size.width * 0.5395687, size.height * 0.2171875);
    path_6.cubicTo(size.width * 0.5389516, size.height * 0.2165138, size.width * 0.5369725, size.height * 0.2136159,
        size.width * 0.5355923, size.height * 0.2156250);
    path_6.cubicTo(size.width * 0.5346232, size.height * 0.2170357, size.width * 0.5336839, size.height * 0.2181572,
        size.width * 0.5319575, size.height * 0.2187855);
    path_6.cubicTo(size.width * 0.5306473, size.height * 0.2192623, size.width * 0.5285811, size.height * 0.2186737,
        size.width * 0.5269077, size.height * 0.2192827);
    path_6.cubicTo(size.width * 0.5254555, size.height * 0.2198111, size.width * 0.5242001, size.height * 0.2208095,
        size.width * 0.5225410, size.height * 0.2214134);
    path_6.cubicTo(size.width * 0.5209849, size.height * 0.2219796, size.width * 0.5190423, size.height * 0.2235085,
        size.width * 0.5178571, size.height * 0.2235085);
    path_6.cubicTo(size.width * 0.5157952, size.height * 0.2235085, size.width * 0.5146674, size.height * 0.2229958,
        size.width * 0.5131489, size.height * 0.2224432);
    path_6.cubicTo(size.width * 0.5114391, size.height * 0.2218209, size.width * 0.5102460, size.height * 0.2203480,
        size.width * 0.5087822, size.height * 0.2198153);
    path_6.cubicTo(size.width * 0.5072765, size.height * 0.2192674, size.width * 0.5061384, size.height * 0.2186901,
        size.width * 0.5048058, size.height * 0.2177202);
    path_6.cubicTo(size.width * 0.5037764, size.height * 0.2169709, size.width * 0.5017401, size.height * 0.2164179,
        size.width * 0.5008294, size.height * 0.2150923);
    path_6.cubicTo(size.width * 0.4994473, size.height * 0.2130803, size.width * 0.4989768, size.height * 0.2118629,
        size.width * 0.4979264, size.height * 0.2103338);
    path_6.cubicTo(size.width * 0.4972102, size.height * 0.2092912, size.width * 0.4960824, size.height * 0.2074803,
        size.width * 0.4957553, size.height * 0.2055753);
    path_6.cubicTo(size.width * 0.4954092, size.height * 0.2035602, size.width * 0.4943458, size.height * 0.2010261,
        size.width * 0.4939500, size.height * 0.1987216);
    path_6.cubicTo(size.width * 0.4935446, size.height * 0.1963605, size.width * 0.4924741, size.height * 0.1945670,
        size.width * 0.4932182, size.height * 0.1924006);
    path_6.cubicTo(size.width * 0.4934715, size.height * 0.1916632, size.width * 0.4955283, size.height * 0.1875494,
        size.width * 0.4950234, size.height * 0.1860795);
    path_6.cubicTo(size.width * 0.4940278, size.height * 0.1831809, size.width * 0.4930153, size.height * 0.1843516,
        size.width * 0.4910470, size.height * 0.1829190);
    path_6.cubicTo(size.width * 0.4900631, size.height * 0.1822029, size.width * 0.4884138, size.height * 0.1807800,
        size.width * 0.4870706, size.height * 0.1802912);
    path_6.cubicTo(size.width * 0.4865997, size.height * 0.1801198, size.width * 0.4860026, size.height * 0.1799843,
        size.width * 0.4854118, size.height * 0.1799716);
    path_6.close();
    Paint paint6Fill = Paint()..style = PaintingStyle.fill;
    paint6Fill.color = blackSeaColor;
    canvas.drawPath(path_6, paint6Fill);

    /// Karadeniz Bölgesi Bitiş

    /// DoğuAnadolu Bölgesi Başlangıç

    Path path_7 = Path();
    path_7.moveTo(size.width * 0.8902957, size.height * 0.2262429);
    path_7.cubicTo(size.width * 0.8895182, size.height * 0.2262430, size.width * 0.8887520, size.height * 0.2263785,
        size.width * 0.8879538, size.height * 0.2266690);
    path_7.cubicTo(size.width * 0.8868143, size.height * 0.2270837, size.width * 0.8843745, size.height * 0.2272991,
        size.width * 0.8828796, size.height * 0.2277344);
    path_7.cubicTo(size.width * 0.8803909, size.height * 0.2284589, size.width * 0.8809524, size.height * 0.2291193,
        size.width * 0.8799766, size.height * 0.2319602);
    path_7.cubicTo(size.width * 0.8792633, size.height * 0.2340369, size.width * 0.8783788, size.height * 0.2388636,
        size.width * 0.8774395, size.height * 0.2398437);
    path_7.cubicTo(size.width * 0.8756951, size.height * 0.2413674, size.width * 0.8754298, size.height * 0.2426204,
        size.width * 0.8741706, size.height * 0.2435369);
    path_7.cubicTo(size.width * 0.8741181, size.height * 0.2435751, size.width * 0.8740100, size.height * 0.2436390,
        size.width * 0.8739510, size.height * 0.2436790);
    path_7.cubicTo(size.width * 0.8746386, size.height * 0.2445113, size.width * 0.8754315, size.height * 0.2481803,
        size.width * 0.8756343, size.height * 0.2493608);
    path_7.cubicTo(size.width * 0.8761102, size.height * 0.2521322, size.width * 0.8769419, size.height * 0.2544248,
        size.width * 0.8778055, size.height * 0.2556818);
    path_7.cubicTo(size.width * 0.8785843, size.height * 0.2568158, size.width * 0.8789390, size.height * 0.2612883,
        size.width * 0.8792447, size.height * 0.2630682);
    path_7.cubicTo(size.width * 0.8797712, size.height * 0.2661340, size.width * 0.8802808, size.height * 0.2664204,
        size.width * 0.8785372, size.height * 0.2683239);
    path_7.cubicTo(size.width * 0.8772553, size.height * 0.2697236, size.width * 0.8754024, size.height * 0.2705878,
        size.width * 0.8741706, size.height * 0.2714844);
    path_7.cubicTo(size.width * 0.8726724, size.height * 0.2725748, size.width * 0.8716084, size.height * 0.2747169,
        size.width * 0.8705601, size.height * 0.2762429);
    path_7.cubicTo(size.width * 0.8694537, size.height * 0.2778535, size.width * 0.8693215, size.height * 0.2796084,
        size.width * 0.8683889, size.height * 0.2809659);
    path_7.cubicTo(size.width * 0.8669643, size.height * 0.2830399, size.width * 0.8661805, size.height * 0.2847678,
        size.width * 0.8654859, size.height * 0.2867898);
    path_7.cubicTo(size.width * 0.8648337, size.height * 0.2886885, size.width * 0.8626297, size.height * 0.2889850,
        size.width * 0.8611436, size.height * 0.2894176);
    path_7.cubicTo(size.width * 0.8595472, size.height * 0.2898824, size.width * 0.8581084, size.height * 0.2904474,
        size.width * 0.8560695, size.height * 0.2904474);
    path_7.cubicTo(size.width * 0.8538383, size.height * 0.2904475, size.width * 0.8525489, size.height * 0.2918791,
        size.width * 0.8513613, size.height * 0.2936080);
    path_7.cubicTo(size.width * 0.8501931, size.height * 0.2953082, size.width * 0.8495003, size.height * 0.2958652,
        size.width * 0.8488242, size.height * 0.2978338);
    path_7.cubicTo(size.width * 0.8481151, size.height * 0.2998978, size.width * 0.8478592, size.height * 0.3027738,
        size.width * 0.8470189, size.height * 0.3052202);
    path_7.cubicTo(size.width * 0.8461660, size.height * 0.3077035, size.width * 0.8459780, size.height * 0.3093161,
        size.width * 0.8452137, size.height * 0.3115412);
    path_7.cubicTo(size.width * 0.8445126, size.height * 0.3135820, size.width * 0.8456850, size.height * 0.3168773,
        size.width * 0.8459455, size.height * 0.3183949);
    path_7.cubicTo(size.width * 0.8461009, size.height * 0.3192987, size.width * 0.8436860, size.height * 0.3222168,
        size.width * 0.8434084, size.height * 0.3226207);
    path_7.cubicTo(size.width * 0.8420413, size.height * 0.3246111, size.width * 0.8401189, size.height * 0.3233869,
        size.width * 0.8390662, size.height * 0.3226207);
    path_7.cubicTo(size.width * 0.8376008, size.height * 0.3215543, size.width * 0.8366920, size.height * 0.3203778,
        size.width * 0.8354313, size.height * 0.3194602);
    path_7.cubicTo(size.width * 0.8338862, size.height * 0.3183356, size.width * 0.8333030, size.height * 0.3178622,
        size.width * 0.8310890, size.height * 0.3178622);
    path_7.cubicTo(size.width * 0.8295400, size.height * 0.3178622, size.width * 0.8278034, size.height * 0.3202536,
        size.width * 0.8267467, size.height * 0.3210227);
    path_7.cubicTo(size.width * 0.8249507, size.height * 0.3223299, size.width * 0.8242281, size.height * 0.3233885,
        size.width * 0.8224044, size.height * 0.3247159);
    path_7.cubicTo(size.width * 0.8209854, size.height * 0.3257488, size.width * 0.8197212, size.height * 0.3257813,
        size.width * 0.8176962, size.height * 0.3257813);
    path_7.cubicTo(size.width * 0.8162029, size.height * 0.3257812, size.width * 0.8159108, size.height * 0.3222391,
        size.width * 0.8155250, size.height * 0.3199929);
    path_7.cubicTo(size.width * 0.8150558, size.height * 0.3172607, size.width * 0.8159126, size.height * 0.3144691,
        size.width * 0.8162325, size.height * 0.3126065);
    path_7.cubicTo(size.width * 0.8167068, size.height * 0.3098441, size.width * 0.8178147, size.height * 0.3091065,
        size.width * 0.8173302, size.height * 0.3062855);
    path_7.cubicTo(size.width * 0.8168609, size.height * 0.3035527, size.width * 0.8134016, size.height * 0.3064360,
        size.width * 0.8115242, size.height * 0.3057528);
    path_7.cubicTo(size.width * 0.8094690, size.height * 0.3050049, size.width * 0.8077899, size.height * 0.3056450,
        size.width * 0.8064745, size.height * 0.3046875);
    path_7.cubicTo(size.width * 0.8042570, size.height * 0.3030736, size.width * 0.8037698, size.height * 0.3029629,
        size.width * 0.8014003, size.height * 0.3046875);
    path_7.cubicTo(size.width * 0.7997995, size.height * 0.3058526, size.width * 0.7993424, size.height * 0.3072329,
        size.width * 0.7977654, size.height * 0.3083807);
    path_7.cubicTo(size.width * 0.7965577, size.height * 0.3092597, size.width * 0.7948185, size.height * 0.3120152,
        size.width * 0.7937891, size.height * 0.3131392);
    path_7.cubicTo(size.width * 0.7922106, size.height * 0.3148624, size.width * 0.7911628, size.height * 0.3153642,
        size.width * 0.7898126, size.height * 0.3173295);
    path_7.cubicTo(size.width * 0.7888429, size.height * 0.3187412, size.width * 0.7870308, size.height * 0.3192838,
        size.width * 0.7854703, size.height * 0.3215554);
    path_7.cubicTo(size.width * 0.7844587, size.height * 0.3230281, size.width * 0.7824016, size.height * 0.3237109,
        size.width * 0.7811037, size.height * 0.3241832);
    path_7.cubicTo(size.width * 0.7793796, size.height * 0.3248106, size.width * 0.7778300, size.height * 0.3262002,
        size.width * 0.7760539, size.height * 0.3268466);
    path_7.cubicTo(size.width * 0.7741611, size.height * 0.3275354, size.width * 0.7731509, size.height * 0.3275014,
        size.width * 0.7731509, size.height * 0.3310369);
    path_7.cubicTo(size.width * 0.7731508, size.height * 0.3337751, size.width * 0.7730984, size.height * 0.3365197,
        size.width * 0.7735168, size.height * 0.3389560);
    path_7.cubicTo(size.width * 0.7739534, size.height * 0.3414980, size.width * 0.7734658, size.height * 0.3444473,
        size.width * 0.7738827, size.height * 0.3468750);
    path_7.cubicTo(size.width * 0.7742838, size.height * 0.3492104, size.width * 0.7742478, size.height * 0.3517349,
        size.width * 0.7745902, size.height * 0.3537287);
    path_7.cubicTo(size.width * 0.7751457, size.height * 0.3569634, size.width * 0.7755937, size.height * 0.3572847,
        size.width * 0.7767613, size.height * 0.3589844);
    path_7.cubicTo(size.width * 0.7777454, size.height * 0.3604168, size.width * 0.7812052, size.height * 0.3595170,
        size.width * 0.7825674, size.height * 0.3595170);
    path_7.cubicTo(size.width * 0.7846405, size.height * 0.3595171, size.width * 0.7855714, size.height * 0.3589844,
        size.width * 0.7876415, size.height * 0.3589844);
    path_7.cubicTo(size.width * 0.7884860, size.height * 0.3589844, size.width * 0.7870127, size.height * 0.3623775,
        size.width * 0.7865437, size.height * 0.3637429);
    path_7.cubicTo(size.width * 0.7857973, size.height * 0.3659158, size.width * 0.7850339, size.height * 0.3669705,
        size.width * 0.7840066, size.height * 0.3684659);
    path_7.cubicTo(size.width * 0.7831973, size.height * 0.3696441, size.width * 0.7812784, size.height * 0.3701424,
        size.width * 0.7800302, size.height * 0.3705966);
    path_7.cubicTo(size.width * 0.7785291, size.height * 0.3711429, size.width * 0.7768519, size.height * 0.3719537,
        size.width * 0.7756879, size.height * 0.3732244);
    path_7.cubicTo(size.width * 0.7741946, size.height * 0.3748548, size.width * 0.7736425, size.height * 0.3756693,
        size.width * 0.7724190, size.height * 0.3774503);
    path_7.cubicTo(size.width * 0.7713145, size.height * 0.3790580, size.width * 0.7712261, size.height * 0.3803960,
        size.width * 0.7695160, size.height * 0.3816406);
    path_7.cubicTo(size.width * 0.7680969, size.height * 0.3826735, size.width * 0.7668327, size.height * 0.3827060,
        size.width * 0.7648078, size.height * 0.3827060);
    path_7.cubicTo(size.width * 0.7629482, size.height * 0.3827060, size.width * 0.7613443, size.height * 0.3806554,
        size.width * 0.7597580, size.height * 0.3800781);
    path_7.cubicTo(size.width * 0.7583884, size.height * 0.3795797, size.width * 0.7566645, size.height * 0.3775780,
        size.width * 0.7557572, size.height * 0.3769176);
    path_7.cubicTo(size.width * 0.7541629, size.height * 0.3757572, size.width * 0.7526077, size.height * 0.3758868,
        size.width * 0.7510490, size.height * 0.3753196);
    path_7.cubicTo(size.width * 0.7493004, size.height * 0.3746833, size.width * 0.7473856, size.height * 0.3769458,
        size.width * 0.7459992, size.height * 0.3774503);
    path_7.cubicTo(size.width * 0.7445702, size.height * 0.3779703, size.width * 0.7426233, size.height * 0.3791084,
        size.width * 0.7412910, size.height * 0.3800781);
    path_7.cubicTo(size.width * 0.7391879, size.height * 0.3816088, size.width * 0.7388140, size.height * 0.3826185,
        size.width * 0.7372902, size.height * 0.3848366);
    path_7.cubicTo(size.width * 0.7357533, size.height * 0.3870738, size.width * 0.7343755, size.height * 0.3887738,
        size.width * 0.7322160, size.height * 0.3895597);
    path_7.cubicTo(size.width * 0.7305906, size.height * 0.3901512, size.width * 0.7283654, size.height * 0.3908175,
        size.width * 0.7271663, size.height * 0.3916903);
    path_7.cubicTo(size.width * 0.7252780, size.height * 0.3930647, size.width * 0.7240256, size.height * 0.3931772,
        size.width * 0.7224580, size.height * 0.3943182);
    path_7.cubicTo(size.width * 0.7213167, size.height * 0.3951489, size.width * 0.7183276, size.height * 0.3943182,
        size.width * 0.7170180, size.height * 0.3943182);
    path_7.cubicTo(size.width * 0.7150364, size.height * 0.3943182, size.width * 0.7136238, size.height * 0.3931984,
        size.width * 0.7123097, size.height * 0.3927202);
    path_7.cubicTo(size.width * 0.7107514, size.height * 0.3921530, size.width * 0.7099493, size.height * 0.3912131,
        size.width * 0.7083333, size.height * 0.3906250);
    path_7.cubicTo(size.width * 0.7071163, size.height * 0.3901821, size.width * 0.7059630, size.height * 0.3883849,
        size.width * 0.7046985, size.height * 0.3874645);
    path_7.cubicTo(size.width * 0.7031891, size.height * 0.3863659, size.width * 0.7023087, size.height * 0.3851924,
        size.width * 0.7010880, size.height * 0.3843040);
    path_7.cubicTo(size.width * 0.6994353, size.height * 0.3831011, size.width * 0.6985690, size.height * 0.3817025,
        size.width * 0.6974532, size.height * 0.3800781);
    path_7.cubicTo(size.width * 0.6967781, size.height * 0.3790954, size.width * 0.6945412, size.height * 0.3776923,
        size.width * 0.6934768, size.height * 0.3769176);
    path_7.cubicTo(size.width * 0.6919866, size.height * 0.3758330, size.width * 0.6905779, size.height * 0.3758523,
        size.width * 0.6887685, size.height * 0.3758523);
    path_7.cubicTo(size.width * 0.6870029, size.height * 0.3758523, size.width * 0.6854114, size.height * 0.3761280,
        size.width * 0.6838164, size.height * 0.3766335);
    path_7.cubicTo(size.width * 0.6835176, size.height * 0.3783446, size.width * 0.6832489, size.height * 0.3798127,
        size.width * 0.6826210, size.height * 0.3816406);
    path_7.cubicTo(size.width * 0.6821127, size.height * 0.3831205, size.width * 0.6810085, size.height * 0.3858665,
        size.width * 0.6789861, size.height * 0.3858665);
    path_7.cubicTo(size.width * 0.6765334, size.height * 0.3858665, size.width * 0.6761366, size.height * 0.3867881,
        size.width * 0.6742779, size.height * 0.3874645);
    path_7.cubicTo(size.width * 0.6721553, size.height * 0.3882370, size.width * 0.6710938, size.height * 0.3888402,
        size.width * 0.6692037, size.height * 0.3874645);
    path_7.cubicTo(size.width * 0.6685686, size.height * 0.3870022, size.width * 0.6650206, size.height * 0.3840163,
        size.width * 0.6645199, size.height * 0.3869318);
    path_7.cubicTo(size.width * 0.6642386, size.height * 0.3885698, size.width * 0.6639897, size.height * 0.3913613,
        size.width * 0.6630562, size.height * 0.3927202);
    path_7.cubicTo(size.width * 0.6626887, size.height * 0.3932551, size.width * 0.6594876, size.height * 0.3964134,
        size.width * 0.6619828, size.height * 0.3964134);
    path_7.cubicTo(size.width * 0.6632925, size.height * 0.3964134, size.width * 0.6662572, size.height * 0.3955827,
        size.width * 0.6673985, size.height * 0.3964134);
    path_7.cubicTo(size.width * 0.6679970, size.height * 0.3968490, size.width * 0.6724554, size.height * 0.3991019,
        size.width * 0.6713993, size.height * 0.4006392);
    path_7.cubicTo(size.width * 0.6704667, size.height * 0.4019967, size.width * 0.6692368, size.height * 0.4021891,
        size.width * 0.6681304, size.height * 0.4037997);
    path_7.cubicTo(size.width * 0.6674120, size.height * 0.4048454, size.width * 0.6652229, size.height * 0.4088101,
        size.width * 0.6641540, size.height * 0.4095881);
    path_7.cubicTo(size.width * 0.6623592, size.height * 0.4108944, size.width * 0.6626246, size.height * 0.4123470,
        size.width * 0.6612510, size.height * 0.4143466);
    path_7.cubicTo(size.width * 0.6602038, size.height * 0.4158710, size.width * 0.6591383, size.height * 0.4184301,
        size.width * 0.6594457, size.height * 0.4206676);
    path_7.cubicTo(size.width * 0.6598056, size.height * 0.4232870, size.width * 0.6601532, size.height * 0.4256914,
        size.width * 0.6601532, size.height * 0.4280540);
    path_7.cubicTo(size.width * 0.6601532, size.height * 0.4305477, size.width * 0.6601532, size.height * 0.4324638,
        size.width * 0.6601532, size.height * 0.4349077);
    path_7.cubicTo(size.width * 0.6601532, size.height * 0.4377473, size.width * 0.6601215, size.height * 0.4399786,
        size.width * 0.6605191, size.height * 0.4422940);
    path_7.cubicTo(size.width * 0.6609364, size.height * 0.4447239, size.width * 0.6612737, size.height * 0.4471494,
        size.width * 0.6616169, size.height * 0.4491477);
    path_7.cubicTo(size.width * 0.6621151, size.height * 0.4520487, size.width * 0.6623244, size.height * 0.4537562,
        size.width * 0.6623244, size.height * 0.4570313);
    path_7.cubicTo(size.width * 0.6623244, size.height * 0.4593647, size.width * 0.6622585, size.height * 0.4618856,
        size.width * 0.6612510, size.height * 0.4633523);
    path_7.cubicTo(size.width * 0.6597742, size.height * 0.4655020, size.width * 0.6598412, size.height * 0.4643961,
        size.width * 0.6576161, size.height * 0.4660156);
    path_7.cubicTo(size.width * 0.6564490, size.height * 0.4668651, size.width * 0.6547187, size.height * 0.4674655,
        size.width * 0.6536397, size.height * 0.4686435);
    path_7.cubicTo(size.width * 0.6521594, size.height * 0.4702596, size.width * 0.6501351, size.height * 0.4718040,
        size.width * 0.6482240, size.height * 0.4718040);
    path_7.cubicTo(size.width * 0.6461835, size.height * 0.4718040, size.width * 0.6445373, size.height * 0.4713468,
        size.width * 0.6431499, size.height * 0.4733665);
    path_7.cubicTo(size.width * 0.6425476, size.height * 0.4742432, size.width * 0.6399412, size.height * 0.4779244,
        size.width * 0.6391491, size.height * 0.4770597);
    path_7.cubicTo(size.width * 0.6386663, size.height * 0.4765325, size.width * 0.6381926, size.height * 0.4760243,
        size.width * 0.6377098, size.height * 0.4754972);
    path_7.cubicTo(size.width * 0.6364987, size.height * 0.4763786, size.width * 0.6355024, size.height * 0.4768996,
        size.width * 0.6340993, size.height * 0.4781250);
    path_7.cubicTo(size.width * 0.6321049, size.height * 0.4798670, size.width * 0.6311084, size.height * 0.4802202,
        size.width * 0.6282933, size.height * 0.4802202);
    path_7.cubicTo(size.width * 0.6264461, size.height * 0.4802202, size.width * 0.6249947, size.height * 0.4803692,
        size.width * 0.6232192, size.height * 0.4797230);
    path_7.cubicTo(size.width * 0.6226614, size.height * 0.4795200, size.width * 0.6182819, size.height * 0.4778214,
        size.width * 0.6188769, size.height * 0.4812855);
    path_7.cubicTo(size.width * 0.6193055, size.height * 0.4837814, size.width * 0.6196041, size.height * 0.4855335,
        size.width * 0.6203162, size.height * 0.4876065);
    path_7.cubicTo(size.width * 0.6212144, size.height * 0.4902217, size.width * 0.6217798, size.height * 0.4901569,
        size.width * 0.6217799, size.height * 0.4939276);
    path_7.cubicTo(size.width * 0.6217799, size.height * 0.4973543, size.width * 0.6215748, size.height * 0.4981822,
        size.width * 0.6206821, size.height * 0.5007812);
    path_7.cubicTo(size.width * 0.6200091, size.height * 0.5027405, size.width * 0.6188812, size.height * 0.5052880,
        size.width * 0.6170716, size.height * 0.5066051);
    path_7.cubicTo(size.width * 0.6149957, size.height * 0.5081161, size.width * 0.6132225, size.height * 0.5099590,
        size.width * 0.6109241, size.height * 0.5107955);
    path_7.cubicTo(size.width * 0.6104412, size.height * 0.5109712, size.width * 0.6099432, size.height * 0.5111524,
        size.width * 0.6094604, size.height * 0.5113281);
    path_7.cubicTo(size.width * 0.6070622, size.height * 0.5122009, size.width * 0.6056235, size.height * 0.5135496,
        size.width * 0.6047521, size.height * 0.5160866);
    path_7.cubicTo(size.width * 0.6041226, size.height * 0.5179195, size.width * 0.6030048, size.height * 0.5208749,
        size.width * 0.6022151, size.height * 0.5224077);
    path_7.cubicTo(size.width * 0.6009719, size.height * 0.5248206, size.width * 0.6001586, size.height * 0.5267330,
        size.width * 0.6007758, size.height * 0.5303267);
    path_7.cubicTo(size.width * 0.6015558, size.height * 0.5348684, size.width * 0.6027038, size.height * 0.5333801,
        size.width * 0.6054840, size.height * 0.5313565);
    path_7.cubicTo(size.width * 0.6074065, size.height * 0.5299573, size.width * 0.6094464, size.height * 0.5301877,
        size.width * 0.6116315, size.height * 0.5308239);
    path_7.cubicTo(size.width * 0.6136021, size.height * 0.5313976, size.width * 0.6150497, size.height * 0.5330454,
        size.width * 0.6170716, size.height * 0.5345170);
    path_7.cubicTo(size.width * 0.6186186, size.height * 0.5356430, size.width * 0.6196754, size.height * 0.5369448,
        size.width * 0.6214139, size.height * 0.5382102);
    path_7.cubicTo(size.width * 0.6227163, size.height * 0.5391581, size.width * 0.6234694, size.height * 0.5402390,
        size.width * 0.6250244, size.height * 0.5413707);
    path_7.cubicTo(size.width * 0.6267311, size.height * 0.5426130, size.width * 0.6272508, size.height * 0.5432398,
        size.width * 0.6290252, size.height * 0.5445313);
    path_7.cubicTo(size.width * 0.6302332, size.height * 0.5454105, size.width * 0.6310260, size.height * 0.5470855,
        size.width * 0.6304645, size.height * 0.5503551);
    path_7.cubicTo(size.width * 0.6300764, size.height * 0.5526149, size.width * 0.6298530, size.height * 0.5550519,
        size.width * 0.6293911, size.height * 0.5577415);
    path_7.cubicTo(size.width * 0.6290368, size.height * 0.5598047, size.width * 0.6286617, size.height * 0.5629545,
        size.width * 0.6279274, size.height * 0.5650923);
    path_7.cubicTo(size.width * 0.6273806, size.height * 0.5666841, size.width * 0.6261473, size.height * 0.5702020,
        size.width * 0.6257562, size.height * 0.5724787);
    path_7.cubicTo(size.width * 0.6252967, size.height * 0.5751545, size.width * 0.6247790, size.height * 0.5769217,
        size.width * 0.6239510, size.height * 0.5793324);
    path_7.cubicTo(size.width * 0.6232680, size.height * 0.5813210, size.width * 0.6230745, size.height * 0.5843835,
        size.width * 0.6221458, size.height * 0.5861861);
    path_7.cubicTo(size.width * 0.6211830, size.height * 0.5880548, size.width * 0.6206876, size.height * 0.5898988,
        size.width * 0.6199746, size.height * 0.5919744);
    path_7.cubicTo(size.width * 0.6193356, size.height * 0.5938348, size.width * 0.6177882, size.height * 0.5967208,
        size.width * 0.6206821, size.height * 0.5956676);
    path_7.cubicTo(size.width * 0.6225938, size.height * 0.5949719, size.width * 0.6243000, size.height * 0.5948986,
        size.width * 0.6261222, size.height * 0.5935724);
    path_7.cubicTo(size.width * 0.6277180, size.height * 0.5924109, size.width * 0.6287092, size.height * 0.5911568,
        size.width * 0.6304645, size.height * 0.5898793);
    path_7.cubicTo(size.width * 0.6318806, size.height * 0.5888486, size.width * 0.6332896, size.height * 0.5886613,
        size.width * 0.6351727, size.height * 0.5893466);
    path_7.cubicTo(size.width * 0.6361445, size.height * 0.5897003, size.width * 0.6387197, size.height * 0.5904350,
        size.width * 0.6402469, size.height * 0.5898793);
    path_7.cubicTo(size.width * 0.6423820, size.height * 0.5891022, size.width * 0.6431684, size.height * 0.5890846,
        size.width * 0.6449551, size.height * 0.5877841);
    path_7.cubicTo(size.width * 0.6460077, size.height * 0.5870180, size.width * 0.6482379, size.height * 0.5852755,
        size.width * 0.6500293, size.height * 0.5846236);
    path_7.cubicTo(size.width * 0.6519317, size.height * 0.5839313, size.width * 0.6523089, size.height * 0.5826271,
        size.width * 0.6518345, size.height * 0.5798651);
    path_7.cubicTo(size.width * 0.6515295, size.height * 0.5780894, size.width * 0.6515580, size.height * 0.5751298,
        size.width * 0.6511027, size.height * 0.5724787);
    path_7.cubicTo(size.width * 0.6508272, size.height * 0.5708748, size.width * 0.6491200, size.height * 0.5674167,
        size.width * 0.6492974, size.height * 0.5672230);
    path_7.cubicTo(size.width * 0.6503958, size.height * 0.5660238, size.width * 0.6523248, size.height * 0.5652859,
        size.width * 0.6540057, size.height * 0.5640625);
    path_7.cubicTo(size.width * 0.6552198, size.height * 0.5631788, size.width * 0.6569362, size.height * 0.5615489,
        size.width * 0.6587139, size.height * 0.5609020);
    path_7.cubicTo(size.width * 0.6606769, size.height * 0.5601876, size.width * 0.6624282, size.height * 0.5589975,
        size.width * 0.6641540, size.height * 0.5577415);
    path_7.cubicTo(size.width * 0.6655995, size.height * 0.5566894, size.width * 0.6682289, size.height * 0.5545455,
        size.width * 0.6699356, size.height * 0.5545455);
    path_7.cubicTo(size.width * 0.6719142, size.height * 0.5545455, size.width * 0.6749092, size.height * 0.5543409,
        size.width * 0.6735705, size.height * 0.5582386);
    path_7.cubicTo(size.width * 0.6735552, size.height * 0.5582829, size.width * 0.6710465, size.height * 0.5632908,
        size.width * 0.6721068, size.height * 0.5640625);
    path_7.cubicTo(size.width * 0.6729871, size.height * 0.5647033, size.width * 0.6748405, size.height * 0.5653786,
        size.width * 0.6757416, size.height * 0.5666903);
    path_7.cubicTo(size.width * 0.6768378, size.height * 0.5682860, size.width * 0.6783742, size.height * 0.5687855,
        size.width * 0.6804498, size.height * 0.5687855);
    path_7.cubicTo(size.width * 0.6821442, size.height * 0.5687855, size.width * 0.6842102, size.height * 0.5692674,
        size.width * 0.6858655, size.height * 0.5687855);
    path_7.cubicTo(size.width * 0.6878042, size.height * 0.5682211, size.width * 0.6898469, size.height * 0.5673544,
        size.width * 0.6916715, size.height * 0.5666903);
    path_7.cubicTo(size.width * 0.6934204, size.height * 0.5660539, size.width * 0.6939489, size.height * 0.5647664,
        size.width * 0.6956479, size.height * 0.5635298);
    path_7.cubicTo(size.width * 0.6975889, size.height * 0.5621171, size.width * 0.6985500, size.height * 0.5614005,
        size.width * 0.6999902, size.height * 0.5593040);
    path_7.cubicTo(size.width * 0.7006911, size.height * 0.5582838, size.width * 0.7017955, size.height * 0.5563697,
        size.width * 0.7017955, size.height * 0.5540483);
    path_7.cubicTo(size.width * 0.7017955, size.height * 0.5512767, size.width * 0.7018213, size.height * 0.5488007,
        size.width * 0.7014539, size.height * 0.5466619);
    path_7.cubicTo(size.width * 0.7011028, size.height * 0.5446171, size.width * 0.7011217, size.height * 0.5434803,
        size.width * 0.7039910, size.height * 0.5424361);
    path_7.cubicTo(size.width * 0.7052407, size.height * 0.5419813, size.width * 0.7081968, size.height * 0.5402238,
        size.width * 0.7097726, size.height * 0.5413707);
    path_7.cubicTo(size.width * 0.7104141, size.height * 0.5418376, size.width * 0.7123638, size.height * 0.5449111,
        size.width * 0.7134075, size.height * 0.5445313);
    path_7.cubicTo(size.width * 0.7147529, size.height * 0.5440416, size.width * 0.7173473, size.height * 0.5440519,
        size.width * 0.7184573, size.height * 0.5424361);
    path_7.cubicTo(size.width * 0.7193315, size.height * 0.5411634, size.width * 0.7207513, size.height * 0.5397635,
        size.width * 0.7220921, size.height * 0.5392756);
    path_7.cubicTo(size.width * 0.7232721, size.height * 0.5388461, size.width * 0.7255716, size.height * 0.5389139,
        size.width * 0.7268004, size.height * 0.5398082);
    path_7.cubicTo(size.width * 0.7278822, size.height * 0.5405956, size.width * 0.7290468, size.height * 0.5423990,
        size.width * 0.7311427, size.height * 0.5408736);
    path_7.cubicTo(size.width * 0.7326124, size.height * 0.5398038, size.width * 0.7337933, size.height * 0.5385776,
        size.width * 0.7351190, size.height * 0.5366477);
    path_7.cubicTo(size.width * 0.7362235, size.height * 0.5350400, size.width * 0.7375686, size.height * 0.5324141,
        size.width * 0.7383880, size.height * 0.5308239);
    path_7.cubicTo(size.width * 0.7395597, size.height * 0.5285497, size.width * 0.7403009, size.height * 0.5278446,
        size.width * 0.7427303, size.height * 0.5287287);
    path_7.cubicTo(size.width * 0.7439445, size.height * 0.5291706, size.width * 0.7456400, size.height * 0.5298054,
        size.width * 0.7470726, size.height * 0.5303267);
    path_7.cubicTo(size.width * 0.7487514, size.height * 0.5309376, size.width * 0.7496510, size.height * 0.5313565,
        size.width * 0.7517808, size.height * 0.5313565);
    path_7.cubicTo(size.width * 0.7537720, size.height * 0.5313565, size.width * 0.7551823, size.height * 0.5330306,
        size.width * 0.7568550, size.height * 0.5324219);
    path_7.cubicTo(size.width * 0.7585976, size.height * 0.5317877, size.width * 0.7604402, size.height * 0.5318984,
        size.width * 0.7619292, size.height * 0.5313565);
    path_7.cubicTo(size.width * 0.7633535, size.height * 0.5308382, size.width * 0.7646935, size.height * 0.5303683,
        size.width * 0.7662715, size.height * 0.5297940);
    path_7.cubicTo(size.width * 0.7669311, size.height * 0.5295540, size.width * 0.7706122, size.height * 0.5287334,
        size.width * 0.7709797, size.height * 0.5276634);
    path_7.cubicTo(size.width * 0.7717876, size.height * 0.5253114, size.width * 0.7711077, size.height * 0.5252835,
        size.width * 0.7706138, size.height * 0.5224077);
    path_7.cubicTo(size.width * 0.7703647, size.height * 0.5209575, size.width * 0.7691655, size.height * 0.5171520,
        size.width * 0.7720531, size.height * 0.5171520);
    path_7.cubicTo(size.width * 0.7738820, size.height * 0.5171520, size.width * 0.7757109, size.height * 0.5175332,
        size.width * 0.7774932, size.height * 0.5181818);
    path_7.cubicTo(size.width * 0.7791514, size.height * 0.5187853, size.width * 0.7803169, size.height * 0.5185613,
        size.width * 0.7822014, size.height * 0.5192472);
    path_7.cubicTo(size.width * 0.7832630, size.height * 0.5196335, size.width * 0.7857001, size.height * 0.5203125,
        size.width * 0.7869096, size.height * 0.5203125);
    path_7.cubicTo(size.width * 0.7887534, size.height * 0.5203125, size.width * 0.7899005, size.height * 0.5197798,
        size.width * 0.7919838, size.height * 0.5197798);
    path_7.cubicTo(size.width * 0.7944353, size.height * 0.5197798, size.width * 0.7952177, size.height * 0.5184914,
        size.width * 0.7970579, size.height * 0.5171520);
    path_7.cubicTo(size.width * 0.7990451, size.height * 0.5157057, size.width * 0.8003850, size.height * 0.5149790,
        size.width * 0.8024737, size.height * 0.5134588);
    path_7.cubicTo(size.width * 0.8037280, size.height * 0.5125458, size.width * 0.8051316, size.height * 0.5112757,
        size.width * 0.8064745, size.height * 0.5102983);
    path_7.cubicTo(size.width * 0.8070018, size.height * 0.5099145, size.width * 0.8103759, size.height * 0.5063204,
        size.width * 0.8111583, size.height * 0.5066051);
    path_7.cubicTo(size.width * 0.8125046, size.height * 0.5070951, size.width * 0.8138589, size.height * 0.5100915,
        size.width * 0.8144272, size.height * 0.5102983);
    path_7.cubicTo(size.width * 0.8164927, size.height * 0.5110500, size.width * 0.8167396, size.height * 0.5125636,
        size.width * 0.8180621, size.height * 0.5144886);
    path_7.cubicTo(size.width * 0.8198957, size.height * 0.5171579, size.width * 0.8171681, size.height * 0.5177456,
        size.width * 0.8184036, size.height * 0.5213423);
    path_7.cubicTo(size.width * 0.8193405, size.height * 0.5240700, size.width * 0.8199437, size.height * 0.5243685,
        size.width * 0.8224044, size.height * 0.5234730);
    path_7.cubicTo(size.width * 0.8237858, size.height * 0.5229703, size.width * 0.8247316, size.height * 0.5211417,
        size.width * 0.8267467, size.height * 0.5218750);
    path_7.cubicTo(size.width * 0.8286842, size.height * 0.5225801, size.width * 0.8295440, size.height * 0.5221357,
        size.width * 0.8303571, size.height * 0.5245028);
    path_7.cubicTo(size.width * 0.8311824, size.height * 0.5269057, size.width * 0.8321624, size.height * 0.5296356,
        size.width * 0.8321624, size.height * 0.5324219);
    path_7.cubicTo(size.width * 0.8321624, size.height * 0.5350656, size.width * 0.8332602, size.height * 0.5362173,
        size.width * 0.8332601, size.height * 0.5387429);
    path_7.cubicTo(size.width * 0.8332601, size.height * 0.5413786, size.width * 0.8332602, size.height * 0.5440262,
        size.width * 0.8332601, size.height * 0.5466619);
    path_7.cubicTo(size.width * 0.8332601, size.height * 0.5489868, size.width * 0.8334440, size.height * 0.5524527,
        size.width * 0.8339920, size.height * 0.5540483);
    path_7.cubicTo(size.width * 0.8347858, size.height * 0.5563592, size.width * 0.8360760, size.height * 0.5570528,
        size.width * 0.8379684, size.height * 0.5577415);
    path_7.cubicTo(size.width * 0.8396953, size.height * 0.5583699, size.width * 0.8411204, size.height * 0.5592703,
        size.width * 0.8426767, size.height * 0.5598366);
    path_7.cubicTo(size.width * 0.8438632, size.height * 0.5602684, size.width * 0.8461627, size.height * 0.5597914,
        size.width * 0.8477508, size.height * 0.5603693);
    path_7.cubicTo(size.width * 0.8485205, size.height * 0.5606494, size.width * 0.8520875, size.height * 0.5630052,
        size.width * 0.8528250, size.height * 0.5619318);
    path_7.cubicTo(size.width * 0.8529628, size.height * 0.5617311, size.width * 0.8542973, size.height * 0.5597885,
        size.width * 0.8553621, size.height * 0.5582386);
    path_7.cubicTo(size.width * 0.8560893, size.height * 0.5571800, size.width * 0.8565204, size.height * 0.5540483,
        size.width * 0.8582406, size.height * 0.5540483);
    path_7.cubicTo(size.width * 0.8593568, size.height * 0.5540483, size.width * 0.8626902, size.height * 0.5547016,
        size.width * 0.8633148, size.height * 0.5556108);
    path_7.cubicTo(size.width * 0.8634354, size.height * 0.5557865, size.width * 0.8635600, size.height * 0.5559677,
        size.width * 0.8636807, size.height * 0.5561435);
    path_7.cubicTo(size.width * 0.8652225, size.height * 0.5583878, size.width * 0.8659650, size.height * 0.5591378,
        size.width * 0.8676571, size.height * 0.5603693);
    path_7.cubicTo(size.width * 0.8688481, size.height * 0.5612361, size.width * 0.8697760, size.height * 0.5626471,
        size.width * 0.8712920, size.height * 0.5635298);
    path_7.cubicTo(size.width * 0.8729773, size.height * 0.5645112, size.width * 0.8754399, size.height * 0.5655012,
        size.width * 0.8770735, size.height * 0.5666903);
    path_7.cubicTo(size.width * 0.8790233, size.height * 0.5681095, size.width * 0.8801489, size.height * 0.5678634,
        size.width * 0.8821477, size.height * 0.5693182);
    path_7.cubicTo(size.width * 0.8839855, size.height * 0.5706558, size.width * 0.8851496, size.height * 0.5715927,
        size.width * 0.8864901, size.height * 0.5735440);
    path_7.cubicTo(size.width * 0.8868369, size.height * 0.5740489, size.width * 0.8891934, size.height * 0.5770289,
        size.width * 0.8904664, size.height * 0.5756392);
    path_7.cubicTo(size.width * 0.8906844, size.height * 0.5754012, size.width * 0.8935490, size.height * 0.5703158,
        size.width * 0.8937354, size.height * 0.5703835);
    path_7.cubicTo(size.width * 0.8947561, size.height * 0.5707550, size.width * 0.8969316, size.height * 0.5727802,
        size.width * 0.8980777, size.height * 0.5719460);
    path_7.cubicTo(size.width * 0.9003525, size.height * 0.5702904, size.width * 0.9011032, size.height * 0.5715585,
        size.width * 0.9017126, size.height * 0.5751065);
    path_7.cubicTo(size.width * 0.9019868, size.height * 0.5767034, size.width * 0.9031970, size.height * 0.5795666,
        size.width * 0.9027859, size.height * 0.5819602);
    path_7.cubicTo(size.width * 0.9024663, size.height * 0.5838216, size.width * 0.9020813, size.height * 0.5861697,
        size.width * 0.9017126, size.height * 0.5883168);
    path_7.cubicTo(size.width * 0.9012714, size.height * 0.5908848, size.width * 0.9008311, size.height * 0.5921328,
        size.width * 0.9013466, size.height * 0.5951349);
    path_7.cubicTo(size.width * 0.9015514, size.height * 0.5963273, size.width * 0.9026855, size.height * 0.5999900,
        size.width * 0.9038837, size.height * 0.6004261);
    path_7.cubicTo(size.width * 0.9059551, size.height * 0.6011799, size.width * 0.9065912, size.height * 0.5986327,
        size.width * 0.9085919, size.height * 0.5993608);
    path_7.cubicTo(size.width * 0.9101518, size.height * 0.5999285, size.width * 0.9111681, size.height * 0.6003160,
        size.width * 0.9129343, size.height * 0.6009588);
    path_7.cubicTo(size.width * 0.9146482, size.height * 0.6015825, size.width * 0.9160433, size.height * 0.6018062,
        size.width * 0.9180084, size.height * 0.6025213);
    path_7.cubicTo(size.width * 0.9194047, size.height * 0.6030295, size.width * 0.9212507, size.height * 0.6051855,
        size.width * 0.9227166, size.height * 0.6046520);
    path_7.cubicTo(size.width * 0.9246480, size.height * 0.6039491, size.width * 0.9293885, size.height * 0.5999293,
        size.width * 0.9284982, size.height * 0.6025213);
    path_7.cubicTo(size.width * 0.9276153, size.height * 0.6050919, size.width * 0.9269509, size.height * 0.6070262,
        size.width * 0.9259611, size.height * 0.6099077);
    path_7.cubicTo(size.width * 0.9254089, size.height * 0.6115154, size.width * 0.9249439, size.height * 0.6137714,
        size.width * 0.9245219, size.height * 0.6162287);
    path_7.cubicTo(size.width * 0.9240691, size.height * 0.6188650, size.width * 0.9237900, size.height * 0.6203927,
        size.width * 0.9237900, size.height * 0.6236151);
    path_7.cubicTo(size.width * 0.9237900, size.height * 0.6260190, size.width * 0.9241559, size.height * 0.6289554,
        size.width * 0.9241560, size.height * 0.6310014);
    path_7.cubicTo(size.width * 0.9241560, size.height * 0.6335695, size.width * 0.9240986, size.height * 0.6364560,
        size.width * 0.9245219, size.height * 0.6389205);
    path_7.cubicTo(size.width * 0.9247742, size.height * 0.6403902, size.width * 0.9253153, size.height * 0.6432359,
        size.width * 0.9263271, size.height * 0.6447088);
    path_7.cubicTo(size.width * 0.9276637, size.height * 0.6466545, size.width * 0.9282411, size.height * 0.6484853,
        size.width * 0.9295960, size.height * 0.6499645);
    path_7.cubicTo(size.width * 0.9308345, size.height * 0.6513166, size.width * 0.9323777, size.height * 0.6526279,
        size.width * 0.9343043, size.height * 0.6526278);
    path_7.cubicTo(size.width * 0.9361149, size.height * 0.6526278, size.width * 0.9379093, size.height * 0.6526279,
        size.width * 0.9397199, size.height * 0.6526278);
    path_7.cubicTo(size.width * 0.9416818, size.height * 0.6526278, size.width * 0.9431049, size.height * 0.6527099,
        size.width * 0.9447941, size.height * 0.6520952);
    path_7.cubicTo(size.width * 0.9458785, size.height * 0.6517005, size.width * 0.9491224, size.height * 0.6510503,
        size.width * 0.9502342, size.height * 0.6494318);
    path_7.cubicTo(size.width * 0.9513364, size.height * 0.6478274, size.width * 0.9524810, size.height * 0.6459677,
        size.width * 0.9542106, size.height * 0.6447088);
    path_7.cubicTo(size.width * 0.9559393, size.height * 0.6434506, size.width * 0.9578495, size.height * 0.6441761,
        size.width * 0.9600165, size.height * 0.6441761);
    path_7.cubicTo(size.width * 0.9622114, size.height * 0.6441761, size.width * 0.9631531, size.height * 0.6440582,
        size.width * 0.9647248, size.height * 0.6457741);
    path_7.cubicTo(size.width * 0.9652899, size.height * 0.6463910, size.width * 0.9679694, size.height * 0.6492759,
        size.width * 0.9679694, size.height * 0.6504972);
    path_7.cubicTo(size.width * 0.9679694, size.height * 0.6526255, size.width * 0.9679182, size.height * 0.6558628,
        size.width * 0.9668960, size.height * 0.6573509);
    path_7.cubicTo(size.width * 0.9656324, size.height * 0.6591903, size.width * 0.9643589, size.height * 0.6604540,
        size.width * 0.9643589, size.height * 0.6636719);
    path_7.cubicTo(size.width * 0.9643589, size.height * 0.6663022, size.width * 0.9643039, size.height * 0.6688384,
        size.width * 0.9650664, size.height * 0.6710582);
    path_7.cubicTo(size.width * 0.9657918, size.height * 0.6731702, size.width * 0.9666998, size.height * 0.6746264,
        size.width * 0.9683353, size.height * 0.6758168);
    path_7.cubicTo(size.width * 0.9686040, size.height * 0.6760123, size.width * 0.9714927, size.height * 0.6791040,
        size.width * 0.9726776, size.height * 0.6773793);
    path_7.cubicTo(size.width * 0.9735829, size.height * 0.6760614, size.width * 0.9732116, size.height * 0.6729088,
        size.width * 0.9741169, size.height * 0.6715909);
    path_7.cubicTo(size.width * 0.9750205, size.height * 0.6702756, size.width * 0.9760970, size.height * 0.6692411,
        size.width * 0.9773858, size.height * 0.6673651);
    path_7.cubicTo(size.width * 0.9782742, size.height * 0.6660719, size.width * 0.9795116, size.height * 0.6653360,
        size.width * 0.9806548, size.height * 0.6636719);
    path_7.cubicTo(size.width * 0.9816233, size.height * 0.6622620, size.width * 0.9830835, size.height * 0.6608389,
        size.width * 0.9842653, size.height * 0.6599787);
    path_7.cubicTo(size.width * 0.9850939, size.height * 0.6593755, size.width * 0.9879709, size.height * 0.6564533,
        size.width * 0.9889735, size.height * 0.6568182);
    path_7.cubicTo(size.width * 0.9909093, size.height * 0.6575227, size.width * 0.9908431, size.height * 0.6598689,
        size.width * 0.9926083, size.height * 0.6605114);
    path_7.cubicTo(size.width * 0.9941169, size.height * 0.6610604, size.width * 0.9958528, size.height * 0.6614913,
        size.width * 0.9958528, size.height * 0.6578835);
    path_7.cubicTo(size.width * 0.9958528, size.height * 0.6543469, size.width * 0.9960516, size.height * 0.6541337,
        size.width * 0.9965847, size.height * 0.6510298);
    path_7.cubicTo(size.width * 0.9967232, size.height * 0.6502233, size.width * 0.9976112, size.height * 0.6451376,
        size.width * 0.9969507, size.height * 0.6441761);
    path_7.cubicTo(size.width * 0.9960646, size.height * 0.6428865, size.width * 0.9948151, size.height * 0.6410675,
        size.width * 0.9936817, size.height * 0.6394176);
    path_7.cubicTo(size.width * 0.9924308, size.height * 0.6375967, size.width * 0.9913672, size.height * 0.6365812,
        size.width * 0.9900712, size.height * 0.6346946);
    path_7.cubicTo(size.width * 0.9893940, size.height * 0.6337088, size.width * 0.9864012, size.height * 0.6324972,
        size.width * 0.9860704, size.height * 0.6315341);
    path_7.cubicTo(size.width * 0.9854624, size.height * 0.6297636, size.width * 0.9853630, size.height * 0.6277508,
        size.width * 0.9853630, size.height * 0.6246804);
    path_7.cubicTo(size.width * 0.9853630, size.height * 0.6220635, size.width * 0.9849970, size.height * 0.6191798,
        size.width * 0.9849970, size.height * 0.6167614);
    path_7.cubicTo(size.width * 0.9849970, size.height * 0.6141445, size.width * 0.9853630, size.height * 0.6112608,
        size.width * 0.9853630, size.height * 0.6088423);
    path_7.cubicTo(size.width * 0.9853630, size.height * 0.6067671, size.width * 0.9862126, size.height * 0.6032253,
        size.width * 0.9853630, size.height * 0.6019886);
    path_7.cubicTo(size.width * 0.9841368, size.height * 0.6002036, size.width * 0.9838717, size.height * 0.5980268,
        size.width * 0.9820941, size.height * 0.5967330);
    path_7.cubicTo(size.width * 0.9812422, size.height * 0.5961129, size.width * 0.9789614, size.height * 0.5941051,
        size.width * 0.9781177, size.height * 0.5941051);
    path_7.cubicTo(size.width * 0.9763907, size.height * 0.5941051, size.width * 0.9749528, size.height * 0.5930398,
        size.width * 0.9730436, size.height * 0.5930398);
    path_7.cubicTo(size.width * 0.9724575, size.height * 0.5930398, size.width * 0.9677778, size.height * 0.5935474,
        size.width * 0.9676034, size.height * 0.5930398);
    path_7.cubicTo(size.width * 0.9668577, size.height * 0.5908685, size.width * 0.9668960, size.height * 0.5887395,
        size.width * 0.9668960, size.height * 0.5856534);
    path_7.cubicTo(size.width * 0.9668960, size.height * 0.5826491, size.width * 0.9671038, size.height * 0.5801466,
        size.width * 0.9676034, size.height * 0.5772372);
    path_7.cubicTo(size.width * 0.9679203, size.height * 0.5753926, size.width * 0.9690526, size.height * 0.5725989,
        size.width * 0.9694331, size.height * 0.5703835);
    path_7.cubicTo(size.width * 0.9699676, size.height * 0.5672707, size.width * 0.9711278, size.height * 0.5643132,
        size.width * 0.9719457, size.height * 0.5619318);
    path_7.cubicTo(size.width * 0.9725475, size.height * 0.5601799, size.width * 0.9735135, size.height * 0.5574922,
        size.width * 0.9744828, size.height * 0.5556108);
    path_7.cubicTo(size.width * 0.9757499, size.height * 0.5531516, size.width * 0.9775726, size.height * 0.5519419,
        size.width * 0.9784836, size.height * 0.5492898);
    path_7.cubicTo(size.width * 0.9792243, size.height * 0.5471333, size.width * 0.9795569, size.height * 0.5462668,
        size.width * 0.9795570, size.height * 0.5435014);
    path_7.cubicTo(size.width * 0.9795570, size.height * 0.5406951, size.width * 0.9790728, size.height * 0.5383953,
        size.width * 0.9766540, size.height * 0.5392756);
    path_7.cubicTo(size.width * 0.9747183, size.height * 0.5399800, size.width * 0.9734946, size.height * 0.5403409,
        size.width * 0.9716042, size.height * 0.5403409);
    path_7.cubicTo(size.width * 0.9683747, size.height * 0.5403409, size.width * 0.9697746, size.height * 0.5397146,
        size.width * 0.9697746, size.height * 0.5361151);
    path_7.cubicTo(size.width * 0.9697746, size.height * 0.5331603, size.width * 0.9703982, size.height * 0.5314891,
        size.width * 0.9708724, size.height * 0.5287287);
    path_7.cubicTo(size.width * 0.9712916, size.height * 0.5262881, size.width * 0.9719457, size.height * 0.5235286,
        size.width * 0.9719457, size.height * 0.5213423);
    path_7.cubicTo(size.width * 0.9719457, size.height * 0.5187715, size.width * 0.9721543, size.height * 0.5153250,
        size.width * 0.9708724, size.height * 0.5134588);
    path_7.cubicTo(size.width * 0.9698194, size.height * 0.5119260, size.width * 0.9675625, size.height * 0.5083223,
        size.width * 0.9687012, size.height * 0.5050071);
    path_7.cubicTo(size.width * 0.9687012, size.height * 0.5039695, size.width * 0.9685344, size.height * 0.5040307,
        size.width * 0.9684573, size.height * 0.5041193);
    path_7.cubicTo(size.width * 0.9684899, size.height * 0.5040389, size.width * 0.9685561, size.height * 0.5038671,
        size.width * 0.9687012, size.height * 0.5034446);
    path_7.cubicTo(size.width * 0.9692175, size.height * 0.5019414, size.width * 0.9701405, size.height * 0.4996242,
        size.width * 0.9701405, size.height * 0.4970881);
    path_7.cubicTo(size.width * 0.9701405, size.height * 0.4944455, size.width * 0.9697490, size.height * 0.4919473,
        size.width * 0.9679694, size.height * 0.4912997);
    path_7.cubicTo(size.width * 0.9654899, size.height * 0.4903974, size.width * 0.9670041, size.height * 0.4893618,
        size.width * 0.9654323, size.height * 0.4870739);
    path_7.cubicTo(size.width * 0.9648724, size.height * 0.4862590, size.width * 0.9634386, size.height * 0.4833843,
        size.width * 0.9632611, size.height * 0.4823509);
    path_7.cubicTo(size.width * 0.9632037, size.height * 0.4820170, size.width * 0.9622578, size.height * 0.4785201,
        size.width * 0.9632611, size.height * 0.4770597);
    path_7.cubicTo(size.width * 0.9637199, size.height * 0.4763919, size.width * 0.9668333, size.height * 0.4721541,
        size.width * 0.9661641, size.height * 0.4702060);
    path_7.cubicTo(size.width * 0.9657448, size.height * 0.4689852, size.width * 0.9642642, size.height * 0.4665297,
        size.width * 0.9639930, size.height * 0.4649503);
    path_7.cubicTo(size.width * 0.9636547, size.height * 0.4629811, size.width * 0.9631955, size.height * 0.4611014,
        size.width * 0.9625293, size.height * 0.4591619);
    path_7.cubicTo(size.width * 0.9617394, size.height * 0.4568623, size.width * 0.9614390, size.height * 0.4554196,
        size.width * 0.9607240, size.height * 0.4533381);
    path_7.cubicTo(size.width * 0.9603530, size.height * 0.4522578, size.width * 0.9602989, size.height * 0.4482751,
        size.width * 0.9596507, size.height * 0.4470170);
    path_7.cubicTo(size.width * 0.9591522, size.height * 0.4460496, size.width * 0.9570734, size.height * 0.4433823,
        size.width * 0.9571136, size.height * 0.4433239);
    path_7.cubicTo(size.width * 0.9581600, size.height * 0.4418006, size.width * 0.9596856, size.height * 0.4412287,
        size.width * 0.9614559, size.height * 0.4412287);
    path_7.cubicTo(size.width * 0.9632185, size.height * 0.4412287, size.width * 0.9649763, size.height * 0.4411959,
        size.width * 0.9665301, size.height * 0.4417614);
    path_7.cubicTo(size.width * 0.9680105, size.height * 0.4423001, size.width * 0.9688228, size.height * 0.4440697,
        size.width * 0.9708724, size.height * 0.4433239);
    path_7.cubicTo(size.width * 0.9715257, size.height * 0.4430861, size.width * 0.9752664, size.height * 0.4416109,
        size.width * 0.9755806, size.height * 0.4406960);
    path_7.cubicTo(size.width * 0.9761068, size.height * 0.4391640, size.width * 0.9755974, size.height * 0.4359239,
        size.width * 0.9763124, size.height * 0.4338423);
    path_7.cubicTo(size.width * 0.9768726, size.height * 0.4322112, size.width * 0.9776604, size.height * 0.4296515,
        size.width * 0.9781177, size.height * 0.4269886);
    path_7.cubicTo(size.width * 0.9786101, size.height * 0.4241215, size.width * 0.9790485, size.height * 0.4225629,
        size.width * 0.9795570, size.height * 0.4196023);
    path_7.cubicTo(size.width * 0.9797732, size.height * 0.4183435, size.width * 0.9793760, size.height * 0.4138081,
        size.width * 0.9799229, size.height * 0.4122159);
    path_7.cubicTo(size.width * 0.9808370, size.height * 0.4095549, size.width * 0.9814762, size.height * 0.4098987,
        size.width * 0.9831919, size.height * 0.4080256);
    path_7.cubicTo(size.width * 0.9843203, size.height * 0.4067936, size.width * 0.9861381, size.height * 0.4056493,
        size.width * 0.9857290, size.height * 0.4032670);
    path_7.cubicTo(size.width * 0.9853583, size.height * 0.4011087, size.width * 0.9854269, size.height * 0.3983841,
        size.width * 0.9849970, size.height * 0.3958807);
    path_7.cubicTo(size.width * 0.9845818, size.height * 0.3934627, size.width * 0.9840896, size.height * 0.3913992,
        size.width * 0.9828259, size.height * 0.3895597);
    path_7.cubicTo(size.width * 0.9818977, size.height * 0.3882084, size.width * 0.9814688, size.height * 0.3860216,
        size.width * 0.9802888, size.height * 0.3843040);
    path_7.cubicTo(size.width * 0.9793546, size.height * 0.3829440, size.width * 0.9782720, size.height * 0.3809894,
        size.width * 0.9770199, size.height * 0.3800781);
    path_7.cubicTo(size.width * 0.9754428, size.height * 0.3789302, size.width * 0.9750342, size.height * 0.3776847,
        size.width * 0.9737753, size.height * 0.3758523);
    path_7.cubicTo(size.width * 0.9728280, size.height * 0.3744732, size.width * 0.9710411, size.height * 0.3722116,
        size.width * 0.9694331, size.height * 0.3716264);
    path_7.cubicTo(size.width * 0.9684710, size.height * 0.3712763, size.width * 0.9663753, size.height * 0.3712064,
        size.width * 0.9650664, size.height * 0.3721591);
    path_7.cubicTo(size.width * 0.9635901, size.height * 0.3732336, size.width * 0.9616069, size.height * 0.3735779,
        size.width * 0.9596507, size.height * 0.3742898);
    path_7.cubicTo(size.width * 0.9577193, size.height * 0.3749927, size.width * 0.9556963, size.height * 0.3749636,
        size.width * 0.9538447, size.height * 0.3742898);
    path_7.cubicTo(size.width * 0.9519099, size.height * 0.3735857, size.width * 0.9503999, size.height * 0.3732847,
        size.width * 0.9487705, size.height * 0.3726918);
    path_7.cubicTo(size.width * 0.9469961, size.height * 0.3720460, size.width * 0.9456849, size.height * 0.3718441,
        size.width * 0.9437207, size.height * 0.3711293);
    path_7.cubicTo(size.width * 0.9423646, size.height * 0.3706358, size.width * 0.9404273, size.height * 0.3710580,
        size.width * 0.9397199, size.height * 0.3689986);
    path_7.cubicTo(size.width * 0.9389513, size.height * 0.3667607, size.width * 0.9379148, size.height * 0.3638503,
        size.width * 0.9379148, size.height * 0.3605824);
    path_7.cubicTo(size.width * 0.9379148, size.height * 0.3573677, size.width * 0.9372639, size.height * 0.3567221,
        size.width * 0.9368414, size.height * 0.3542614);
    path_7.cubicTo(size.width * 0.9364413, size.height * 0.3519326, size.width * 0.9353589, size.height * 0.3504587,
        size.width * 0.9350117, size.height * 0.3484375);
    path_7.cubicTo(size.width * 0.9346087, size.height * 0.3460909, size.width * 0.9336529, size.height * 0.3452489,
        size.width * 0.9332065, size.height * 0.3426491);
    path_7.cubicTo(size.width * 0.9330672, size.height * 0.3418384, size.width * 0.9316277, size.height * 0.3361455,
        size.width * 0.9328406, size.height * 0.3352628);
    path_7.cubicTo(size.width * 0.9340335, size.height * 0.3343945, size.width * 0.9356453, size.height * 0.3354414,
        size.width * 0.9368414, size.height * 0.3337003);
    path_7.cubicTo(size.width * 0.9380368, size.height * 0.3319600, size.width * 0.9381454, size.height * 0.3304008,
        size.width * 0.9390125, size.height * 0.3278764);
    path_7.cubicTo(size.width * 0.9393540, size.height * 0.3268821, size.width * 0.9408177, size.height * 0.3236698,
        size.width * 0.9408177, size.height * 0.3220881);
    path_7.cubicTo(size.width * 0.9408177, size.height * 0.3196747, size.width * 0.9418911, size.height * 0.3176201,
        size.width * 0.9418911, size.height * 0.3152344);
    path_7.cubicTo(size.width * 0.9418911, size.height * 0.3127109, size.width * 0.9427199, size.height * 0.3100106,
        size.width * 0.9422570, size.height * 0.3073153);
    path_7.cubicTo(size.width * 0.9418753, size.height * 0.3050930, size.width * 0.9407697, size.height * 0.3033776,
        size.width * 0.9404518, size.height * 0.3015270);
    path_7.cubicTo(size.width * 0.9400586, size.height * 0.2992377, size.width * 0.9389678, size.height * 0.2970763,
        size.width * 0.9386465, size.height * 0.2952060);
    path_7.cubicTo(size.width * 0.9381883, size.height * 0.2925374, size.width * 0.9372729, size.height * 0.2921411,
        size.width * 0.9361094, size.height * 0.2904474);
    path_7.cubicTo(size.width * 0.9351512, size.height * 0.2890524, size.width * 0.9343146, size.height * 0.2865310,
        size.width * 0.9332065, size.height * 0.2857244);
    path_7.cubicTo(size.width * 0.9327997, size.height * 0.2854284, size.width * 0.9289376, size.height * 0.2847660,
        size.width * 0.9284982, size.height * 0.2841264);
    path_7.cubicTo(size.width * 0.9276568, size.height * 0.2829016, size.width * 0.9267210, size.height * 0.2816971,
        size.width * 0.9263271, size.height * 0.2794034);
    path_7.cubicTo(size.width * 0.9257116, size.height * 0.2758196, size.width * 0.9265811, size.height * 0.2753320,
        size.width * 0.9270589, size.height * 0.2725497);
    path_7.cubicTo(size.width * 0.9273517, size.height * 0.2708450, size.width * 0.9243479, size.height * 0.2698955,
        size.width * 0.9248877, size.height * 0.2683239);
    path_7.cubicTo(size.width * 0.9255115, size.height * 0.2665081, size.width * 0.9257175, size.height * 0.2648453,
        size.width * 0.9252294, size.height * 0.2620028);
    path_7.cubicTo(size.width * 0.9248493, size.height * 0.2597899, size.width * 0.9241988, size.height * 0.2572510,
        size.width * 0.9227166, size.height * 0.2567116);
    path_7.cubicTo(size.width * 0.9211462, size.height * 0.2561401, size.width * 0.9200974, size.height * 0.2566084,
        size.width * 0.9183499, size.height * 0.2572443);
    path_7.cubicTo(size.width * 0.9167391, size.height * 0.2578305, size.width * 0.9157475, size.height * 0.2593722,
        size.width * 0.9143735, size.height * 0.2598722);
    path_7.cubicTo(size.width * 0.9125535, size.height * 0.2605345, size.width * 0.9113581, size.height * 0.2611072,
        size.width * 0.9103972, size.height * 0.2583097);
    path_7.cubicTo(size.width * 0.9095345, size.height * 0.2557982, size.width * 0.9111397, size.height * 0.2547146,
        size.width * 0.9107631, size.height * 0.2525213);
    path_7.cubicTo(size.width * 0.9100699, size.height * 0.2484853, size.width * 0.9091927, size.height * 0.2503696,
        size.width * 0.9064208, size.height * 0.2493608);
    path_7.cubicTo(size.width * 0.9048316, size.height * 0.2487825, size.width * 0.9039380, size.height * 0.2483746,
        size.width * 0.9027859, size.height * 0.2466974);
    path_7.cubicTo(size.width * 0.9018404, size.height * 0.2453211, size.width * 0.9009979, size.height * 0.2446880,
        size.width * 0.9002489, size.height * 0.2425071);
    path_7.cubicTo(size.width * 0.8998065, size.height * 0.2412193, size.width * 0.8990222, size.height * 0.2368381,
        size.width * 0.8980777, size.height * 0.2361506);
    path_7.cubicTo(size.width * 0.8965558, size.height * 0.2350429, size.width * 0.8959401, size.height * 0.2341887,
        size.width * 0.8951747, size.height * 0.2319602);
    path_7.cubicTo(size.width * 0.8947630, size.height * 0.2307616, size.width * 0.8938231, size.height * 0.2271005,
        size.width * 0.8926376, size.height * 0.2266690);
    path_7.cubicTo(size.width * 0.8918383, size.height * 0.2263781, size.width * 0.8910731, size.height * 0.2262428,
        size.width * 0.8902957, size.height * 0.2262429);
    path_7.close();
    Paint paint7Fill = Paint()..style = PaintingStyle.fill;
    paint7Fill.color = easternAnatoliaColor;
    canvas.drawPath(path_7, paint7Fill);

    /// DoğuAnadolu Bölgesi Bitiş

    /// GüneyDoğuAnadolu Bölgesi Başlangıç

    Path path_8 = Path();
    path_8.moveTo(size.width * 0.8109875, size.height * 0.5066051);
    path_8.cubicTo(size.width * 0.8099702, size.height * 0.5067668, size.width * 0.8069689, size.height * 0.5099385,
        size.width * 0.8064745, size.height * 0.5102983);
    path_8.cubicTo(size.width * 0.8051315, size.height * 0.5112757, size.width * 0.8037280, size.height * 0.5125458,
        size.width * 0.8024737, size.height * 0.5134588);
    path_8.cubicTo(size.width * 0.8003849, size.height * 0.5149790, size.width * 0.7990452, size.height * 0.5157057,
        size.width * 0.7970579, size.height * 0.5171520);
    path_8.cubicTo(size.width * 0.7952177, size.height * 0.5184914, size.width * 0.7944354, size.height * 0.5197798,
        size.width * 0.7919838, size.height * 0.5197798);
    path_8.cubicTo(size.width * 0.7899005, size.height * 0.5197798, size.width * 0.7887535, size.height * 0.5203125,
        size.width * 0.7869096, size.height * 0.5203125);
    path_8.cubicTo(size.width * 0.7857002, size.height * 0.5203125, size.width * 0.7832630, size.height * 0.5196335,
        size.width * 0.7822014, size.height * 0.5192472);
    path_8.cubicTo(size.width * 0.7803169, size.height * 0.5185613, size.width * 0.7791514, size.height * 0.5187853,
        size.width * 0.7774932, size.height * 0.5181818);
    path_8.cubicTo(size.width * 0.7757109, size.height * 0.5175332, size.width * 0.7738820, size.height * 0.5171520,
        size.width * 0.7720531, size.height * 0.5171520);
    path_8.cubicTo(size.width * 0.7691655, size.height * 0.5171520, size.width * 0.7703647, size.height * 0.5209575,
        size.width * 0.7706138, size.height * 0.5224077);
    path_8.cubicTo(size.width * 0.7711077, size.height * 0.5252835, size.width * 0.7717876, size.height * 0.5253114,
        size.width * 0.7709797, size.height * 0.5276634);
    path_8.cubicTo(size.width * 0.7706122, size.height * 0.5287334, size.width * 0.7669311, size.height * 0.5295540,
        size.width * 0.7662715, size.height * 0.5297940);
    path_8.cubicTo(size.width * 0.7646935, size.height * 0.5303683, size.width * 0.7633535, size.height * 0.5308382,
        size.width * 0.7619292, size.height * 0.5313565);
    path_8.cubicTo(size.width * 0.7604402, size.height * 0.5318984, size.width * 0.7585976, size.height * 0.5317877,
        size.width * 0.7568550, size.height * 0.5324219);
    path_8.cubicTo(size.width * 0.7551823, size.height * 0.5330306, size.width * 0.7537720, size.height * 0.5313565,
        size.width * 0.7517808, size.height * 0.5313565);
    path_8.cubicTo(size.width * 0.7496510, size.height * 0.5313565, size.width * 0.7487514, size.height * 0.5309376,
        size.width * 0.7470726, size.height * 0.5303267);
    path_8.cubicTo(size.width * 0.7456400, size.height * 0.5298054, size.width * 0.7439445, size.height * 0.5291706,
        size.width * 0.7427303, size.height * 0.5287287);
    path_8.cubicTo(size.width * 0.7403009, size.height * 0.5278446, size.width * 0.7395597, size.height * 0.5285497,
        size.width * 0.7383880, size.height * 0.5308239);
    path_8.cubicTo(size.width * 0.7375686, size.height * 0.5324141, size.width * 0.7362235, size.height * 0.5350400,
        size.width * 0.7351190, size.height * 0.5366477);
    path_8.cubicTo(size.width * 0.7337933, size.height * 0.5385776, size.width * 0.7326124, size.height * 0.5398038,
        size.width * 0.7311427, size.height * 0.5408736);
    path_8.cubicTo(size.width * 0.7290468, size.height * 0.5423990, size.width * 0.7278822, size.height * 0.5405956,
        size.width * 0.7268004, size.height * 0.5398082);
    path_8.cubicTo(size.width * 0.7255716, size.height * 0.5389139, size.width * 0.7232721, size.height * 0.5388461,
        size.width * 0.7220921, size.height * 0.5392756);
    path_8.cubicTo(size.width * 0.7207513, size.height * 0.5397635, size.width * 0.7193315, size.height * 0.5411634,
        size.width * 0.7184573, size.height * 0.5424361);
    path_8.cubicTo(size.width * 0.7173473, size.height * 0.5440519, size.width * 0.7147529, size.height * 0.5440416,
        size.width * 0.7134075, size.height * 0.5445313);
    path_8.cubicTo(size.width * 0.7123638, size.height * 0.5449111, size.width * 0.7104141, size.height * 0.5418376,
        size.width * 0.7097726, size.height * 0.5413707);
    path_8.cubicTo(size.width * 0.7081968, size.height * 0.5402238, size.width * 0.7052407, size.height * 0.5419813,
        size.width * 0.7039910, size.height * 0.5424361);
    path_8.cubicTo(size.width * 0.7011217, size.height * 0.5434803, size.width * 0.7011028, size.height * 0.5446171,
        size.width * 0.7014539, size.height * 0.5466619);
    path_8.cubicTo(size.width * 0.7018213, size.height * 0.5488007, size.width * 0.7017955, size.height * 0.5512767,
        size.width * 0.7017955, size.height * 0.5540483);
    path_8.cubicTo(size.width * 0.7017955, size.height * 0.5563697, size.width * 0.7006911, size.height * 0.5582838,
        size.width * 0.6999902, size.height * 0.5593040);
    path_8.cubicTo(size.width * 0.6985500, size.height * 0.5614005, size.width * 0.6975889, size.height * 0.5621171,
        size.width * 0.6956479, size.height * 0.5635298);
    path_8.cubicTo(size.width * 0.6939489, size.height * 0.5647664, size.width * 0.6934204, size.height * 0.5660539,
        size.width * 0.6916715, size.height * 0.5666903);
    path_8.cubicTo(size.width * 0.6898469, size.height * 0.5673544, size.width * 0.6878042, size.height * 0.5682211,
        size.width * 0.6858655, size.height * 0.5687855);
    path_8.cubicTo(size.width * 0.6842102, size.height * 0.5692674, size.width * 0.6821442, size.height * 0.5687855,
        size.width * 0.6804498, size.height * 0.5687855);
    path_8.cubicTo(size.width * 0.6783742, size.height * 0.5687855, size.width * 0.6768378, size.height * 0.5682860,
        size.width * 0.6757416, size.height * 0.5666903);
    path_8.cubicTo(size.width * 0.6748405, size.height * 0.5653786, size.width * 0.6729871, size.height * 0.5647033,
        size.width * 0.6721068, size.height * 0.5640625);
    path_8.cubicTo(size.width * 0.6710465, size.height * 0.5632908, size.width * 0.6735552, size.height * 0.5582829,
        size.width * 0.6735705, size.height * 0.5582386);
    path_8.cubicTo(size.width * 0.6749092, size.height * 0.5543409, size.width * 0.6719142, size.height * 0.5545455,
        size.width * 0.6699356, size.height * 0.5545455);
    path_8.cubicTo(size.width * 0.6682289, size.height * 0.5545455, size.width * 0.6655995, size.height * 0.5566894,
        size.width * 0.6641540, size.height * 0.5577415);
    path_8.cubicTo(size.width * 0.6624282, size.height * 0.5589975, size.width * 0.6606769, size.height * 0.5601876,
        size.width * 0.6587139, size.height * 0.5609020);
    path_8.cubicTo(size.width * 0.6569362, size.height * 0.5615489, size.width * 0.6552198, size.height * 0.5631788,
        size.width * 0.6540057, size.height * 0.5640625);
    path_8.cubicTo(size.width * 0.6523248, size.height * 0.5652859, size.width * 0.6503958, size.height * 0.5660238,
        size.width * 0.6492974, size.height * 0.5672230);
    path_8.cubicTo(size.width * 0.6491200, size.height * 0.5674167, size.width * 0.6508272, size.height * 0.5708748,
        size.width * 0.6511027, size.height * 0.5724787);
    path_8.cubicTo(size.width * 0.6515580, size.height * 0.5751298, size.width * 0.6515295, size.height * 0.5780894,
        size.width * 0.6518345, size.height * 0.5798651);
    path_8.cubicTo(size.width * 0.6523089, size.height * 0.5826271, size.width * 0.6519317, size.height * 0.5839313,
        size.width * 0.6500293, size.height * 0.5846236);
    path_8.cubicTo(size.width * 0.6482379, size.height * 0.5852755, size.width * 0.6460077, size.height * 0.5870180,
        size.width * 0.6449551, size.height * 0.5877841);
    path_8.cubicTo(size.width * 0.6431684, size.height * 0.5890846, size.width * 0.6423820, size.height * 0.5891022,
        size.width * 0.6402469, size.height * 0.5898793);
    path_8.cubicTo(size.width * 0.6387197, size.height * 0.5904350, size.width * 0.6361445, size.height * 0.5897003,
        size.width * 0.6351727, size.height * 0.5893466);
    path_8.cubicTo(size.width * 0.6332896, size.height * 0.5886613, size.width * 0.6318806, size.height * 0.5888486,
        size.width * 0.6304645, size.height * 0.5898793);
    path_8.cubicTo(size.width * 0.6287092, size.height * 0.5911568, size.width * 0.6277180, size.height * 0.5924109,
        size.width * 0.6261222, size.height * 0.5935724);
    path_8.cubicTo(size.width * 0.6243000, size.height * 0.5948986, size.width * 0.6225938, size.height * 0.5949719,
        size.width * 0.6206821, size.height * 0.5956676);
    path_8.cubicTo(size.width * 0.6203203, size.height * 0.5957993, size.width * 0.6200373, size.height * 0.5958624,
        size.width * 0.6198039, size.height * 0.5958807);
    path_8.cubicTo(size.width * 0.6184269, size.height * 0.5972192, size.width * 0.6167552, size.height * 0.5987915,
        size.width * 0.6156323, size.height * 0.6004261);
    path_8.cubicTo(size.width * 0.6154476, size.height * 0.6006951, size.width * 0.6121441, size.height * 0.6044051,
        size.width * 0.6123634, size.height * 0.6056818);
    path_8.cubicTo(size.width * 0.6126102, size.height * 0.6071189, size.width * 0.6121428, size.height * 0.6113607,
        size.width * 0.6127293, size.height * 0.6130682);
    path_8.cubicTo(size.width * 0.6136578, size.height * 0.6157715, size.width * 0.6135023, size.height * 0.6165188,
        size.width * 0.6156323, size.height * 0.6172940);
    path_8.cubicTo(size.width * 0.6167350, size.height * 0.6176953, size.width * 0.6186316, size.height * 0.6184996,
        size.width * 0.6196087, size.height * 0.6199219);
    path_8.cubicTo(size.width * 0.6205244, size.height * 0.6212548, size.width * 0.6221458, size.height * 0.6222816,
        size.width * 0.6221458, size.height * 0.6246804);
    path_8.cubicTo(size.width * 0.6221458, size.height * 0.6270779, size.width * 0.6235204, size.height * 0.6295917,
        size.width * 0.6228532, size.height * 0.6315341);
    path_8.cubicTo(size.width * 0.6221710, size.height * 0.6335203, size.width * 0.6213374, size.height * 0.6345982,
        size.width * 0.6196087, size.height * 0.6352273);
    path_8.cubicTo(size.width * 0.6180878, size.height * 0.6357808, size.width * 0.6157841, size.height * 0.6367898,
        size.width * 0.6141686, size.height * 0.6367898);
    path_8.cubicTo(size.width * 0.6122179, size.height * 0.6367898, size.width * 0.6106851, size.height * 0.6367436,
        size.width * 0.6090945, size.height * 0.6373224);
    path_8.cubicTo(size.width * 0.6078859, size.height * 0.6377623, size.width * 0.6057823, size.height * 0.6389342,
        size.width * 0.6043862, size.height * 0.6399503);
    path_8.cubicTo(size.width * 0.6031846, size.height * 0.6408249, size.width * 0.6018287, size.height * 0.6410482,
        size.width * 0.6004098, size.height * 0.6420810);
    path_8.cubicTo(size.width * 0.5996739, size.height * 0.6426166, size.width * 0.5965587, size.height * 0.6432789,
        size.width * 0.5960675, size.height * 0.6447088);
    path_8.cubicTo(size.width * 0.5953933, size.height * 0.6466716, size.width * 0.5950205, size.height * 0.6494126,
        size.width * 0.5935304, size.height * 0.6504972);
    path_8.cubicTo(size.width * 0.5925220, size.height * 0.6512312, size.width * 0.5909142, size.height * 0.6522862,
        size.width * 0.5891881, size.height * 0.6510298);
    path_8.cubicTo(size.width * 0.5870795, size.height * 0.6494951, size.width * 0.5879616, size.height * 0.6486112,
        size.width * 0.5873829, size.height * 0.6452415);
    path_8.cubicTo(size.width * 0.5870522, size.height * 0.6433157, size.width * 0.5873118, size.height * 0.6404149,
        size.width * 0.5862851, size.height * 0.6389205);
    path_8.cubicTo(size.width * 0.5846973, size.height * 0.6366091, size.width * 0.5844582, size.height * 0.6378532,
        size.width * 0.5823087, size.height * 0.6394176);
    path_8.cubicTo(size.width * 0.5811449, size.height * 0.6402647, size.width * 0.5795551, size.height * 0.6407982,
        size.width * 0.5783324, size.height * 0.6425781);
    path_8.cubicTo(size.width * 0.5773845, size.height * 0.6439579, size.width * 0.5770542, size.height * 0.6455040,
        size.width * 0.5757953, size.height * 0.6473366);
    path_8.cubicTo(size.width * 0.5748492, size.height * 0.6487139, size.width * 0.5742044, size.height * 0.6512505,
        size.width * 0.5732582, size.height * 0.6526278);
    path_8.cubicTo(size.width * 0.5722383, size.height * 0.6541125, size.width * 0.5714005, size.height * 0.6547612,
        size.width * 0.5699893, size.height * 0.6557884);
    path_8.cubicTo(size.width * 0.5683167, size.height * 0.6570057, size.width * 0.5678088, size.height * 0.6578971,
        size.width * 0.5663788, size.height * 0.6599787);
    path_8.cubicTo(size.width * 0.5650313, size.height * 0.6619402, size.width * 0.5644964, size.height * 0.6643168,
        size.width * 0.5634758, size.height * 0.6658026);
    path_8.cubicTo(size.width * 0.5627780, size.height * 0.6668184, size.width * 0.5613046, size.height * 0.6691768,
        size.width * 0.5613046, size.height * 0.6710582);
    path_8.cubicTo(size.width * 0.5613046, size.height * 0.6728985, size.width * 0.5608210, size.height * 0.6777405,
        size.width * 0.5616706, size.height * 0.6789773);
    path_8.cubicTo(size.width * 0.5626022, size.height * 0.6803334, size.width * 0.5630757, size.height * 0.6815980,
        size.width * 0.5645492, size.height * 0.6826705);
    path_8.cubicTo(size.width * 0.5656779, size.height * 0.6834919, size.width * 0.5674187, size.height * 0.6847169,
        size.width * 0.5681840, size.height * 0.6858310);
    path_8.cubicTo(size.width * 0.5687465, size.height * 0.6866497, size.width * 0.5706890, size.height * 0.6889915,
        size.width * 0.5721604, size.height * 0.6889915);
    path_8.cubicTo(size.width * 0.5734901, size.height * 0.6889915, size.width * 0.5757121, size.height * 0.6891795,
        size.width * 0.5768687, size.height * 0.6900213);
    path_8.cubicTo(size.width * 0.5778172, size.height * 0.6907117, size.width * 0.5792744, size.height * 0.6927700,
        size.width * 0.5805035, size.height * 0.6932173);
    path_8.cubicTo(size.width * 0.5824647, size.height * 0.6939310, size.width * 0.5837577, size.height * 0.6951917,
        size.width * 0.5855533, size.height * 0.6958452);
    path_8.cubicTo(size.width * 0.5870947, size.height * 0.6964061, size.width * 0.5878903, size.height * 0.6971164,
        size.width * 0.5891881, size.height * 0.6990057);
    path_8.cubicTo(size.width * 0.5901180, size.height * 0.7003592, size.width * 0.5911295, size.height * 0.7033128,
        size.width * 0.5924327, size.height * 0.7042614);
    path_8.cubicTo(size.width * 0.5936571, size.height * 0.7051526, size.width * 0.5942349, size.height * 0.7062577,
        size.width * 0.5960675, size.height * 0.7069247);
    path_8.cubicTo(size.width * 0.5973488, size.height * 0.7073910, size.width * 0.5993530, size.height * 0.7079546,
        size.width * 0.6007758, size.height * 0.7079545);
    path_8.cubicTo(size.width * 0.6025733, size.height * 0.7079545, size.width * 0.6037869, size.height * 0.7090199,
        size.width * 0.6058499, size.height * 0.7090199);
    path_8.cubicTo(size.width * 0.6078668, size.height * 0.7090199, size.width * 0.6093618, size.height * 0.7090917,
        size.width * 0.6109241, size.height * 0.7079545);
    path_8.cubicTo(size.width * 0.6123704, size.height * 0.7069018, size.width * 0.6139353, size.height * 0.7057629,
        size.width * 0.6152664, size.height * 0.7047940);
    path_8.cubicTo(size.width * 0.6166718, size.height * 0.7037711, size.width * 0.6185792, size.height * 0.7022657,
        size.width * 0.6203162, size.height * 0.7016335);
    path_8.cubicTo(size.width * 0.6222675, size.height * 0.7009234, size.width * 0.6230771, size.height * 0.6995900,
        size.width * 0.6246829, size.height * 0.6990057);
    path_8.cubicTo(size.width * 0.6263199, size.height * 0.6984099, size.width * 0.6281695, size.height * 0.6979766,
        size.width * 0.6297326, size.height * 0.6974077);
    path_8.cubicTo(size.width * 0.6312090, size.height * 0.6968704, size.width * 0.6321238, size.height * 0.6948329,
        size.width * 0.6337334, size.height * 0.6942472);
    path_8.cubicTo(size.width * 0.6349229, size.height * 0.6938143, size.width * 0.6364703, size.height * 0.6927362,
        size.width * 0.6380757, size.height * 0.6921520);
    path_8.cubicTo(size.width * 0.6393099, size.height * 0.6917029, size.width * 0.6408904, size.height * 0.6908668,
        size.width * 0.6420521, size.height * 0.6900213);
    path_8.cubicTo(size.width * 0.6436071, size.height * 0.6888895, size.width * 0.6446524, size.height * 0.6883668,
        size.width * 0.6460285, size.height * 0.6863636);
    path_8.cubicTo(size.width * 0.6464116, size.height * 0.6858059, size.width * 0.6484903, size.height * 0.6810724,
        size.width * 0.6492974, size.height * 0.6810724);
    path_8.cubicTo(size.width * 0.6514742, size.height * 0.6810724, size.width * 0.6537295, size.height * 0.6819130,
        size.width * 0.6558109, size.height * 0.6826705);
    path_8.cubicTo(size.width * 0.6571999, size.height * 0.6831760, size.width * 0.6591653, size.height * 0.6846724,
        size.width * 0.6608851, size.height * 0.6852983);
    path_8.cubicTo(size.width * 0.6626760, size.height * 0.6859501, size.width * 0.6636394, size.height * 0.6878809,
        size.width * 0.6652274, size.height * 0.6884588);
    path_8.cubicTo(size.width * 0.6666363, size.height * 0.6889715, size.width * 0.6678129, size.height * 0.6899411,
        size.width * 0.6688622, size.height * 0.6910866);
    path_8.cubicTo(size.width * 0.6698500, size.height * 0.6921651, size.width * 0.6714716, size.height * 0.6933226,
        size.width * 0.6724727, size.height * 0.6947798);
    path_8.cubicTo(size.width * 0.6729879, size.height * 0.6955298, size.width * 0.6747124, size.height * 0.6984979,
        size.width * 0.6761075, size.height * 0.6990057);
    path_8.cubicTo(size.width * 0.6776911, size.height * 0.6995820, size.width * 0.6780419, size.height * 0.7015562,
        size.width * 0.6797180, size.height * 0.7021662);
    path_8.cubicTo(size.width * 0.6809697, size.height * 0.7026217, size.width * 0.6830124, size.height * 0.7026989,
        size.width * 0.6847922, size.height * 0.7026989);
    path_8.cubicTo(size.width * 0.6864295, size.height * 0.7026989, size.width * 0.6886287, size.height * 0.7021242,
        size.width * 0.6902078, size.height * 0.7026989);
    path_8.cubicTo(size.width * 0.6921679, size.height * 0.7034122, size.width * 0.6931407, size.height * 0.7026989,
        size.width * 0.6952820, size.height * 0.7026989);
    path_8.cubicTo(size.width * 0.6969618, size.height * 0.7026989, size.width * 0.6984747, size.height * 0.7031583,
        size.width * 0.6999902, size.height * 0.7042614);
    path_8.cubicTo(size.width * 0.7012417, size.height * 0.7051723, size.width * 0.7027442, size.height * 0.7064709,
        size.width * 0.7039910, size.height * 0.7069247);
    path_8.cubicTo(size.width * 0.7062428, size.height * 0.7077442, size.width * 0.7055481, size.height * 0.7062071,
        size.width * 0.7079674, size.height * 0.7053267);
    path_8.cubicTo(size.width * 0.7095608, size.height * 0.7047468, size.width * 0.7114054, size.height * 0.7038270,
        size.width * 0.7130416, size.height * 0.7032315);
    path_8.cubicTo(size.width * 0.7145352, size.height * 0.7026880, size.width * 0.7161847, size.height * 0.7016335,
        size.width * 0.7180913, size.height * 0.7016335);
    path_8.cubicTo(size.width * 0.7199160, size.height * 0.7016335, size.width * 0.7217764, size.height * 0.7005681,
        size.width * 0.7235314, size.height * 0.7005682);
    path_8.cubicTo(size.width * 0.7253407, size.height * 0.7005682, size.width * 0.7272300, size.height * 0.6995384,
        size.width * 0.7286056, size.height * 0.6995384);
    path_8.cubicTo(size.width * 0.7305675, size.height * 0.6995384, size.width * 0.7319906, size.height * 0.6996204,
        size.width * 0.7336797, size.height * 0.6990057);
    path_8.cubicTo(size.width * 0.7354400, size.height * 0.6983651, size.width * 0.7376517, size.height * 0.6976950,
        size.width * 0.7394614, size.height * 0.6963778);
    path_8.cubicTo(size.width * 0.7413508, size.height * 0.6950026, size.width * 0.7422487, size.height * 0.6946154,
        size.width * 0.7441696, size.height * 0.6932173);
    path_8.cubicTo(size.width * 0.7453402, size.height * 0.6923653, size.width * 0.7477443, size.height * 0.6917915,
        size.width * 0.7488778, size.height * 0.6905540);
    path_8.cubicTo(size.width * 0.7502213, size.height * 0.6890873, size.width * 0.7523297, size.height * 0.6875444,
        size.width * 0.7539520, size.height * 0.6863636);
    path_8.cubicTo(size.width * 0.7552906, size.height * 0.6853893, size.width * 0.7560431, size.height * 0.6843267,
        size.width * 0.7575868, size.height * 0.6832031);
    path_8.cubicTo(size.width * 0.7587882, size.height * 0.6823287, size.width * 0.7597580, size.height * 0.6810547,
        size.width * 0.7611973, size.height * 0.6800071);
    path_8.cubicTo(size.width * 0.7627175, size.height * 0.6789007, size.width * 0.7633247, size.height * 0.6776952,
        size.width * 0.7651737, size.height * 0.6763494);
    path_8.cubicTo(size.width * 0.7662960, size.height * 0.6755326, size.width * 0.7680025, size.height * 0.6742550,
        size.width * 0.7695160, size.height * 0.6731534);
    path_8.cubicTo(size.width * 0.7707362, size.height * 0.6722653, size.width * 0.7725467, size.height * 0.6709544,
        size.width * 0.7738827, size.height * 0.6694957);
    path_8.cubicTo(size.width * 0.7750266, size.height * 0.6682469, size.width * 0.7767538, size.height * 0.6674087,
        size.width * 0.7782250, size.height * 0.6658026);
    path_8.cubicTo(size.width * 0.7800740, size.height * 0.6637839, size.width * 0.7811808, size.height * 0.6634041,
        size.width * 0.7832748, size.height * 0.6626420);
    path_8.cubicTo(size.width * 0.7844866, size.height * 0.6622011, size.width * 0.7867281, size.height * 0.6621666,
        size.width * 0.7883489, size.height * 0.6615767);
    path_8.cubicTo(size.width * 0.7902091, size.height * 0.6608998, size.width * 0.7914781, size.height * 0.6605113,
        size.width * 0.7934231, size.height * 0.6605114);
    path_8.cubicTo(size.width * 0.7954441, size.height * 0.6605114, size.width * 0.7968468, size.height * 0.6603754,
        size.width * 0.7984973, size.height * 0.6615767);
    path_8.cubicTo(size.width * 0.7995173, size.height * 0.6623192, size.width * 0.8017500, size.height * 0.6643407,
        size.width * 0.8028396, size.height * 0.6647372);
    path_8.cubicTo(size.width * 0.8040634, size.height * 0.6651826, size.width * 0.8056928, size.height * 0.6662997,
        size.width * 0.8071819, size.height * 0.6662997);
    path_8.cubicTo(size.width * 0.8091876, size.height * 0.6662997, size.width * 0.8104052, size.height * 0.6673651,
        size.width * 0.8118901, size.height * 0.6673651);
    path_8.cubicTo(size.width * 0.8137008, size.height * 0.6673651, size.width * 0.8155195, size.height * 0.6673651,
        size.width * 0.8173302, size.height * 0.6673651);
    path_8.cubicTo(size.width * 0.8186814, size.height * 0.6673651, size.width * 0.8208119, size.height * 0.6674119,
        size.width * 0.8224044, size.height * 0.6668324);
    path_8.cubicTo(size.width * 0.8246520, size.height * 0.6660144, size.width * 0.8261770, size.height * 0.6644030,
        size.width * 0.8281859, size.height * 0.6636719);
    path_8.cubicTo(size.width * 0.8298596, size.height * 0.6630628, size.width * 0.8317450, size.height * 0.6631392,
        size.width * 0.8336261, size.height * 0.6631392);
    path_8.cubicTo(size.width * 0.8358179, size.height * 0.6631392, size.width * 0.8375454, size.height * 0.6622544,
        size.width * 0.8394077, size.height * 0.6615767);
    path_8.cubicTo(size.width * 0.8412045, size.height * 0.6609228, size.width * 0.8433047, size.height * 0.6605113,
        size.width * 0.8452137, size.height * 0.6605114);
    path_8.cubicTo(size.width * 0.8469763, size.height * 0.6605114, size.width * 0.8487340, size.height * 0.6605442,
        size.width * 0.8502879, size.height * 0.6599787);
    path_8.cubicTo(size.width * 0.8517461, size.height * 0.6594480, size.width * 0.8532798, size.height * 0.6588664,
        size.width * 0.8546301, size.height * 0.6578835);
    path_8.cubicTo(size.width * 0.8558706, size.height * 0.6569806, size.width * 0.8579530, size.height * 0.6558930,
        size.width * 0.8597043, size.height * 0.6552557);
    path_8.cubicTo(size.width * 0.8616409, size.height * 0.6545509, size.width * 0.8628260, size.height * 0.6533393,
        size.width * 0.8640467, size.height * 0.6515625);
    path_8.cubicTo(size.width * 0.8650557, size.height * 0.6500936, size.width * 0.8655356, size.height * 0.6488804,
        size.width * 0.8669496, size.height * 0.6473366);
    path_8.cubicTo(size.width * 0.8677297, size.height * 0.6464850, size.width * 0.8709469, size.height * 0.6426390,
        size.width * 0.8716579, size.height * 0.6447088);
    path_8.cubicTo(size.width * 0.8721997, size.height * 0.6462864, size.width * 0.8742697, size.height * 0.6478782,
        size.width * 0.8745365, size.height * 0.6494318);
    path_8.cubicTo(size.width * 0.8748400, size.height * 0.6511993, size.width * 0.8752761, size.height * 0.6537029,
        size.width * 0.8756343, size.height * 0.6557884);
    path_8.cubicTo(size.width * 0.8760109, size.height * 0.6579812, size.width * 0.8767958, size.height * 0.6607682,
        size.width * 0.8774395, size.height * 0.6626420);
    path_8.cubicTo(size.width * 0.8782545, size.height * 0.6650147, size.width * 0.8792810, size.height * 0.6644268,
        size.width * 0.8810500, size.height * 0.6631392);
    path_8.cubicTo(size.width * 0.8827315, size.height * 0.6619153, size.width * 0.8839087, size.height * 0.6617171,
        size.width * 0.8857582, size.height * 0.6610440);
    path_8.cubicTo(size.width * 0.8885904, size.height * 0.6600133, size.width * 0.8874590, size.height * 0.6597856,
        size.width * 0.8886612, size.height * 0.6562855);
    path_8.cubicTo(size.width * 0.8893826, size.height * 0.6541855, size.width * 0.8904457, size.height * 0.6511865,
        size.width * 0.8908323, size.height * 0.6489347);
    path_8.cubicTo(size.width * 0.8913027, size.height * 0.6461954, size.width * 0.8919892, size.height * 0.6446177,
        size.width * 0.8933694, size.height * 0.6431108);
    path_8.cubicTo(size.width * 0.8950354, size.height * 0.6412919, size.width * 0.8958190, size.height * 0.6399503,
        size.width * 0.8980777, size.height * 0.6399503);
    path_8.cubicTo(size.width * 0.8995217, size.height * 0.6399503, size.width * 0.9016661, size.height * 0.6409836,
        size.width * 0.9024200, size.height * 0.6420810);
    path_8.cubicTo(size.width * 0.9032015, size.height * 0.6432185, size.width * 0.9038751, size.height * 0.6452472,
        size.width * 0.9053230, size.height * 0.6457741);
    path_8.cubicTo(size.width * 0.9073231, size.height * 0.6465020, size.width * 0.9073206, size.height * 0.6445510,
        size.width * 0.9092994, size.height * 0.6431108);
    path_8.cubicTo(size.width * 0.9100383, size.height * 0.6425730, size.width * 0.9130319, size.height * 0.6395952,
        size.width * 0.9140077, size.height * 0.6399503);
    path_8.cubicTo(size.width * 0.9157732, size.height * 0.6405928, size.width * 0.9170920, size.height * 0.6422990,
        size.width * 0.9183499, size.height * 0.6431108);
    path_8.cubicTo(size.width * 0.9200746, size.height * 0.6441151, size.width * 0.9198937, size.height * 0.6439858,
        size.width * 0.9208870, size.height * 0.6447088);
    path_8.cubicTo(size.width * 0.9217913, size.height * 0.6453669, size.width * 0.9233839, size.height * 0.6473221,
        size.width * 0.9248877, size.height * 0.6478693);
    path_8.cubicTo(size.width * 0.9266109, size.height * 0.6484964, size.width * 0.9276558, size.height * 0.6493513,
        size.width * 0.9292301, size.height * 0.6504972);
    path_8.cubicTo(size.width * 0.9297750, size.height * 0.6508938, size.width * 0.9311725, size.height * 0.6522635,
        size.width * 0.9321819, size.height * 0.6520597);
    path_8.cubicTo(size.width * 0.9312030, size.height * 0.6515522, size.width * 0.9303387, size.height * 0.6507753,
        size.width * 0.9295960, size.height * 0.6499645);
    path_8.cubicTo(size.width * 0.9282411, size.height * 0.6484853, size.width * 0.9276637, size.height * 0.6466545,
        size.width * 0.9263271, size.height * 0.6447088);
    path_8.cubicTo(size.width * 0.9253153, size.height * 0.6432359, size.width * 0.9247742, size.height * 0.6403902,
        size.width * 0.9245219, size.height * 0.6389205);
    path_8.cubicTo(size.width * 0.9240986, size.height * 0.6364560, size.width * 0.9241560, size.height * 0.6335695,
        size.width * 0.9241560, size.height * 0.6310014);
    path_8.cubicTo(size.width * 0.9241558, size.height * 0.6289554, size.width * 0.9237900, size.height * 0.6260190,
        size.width * 0.9237900, size.height * 0.6236151);
    path_8.cubicTo(size.width * 0.9237900, size.height * 0.6203927, size.width * 0.9240691, size.height * 0.6188650,
        size.width * 0.9245219, size.height * 0.6162287);
    path_8.cubicTo(size.width * 0.9249439, size.height * 0.6137714, size.width * 0.9254089, size.height * 0.6115154,
        size.width * 0.9259611, size.height * 0.6099077);
    path_8.cubicTo(size.width * 0.9269510, size.height * 0.6070262, size.width * 0.9276153, size.height * 0.6050919,
        size.width * 0.9284982, size.height * 0.6025213);
    path_8.cubicTo(size.width * 0.9293886, size.height * 0.5999293, size.width * 0.9246480, size.height * 0.6039491,
        size.width * 0.9227166, size.height * 0.6046520);
    path_8.cubicTo(size.width * 0.9212507, size.height * 0.6051855, size.width * 0.9194047, size.height * 0.6030295,
        size.width * 0.9180084, size.height * 0.6025213);
    path_8.cubicTo(size.width * 0.9160432, size.height * 0.6018062, size.width * 0.9146482, size.height * 0.6015825,
        size.width * 0.9129343, size.height * 0.6009588);
    path_8.cubicTo(size.width * 0.9111680, size.height * 0.6003160, size.width * 0.9101518, size.height * 0.5999285,
        size.width * 0.9085919, size.height * 0.5993608);
    path_8.cubicTo(size.width * 0.9065913, size.height * 0.5986327, size.width * 0.9059551, size.height * 0.6011799,
        size.width * 0.9038837, size.height * 0.6004261);
    path_8.cubicTo(size.width * 0.9026855, size.height * 0.5999900, size.width * 0.9015514, size.height * 0.5963273,
        size.width * 0.9013466, size.height * 0.5951349);
    path_8.cubicTo(size.width * 0.9008311, size.height * 0.5921328, size.width * 0.9012714, size.height * 0.5908848,
        size.width * 0.9017126, size.height * 0.5883168);
    path_8.cubicTo(size.width * 0.9020813, size.height * 0.5861697, size.width * 0.9024663, size.height * 0.5838216,
        size.width * 0.9027859, size.height * 0.5819602);
    path_8.cubicTo(size.width * 0.9031969, size.height * 0.5795666, size.width * 0.9019868, size.height * 0.5767034,
        size.width * 0.9017126, size.height * 0.5751065);
    path_8.cubicTo(size.width * 0.9011031, size.height * 0.5715585, size.width * 0.9003525, size.height * 0.5702904,
        size.width * 0.8980777, size.height * 0.5719460);
    path_8.cubicTo(size.width * 0.8969316, size.height * 0.5727802, size.width * 0.8947561, size.height * 0.5707550,
        size.width * 0.8937354, size.height * 0.5703835);
    path_8.cubicTo(size.width * 0.8935490, size.height * 0.5703158, size.width * 0.8906844, size.height * 0.5754012,
        size.width * 0.8904664, size.height * 0.5756392);
    path_8.cubicTo(size.width * 0.8891934, size.height * 0.5770289, size.width * 0.8868369, size.height * 0.5740489,
        size.width * 0.8864901, size.height * 0.5735440);
    path_8.cubicTo(size.width * 0.8851495, size.height * 0.5715927, size.width * 0.8839855, size.height * 0.5706558,
        size.width * 0.8821477, size.height * 0.5693182);
    path_8.cubicTo(size.width * 0.8801490, size.height * 0.5678634, size.width * 0.8790233, size.height * 0.5681095,
        size.width * 0.8770735, size.height * 0.5666903);
    path_8.cubicTo(size.width * 0.8754400, size.height * 0.5655012, size.width * 0.8729773, size.height * 0.5645112,
        size.width * 0.8712920, size.height * 0.5635298);
    path_8.cubicTo(size.width * 0.8697760, size.height * 0.5626471, size.width * 0.8688481, size.height * 0.5612361,
        size.width * 0.8676571, size.height * 0.5603693);
    path_8.cubicTo(size.width * 0.8659650, size.height * 0.5591378, size.width * 0.8652225, size.height * 0.5583878,
        size.width * 0.8636807, size.height * 0.5561435);
    path_8.cubicTo(size.width * 0.8635600, size.height * 0.5559677, size.width * 0.8634354, size.height * 0.5557865,
        size.width * 0.8633148, size.height * 0.5556108);
    path_8.cubicTo(size.width * 0.8626903, size.height * 0.5547016, size.width * 0.8593568, size.height * 0.5540483,
        size.width * 0.8582406, size.height * 0.5540483);
    path_8.cubicTo(size.width * 0.8565205, size.height * 0.5540483, size.width * 0.8560893, size.height * 0.5571800,
        size.width * 0.8553621, size.height * 0.5582386);
    path_8.cubicTo(size.width * 0.8542973, size.height * 0.5597885, size.width * 0.8529628, size.height * 0.5617311,
        size.width * 0.8528250, size.height * 0.5619318);
    path_8.cubicTo(size.width * 0.8520874, size.height * 0.5630052, size.width * 0.8485205, size.height * 0.5606494,
        size.width * 0.8477508, size.height * 0.5603693);
    path_8.cubicTo(size.width * 0.8461626, size.height * 0.5597914, size.width * 0.8438632, size.height * 0.5602684,
        size.width * 0.8426767, size.height * 0.5598366);
    path_8.cubicTo(size.width * 0.8411203, size.height * 0.5592703, size.width * 0.8396953, size.height * 0.5583699,
        size.width * 0.8379684, size.height * 0.5577415);
    path_8.cubicTo(size.width * 0.8360760, size.height * 0.5570528, size.width * 0.8347858, size.height * 0.5563592,
        size.width * 0.8339920, size.height * 0.5540483);
    path_8.cubicTo(size.width * 0.8334439, size.height * 0.5524527, size.width * 0.8332601, size.height * 0.5489868,
        size.width * 0.8332601, size.height * 0.5466619);
    path_8.cubicTo(size.width * 0.8332603, size.height * 0.5440262, size.width * 0.8332601, size.height * 0.5413786,
        size.width * 0.8332601, size.height * 0.5387429);
    path_8.cubicTo(size.width * 0.8332603, size.height * 0.5362173, size.width * 0.8321624, size.height * 0.5350656,
        size.width * 0.8321624, size.height * 0.5324219);
    path_8.cubicTo(size.width * 0.8321624, size.height * 0.5296356, size.width * 0.8311824, size.height * 0.5269057,
        size.width * 0.8303571, size.height * 0.5245028);
    path_8.cubicTo(size.width * 0.8295440, size.height * 0.5221357, size.width * 0.8286842, size.height * 0.5225801,
        size.width * 0.8267467, size.height * 0.5218750);
    path_8.cubicTo(size.width * 0.8247316, size.height * 0.5211417, size.width * 0.8237858, size.height * 0.5229703,
        size.width * 0.8224044, size.height * 0.5234730);
    path_8.cubicTo(size.width * 0.8199437, size.height * 0.5243685, size.width * 0.8193405, size.height * 0.5240700,
        size.width * 0.8184036, size.height * 0.5213423);
    path_8.cubicTo(size.width * 0.8171681, size.height * 0.5177456, size.width * 0.8198957, size.height * 0.5171579,
        size.width * 0.8180621, size.height * 0.5144886);
    path_8.cubicTo(size.width * 0.8167396, size.height * 0.5125636, size.width * 0.8164927, size.height * 0.5110500,
        size.width * 0.8144272, size.height * 0.5102983);
    path_8.cubicTo(size.width * 0.8138590, size.height * 0.5100915, size.width * 0.8125046, size.height * 0.5070951,
        size.width * 0.8111583, size.height * 0.5066051);
    path_8.cubicTo(size.width * 0.8111094, size.height * 0.5065873, size.width * 0.8110553, size.height * 0.5065943,
        size.width * 0.8109875, size.height * 0.5066051);
    path_8.close();
    Paint paint8Fill = Paint()..style = PaintingStyle.fill;
    paint8Fill.color = southeasternAnatoliaColor;
    canvas.drawPath(path_8, paint8Fill);

    /// GüneyDoğuAnadolu Bölgesi Bitiş

    /// Akdeniz Bölgesi Başlangıç
    Path path_9 = Path();
    path_9.moveTo(size.width * 0.5890662, size.height * 0.5149858);
    path_9.cubicTo(size.width * 0.5889800, size.height * 0.5149904, size.width * 0.5889021, size.height * 0.5149922,
        size.width * 0.5888222, size.height * 0.5150213);
    path_9.cubicTo(size.width * 0.5869930, size.height * 0.5156870, size.width * 0.5857904, size.height * 0.5164087,
        size.width * 0.5837480, size.height * 0.5171520);
    path_9.cubicTo(size.width * 0.5824700, size.height * 0.5176171, size.width * 0.5798829, size.height * 0.5170532,
        size.width * 0.5783324, size.height * 0.5181818);
    path_9.cubicTo(size.width * 0.5767246, size.height * 0.5193520, size.width * 0.5751720, size.height * 0.5201773,
        size.width * 0.5746975, size.height * 0.5229403);
    path_9.cubicTo(size.width * 0.5742640, size.height * 0.5254645, size.width * 0.5740367, size.height * 0.5273919,
        size.width * 0.5736241, size.height * 0.5297940);
    path_9.cubicTo(size.width * 0.5732547, size.height * 0.5319454, size.width * 0.5726962, size.height * 0.5349438,
        size.width * 0.5710870, size.height * 0.5361151);
    path_9.cubicTo(size.width * 0.5698350, size.height * 0.5370263, size.width * 0.5692011, size.height * 0.5382689,
        size.width * 0.5678181, size.height * 0.5392756);
    path_9.cubicTo(size.width * 0.5665180, size.height * 0.5402218, size.width * 0.5657120, size.height * 0.5447710,
        size.width * 0.5645492, size.height * 0.5435014);
    path_9.cubicTo(size.width * 0.5638085, size.height * 0.5426927, size.width * 0.5627280, size.height * 0.5412887,
        size.width * 0.5620365, size.height * 0.5392756);
    path_9.cubicTo(size.width * 0.5613375, size.height * 0.5372405, size.width * 0.5610876, size.height * 0.5364848,
        size.width * 0.5605728, size.height * 0.5334872);
    path_9.cubicTo(size.width * 0.5602644, size.height * 0.5316918, size.width * 0.5594755, size.height * 0.5290126,
        size.width * 0.5573283, size.height * 0.5297940);
    path_9.cubicTo(size.width * 0.5559375, size.height * 0.5303001, size.width * 0.5545091, size.height * 0.5307628,
        size.width * 0.5529616, size.height * 0.5318892);
    path_9.cubicTo(size.width * 0.5514809, size.height * 0.5329669, size.width * 0.5500733, size.height * 0.5339984,
        size.width * 0.5489852, size.height * 0.5355824);
    path_9.cubicTo(size.width * 0.5475555, size.height * 0.5376635, size.width * 0.5453096, size.height * 0.5399624,
        size.width * 0.5442769, size.height * 0.5429688);
    path_9.cubicTo(size.width * 0.5437620, size.height * 0.5444680, size.width * 0.5427906, size.height * 0.5464359,
        size.width * 0.5424717, size.height * 0.5487571);
    path_9.cubicTo(size.width * 0.5421594, size.height * 0.5510302, size.width * 0.5417991, size.height * 0.5546554,
        size.width * 0.5410324, size.height * 0.5561435);
    path_9.cubicTo(size.width * 0.5404833, size.height * 0.5572091, size.width * 0.5387472, size.height * 0.5608997,
        size.width * 0.5370316, size.height * 0.5613991);
    path_9.cubicTo(size.width * 0.5346146, size.height * 0.5621028, size.width * 0.5337038, size.height * 0.5631858,
        size.width * 0.5319575, size.height * 0.5650923);
    path_9.cubicTo(size.width * 0.5305673, size.height * 0.5666101, size.width * 0.5289427, size.height * 0.5672866,
        size.width * 0.5276151, size.height * 0.5682528);
    path_9.cubicTo(size.width * 0.5266909, size.height * 0.5689255, size.width * 0.5231833, size.height * 0.5701116,
        size.width * 0.5229069, size.height * 0.5709162);
    path_9.cubicTo(size.width * 0.5222765, size.height * 0.5727516, size.width * 0.5215542, size.height * 0.5748544,
        size.width * 0.5207358, size.height * 0.5772372);
    path_9.cubicTo(size.width * 0.5201796, size.height * 0.5788565, size.width * 0.5190010, size.height * 0.5814631,
        size.width * 0.5171253, size.height * 0.5814631);
    path_9.cubicTo(size.width * 0.5153091, size.height * 0.5814631, size.width * 0.5145179, size.height * 0.5830256,
        size.width * 0.5127830, size.height * 0.5830256);
    path_9.cubicTo(size.width * 0.5108278, size.height * 0.5830256, size.width * 0.5091409, size.height * 0.5840909,
        size.width * 0.5073429, size.height * 0.5840909);
    path_9.cubicTo(size.width * 0.5055686, size.height * 0.5840909, size.width * 0.5040614, size.height * 0.5836780,
        size.width * 0.5022687, size.height * 0.5830256);
    path_9.cubicTo(size.width * 0.5010482, size.height * 0.5825814, size.width * 0.4975605, size.height * 0.5815319,
        size.width * 0.4975605, size.height * 0.5846236);
    path_9.cubicTo(size.width * 0.4975605, size.height * 0.5871655, size.width * 0.4979264, size.height * 0.5901950,
        size.width * 0.4979264, size.height * 0.5919744);
    path_9.cubicTo(size.width * 0.4979264, size.height * 0.5951240, size.width * 0.4968341, size.height * 0.5959477,
        size.width * 0.4950234, size.height * 0.5972656);
    path_9.cubicTo(size.width * 0.4939771, size.height * 0.5980272, size.width * 0.4927738, size.height * 0.5989778,
        size.width * 0.4917789, size.height * 0.6004261);
    path_9.cubicTo(size.width * 0.4907923, size.height * 0.6018623, size.width * 0.4904490, size.height * 0.6034273,
        size.width * 0.4892418, size.height * 0.6051847);
    path_9.cubicTo(size.width * 0.4878490, size.height * 0.6072121, size.width * 0.4870778, size.height * 0.6075399,
        size.width * 0.4848995, size.height * 0.6067472);
    path_9.cubicTo(size.width * 0.4829016, size.height * 0.6060201, size.width * 0.4822037, size.height * 0.6049494,
        size.width * 0.4801913, size.height * 0.6056818);
    path_9.cubicTo(size.width * 0.4780634, size.height * 0.6064562, size.width * 0.4780201, size.height * 0.6067046,
        size.width * 0.4780201, size.height * 0.6104403);
    path_9.cubicTo(size.width * 0.4780201, size.height * 0.6126784, size.width * 0.4780708, size.height * 0.6159146,
        size.width * 0.4787276, size.height * 0.6178267);
    path_9.cubicTo(size.width * 0.4792269, size.height * 0.6192804, size.width * 0.4811389, size.height * 0.6212488,
        size.width * 0.4794594, size.height * 0.6230824);
    path_9.cubicTo(size.width * 0.4784548, size.height * 0.6241792, size.width * 0.4766689, size.height * 0.6259865,
        size.width * 0.4758489, size.height * 0.6283736);
    path_9.cubicTo(size.width * 0.4751472, size.height * 0.6304167, size.width * 0.4772525, size.height * 0.6362489,
        size.width * 0.4758489, size.height * 0.6352273);
    path_9.cubicTo(size.width * 0.4746861, size.height * 0.6343809, size.width * 0.4734754, size.height * 0.6326376,
        size.width * 0.4722141, size.height * 0.6330966);
    path_9.cubicTo(size.width * 0.4711136, size.height * 0.6334971, size.width * 0.4679160, size.height * 0.6383878,
        size.width * 0.4678718, size.height * 0.6383878);
    path_9.cubicTo(size.width * 0.4665909, size.height * 0.6383878, size.width * 0.4644108, size.height * 0.6359607,
        size.width * 0.4631635, size.height * 0.6373224);
    path_9.cubicTo(size.width * 0.4618267, size.height * 0.6387820, size.width * 0.4606175, size.height * 0.6399764,
        size.width * 0.4598946, size.height * 0.6420810);
    path_9.cubicTo(size.width * 0.4593501, size.height * 0.6436661, size.width * 0.4583695, size.height * 0.6449231,
        size.width * 0.4577235, size.height * 0.6468040);
    path_9.cubicTo(size.width * 0.4569370, size.height * 0.6490936, size.width * 0.4562227, size.height * 0.6500839,
        size.width * 0.4551864, size.height * 0.6520952);
    path_9.cubicTo(size.width * 0.4540589, size.height * 0.6542834, size.width * 0.4530559, size.height * 0.6560073,
        size.width * 0.4512100, size.height * 0.6573509);
    path_9.cubicTo(size.width * 0.4496445, size.height * 0.6584903, size.width * 0.4478769, size.height * 0.6598979,
        size.width * 0.4457699, size.height * 0.6605114);
    path_9.cubicTo(size.width * 0.4434692, size.height * 0.6611812, size.width * 0.4406235, size.height * 0.6608218,
        size.width * 0.4385490, size.height * 0.6615767);
    path_9.cubicTo(size.width * 0.4381869, size.height * 0.6615767, size.width * 0.4378025, size.height * 0.6614489,
        size.width * 0.4374512, size.height * 0.6615767);
    path_9.cubicTo(size.width * 0.4360585, size.height * 0.6620835, size.width * 0.4338391, size.height * 0.6626090,
        size.width * 0.4327430, size.height * 0.6642045);
    path_9.cubicTo(size.width * 0.4319941, size.height * 0.6652946, size.width * 0.4315045, size.height * 0.6680179,
        size.width * 0.4302059, size.height * 0.6689631);
    path_9.cubicTo(size.width * 0.4288966, size.height * 0.6699160, size.width * 0.4269291, size.height * 0.6709368,
        size.width * 0.4251317, size.height * 0.6715909);
    path_9.cubicTo(size.width * 0.4237637, size.height * 0.6720888, size.width * 0.4217081, size.height * 0.6725259,
        size.width * 0.4204235, size.height * 0.6715909);
    path_9.cubicTo(size.width * 0.4190519, size.height * 0.6705926, size.width * 0.4175162, size.height * 0.6704029,
        size.width * 0.4157153, size.height * 0.6710582);
    path_9.cubicTo(size.width * 0.4146818, size.height * 0.6714343, size.width * 0.4125605, size.height * 0.6717919,
        size.width * 0.4113730, size.height * 0.6726562);
    path_9.cubicTo(size.width * 0.4101890, size.height * 0.6735180, size.width * 0.4087528, size.height * 0.6736861,
        size.width * 0.4066647, size.height * 0.6736861);
    path_9.cubicTo(size.width * 0.4051740, size.height * 0.6736861, size.width * 0.4044821, size.height * 0.6738584,
        size.width * 0.4026883, size.height * 0.6758168);
    path_9.cubicTo(size.width * 0.4014323, size.height * 0.6771880, size.width * 0.3998966, size.height * 0.6783814,
        size.width * 0.3983460, size.height * 0.6795099);
    path_9.cubicTo(size.width * 0.3970800, size.height * 0.6804314, size.width * 0.3957383, size.height * 0.6811762,
        size.width * 0.3943696, size.height * 0.6826705);
    path_9.cubicTo(size.width * 0.3934299, size.height * 0.6836964, size.width * 0.3922366, size.height * 0.6855369,
        size.width * 0.3911007, size.height * 0.6863636);
    path_9.cubicTo(size.width * 0.3895793, size.height * 0.6874710, size.width * 0.3885432, size.height * 0.6900376,
        size.width * 0.3871243, size.height * 0.6905540);
    path_9.cubicTo(size.width * 0.3857978, size.height * 0.6910367, size.width * 0.3823816, size.height * 0.6916841,
        size.width * 0.3816842, size.height * 0.6937145);
    path_9.cubicTo(size.width * 0.3808703, size.height * 0.6960841, size.width * 0.3807227, size.height * 0.6976060,
        size.width * 0.3820502, size.height * 0.6995384);
    path_9.cubicTo(size.width * 0.3824906, size.height * 0.7001795, size.width * 0.3842588, size.height * 0.7034760,
        size.width * 0.3849532, size.height * 0.7037287);
    path_9.cubicTo(size.width * 0.3867766, size.height * 0.7043923, size.width * 0.3872814, size.height * 0.7066207,
        size.width * 0.3885636, size.height * 0.7084872);
    path_9.cubicTo(size.width * 0.3899132, size.height * 0.7104519, size.width * 0.3909831, size.height * 0.7109438,
        size.width * 0.3921985, size.height * 0.7127131);
    path_9.cubicTo(size.width * 0.3927052, size.height * 0.7134507, size.width * 0.3951401, size.height * 0.7160037,
        size.width * 0.3947112, size.height * 0.7185014);
    path_9.cubicTo(size.width * 0.3943331, size.height * 0.7207030, size.width * 0.3937726, size.height * 0.7210489,
        size.width * 0.3914666, size.height * 0.7227273);
    path_9.cubicTo(size.width * 0.3901247, size.height * 0.7237040, size.width * 0.3880932, size.height * 0.7246499,
        size.width * 0.3863925, size.height * 0.7258878);
    path_9.cubicTo(size.width * 0.3846865, size.height * 0.7271295, size.width * 0.3828587, size.height * 0.7278219,
        size.width * 0.3809524, size.height * 0.7285156);
    path_9.cubicTo(size.width * 0.3796556, size.height * 0.7289875, size.width * 0.3782467, size.height * 0.7311435,
        size.width * 0.3769760, size.height * 0.7311435);
    path_9.cubicTo(size.width * 0.3751653, size.height * 0.7311435, size.width * 0.3733466, size.height * 0.7311435,
        size.width * 0.3715359, size.height * 0.7311435);
    path_9.cubicTo(size.width * 0.3696608, size.height * 0.7311435, size.width * 0.3690675, size.height * 0.7301459,
        size.width * 0.3675595, size.height * 0.7290483);
    path_9.cubicTo(size.width * 0.3664857, size.height * 0.7282667, size.width * 0.3653056, size.height * 0.7274078,
        size.width * 0.3639491, size.height * 0.7264205);
    path_9.cubicTo(size.width * 0.3628754, size.height * 0.7256390, size.width * 0.3606017, size.height * 0.7247083,
        size.width * 0.3596068, size.height * 0.7232599);
    path_9.cubicTo(size.width * 0.3586463, size.height * 0.7218619, size.width * 0.3578319, size.height * 0.7201878,
        size.width * 0.3570697, size.height * 0.7179688);
    path_9.cubicTo(size.width * 0.3562195, size.height * 0.7154934, size.width * 0.3561364, size.height * 0.7136707,
        size.width * 0.3556060, size.height * 0.7105824);
    path_9.cubicTo(size.width * 0.3552405, size.height * 0.7084545, size.width * 0.3545326, size.height * 0.7056584,
        size.width * 0.3545326, size.height * 0.7037287);
    path_9.cubicTo(size.width * 0.3545326, size.height * 0.7016629, size.width * 0.3540182, size.height * 0.6985736,
        size.width * 0.3534348, size.height * 0.6968750);
    path_9.cubicTo(size.width * 0.3532211, size.height * 0.6962528, size.width * 0.3523412, size.height * 0.6913456,
        size.width * 0.3516296, size.height * 0.6910866);
    path_9.cubicTo(size.width * 0.3499015, size.height * 0.6904578, size.width * 0.3491361, size.height * 0.6891316,
        size.width * 0.3472873, size.height * 0.6884588);
    path_9.cubicTo(size.width * 0.3450386, size.height * 0.6876405, size.width * 0.3457330, size.height * 0.6867953,
        size.width * 0.3451161, size.height * 0.6832031);
    path_9.cubicTo(size.width * 0.3446735, size.height * 0.6806258, size.width * 0.3440555, size.height * 0.6795472,
        size.width * 0.3433109, size.height * 0.6773793);
    path_9.cubicTo(size.width * 0.3426661, size.height * 0.6755020, size.width * 0.3419344, size.height * 0.6745081,
        size.width * 0.3411153, size.height * 0.6721236);
    path_9.cubicTo(size.width * 0.3403797, size.height * 0.6699818, size.width * 0.3397256, size.height * 0.6684487,
        size.width * 0.3382367, size.height * 0.6673651);
    path_9.cubicTo(size.width * 0.3369111, size.height * 0.6664002, size.width * 0.3350368, size.height * 0.6648022,
        size.width * 0.3338944, size.height * 0.6631392);
    path_9.cubicTo(size.width * 0.3331723, size.height * 0.6620881, size.width * 0.3315823, size.height * 0.6606693,
        size.width * 0.3309914, size.height * 0.6589489);
    path_9.cubicTo(size.width * 0.3303702, size.height * 0.6571403, size.width * 0.3297241, size.height * 0.6550439,
        size.width * 0.3284543, size.height * 0.6536577);
    path_9.cubicTo(size.width * 0.3275146, size.height * 0.6526317, size.width * 0.3263213, size.height * 0.6507912,
        size.width * 0.3251854, size.height * 0.6499645);
    path_9.cubicTo(size.width * 0.3235536, size.height * 0.6487768, size.width * 0.3225694, size.height * 0.6477565,
        size.width * 0.3212090, size.height * 0.6462713);
    path_9.cubicTo(size.width * 0.3199588, size.height * 0.6449064, size.width * 0.3185823, size.height * 0.6435605,
        size.width * 0.3172326, size.height * 0.6425781);
    path_9.cubicTo(size.width * 0.3159407, size.height * 0.6416378, size.width * 0.3140633, size.height * 0.6410156,
        size.width * 0.3121585, size.height * 0.6410156);
    path_9.cubicTo(size.width * 0.3103478, size.height * 0.6410156, size.width * 0.3085290, size.height * 0.6410156,
        size.width * 0.3067184, size.height * 0.6410156);
    path_9.cubicTo(size.width * 0.3053565, size.height * 0.6410156, size.width * 0.3022465, size.height * 0.6418568,
        size.width * 0.3013027, size.height * 0.6404830);
    path_9.cubicTo(size.width * 0.3004446, size.height * 0.6392338, size.width * 0.2991709, size.height * 0.6376174,
        size.width * 0.2980338, size.height * 0.6367898);
    path_9.cubicTo(size.width * 0.2969403, size.height * 0.6359939, size.width * 0.2955557, size.height * 0.6350909,
        size.width * 0.2965945, size.height * 0.6320668);
    path_9.cubicTo(size.width * 0.2972826, size.height * 0.6300633, size.width * 0.2980338, size.height * 0.6274288,
        size.width * 0.2980338, size.height * 0.6252131);
    path_9.cubicTo(size.width * 0.2980338, size.height * 0.6222302, size.width * 0.2983120, size.height * 0.6199350,
        size.width * 0.2987656, size.height * 0.6172940);
    path_9.cubicTo(size.width * 0.2991811, size.height * 0.6148750, size.width * 0.2993587, size.height * 0.6132372,
        size.width * 0.2998390, size.height * 0.6104403);
    path_9.cubicTo(size.width * 0.3002012, size.height * 0.6083313, size.width * 0.3004858, size.height * 0.6056796,
        size.width * 0.3009368, size.height * 0.6030540);
    path_9.cubicTo(size.width * 0.3012334, size.height * 0.6013267, size.width * 0.3020101, size.height * 0.5988712,
        size.width * 0.3020101, size.height * 0.5962003);
    path_9.cubicTo(size.width * 0.3020101, size.height * 0.5934599, size.width * 0.3012850, size.height * 0.5919067,
        size.width * 0.3009368, size.height * 0.5898793);
    path_9.cubicTo(size.width * 0.3005234, size.height * 0.5874721, size.width * 0.2992100, size.height * 0.5866783,
        size.width * 0.2987656, size.height * 0.5840909);
    path_9.cubicTo(size.width * 0.2984179, size.height * 0.5820664, size.width * 0.2972522, size.height * 0.5798835,
        size.width * 0.2994731, size.height * 0.5782670);
    path_9.cubicTo(size.width * 0.3011071, size.height * 0.5770777, size.width * 0.3022242, size.height * 0.5767046,
        size.width * 0.3045472, size.height * 0.5767045);
    path_9.cubicTo(size.width * 0.3069229, size.height * 0.5767045, size.width * 0.3072248, size.height * 0.5765001,
        size.width * 0.3085236, size.height * 0.5746094);
    path_9.cubicTo(size.width * 0.3096329, size.height * 0.5729947, size.width * 0.3110607, size.height * 0.5715543,
        size.width * 0.3110607, size.height * 0.5693182);
    path_9.cubicTo(size.width * 0.3110607, size.height * 0.5660268, size.width * 0.3100108, size.height * 0.5662615,
        size.width * 0.3092555, size.height * 0.5640625);
    path_9.cubicTo(size.width * 0.3085800, size.height * 0.5620959, size.width * 0.3069149, size.height * 0.5614742,
        size.width * 0.3063525, size.height * 0.5598366);
    path_9.cubicTo(size.width * 0.3056419, size.height * 0.5577680, size.width * 0.3050222, size.height * 0.5573676,
        size.width * 0.3038154, size.height * 0.5556108);
    path_9.cubicTo(size.width * 0.3024180, size.height * 0.5535767, size.width * 0.3014973, size.height * 0.5525919,
        size.width * 0.2998390, size.height * 0.5513849);
    path_9.cubicTo(size.width * 0.2980442, size.height * 0.5500786, size.width * 0.2977121, size.height * 0.5482744,
        size.width * 0.2962285, size.height * 0.5471946);
    path_9.cubicTo(size.width * 0.2951043, size.height * 0.5463763, size.width * 0.2939938, size.height * 0.5454470,
        size.width * 0.2933255, size.height * 0.5435014);
    path_9.cubicTo(size.width * 0.2926512, size.height * 0.5415382, size.width * 0.2929252, size.height * 0.5405627,
        size.width * 0.2929596, size.height * 0.5376776);
    path_9.cubicTo(size.width * 0.2923438, size.height * 0.5385740, size.width * 0.2901105, size.height * 0.5340629,
        size.width * 0.2897151, size.height * 0.5334872);
    path_9.cubicTo(size.width * 0.2884435, size.height * 0.5316362, size.width * 0.2885043, size.height * 0.5296440,
        size.width * 0.2871780, size.height * 0.5281960);
    path_9.cubicTo(size.width * 0.2857048, size.height * 0.5265876, size.width * 0.2849414, size.height * 0.5263793,
        size.width * 0.2831772, size.height * 0.5276634);
    path_9.cubicTo(size.width * 0.2814717, size.height * 0.5289047, size.width * 0.2810769, size.height * 0.5307563,
        size.width * 0.2799327, size.height * 0.5324219);
    path_9.cubicTo(size.width * 0.2787527, size.height * 0.5341395, size.width * 0.2779579, size.height * 0.5358291,
        size.width * 0.2770297, size.height * 0.5371804);
    path_9.cubicTo(size.width * 0.2756367, size.height * 0.5392081, size.width * 0.2748341, size.height * 0.5403765,
        size.width * 0.2734192, size.height * 0.5424361);
    path_9.cubicTo(size.width * 0.2721395, size.height * 0.5442990, size.width * 0.2713743, size.height * 0.5448801,
        size.width * 0.2701503, size.height * 0.5466619);
    path_9.cubicTo(size.width * 0.2688705, size.height * 0.5485248, size.width * 0.2684714, size.height * 0.5496031,
        size.width * 0.2672473, size.height * 0.5513849);
    path_9.cubicTo(size.width * 0.2659015, size.height * 0.5533439, size.width * 0.2638566, size.height * 0.5535156,
        size.width * 0.2618316, size.height * 0.5535156);
    path_9.cubicTo(size.width * 0.2591381, size.height * 0.5535156, size.width * 0.2578744, size.height * 0.5542091,
        size.width * 0.2556596, size.height * 0.5561435);
    path_9.cubicTo(size.width * 0.2537678, size.height * 0.5577958, size.width * 0.2528764, size.height * 0.5589907,
        size.width * 0.2520492, size.height * 0.5613991);
    path_9.cubicTo(size.width * 0.2513647, size.height * 0.5633920, size.width * 0.2499337, size.height * 0.5644786,
        size.width * 0.2491462, size.height * 0.5656250);
    path_9.cubicTo(size.width * 0.2480965, size.height * 0.5671530, size.width * 0.2471426, size.height * 0.5685415,
        size.width * 0.2462432, size.height * 0.5698509);
    path_9.cubicTo(size.width * 0.2447045, size.height * 0.5720907, size.width * 0.2440661, size.height * 0.5730554,
        size.width * 0.2429986, size.height * 0.5746094);
    path_9.cubicTo(size.width * 0.2418026, size.height * 0.5763504, size.width * 0.2409257, size.height * 0.5765260,
        size.width * 0.2397297, size.height * 0.5782670);
    path_9.cubicTo(size.width * 0.2381589, size.height * 0.5805537, size.width * 0.2373488, size.height * 0.5811717,
        size.width * 0.2361192, size.height * 0.5835582);
    path_9.cubicTo(size.width * 0.2349168, size.height * 0.5858920, size.width * 0.2372140, size.height * 0.5878733,
        size.width * 0.2375585, size.height * 0.5898793);
    path_9.cubicTo(size.width * 0.2380544, size.height * 0.5927665, size.width * 0.2352346, size.height * 0.5941808,
        size.width * 0.2339237, size.height * 0.5951349);
    path_9.cubicTo(size.width * 0.2323848, size.height * 0.5962550, size.width * 0.2316719, size.height * 0.5983719,
        size.width * 0.2303132, size.height * 0.5993608);
    path_9.cubicTo(size.width * 0.2289491, size.height * 0.6003537, size.width * 0.2268594, size.height * 0.5998935,
        size.width * 0.2252391, size.height * 0.5998935);
    path_9.cubicTo(size.width * 0.2231802, size.height * 0.5998935, size.width * 0.2213810, size.height * 0.6004261,
        size.width * 0.2194575, size.height * 0.6004261);
    path_9.cubicTo(size.width * 0.2177366, size.height * 0.6004261, size.width * 0.2155699, size.height * 0.6027230,
        size.width * 0.2143833, size.height * 0.6035866);
    path_9.cubicTo(size.width * 0.2129242, size.height * 0.6046486, size.width * 0.2116998, size.height * 0.6058684,
        size.width * 0.2104069, size.height * 0.6072798);
    path_9.cubicTo(size.width * 0.2091661, size.height * 0.6086344, size.width * 0.2080895, size.height * 0.6106000,
        size.width * 0.2067721, size.height * 0.6120384);
    path_9.cubicTo(size.width * 0.2053324, size.height * 0.6136101, size.width * 0.2038534, size.height * 0.6151779,
        size.width * 0.2024297, size.height * 0.6156960);
    path_9.cubicTo(size.width * 0.2019962, size.height * 0.6158538, size.width * 0.2016979, size.height * 0.6225274,
        size.width * 0.2016979, size.height * 0.6236151);
    path_9.cubicTo(size.width * 0.2016979, size.height * 0.6253808, size.width * 0.2025138, size.height * 0.6282948,
        size.width * 0.2027957, size.height * 0.6299361);
    path_9.cubicTo(size.width * 0.2028963, size.height * 0.6305219, size.width * 0.2052891, size.height * 0.6312445,
        size.width * 0.2056987, size.height * 0.6336293);
    path_9.cubicTo(size.width * 0.2060805, size.height * 0.6358528, size.width * 0.2038253, size.height * 0.6384514,
        size.width * 0.2027957, size.height * 0.6399503);
    path_9.cubicTo(size.width * 0.2013379, size.height * 0.6420724, size.width * 0.1999244, size.height * 0.6441655,
        size.width * 0.1988193, size.height * 0.6457741);
    path_9.cubicTo(size.width * 0.1981049, size.height * 0.6468141, size.width * 0.1979763, size.height * 0.6508208,
        size.width * 0.1973556, size.height * 0.6526278);
    path_9.cubicTo(size.width * 0.1965665, size.height * 0.6549252, size.width * 0.1962822, size.height * 0.6568609,
        size.width * 0.1962822, size.height * 0.6599787);
    path_9.cubicTo(size.width * 0.1962822, size.height * 0.6628061, size.width * 0.1958943, size.height * 0.6648295,
        size.width * 0.1955504, size.height * 0.6668324);
    path_9.cubicTo(size.width * 0.1949513, size.height * 0.6703206, size.width * 0.1959163, size.height * 0.6698477,
        size.width * 0.1959163, size.height * 0.6731534);
    path_9.cubicTo(size.width * 0.1959163, size.height * 0.6748978, size.width * 0.1939250, size.height * 0.6776502,
        size.width * 0.1937451, size.height * 0.6779119);
    path_9.cubicTo(size.width * 0.1933851, size.height * 0.6784361, size.width * 0.1977882, size.height * 0.6786624,
        size.width * 0.1980874, size.height * 0.6784446);
    path_9.cubicTo(size.width * 0.1995555, size.height * 0.6773761, size.width * 0.2000752, size.height * 0.6749250,
        size.width * 0.2016979, size.height * 0.6731534);
    path_9.cubicTo(size.width * 0.2030033, size.height * 0.6717282, size.width * 0.2044603, size.height * 0.6714188,
        size.width * 0.2056987, size.height * 0.6710582);
    path_9.cubicTo(size.width * 0.2071724, size.height * 0.6706292, size.width * 0.2080793, size.height * 0.6734939,
        size.width * 0.2089432, size.height * 0.6747514);
    path_9.cubicTo(size.width * 0.2097900, size.height * 0.6759841, size.width * 0.2100410, size.height * 0.6786589,
        size.width * 0.2100410, size.height * 0.6810724);
    path_9.cubicTo(size.width * 0.2100410, size.height * 0.6841119, size.width * 0.2099011, size.height * 0.6862027,
        size.width * 0.2093091, size.height * 0.6879261);
    path_9.cubicTo(size.width * 0.2084325, size.height * 0.6904784, size.width * 0.2080711, size.height * 0.6915304,
        size.width * 0.2071380, size.height * 0.6942472);
    path_9.cubicTo(size.width * 0.2065327, size.height * 0.6960094, size.width * 0.2058441, size.height * 0.6965612,
        size.width * 0.2053327, size.height * 0.6995384);
    path_9.cubicTo(size.width * 0.2049266, size.height * 0.7019031, size.width * 0.2045748, size.height * 0.7038804,
        size.width * 0.2042350, size.height * 0.7058594);
    path_9.cubicTo(size.width * 0.2038081, size.height * 0.7083452, size.width * 0.2038690, size.height * 0.7109925,
        size.width * 0.2038690, size.height * 0.7137429);
    path_9.cubicTo(size.width * 0.2038691, size.height * 0.7150475, size.width * 0.1998837, size.height * 0.7166791,
        size.width * 0.1995267, size.height * 0.7169389);
    path_9.cubicTo(size.width * 0.1981001, size.height * 0.7179773, size.width * 0.1978733, size.height * 0.7193459,
        size.width * 0.1966481, size.height * 0.7211293);
    path_9.cubicTo(size.width * 0.1954157, size.height * 0.7229232, size.width * 0.1948762, size.height * 0.7236602,
        size.width * 0.1941110, size.height * 0.7258878);
    path_9.cubicTo(size.width * 0.1934103, size.height * 0.7279279, size.width * 0.1926450, size.height * 0.7295594,
        size.width * 0.1922814, size.height * 0.7316761);
    path_9.cubicTo(size.width * 0.1918844, size.height * 0.7339878, size.width * 0.1922365, size.height * 0.7373354,
        size.width * 0.1919399, size.height * 0.7390625);
    path_9.cubicTo(size.width * 0.1914710, size.height * 0.7417925, size.width * 0.1900886, size.height * 0.7417040,
        size.width * 0.1882075, size.height * 0.7416903);
    path_9.cubicTo(size.width * 0.1883157, size.height * 0.7424726, size.width * 0.1884602, size.height * 0.7432074,
        size.width * 0.1886710, size.height * 0.7438210);
    path_9.cubicTo(size.width * 0.1894246, size.height * 0.7460152, size.width * 0.1901449, size.height * 0.7468610,
        size.width * 0.1919399, size.height * 0.7475142);
    path_9.cubicTo(size.width * 0.1934062, size.height * 0.7480478, size.width * 0.1951258, size.height * 0.7490554,
        size.width * 0.1966481, size.height * 0.7496094);
    path_9.cubicTo(size.width * 0.1981657, size.height * 0.7501616, size.width * 0.1998466, size.height * 0.7511719,
        size.width * 0.2013320, size.height * 0.7511719);
    path_9.cubicTo(size.width * 0.2025138, size.height * 0.7511719, size.width * 0.2056489, size.height * 0.7526960,
        size.width * 0.2060402, size.height * 0.7538352);
    path_9.cubicTo(size.width * 0.2063101, size.height * 0.7546210, size.width * 0.2070332, size.height * 0.7593191,
        size.width * 0.2078698, size.height * 0.7596236);
    path_9.cubicTo(size.width * 0.2088793, size.height * 0.7599909, size.width * 0.2104069, size.height * 0.7606505,
        size.width * 0.2104069, size.height * 0.7580256);
    path_9.cubicTo(size.width * 0.2104069, size.height * 0.7531984, size.width * 0.2116303, size.height * 0.7559304,
        size.width * 0.2132855, size.height * 0.7559304);
    path_9.cubicTo(size.width * 0.2156086, size.height * 0.7559304, size.width * 0.2158107, size.height * 0.7550291,
        size.width * 0.2176278, size.height * 0.7543679);
    path_9.cubicTo(size.width * 0.2191775, size.height * 0.7538039, size.width * 0.2212674, size.height * 0.7537929,
        size.width * 0.2223361, size.height * 0.7522372);
    path_9.cubicTo(size.width * 0.2231057, size.height * 0.7511169, size.width * 0.2243137, size.height * 0.7491471,
        size.width * 0.2259709, size.height * 0.7485440);
    path_9.cubicTo(size.width * 0.2272282, size.height * 0.7480865, size.width * 0.2296779, size.height * 0.7481449,
        size.width * 0.2314110, size.height * 0.7475142);
    path_9.cubicTo(size.width * 0.2336256, size.height * 0.7467083, size.width * 0.2333515, size.height * 0.7465520,
        size.width * 0.2342896, size.height * 0.7438210);
    path_9.cubicTo(size.width * 0.2353455, size.height * 0.7407470, size.width * 0.2356954, size.height * 0.7411577,
        size.width * 0.2379245, size.height * 0.7411577);
    path_9.cubicTo(size.width * 0.2394999, size.height * 0.7411577, size.width * 0.2418175, size.height * 0.7410363,
        size.width * 0.2426327, size.height * 0.7422230);
    path_9.cubicTo(size.width * 0.2431551, size.height * 0.7429835, size.width * 0.2453119, size.height * 0.7446132,
        size.width * 0.2455357, size.height * 0.7459162);
    path_9.cubicTo(size.width * 0.2456621, size.height * 0.7466518, size.width * 0.2468108, size.height * 0.7524763,
        size.width * 0.2477069, size.height * 0.7511719);
    path_9.cubicTo(size.width * 0.2482955, size.height * 0.7503150, size.width * 0.2499604, size.height * 0.7484903,
        size.width * 0.2502196, size.height * 0.7469815);
    path_9.cubicTo(size.width * 0.2505627, size.height * 0.7449834, size.width * 0.2511802, size.height * 0.7429553,
        size.width * 0.2520492, size.height * 0.7416903);
    path_9.cubicTo(size.width * 0.2527122, size.height * 0.7407252, size.width * 0.2544814, size.height * 0.7378801,
        size.width * 0.2531226, size.height * 0.7359020);
    path_9.cubicTo(size.width * 0.2523308, size.height * 0.7347494, size.width * 0.2505855, size.height * 0.7330441,
        size.width * 0.2505855, size.height * 0.7322088);
    path_9.cubicTo(size.width * 0.2505855, size.height * 0.7294221, size.width * 0.2519316, size.height * 0.7282899,
        size.width * 0.2527566, size.height * 0.7258878);
    path_9.cubicTo(size.width * 0.2534563, size.height * 0.7238507, size.width * 0.2537386, size.height * 0.7218393,
        size.width * 0.2542203, size.height * 0.7190341);
    path_9.cubicTo(size.width * 0.2546361, size.height * 0.7166134, size.width * 0.2551616, size.height * 0.7145479,
        size.width * 0.2556596, size.height * 0.7116477);
    path_9.cubicTo(size.width * 0.2561058, size.height * 0.7090501, size.width * 0.2559069, size.height * 0.7070827,
        size.width * 0.2563915, size.height * 0.7042614);
    path_9.cubicTo(size.width * 0.2567355, size.height * 0.7022584, size.width * 0.2571233, size.height * 0.7002351,
        size.width * 0.2571233, size.height * 0.6974077);
    path_9.cubicTo(size.width * 0.2571233, size.height * 0.6945436, size.width * 0.2577494, size.height * 0.6923890,
        size.width * 0.2585626, size.height * 0.6900213);
    path_9.cubicTo(size.width * 0.2590628, size.height * 0.6885650, size.width * 0.2613126, size.height * 0.6836066,
        size.width * 0.2629050, size.height * 0.6847656);
    path_9.cubicTo(size.width * 0.2635886, size.height * 0.6852632, size.width * 0.2658298, size.height * 0.6884588,
        size.width * 0.2665154, size.height * 0.6884588);
    path_9.cubicTo(size.width * 0.2684011, size.height * 0.6884588, size.width * 0.2690056, size.height * 0.6879262,
        size.width * 0.2712237, size.height * 0.6879261);
    path_9.cubicTo(size.width * 0.2728751, size.height * 0.6879261, size.width * 0.2748923, size.height * 0.6884588,
        size.width * 0.2762978, size.height * 0.6884588);
    path_9.cubicTo(size.width * 0.2783679, size.height * 0.6884588, size.width * 0.2795382, size.height * 0.6889915,
        size.width * 0.2813720, size.height * 0.6889915);
    path_9.cubicTo(size.width * 0.2830908, size.height * 0.6889915, size.width * 0.2846923, size.height * 0.6888859,
        size.width * 0.2864461, size.height * 0.6895241);
    path_9.cubicTo(size.width * 0.2879394, size.height * 0.6900676, size.width * 0.2892957, size.height * 0.6898776,
        size.width * 0.2911544, size.height * 0.6905540);
    path_9.cubicTo(size.width * 0.2928826, size.height * 0.6911829, size.width * 0.2939248, size.height * 0.6919795,
        size.width * 0.2958626, size.height * 0.6926847);
    path_9.cubicTo(size.width * 0.2971537, size.height * 0.6931545, size.width * 0.2987708, size.height * 0.6937576,
        size.width * 0.2998390, size.height * 0.6953125);
    path_9.cubicTo(size.width * 0.3007259, size.height * 0.6966035, size.width * 0.3017786, size.height * 0.6987971,
        size.width * 0.3038154, size.height * 0.6995384);
    path_9.cubicTo(size.width * 0.3053796, size.height * 0.7001076, size.width * 0.3073565, size.height * 0.7017414,
        size.width * 0.3085236, size.height * 0.7021662);
    path_9.cubicTo(size.width * 0.3103159, size.height * 0.7028184, size.width * 0.3111756, size.height * 0.7030133,
        size.width * 0.3128903, size.height * 0.7042614);
    path_9.cubicTo(size.width * 0.3142597, size.height * 0.7052580, size.width * 0.3153874, size.height * 0.7068779,
        size.width * 0.3168667, size.height * 0.7079545);
    path_9.cubicTo(size.width * 0.3179019, size.height * 0.7087080, size.width * 0.3192407, size.height * 0.7106651,
        size.width * 0.3204772, size.height * 0.7111151);
    path_9.cubicTo(size.width * 0.3219094, size.height * 0.7116363, size.width * 0.3242161, size.height * 0.7113020,
        size.width * 0.3251854, size.height * 0.7127131);
    path_9.cubicTo(size.width * 0.3261636, size.height * 0.7141370, size.width * 0.3273084, size.height * 0.7146225,
        size.width * 0.3284543, size.height * 0.7158736);
    path_9.cubicTo(size.width * 0.3295639, size.height * 0.7170850, size.width * 0.3341576, size.height * 0.7198357,
        size.width * 0.3349678, size.height * 0.7221946);
    path_9.cubicTo(size.width * 0.3353226, size.height * 0.7228831, size.width * 0.3357601, size.height * 0.7234004,
        size.width * 0.3360656, size.height * 0.7242898);
    path_9.cubicTo(size.width * 0.3367530, size.height * 0.7262910, size.width * 0.3374775, size.height * 0.7268378,
        size.width * 0.3382367, size.height * 0.7290483);
    path_9.cubicTo(size.width * 0.3388116, size.height * 0.7307220, size.width * 0.3400361, size.height * 0.7332044,
        size.width * 0.3404079, size.height * 0.7353693);
    path_9.cubicTo(size.width * 0.3408193, size.height * 0.7377651, size.width * 0.3414061, size.height * 0.7393408,
        size.width * 0.3422131, size.height * 0.7416903);
    path_9.cubicTo(size.width * 0.3430087, size.height * 0.7440067, size.width * 0.3434072, size.height * 0.7456994,
        size.width * 0.3443843, size.height * 0.7485440);
    path_9.cubicTo(size.width * 0.3449966, size.height * 0.7503266, size.width * 0.3456948, size.height * 0.7525824,
        size.width * 0.3469214, size.height * 0.7543679);
    path_9.cubicTo(size.width * 0.3480815, size.height * 0.7560567, size.width * 0.3493714, size.height * 0.7574701,
        size.width * 0.3508977, size.height * 0.7580256);
    path_9.cubicTo(size.width * 0.3520088, size.height * 0.7584299, size.width * 0.3536929, size.height * 0.7595932,
        size.width * 0.3552400, size.height * 0.7601562);
    path_9.cubicTo(size.width * 0.3572079, size.height * 0.7608724, size.width * 0.3578527, size.height * 0.7618013,
        size.width * 0.3592408, size.height * 0.7633168);
    path_9.cubicTo(size.width * 0.3603905, size.height * 0.7645720, size.width * 0.3617296, size.height * 0.7656608,
        size.width * 0.3635831, size.height * 0.7670099);
    path_9.cubicTo(size.width * 0.3645055, size.height * 0.7676813, size.width * 0.3671252, size.height * 0.7699773,
        size.width * 0.3682914, size.height * 0.7696378);
    path_9.cubicTo(size.width * 0.3709257, size.height * 0.7688709, size.width * 0.3705241, size.height * 0.7672137,
        size.width * 0.3722678, size.height * 0.7659446);
    path_9.cubicTo(size.width * 0.3739409, size.height * 0.7647269, size.width * 0.3750928, size.height * 0.7638884,
        size.width * 0.3766101, size.height * 0.7627841);
    path_9.cubicTo(size.width * 0.3785261, size.height * 0.7613895, size.width * 0.3803092, size.height * 0.7623524,
        size.width * 0.3820502, size.height * 0.7617188);
    path_9.cubicTo(size.width * 0.3833318, size.height * 0.7612523, size.width * 0.3858098, size.height * 0.7617976,
        size.width * 0.3874902, size.height * 0.7611861);
    path_9.cubicTo(size.width * 0.3890234, size.height * 0.7606281, size.width * 0.3914931, size.height * 0.7611846,
        size.width * 0.3929059, size.height * 0.7601562);
    path_9.cubicTo(size.width * 0.3940160, size.height * 0.7593483, size.width * 0.3954315, size.height * 0.7580564,
        size.width * 0.3968823, size.height * 0.7575284);
    path_9.cubicTo(size.width * 0.3985117, size.height * 0.7569355, size.width * 0.4005584, size.height * 0.7568865,
        size.width * 0.4023224, size.height * 0.7575284);
    path_9.cubicTo(size.width * 0.4036835, size.height * 0.7580237, size.width * 0.4055462, size.height * 0.7580256,
        size.width * 0.4073966, size.height * 0.7580256);
    path_9.cubicTo(size.width * 0.4096634, size.height * 0.7580256, size.width * 0.4105185, size.height * 0.7581950,
        size.width * 0.4121048, size.height * 0.7564631);
    path_9.cubicTo(size.width * 0.4137794, size.height * 0.7546348, size.width * 0.4154347, size.height * 0.7545721,
        size.width * 0.4171790, size.height * 0.7533026);
    path_9.cubicTo(size.width * 0.4185440, size.height * 0.7523090, size.width * 0.4186501, size.height * 0.7506515,
        size.width * 0.4200820, size.height * 0.7496094);
    path_9.cubicTo(size.width * 0.4212286, size.height * 0.7487748, size.width * 0.4217654, size.height * 0.7467861,
        size.width * 0.4229606, size.height * 0.7459162);
    path_9.cubicTo(size.width * 0.4244131, size.height * 0.7448590, size.width * 0.4246540, size.height * 0.7400871,
        size.width * 0.4262295, size.height * 0.7406605);
    path_9.cubicTo(size.width * 0.4279599, size.height * 0.7412902, size.width * 0.4307660, size.height * 0.7432884,
        size.width * 0.4320111, size.height * 0.7432884);
    path_9.cubicTo(size.width * 0.4345173, size.height * 0.7432884, size.width * 0.4348189, size.height * 0.7430683,
        size.width * 0.4356460, size.height * 0.7406605);
    path_9.cubicTo(size.width * 0.4363494, size.height * 0.7386126, size.width * 0.4370558, size.height * 0.7370530,
        size.width * 0.4378171, size.height * 0.7348366);
    path_9.cubicTo(size.width * 0.4383805, size.height * 0.7331965, size.width * 0.4392535, size.height * 0.7306507,
        size.width * 0.4403542, size.height * 0.7290483);
    path_9.cubicTo(size.width * 0.4421027, size.height * 0.7265031, size.width * 0.4416816, size.height * 0.7272832,
        size.width * 0.4435988, size.height * 0.7258878);
    path_9.cubicTo(size.width * 0.4456815, size.height * 0.7243718, size.width * 0.4463466, size.height * 0.7226819,
        size.width * 0.4472336, size.height * 0.7200994);
    path_9.cubicTo(size.width * 0.4477972, size.height * 0.7184585, size.width * 0.4484660, size.height * 0.7160976,
        size.width * 0.4494048, size.height * 0.7142756);
    path_9.cubicTo(size.width * 0.4501609, size.height * 0.7128080, size.width * 0.4512765, size.height * 0.7101854,
        size.width * 0.4530152, size.height * 0.7095526);
    path_9.cubicTo(size.width * 0.4538976, size.height * 0.7092314, size.width * 0.4562938, size.height * 0.7077939,
        size.width * 0.4570160, size.height * 0.7063920);
    path_9.cubicTo(size.width * 0.4580525, size.height * 0.7043802, size.width * 0.4595915, size.height * 0.7026074,
        size.width * 0.4609924, size.height * 0.7005682);
    path_9.cubicTo(size.width * 0.4624802, size.height * 0.6984024, size.width * 0.4644783, size.height * 0.6963806,
        size.width * 0.4664325, size.height * 0.6942472);
    path_9.cubicTo(size.width * 0.4676258, size.height * 0.6929444, size.width * 0.4693742, size.height * 0.6908521,
        size.width * 0.4714822, size.height * 0.6916193);
    path_9.cubicTo(size.width * 0.4730416, size.height * 0.6921868, size.width * 0.4744606, size.height * 0.6932367,
        size.width * 0.4758489, size.height * 0.6942472);
    path_9.cubicTo(size.width * 0.4762156, size.height * 0.6945140, size.width * 0.4777418, size.height * 0.6966902,
        size.width * 0.4787276, size.height * 0.6974077);
    path_9.cubicTo(size.width * 0.4798437, size.height * 0.6982201, size.width * 0.4807048, size.height * 0.6994678,
        size.width * 0.4823624, size.height * 0.7000710);
    path_9.cubicTo(size.width * 0.4838805, size.height * 0.7006235, size.width * 0.4848076, size.height * 0.6994047,
        size.width * 0.4863388, size.height * 0.7016335);
    path_9.cubicTo(size.width * 0.4876152, size.height * 0.7034915, size.width * 0.4887067, size.height * 0.7035706,
        size.width * 0.4903152, size.height * 0.7053267);
    path_9.cubicTo(size.width * 0.4913831, size.height * 0.7064926, size.width * 0.4928398, size.height * 0.7084827,
        size.width * 0.4943160, size.height * 0.7090199);
    path_9.cubicTo(size.width * 0.4958205, size.height * 0.7095674, size.width * 0.4972866, size.height * 0.7105497,
        size.width * 0.4982923, size.height * 0.7116477);
    path_9.cubicTo(size.width * 0.4995957, size.height * 0.7130707, size.width * 0.5008419, size.height * 0.7143024,
        size.width * 0.5022687, size.height * 0.7153409);
    path_9.cubicTo(size.width * 0.5036613, size.height * 0.7163544, size.width * 0.5049242, size.height * 0.7170201,
        size.width * 0.5066110, size.height * 0.7164063);
    path_9.cubicTo(size.width * 0.5083617, size.height * 0.7157691, size.width * 0.5100152, size.height * 0.7152248,
        size.width * 0.5113193, size.height * 0.7142756);
    path_9.cubicTo(size.width * 0.5129686, size.height * 0.7130752, size.width * 0.5136491, size.height * 0.7142756,
        size.width * 0.5153201, size.height * 0.7142756);
    path_9.cubicTo(size.width * 0.5167342, size.height * 0.7142756, size.width * 0.5188931, size.height * 0.7129309,
        size.width * 0.5192964, size.height * 0.7105824);
    path_9.cubicTo(size.width * 0.5197564, size.height * 0.7079045, size.width * 0.5202705, size.height * 0.7060807,
        size.width * 0.5181987, size.height * 0.7053267);
    path_9.cubicTo(size.width * 0.5169005, size.height * 0.7048543, size.width * 0.5164395, size.height * 0.7010748,
        size.width * 0.5181987, size.height * 0.6995384);
    path_9.cubicTo(size.width * 0.5196975, size.height * 0.6982293, size.width * 0.5213912, size.height * 0.6976929,
        size.width * 0.5236388, size.height * 0.6968750);
    path_9.cubicTo(size.width * 0.5256938, size.height * 0.6961271, size.width * 0.5293584, size.height * 0.6964680,
        size.width * 0.5308841, size.height * 0.6942472);
    path_9.cubicTo(size.width * 0.5323367, size.height * 0.6921327, size.width * 0.5339447, size.height * 0.6895615,
        size.width * 0.5355923, size.height * 0.6863636);
    path_9.cubicTo(size.width * 0.5365136, size.height * 0.6845755, size.width * 0.5389713, size.height * 0.6804555,
        size.width * 0.5406665, size.height * 0.6810724);
    path_9.cubicTo(size.width * 0.5427315, size.height * 0.6818239, size.width * 0.5433194, size.height * 0.6828391,
        size.width * 0.5446429, size.height * 0.6847656);
    path_9.cubicTo(size.width * 0.5456566, size.height * 0.6862413, size.width * 0.5457729, size.height * 0.6875034,
        size.width * 0.5468140, size.height * 0.6895241);
    path_9.cubicTo(size.width * 0.5474842, size.height * 0.6908249, size.width * 0.5486192, size.height * 0.6928558,
        size.width * 0.5486192, size.height * 0.6953125);
    path_9.cubicTo(size.width * 0.5486192, size.height * 0.6981862, size.width * 0.5486478, size.height * 0.7001185,
        size.width * 0.5493511, size.height * 0.7021662);
    path_9.cubicTo(size.width * 0.5500632, size.height * 0.7042395, size.width * 0.5505974, size.height * 0.7060241,
        size.width * 0.5500829, size.height * 0.7090199);
    path_9.cubicTo(size.width * 0.5495112, size.height * 0.7123489, size.width * 0.5489107, size.height * 0.7130518,
        size.width * 0.5468140, size.height * 0.7153409);
    path_9.cubicTo(size.width * 0.5459567, size.height * 0.7162768, size.width * 0.5433949, size.height * 0.7176902,
        size.width * 0.5424717, size.height * 0.7190341);
    path_9.cubicTo(size.width * 0.5412225, size.height * 0.7208526, size.width * 0.5390980, size.height * 0.7218500,
        size.width * 0.5377635, size.height * 0.7237926);
    path_9.cubicTo(size.width * 0.5364284, size.height * 0.7257360, size.width * 0.5353612, size.height * 0.7272896,
        size.width * 0.5341530, size.height * 0.7290483);
    path_9.cubicTo(size.width * 0.5329262, size.height * 0.7308341, size.width * 0.5316498, size.height * 0.7316269,
        size.width * 0.5301522, size.height * 0.7338068);
    path_9.cubicTo(size.width * 0.5294282, size.height * 0.7348607, size.width * 0.5274847, size.height * 0.7371586,
        size.width * 0.5272492, size.height * 0.7385298);
    path_9.cubicTo(size.width * 0.5269553, size.height * 0.7402412, size.width * 0.5266976, size.height * 0.7440479,
        size.width * 0.5279811, size.height * 0.7459162);
    path_9.cubicTo(size.width * 0.5290881, size.height * 0.7475277, size.width * 0.5296784, size.height * 0.7494168,
        size.width * 0.5308841, size.height * 0.7511719);
    path_9.cubicTo(size.width * 0.5319030, size.height * 0.7526551, size.width * 0.5326912, size.height * 0.7548763,
        size.width * 0.5330552, size.height * 0.7569957);
    path_9.cubicTo(size.width * 0.5333786, size.height * 0.7588789, size.width * 0.5344548, size.height * 0.7604220,
        size.width * 0.5348605, size.height * 0.7627841);
    path_9.cubicTo(size.width * 0.5352783, size.height * 0.7652172, size.width * 0.5367596, size.height * 0.7670009,
        size.width * 0.5363242, size.height * 0.7701705);
    path_9.cubicTo(size.width * 0.5360542, size.height * 0.7721350, size.width * 0.5334532, size.height * 0.7729498,
        size.width * 0.5337871, size.height * 0.7748935);
    path_9.cubicTo(size.width * 0.5342861, size.height * 0.7777991, size.width * 0.5359272, size.height * 0.7775116,
        size.width * 0.5370316, size.height * 0.7791193);
    path_9.cubicTo(size.width * 0.5380289, size.height * 0.7805710, size.width * 0.5393331, size.height * 0.7810430,
        size.width * 0.5410324, size.height * 0.7822798);
    path_9.cubicTo(size.width * 0.5416915, size.height * 0.7827595, size.width * 0.5442031, size.height * 0.7836275,
        size.width * 0.5446429, size.height * 0.7849077);
    path_9.cubicTo(size.width * 0.5452724, size.height * 0.7867405, size.width * 0.5479119, size.height * 0.7900917,
        size.width * 0.5482533, size.height * 0.7881037);
    path_9.cubicTo(size.width * 0.5486343, size.height * 0.7858852, size.width * 0.5487090, size.height * 0.7825868,
        size.width * 0.5493511, size.height * 0.7807173);
    path_9.cubicTo(size.width * 0.5501147, size.height * 0.7784942, size.width * 0.5509422, size.height * 0.7768031,
        size.width * 0.5518882, size.height * 0.7754261);
    path_9.cubicTo(size.width * 0.5527050, size.height * 0.7742370, size.width * 0.5541436, size.height * 0.7732519,
        size.width * 0.5554986, size.height * 0.7722656);
    path_9.cubicTo(size.width * 0.5555888, size.height * 0.7722000, size.width * 0.5596635, size.height * 0.7689953,
        size.width * 0.5594994, size.height * 0.7680398);
    path_9.cubicTo(size.width * 0.5591300, size.height * 0.7658890, size.width * 0.5587676, size.height * 0.7643695,
        size.width * 0.5587676, size.height * 0.7611861);
    path_9.cubicTo(size.width * 0.5587676, size.height * 0.7594066, size.width * 0.5583328, size.height * 0.7544682,
        size.width * 0.5591335, size.height * 0.7533026);
    path_9.cubicTo(size.width * 0.5603934, size.height * 0.7514686, size.width * 0.5606319, size.height * 0.7503476,
        size.width * 0.5623780, size.height * 0.7490767);
    path_9.cubicTo(size.width * 0.5637251, size.height * 0.7480963, size.width * 0.5660858, size.height * 0.7473810,
        size.width * 0.5678181, size.height * 0.7480114);
    path_9.cubicTo(size.width * 0.5685146, size.height * 0.7482648, size.width * 0.5725682, size.height * 0.7495485,
        size.width * 0.5732582, size.height * 0.7485440);
    path_9.cubicTo(size.width * 0.5744154, size.height * 0.7468595, size.width * 0.5756040, size.height * 0.7453948,
        size.width * 0.5746975, size.height * 0.7427557);
    path_9.cubicTo(size.width * 0.5742019, size.height * 0.7413127, size.width * 0.5733955, size.height * 0.7394288,
        size.width * 0.5721604, size.height * 0.7385298);
    path_9.cubicTo(size.width * 0.5710876, size.height * 0.7377490, size.width * 0.5698896, size.height * 0.7366773,
        size.width * 0.5692574, size.height * 0.7348366);
    path_9.cubicTo(size.width * 0.5688536, size.height * 0.7336609, size.width * 0.5670863, size.height * 0.7304162,
        size.width * 0.5670863, size.height * 0.7295810);
    path_9.cubicTo(size.width * 0.5670863, size.height * 0.7270494, size.width * 0.5662588, size.height * 0.7250237,
        size.width * 0.5667447, size.height * 0.7221946);
    path_9.cubicTo(size.width * 0.5670817, size.height * 0.7202323, size.width * 0.5674522, size.height * 0.7175663,
        size.width * 0.5674522, size.height * 0.7148082);
    path_9.cubicTo(size.width * 0.5674522, size.height * 0.7122032, size.width * 0.5677568, size.height * 0.7092340,
        size.width * 0.5685500, size.height * 0.7069247);
    path_9.cubicTo(size.width * 0.5693837, size.height * 0.7044975, size.width * 0.5711612, size.height * 0.6991748,
        size.width * 0.5714286, size.height * 0.6974077);
    path_9.cubicTo(size.width * 0.5715946, size.height * 0.6961994, size.width * 0.5721604, size.height * 0.6929511,
        size.width * 0.5721604, size.height * 0.6916193);
    path_9.cubicTo(size.width * 0.5721604, size.height * 0.6909053, size.width * 0.5721771, size.height * 0.6899668,
        size.width * 0.5722580, size.height * 0.6889915);
    path_9.cubicTo(size.width * 0.5722283, size.height * 0.6889913, size.width * 0.5721893, size.height * 0.6889915,
        size.width * 0.5721604, size.height * 0.6889915);
    path_9.cubicTo(size.width * 0.5706890, size.height * 0.6889915, size.width * 0.5687465, size.height * 0.6866497,
        size.width * 0.5681840, size.height * 0.6858310);
    path_9.cubicTo(size.width * 0.5674187, size.height * 0.6847169, size.width * 0.5656779, size.height * 0.6834919,
        size.width * 0.5645492, size.height * 0.6826705);
    path_9.cubicTo(size.width * 0.5630757, size.height * 0.6815980, size.width * 0.5626022, size.height * 0.6803334,
        size.width * 0.5616706, size.height * 0.6789773);
    path_9.cubicTo(size.width * 0.5608210, size.height * 0.6777405, size.width * 0.5613046, size.height * 0.6728985,
        size.width * 0.5613046, size.height * 0.6710582);
    path_9.cubicTo(size.width * 0.5613046, size.height * 0.6691768, size.width * 0.5627780, size.height * 0.6668184,
        size.width * 0.5634758, size.height * 0.6658026);
    path_9.cubicTo(size.width * 0.5644964, size.height * 0.6643168, size.width * 0.5650313, size.height * 0.6619402,
        size.width * 0.5663788, size.height * 0.6599787);
    path_9.cubicTo(size.width * 0.5678088, size.height * 0.6578971, size.width * 0.5683167, size.height * 0.6570057,
        size.width * 0.5699893, size.height * 0.6557884);
    path_9.cubicTo(size.width * 0.5714005, size.height * 0.6547612, size.width * 0.5722383, size.height * 0.6541125,
        size.width * 0.5732582, size.height * 0.6526278);
    path_9.cubicTo(size.width * 0.5742044, size.height * 0.6512505, size.width * 0.5748492, size.height * 0.6487139,
        size.width * 0.5757953, size.height * 0.6473366);
    path_9.cubicTo(size.width * 0.5770542, size.height * 0.6455040, size.width * 0.5773845, size.height * 0.6439579,
        size.width * 0.5783324, size.height * 0.6425781);
    path_9.cubicTo(size.width * 0.5795551, size.height * 0.6407982, size.width * 0.5811449, size.height * 0.6402647,
        size.width * 0.5823087, size.height * 0.6394176);
    path_9.cubicTo(size.width * 0.5844582, size.height * 0.6378532, size.width * 0.5846973, size.height * 0.6366091,
        size.width * 0.5862851, size.height * 0.6389205);
    path_9.cubicTo(size.width * 0.5873118, size.height * 0.6404149, size.width * 0.5870522, size.height * 0.6433157,
        size.width * 0.5873829, size.height * 0.6452415);
    path_9.cubicTo(size.width * 0.5879616, size.height * 0.6486112, size.width * 0.5870795, size.height * 0.6494951,
        size.width * 0.5891881, size.height * 0.6510298);
    path_9.cubicTo(size.width * 0.5909142, size.height * 0.6522862, size.width * 0.5925220, size.height * 0.6512312,
        size.width * 0.5935304, size.height * 0.6504972);
    path_9.cubicTo(size.width * 0.5950205, size.height * 0.6494126, size.width * 0.5953933, size.height * 0.6466716,
        size.width * 0.5960675, size.height * 0.6447088);
    path_9.cubicTo(size.width * 0.5965587, size.height * 0.6432789, size.width * 0.5996739, size.height * 0.6426166,
        size.width * 0.6004098, size.height * 0.6420810);
    path_9.cubicTo(size.width * 0.6018287, size.height * 0.6410482, size.width * 0.6031846, size.height * 0.6408249,
        size.width * 0.6043862, size.height * 0.6399503);
    path_9.cubicTo(size.width * 0.6057823, size.height * 0.6389342, size.width * 0.6078859, size.height * 0.6377623,
        size.width * 0.6090945, size.height * 0.6373224);
    path_9.cubicTo(size.width * 0.6106851, size.height * 0.6367436, size.width * 0.6122179, size.height * 0.6367898,
        size.width * 0.6141686, size.height * 0.6367898);
    path_9.cubicTo(size.width * 0.6157841, size.height * 0.6367898, size.width * 0.6180878, size.height * 0.6357808,
        size.width * 0.6196087, size.height * 0.6352273);
    path_9.cubicTo(size.width * 0.6213374, size.height * 0.6345982, size.width * 0.6221710, size.height * 0.6335203,
        size.width * 0.6228532, size.height * 0.6315341);
    path_9.cubicTo(size.width * 0.6235204, size.height * 0.6295917, size.width * 0.6221458, size.height * 0.6270779,
        size.width * 0.6221458, size.height * 0.6246804);
    path_9.cubicTo(size.width * 0.6221458, size.height * 0.6222816, size.width * 0.6205244, size.height * 0.6212548,
        size.width * 0.6196087, size.height * 0.6199219);
    path_9.cubicTo(size.width * 0.6186316, size.height * 0.6184996, size.width * 0.6167350, size.height * 0.6176953,
        size.width * 0.6156323, size.height * 0.6172940);
    path_9.cubicTo(size.width * 0.6135023, size.height * 0.6165188, size.width * 0.6136578, size.height * 0.6157715,
        size.width * 0.6127293, size.height * 0.6130682);
    path_9.cubicTo(size.width * 0.6121428, size.height * 0.6113607, size.width * 0.6126102, size.height * 0.6071189,
        size.width * 0.6123634, size.height * 0.6056818);
    path_9.cubicTo(size.width * 0.6121441, size.height * 0.6044051, size.width * 0.6154476, size.height * 0.6006951,
        size.width * 0.6156323, size.height * 0.6004261);
    path_9.cubicTo(size.width * 0.6167552, size.height * 0.5987915, size.width * 0.6184269, size.height * 0.5972192,
        size.width * 0.6198039, size.height * 0.5958807);
    path_9.cubicTo(size.width * 0.6181701, size.height * 0.5960084, size.width * 0.6194155, size.height * 0.5936023,
        size.width * 0.6199746, size.height * 0.5919744);
    path_9.cubicTo(size.width * 0.6206876, size.height * 0.5898988, size.width * 0.6211830, size.height * 0.5880548,
        size.width * 0.6221458, size.height * 0.5861861);
    path_9.cubicTo(size.width * 0.6230745, size.height * 0.5843835, size.width * 0.6232680, size.height * 0.5813210,
        size.width * 0.6239510, size.height * 0.5793324);
    path_9.cubicTo(size.width * 0.6247790, size.height * 0.5769217, size.width * 0.6252967, size.height * 0.5751545,
        size.width * 0.6257562, size.height * 0.5724787);
    path_9.cubicTo(size.width * 0.6261473, size.height * 0.5702020, size.width * 0.6273806, size.height * 0.5666841,
        size.width * 0.6279274, size.height * 0.5650923);
    path_9.cubicTo(size.width * 0.6286617, size.height * 0.5629545, size.width * 0.6290368, size.height * 0.5598047,
        size.width * 0.6293911, size.height * 0.5577415);
    path_9.cubicTo(size.width * 0.6298530, size.height * 0.5550519, size.width * 0.6300764, size.height * 0.5526149,
        size.width * 0.6304645, size.height * 0.5503551);
    path_9.cubicTo(size.width * 0.6310260, size.height * 0.5470855, size.width * 0.6302332, size.height * 0.5454105,
        size.width * 0.6290252, size.height * 0.5445313);
    path_9.cubicTo(size.width * 0.6272508, size.height * 0.5432398, size.width * 0.6267311, size.height * 0.5426130,
        size.width * 0.6250244, size.height * 0.5413707);
    path_9.cubicTo(size.width * 0.6234694, size.height * 0.5402390, size.width * 0.6227163, size.height * 0.5391581,
        size.width * 0.6214139, size.height * 0.5382102);
    path_9.cubicTo(size.width * 0.6196754, size.height * 0.5369448, size.width * 0.6186186, size.height * 0.5356430,
        size.width * 0.6170716, size.height * 0.5345170);
    path_9.cubicTo(size.width * 0.6150497, size.height * 0.5330454, size.width * 0.6136021, size.height * 0.5313976,
        size.width * 0.6116315, size.height * 0.5308239);
    path_9.cubicTo(size.width * 0.6094464, size.height * 0.5301877, size.width * 0.6074065, size.height * 0.5299573,
        size.width * 0.6054840, size.height * 0.5313565);
    path_9.cubicTo(size.width * 0.6027038, size.height * 0.5333801, size.width * 0.6015558, size.height * 0.5348684,
        size.width * 0.6007758, size.height * 0.5303267);
    path_9.cubicTo(size.width * 0.6001586, size.height * 0.5267330, size.width * 0.6009719, size.height * 0.5248206,
        size.width * 0.6022151, size.height * 0.5224077);
    path_9.cubicTo(size.width * 0.6027634, size.height * 0.5213434, size.width * 0.6034045, size.height * 0.5196593,
        size.width * 0.6039959, size.height * 0.5180753);
    path_9.cubicTo(size.width * 0.6038890, size.height * 0.5181030, size.width * 0.6037798, size.height * 0.5181451,
        size.width * 0.6036788, size.height * 0.5181818);
    path_9.cubicTo(size.width * 0.6016945, size.height * 0.5189039, size.width * 0.5997000, size.height * 0.5192471,
        size.width * 0.5975068, size.height * 0.5192472);
    path_9.cubicTo(size.width * 0.5943758, size.height * 0.5192472, size.width * 0.5947032, size.height * 0.5209542,
        size.width * 0.5927986, size.height * 0.5181818);
    path_9.cubicTo(size.width * 0.5922845, size.height * 0.5174334, size.width * 0.5903589, size.height * 0.5149161,
        size.width * 0.5890662, size.height * 0.5149858);
    path_9.close();
    Paint paint9Fill = Paint()..style = PaintingStyle.fill;
    paint9Fill.color = mediterraneanColor;
    canvas.drawPath(path_9, paint9Fill);

    /// Akdeniz Bögesi Bitiş

    /// İçAnadolu Bölgesi Başlangıç
    Path path_10 = Path();
    path_10.moveTo(size.width * 0.3865632, size.height * 0.2725497);
    path_10.cubicTo(size.width * 0.3856329, size.height * 0.2728371, size.width * 0.3860265, size.height * 0.2780243,
        size.width * 0.3860265, size.height * 0.2794034);
    path_10.cubicTo(size.width * 0.3860265, size.height * 0.2820983, size.width * 0.3853640, size.height * 0.2835611,
        size.width * 0.3838554, size.height * 0.2846591);
    path_10.cubicTo(size.width * 0.3823103, size.height * 0.2857837, size.width * 0.3817270, size.height * 0.2862571,
        size.width * 0.3795131, size.height * 0.2862571);
    path_10.cubicTo(size.width * 0.3777024, size.height * 0.2862571, size.width * 0.3758836, size.height * 0.2862571,
        size.width * 0.3740730, size.height * 0.2862571);
    path_10.cubicTo(size.width * 0.3723135, size.height * 0.2862571, size.width * 0.3706206, size.height * 0.2873626,
        size.width * 0.3693648, size.height * 0.2878196);
    path_10.cubicTo(size.width * 0.3676185, size.height * 0.2884551, size.width * 0.3663389, size.height * 0.2900756,
        size.width * 0.3650224, size.height * 0.2915128);
    path_10.cubicTo(size.width * 0.3637223, size.height * 0.2929322, size.width * 0.3623481, size.height * 0.2949086,
        size.width * 0.3614120, size.height * 0.2962713);
    path_10.cubicTo(size.width * 0.3602872, size.height * 0.2979086, size.width * 0.3591260, size.height * 0.2975998,
        size.width * 0.3581431, size.height * 0.3004616);
    path_10.cubicTo(size.width * 0.3579329, size.height * 0.3010735, size.width * 0.3585090, size.height * 0.3065196,
        size.width * 0.3585090, size.height * 0.3078480);
    path_10.cubicTo(size.width * 0.3585090, size.height * 0.3111400, size.width * 0.3588008, size.height * 0.3112298,
        size.width * 0.3567037, size.height * 0.3136719);
    path_10.cubicTo(size.width * 0.3553747, size.height * 0.3149095, size.width * 0.3543356, size.height * 0.3163458,
        size.width * 0.3538007, size.height * 0.3194602);
    path_10.cubicTo(size.width * 0.3533168, size.height * 0.3222780, size.width * 0.3545899, size.height * 0.3239841,
        size.width * 0.3548985, size.height * 0.3257813);
    path_10.cubicTo(size.width * 0.3554689, size.height * 0.3291026, size.width * 0.3557756, size.height * 0.3295163,
        size.width * 0.3552400, size.height * 0.3326349);
    path_10.cubicTo(size.width * 0.3549464, size.height * 0.3343446, size.width * 0.3533671, size.height * 0.3364267,
        size.width * 0.3527030, size.height * 0.3373935);
    path_10.cubicTo(size.width * 0.3509542, size.height * 0.3399391, size.width * 0.3521569, size.height * 0.3400691,
        size.width * 0.3494584, size.height * 0.3410511);
    path_10.cubicTo(size.width * 0.3479427, size.height * 0.3416028, size.width * 0.3468771, size.height * 0.3421165,
        size.width * 0.3447502, size.height * 0.3421165);
    path_10.cubicTo(size.width * 0.3427682, size.height * 0.3421165, size.width * 0.3416370, size.height * 0.3410511,
        size.width * 0.3393101, size.height * 0.3410511);
    path_10.cubicTo(size.width * 0.3373602, size.height * 0.3410511, size.width * 0.3358782, size.height * 0.3427173,
        size.width * 0.3346019, size.height * 0.3431818);
    path_10.cubicTo(size.width * 0.3327308, size.height * 0.3438628, size.width * 0.3314350, size.height * 0.3447160,
        size.width * 0.3298936, size.height * 0.3452770);
    path_10.cubicTo(size.width * 0.3283349, size.height * 0.3458443, size.width * 0.3265709, size.height * 0.3474006,
        size.width * 0.3251854, size.height * 0.3479048);
    path_10.cubicTo(size.width * 0.3233169, size.height * 0.3485848, size.width * 0.3213842, size.height * 0.3484375,
        size.width * 0.3194038, size.height * 0.3484375);
    path_10.cubicTo(size.width * 0.3174214, size.height * 0.3484375, size.width * 0.3158970, size.height * 0.3479048,
        size.width * 0.3139637, size.height * 0.3479048);
    path_10.cubicTo(size.width * 0.3116820, size.height * 0.3479048, size.width * 0.3104522, size.height * 0.3493337,
        size.width * 0.3085236, size.height * 0.3500355);
    path_10.cubicTo(size.width * 0.3075845, size.height * 0.3503773, size.width * 0.3062520, size.height * 0.3530205,
        size.width * 0.3052791, size.height * 0.3537287);
    path_10.cubicTo(size.width * 0.3047779, size.height * 0.3540935, size.width * 0.3020405, size.height * 0.3509699,
        size.width * 0.3009368, size.height * 0.3505682);
    path_10.cubicTo(size.width * 0.2992760, size.height * 0.3499638, size.width * 0.2984324, size.height * 0.3489702,
        size.width * 0.2965945, size.height * 0.3489702);
    path_10.cubicTo(size.width * 0.2951585, size.height * 0.3489702, size.width * 0.2925994, size.height * 0.3482975,
        size.width * 0.2915203, size.height * 0.3479048);
    path_10.cubicTo(size.width * 0.2893573, size.height * 0.3471177, size.width * 0.2881322, size.height * 0.3471987,
        size.width * 0.2868121, size.height * 0.3452770);
    path_10.cubicTo(size.width * 0.2855610, size.height * 0.3434558, size.width * 0.2843116, size.height * 0.3431952,
        size.width * 0.2828113, size.height * 0.3426491);
    path_10.cubicTo(size.width * 0.2802496, size.height * 0.3417169, size.width * 0.2799327, size.height * 0.3411774,
        size.width * 0.2799327, size.height * 0.3458097);
    path_10.cubicTo(size.width * 0.2799327, size.height * 0.3488585, size.width * 0.2800122, size.height * 0.3508351,
        size.width * 0.2806401, size.height * 0.3526634);
    path_10.cubicTo(size.width * 0.2814744, size.height * 0.3550922, size.width * 0.2813554, size.height * 0.3564174,
        size.width * 0.2810060, size.height * 0.3584517);
    path_10.cubicTo(size.width * 0.2809456, size.height * 0.3588039, size.width * 0.2770247, size.height * 0.3608524,
        size.width * 0.2766637, size.height * 0.3611151);
    path_10.cubicTo(size.width * 0.2750083, size.height * 0.3623200, size.width * 0.2738791, size.height * 0.3629011,
        size.width * 0.2730533, size.height * 0.3653054);
    path_10.cubicTo(size.width * 0.2720023, size.height * 0.3683652, size.width * 0.2733115, size.height * 0.3689986,
        size.width * 0.2701503, size.height * 0.3689986);
    path_10.cubicTo(size.width * 0.2681812, size.height * 0.3689986, size.width * 0.2672086, size.height * 0.3679458,
        size.width * 0.2658080, size.height * 0.3674361);
    path_10.cubicTo(size.width * 0.2642338, size.height * 0.3668632, size.width * 0.2630370, size.height * 0.3662643,
        size.width * 0.2618072, size.height * 0.3655895);
    path_10.cubicTo(size.width * 0.2613597, size.height * 0.3657866, size.width * 0.2608644, size.height * 0.3660093,
        size.width * 0.2603679, size.height * 0.3663707);
    path_10.cubicTo(size.width * 0.2585642, size.height * 0.3676836, size.width * 0.2583155, size.height * 0.3683070,
        size.width * 0.2578308, size.height * 0.3711293);
    path_10.cubicTo(size.width * 0.2574151, size.height * 0.3735497, size.width * 0.2568741, size.height * 0.3744471,
        size.width * 0.2560256, size.height * 0.3769176);
    path_10.cubicTo(size.width * 0.2556199, size.height * 0.3780988, size.width * 0.2544896, size.height * 0.3823140,
        size.width * 0.2538544, size.height * 0.3832386);
    path_10.cubicTo(size.width * 0.2524959, size.height * 0.3852162, size.width * 0.2520119, size.height * 0.3856272,
        size.width * 0.2502196, size.height * 0.3869318);
    path_10.cubicTo(size.width * 0.2487707, size.height * 0.3879864, size.width * 0.2470755, size.height * 0.3878153,
        size.width * 0.2458772, size.height * 0.3895597);
    path_10.cubicTo(size.width * 0.2451814, size.height * 0.3905726, size.width * 0.2441325, size.height * 0.3929603,
        size.width * 0.2429986, size.height * 0.3937855);
    path_10.cubicTo(size.width * 0.2417438, size.height * 0.3946988, size.width * 0.2397844, size.height * 0.3953480,
        size.width * 0.2379245, size.height * 0.3953480);
    path_10.cubicTo(size.width * 0.2362042, size.height * 0.3953480, size.width * 0.2343250, size.height * 0.3950220,
        size.width * 0.2328503, size.height * 0.3958807);
    path_10.cubicTo(size.width * 0.2302140, size.height * 0.3974157, size.width * 0.2280404, size.height * 0.3980354,
        size.width * 0.2274102, size.height * 0.4017045);
    path_10.cubicTo(size.width * 0.2270339, size.height * 0.4038960, size.width * 0.2267447, size.height * 0.4070535,
        size.width * 0.2277762, size.height * 0.4090554);
    path_10.cubicTo(size.width * 0.2282486, size.height * 0.4099723, size.width * 0.2293473, size.height * 0.4108332,
        size.width * 0.2302157, size.height * 0.4116477);
    path_10.cubicTo(size.width * 0.2320532, size.height * 0.4111381, size.width * 0.2331692, size.height * 0.4123928,
        size.width * 0.2350215, size.height * 0.4117188);
    path_10.cubicTo(size.width * 0.2374808, size.height * 0.4108238, size.width * 0.2356676, size.height * 0.4129150,
        size.width * 0.2346555, size.height * 0.4148793);
    path_10.cubicTo(size.width * 0.2335040, size.height * 0.4171144, size.width * 0.2335487, size.height * 0.4185106,
        size.width * 0.2342896, size.height * 0.4206676);
    path_10.cubicTo(size.width * 0.2347519, size.height * 0.4220134, size.width * 0.2371685, size.height * 0.4234198,
        size.width * 0.2382904, size.height * 0.4238281);
    path_10.cubicTo(size.width * 0.2396561, size.height * 0.4243251, size.width * 0.2394662, size.height * 0.4276348,
        size.width * 0.2404616, size.height * 0.4290838);
    path_10.cubicTo(size.width * 0.2413101, size.height * 0.4303190, size.width * 0.2418367, size.height * 0.4329362,
        size.width * 0.2422668, size.height * 0.4354403);
    path_10.cubicTo(size.width * 0.2426548, size.height * 0.4376999, size.width * 0.2432132, size.height * 0.4388912,
        size.width * 0.2437061, size.height * 0.4417614);
    path_10.cubicTo(size.width * 0.2441487, size.height * 0.4443384, size.width * 0.2445069, size.height * 0.4465847,
        size.width * 0.2455357, size.height * 0.4480824);
    path_10.cubicTo(size.width * 0.2467416, size.height * 0.4498377, size.width * 0.2473918, size.height * 0.4508938,
        size.width * 0.2480484, size.height * 0.4528054);
    path_10.cubicTo(size.width * 0.2486925, size.height * 0.4546807, size.width * 0.2494033, size.height * 0.4567144,
        size.width * 0.2498780, size.height * 0.4580966);
    path_10.cubicTo(size.width * 0.2504720, size.height * 0.4598258, size.width * 0.2518621, size.height * 0.4604876,
        size.width * 0.2527566, size.height * 0.4617898);
    path_10.cubicTo(size.width * 0.2538682, size.height * 0.4634079, size.width * 0.2542827, size.height * 0.4658105,
        size.width * 0.2545863, size.height * 0.4675781);
    path_10.cubicTo(size.width * 0.2546382, size.height * 0.4678803, size.width * 0.2574446, size.height * 0.4712121,
        size.width * 0.2574649, size.height * 0.4712713);
    path_10.cubicTo(size.width * 0.2575864, size.height * 0.4716252, size.width * 0.2621926, size.height * 0.4699610,
        size.width * 0.2625390, size.height * 0.4697088);
    path_10.cubicTo(size.width * 0.2642489, size.height * 0.4684643, size.width * 0.2652414, size.height * 0.4672092,
        size.width * 0.2668813, size.height * 0.4660156);
    path_10.cubicTo(size.width * 0.2681402, size.height * 0.4650994, size.width * 0.2696395, size.height * 0.4625333,
        size.width * 0.2705162, size.height * 0.4612571);
    path_10.cubicTo(size.width * 0.2721581, size.height * 0.4588669, size.width * 0.2728260, size.height * 0.4600441,
        size.width * 0.2744926, size.height * 0.4612571);
    path_10.cubicTo(size.width * 0.2760092, size.height * 0.4623609, size.width * 0.2763910, size.height * 0.4632530,
        size.width * 0.2781274, size.height * 0.4638849);
    path_10.cubicTo(size.width * 0.2786525, size.height * 0.4640760, size.width * 0.2816503, size.height * 0.4597866,
        size.width * 0.2817379, size.height * 0.4596591);
    path_10.cubicTo(size.width * 0.2828799, size.height * 0.4579968, size.width * 0.2841609, size.height * 0.4571320,
        size.width * 0.2857143, size.height * 0.4560014);
    path_10.cubicTo(size.width * 0.2870697, size.height * 0.4550149, size.width * 0.2886000, size.height * 0.4542765,
        size.width * 0.2897151, size.height * 0.4538707);
    path_10.cubicTo(size.width * 0.2913102, size.height * 0.4532902, size.width * 0.2931785, size.height * 0.4534177,
        size.width * 0.2944233, size.height * 0.4538707);
    path_10.cubicTo(size.width * 0.2957399, size.height * 0.4543499, size.width * 0.2962820, size.height * 0.4568098,
        size.width * 0.2965945, size.height * 0.4586293);
    path_10.cubicTo(size.width * 0.2970775, size.height * 0.4614420, size.width * 0.2976493, size.height * 0.4627117,
        size.width * 0.2980338, size.height * 0.4649503);
    path_10.cubicTo(size.width * 0.2983448, size.height * 0.4667615, size.width * 0.2997268, size.height * 0.4693468,
        size.width * 0.3002049, size.height * 0.4707386);
    path_10.cubicTo(size.width * 0.3008914, size.height * 0.4727373, size.width * 0.3036881, size.height * 0.4715840,
        size.width * 0.3045472, size.height * 0.4712713);
    path_10.cubicTo(size.width * 0.3063783, size.height * 0.4706049, size.width * 0.3068712, size.height * 0.4697088,
        size.width * 0.3088895, size.height * 0.4697088);
    path_10.cubicTo(size.width * 0.3106924, size.height * 0.4697088, size.width * 0.3116297, size.height * 0.4694897,
        size.width * 0.3135978, size.height * 0.4702060);
    path_10.cubicTo(size.width * 0.3157797, size.height * 0.4710000, size.width * 0.3154073, size.height * 0.4740163,
        size.width * 0.3150615, size.height * 0.4760298);
    path_10.cubicTo(size.width * 0.3146349, size.height * 0.4785133, size.width * 0.3150615, size.height * 0.4800634,
        size.width * 0.3150615, size.height * 0.4828835);
    path_10.cubicTo(size.width * 0.3150615, size.height * 0.4853020, size.width * 0.3154030, size.height * 0.4881502,
        size.width * 0.3154030, size.height * 0.4907670);
    path_10.cubicTo(size.width * 0.3154030, size.height * 0.4934824, size.width * 0.3146953, size.height * 0.4954905,
        size.width * 0.3135978, size.height * 0.4970881);
    path_10.cubicTo(size.width * 0.3125694, size.height * 0.4985851, size.width * 0.3115282, size.height * 0.5002764,
        size.width * 0.3107192, size.height * 0.5018466);
    path_10.cubicTo(size.width * 0.3100149, size.height * 0.5032136, size.width * 0.3099873, size.height * 0.5065388,
        size.width * 0.3099873, size.height * 0.5087003);
    path_10.cubicTo(size.width * 0.3099873, size.height * 0.5117809, size.width * 0.3103772, size.height * 0.5135626,
        size.width * 0.3107192, size.height * 0.5155540);
    path_10.cubicTo(size.width * 0.3111959, size.height * 0.5183298, size.width * 0.3149029, size.height * 0.5141868,
        size.width * 0.3114266, size.height * 0.5192472);
    path_10.cubicTo(size.width * 0.3100641, size.height * 0.5212305, size.width * 0.3087885, size.height * 0.5225091,
        size.width * 0.3074502, size.height * 0.5239702);
    path_10.cubicTo(size.width * 0.3062442, size.height * 0.5252869, size.width * 0.3047540, size.height * 0.5268297,
        size.width * 0.3038154, size.height * 0.5281960);
    path_10.cubicTo(size.width * 0.3027701, size.height * 0.5297177, size.width * 0.3016318, size.height * 0.5307309,
        size.width * 0.3005708, size.height * 0.5318892);
    path_10.cubicTo(size.width * 0.2994348, size.height * 0.5331295, size.width * 0.2980762, size.height * 0.5334385,
        size.width * 0.2965945, size.height * 0.5345170);
    path_10.cubicTo(size.width * 0.2951604, size.height * 0.5355608, size.width * 0.2939089, size.height * 0.5362957,
        size.width * 0.2929596, size.height * 0.5376776);
    path_10.cubicTo(size.width * 0.2929252, size.height * 0.5405627, size.width * 0.2926512, size.height * 0.5415382,
        size.width * 0.2933255, size.height * 0.5435014);
    path_10.cubicTo(size.width * 0.2939938, size.height * 0.5454470, size.width * 0.2951043, size.height * 0.5463763,
        size.width * 0.2962285, size.height * 0.5471946);
    path_10.cubicTo(size.width * 0.2977121, size.height * 0.5482744, size.width * 0.2980442, size.height * 0.5500786,
        size.width * 0.2998390, size.height * 0.5513849);
    path_10.cubicTo(size.width * 0.3014973, size.height * 0.5525919, size.width * 0.3024180, size.height * 0.5535767,
        size.width * 0.3038154, size.height * 0.5556108);
    path_10.cubicTo(size.width * 0.3050222, size.height * 0.5573676, size.width * 0.3056419, size.height * 0.5577680,
        size.width * 0.3063525, size.height * 0.5598366);
    path_10.cubicTo(size.width * 0.3069149, size.height * 0.5614742, size.width * 0.3085800, size.height * 0.5620959,
        size.width * 0.3092555, size.height * 0.5640625);
    path_10.cubicTo(size.width * 0.3100108, size.height * 0.5662615, size.width * 0.3110607, size.height * 0.5660268,
        size.width * 0.3110607, size.height * 0.5693182);
    path_10.cubicTo(size.width * 0.3110607, size.height * 0.5715543, size.width * 0.3096329, size.height * 0.5729947,
        size.width * 0.3085236, size.height * 0.5746094);
    path_10.cubicTo(size.width * 0.3072248, size.height * 0.5765001, size.width * 0.3069229, size.height * 0.5767045,
        size.width * 0.3045472, size.height * 0.5767045);
    path_10.cubicTo(size.width * 0.3022242, size.height * 0.5767046, size.width * 0.3011071, size.height * 0.5770777,
        size.width * 0.2994731, size.height * 0.5782670);
    path_10.cubicTo(size.width * 0.2972522, size.height * 0.5798835, size.width * 0.2984179, size.height * 0.5820664,
        size.width * 0.2987656, size.height * 0.5840909);
    path_10.cubicTo(size.width * 0.2992100, size.height * 0.5866783, size.width * 0.3005234, size.height * 0.5874721,
        size.width * 0.3009368, size.height * 0.5898793);
    path_10.cubicTo(size.width * 0.3012850, size.height * 0.5919067, size.width * 0.3020101, size.height * 0.5934599,
        size.width * 0.3020101, size.height * 0.5962003);
    path_10.cubicTo(size.width * 0.3020101, size.height * 0.5988712, size.width * 0.3012334, size.height * 0.6013267,
        size.width * 0.3009368, size.height * 0.6030540);
    path_10.cubicTo(size.width * 0.3004858, size.height * 0.6056796, size.width * 0.3002012, size.height * 0.6083313,
        size.width * 0.2998390, size.height * 0.6104403);
    path_10.cubicTo(size.width * 0.2993587, size.height * 0.6132372, size.width * 0.2991811, size.height * 0.6148750,
        size.width * 0.2987656, size.height * 0.6172940);
    path_10.cubicTo(size.width * 0.2983120, size.height * 0.6199350, size.width * 0.2980338, size.height * 0.6222302,
        size.width * 0.2980338, size.height * 0.6252131);
    path_10.cubicTo(size.width * 0.2980338, size.height * 0.6274288, size.width * 0.2972826, size.height * 0.6300633,
        size.width * 0.2965945, size.height * 0.6320668);
    path_10.cubicTo(size.width * 0.2955557, size.height * 0.6350909, size.width * 0.2969403, size.height * 0.6359939,
        size.width * 0.2980338, size.height * 0.6367898);
    path_10.cubicTo(size.width * 0.2991709, size.height * 0.6376174, size.width * 0.3004446, size.height * 0.6392338,
        size.width * 0.3013027, size.height * 0.6404830);
    path_10.cubicTo(size.width * 0.3022465, size.height * 0.6418568, size.width * 0.3053565, size.height * 0.6410156,
        size.width * 0.3067184, size.height * 0.6410156);
    path_10.cubicTo(size.width * 0.3085290, size.height * 0.6410156, size.width * 0.3103478, size.height * 0.6410156,
        size.width * 0.3121585, size.height * 0.6410156);
    path_10.cubicTo(size.width * 0.3140633, size.height * 0.6410156, size.width * 0.3159407, size.height * 0.6416378,
        size.width * 0.3172326, size.height * 0.6425781);
    path_10.cubicTo(size.width * 0.3185823, size.height * 0.6435605, size.width * 0.3199588, size.height * 0.6449064,
        size.width * 0.3212090, size.height * 0.6462713);
    path_10.cubicTo(size.width * 0.3225694, size.height * 0.6477565, size.width * 0.3235536, size.height * 0.6487768,
        size.width * 0.3251854, size.height * 0.6499645);
    path_10.cubicTo(size.width * 0.3263213, size.height * 0.6507912, size.width * 0.3275146, size.height * 0.6526317,
        size.width * 0.3284543, size.height * 0.6536577);
    path_10.cubicTo(size.width * 0.3297241, size.height * 0.6550439, size.width * 0.3303702, size.height * 0.6571403,
        size.width * 0.3309914, size.height * 0.6589489);
    path_10.cubicTo(size.width * 0.3315823, size.height * 0.6606693, size.width * 0.3331723, size.height * 0.6620881,
        size.width * 0.3338944, size.height * 0.6631392);
    path_10.cubicTo(size.width * 0.3350368, size.height * 0.6648022, size.width * 0.3369111, size.height * 0.6664002,
        size.width * 0.3382367, size.height * 0.6673651);
    path_10.cubicTo(size.width * 0.3397256, size.height * 0.6684487, size.width * 0.3403797, size.height * 0.6699818,
        size.width * 0.3411153, size.height * 0.6721236);
    path_10.cubicTo(size.width * 0.3419344, size.height * 0.6745081, size.width * 0.3426661, size.height * 0.6755020,
        size.width * 0.3433109, size.height * 0.6773793);
    path_10.cubicTo(size.width * 0.3440555, size.height * 0.6795472, size.width * 0.3446735, size.height * 0.6806258,
        size.width * 0.3451161, size.height * 0.6832031);
    path_10.cubicTo(size.width * 0.3457330, size.height * 0.6867953, size.width * 0.3450386, size.height * 0.6876405,
        size.width * 0.3472873, size.height * 0.6884588);
    path_10.cubicTo(size.width * 0.3491361, size.height * 0.6891316, size.width * 0.3499015, size.height * 0.6904578,
        size.width * 0.3516296, size.height * 0.6910866);
    path_10.cubicTo(size.width * 0.3523412, size.height * 0.6913456, size.width * 0.3532211, size.height * 0.6962528,
        size.width * 0.3534348, size.height * 0.6968750);
    path_10.cubicTo(size.width * 0.3540182, size.height * 0.6985736, size.width * 0.3545326, size.height * 0.7016629,
        size.width * 0.3545326, size.height * 0.7037287);
    path_10.cubicTo(size.width * 0.3545326, size.height * 0.7056584, size.width * 0.3552405, size.height * 0.7084545,
        size.width * 0.3556060, size.height * 0.7105824);
    path_10.cubicTo(size.width * 0.3561364, size.height * 0.7136707, size.width * 0.3562195, size.height * 0.7154934,
        size.width * 0.3570697, size.height * 0.7179688);
    path_10.cubicTo(size.width * 0.3578319, size.height * 0.7201878, size.width * 0.3586463, size.height * 0.7218619,
        size.width * 0.3596068, size.height * 0.7232599);
    path_10.cubicTo(size.width * 0.3606017, size.height * 0.7247083, size.width * 0.3628754, size.height * 0.7256390,
        size.width * 0.3639491, size.height * 0.7264205);
    path_10.cubicTo(size.width * 0.3653056, size.height * 0.7274078, size.width * 0.3664857, size.height * 0.7282667,
        size.width * 0.3675595, size.height * 0.7290483);
    path_10.cubicTo(size.width * 0.3690675, size.height * 0.7301459, size.width * 0.3696608, size.height * 0.7311435,
        size.width * 0.3715359, size.height * 0.7311435);
    path_10.cubicTo(size.width * 0.3733466, size.height * 0.7311435, size.width * 0.3751653, size.height * 0.7311435,
        size.width * 0.3769760, size.height * 0.7311435);
    path_10.cubicTo(size.width * 0.3782467, size.height * 0.7311435, size.width * 0.3796556, size.height * 0.7289875,
        size.width * 0.3809524, size.height * 0.7285156);
    path_10.cubicTo(size.width * 0.3828587, size.height * 0.7278219, size.width * 0.3846865, size.height * 0.7271295,
        size.width * 0.3863925, size.height * 0.7258878);
    path_10.cubicTo(size.width * 0.3880932, size.height * 0.7246499, size.width * 0.3901247, size.height * 0.7237040,
        size.width * 0.3914666, size.height * 0.7227273);
    path_10.cubicTo(size.width * 0.3937726, size.height * 0.7210489, size.width * 0.3943331, size.height * 0.7207030,
        size.width * 0.3947112, size.height * 0.7185014);
    path_10.cubicTo(size.width * 0.3951401, size.height * 0.7160037, size.width * 0.3927052, size.height * 0.7134507,
        size.width * 0.3921985, size.height * 0.7127131);
    path_10.cubicTo(size.width * 0.3909831, size.height * 0.7109438, size.width * 0.3899132, size.height * 0.7104519,
        size.width * 0.3885636, size.height * 0.7084872);
    path_10.cubicTo(size.width * 0.3872814, size.height * 0.7066207, size.width * 0.3867766, size.height * 0.7043923,
        size.width * 0.3849532, size.height * 0.7037287);
    path_10.cubicTo(size.width * 0.3842588, size.height * 0.7034760, size.width * 0.3824906, size.height * 0.7001795,
        size.width * 0.3820502, size.height * 0.6995384);
    path_10.cubicTo(size.width * 0.3807227, size.height * 0.6976060, size.width * 0.3808703, size.height * 0.6960841,
        size.width * 0.3816842, size.height * 0.6937145);
    path_10.cubicTo(size.width * 0.3823816, size.height * 0.6916841, size.width * 0.3857978, size.height * 0.6910367,
        size.width * 0.3871243, size.height * 0.6905540);
    path_10.cubicTo(size.width * 0.3885432, size.height * 0.6900376, size.width * 0.3895793, size.height * 0.6874710,
        size.width * 0.3911007, size.height * 0.6863636);
    path_10.cubicTo(size.width * 0.3922366, size.height * 0.6855369, size.width * 0.3934299, size.height * 0.6836964,
        size.width * 0.3943696, size.height * 0.6826705);
    path_10.cubicTo(size.width * 0.3957383, size.height * 0.6811762, size.width * 0.3970800, size.height * 0.6804314,
        size.width * 0.3983460, size.height * 0.6795099);
    path_10.cubicTo(size.width * 0.3998966, size.height * 0.6783814, size.width * 0.4014323, size.height * 0.6771880,
        size.width * 0.4026883, size.height * 0.6758168);
    path_10.cubicTo(size.width * 0.4044821, size.height * 0.6738584, size.width * 0.4051740, size.height * 0.6736861,
        size.width * 0.4066647, size.height * 0.6736861);
    path_10.cubicTo(size.width * 0.4087528, size.height * 0.6736861, size.width * 0.4101890, size.height * 0.6735180,
        size.width * 0.4113730, size.height * 0.6726562);
    path_10.cubicTo(size.width * 0.4125605, size.height * 0.6717919, size.width * 0.4146818, size.height * 0.6714343,
        size.width * 0.4157153, size.height * 0.6710582);
    path_10.cubicTo(size.width * 0.4175162, size.height * 0.6704029, size.width * 0.4190519, size.height * 0.6705926,
        size.width * 0.4204235, size.height * 0.6715909);
    path_10.cubicTo(size.width * 0.4217081, size.height * 0.6725259, size.width * 0.4237637, size.height * 0.6720888,
        size.width * 0.4251317, size.height * 0.6715909);
    path_10.cubicTo(size.width * 0.4269291, size.height * 0.6709368, size.width * 0.4288966, size.height * 0.6699160,
        size.width * 0.4302059, size.height * 0.6689631);
    path_10.cubicTo(size.width * 0.4315045, size.height * 0.6680179, size.width * 0.4319941, size.height * 0.6652946,
        size.width * 0.4327430, size.height * 0.6642045);
    path_10.cubicTo(size.width * 0.4338391, size.height * 0.6626090, size.width * 0.4360585, size.height * 0.6620835,
        size.width * 0.4374512, size.height * 0.6615767);
    path_10.cubicTo(size.width * 0.4378025, size.height * 0.6614489, size.width * 0.4381869, size.height * 0.6615767,
        size.width * 0.4385490, size.height * 0.6615767);
    path_10.cubicTo(size.width * 0.4406235, size.height * 0.6608218, size.width * 0.4434692, size.height * 0.6611812,
        size.width * 0.4457699, size.height * 0.6605114);
    path_10.cubicTo(size.width * 0.4478769, size.height * 0.6598979, size.width * 0.4496445, size.height * 0.6584903,
        size.width * 0.4512100, size.height * 0.6573509);
    path_10.cubicTo(size.width * 0.4530559, size.height * 0.6560073, size.width * 0.4540589, size.height * 0.6542834,
        size.width * 0.4551864, size.height * 0.6520952);
    path_10.cubicTo(size.width * 0.4562227, size.height * 0.6500839, size.width * 0.4569370, size.height * 0.6490936,
        size.width * 0.4577235, size.height * 0.6468040);
    path_10.cubicTo(size.width * 0.4583695, size.height * 0.6449231, size.width * 0.4593501, size.height * 0.6436661,
        size.width * 0.4598946, size.height * 0.6420810);
    path_10.cubicTo(size.width * 0.4606175, size.height * 0.6399764, size.width * 0.4618267, size.height * 0.6387820,
        size.width * 0.4631635, size.height * 0.6373224);
    path_10.cubicTo(size.width * 0.4644108, size.height * 0.6359607, size.width * 0.4665909, size.height * 0.6383878,
        size.width * 0.4678718, size.height * 0.6383878);
    path_10.cubicTo(size.width * 0.4679160, size.height * 0.6383878, size.width * 0.4711136, size.height * 0.6334971,
        size.width * 0.4722141, size.height * 0.6330966);
    path_10.cubicTo(size.width * 0.4734754, size.height * 0.6326376, size.width * 0.4746861, size.height * 0.6343809,
        size.width * 0.4758489, size.height * 0.6352273);
    path_10.cubicTo(size.width * 0.4772525, size.height * 0.6362489, size.width * 0.4751472, size.height * 0.6304167,
        size.width * 0.4758489, size.height * 0.6283736);
    path_10.cubicTo(size.width * 0.4766689, size.height * 0.6259865, size.width * 0.4784548, size.height * 0.6241792,
        size.width * 0.4794594, size.height * 0.6230824);
    path_10.cubicTo(size.width * 0.4811389, size.height * 0.6212488, size.width * 0.4792269, size.height * 0.6192804,
        size.width * 0.4787276, size.height * 0.6178267);
    path_10.cubicTo(size.width * 0.4780708, size.height * 0.6159146, size.width * 0.4780201, size.height * 0.6126784,
        size.width * 0.4780201, size.height * 0.6104403);
    path_10.cubicTo(size.width * 0.4780201, size.height * 0.6067046, size.width * 0.4780634, size.height * 0.6064562,
        size.width * 0.4801913, size.height * 0.6056818);
    path_10.cubicTo(size.width * 0.4822037, size.height * 0.6049494, size.width * 0.4829016, size.height * 0.6060201,
        size.width * 0.4848995, size.height * 0.6067472);
    path_10.cubicTo(size.width * 0.4870778, size.height * 0.6075399, size.width * 0.4878490, size.height * 0.6072121,
        size.width * 0.4892418, size.height * 0.6051847);
    path_10.cubicTo(size.width * 0.4904490, size.height * 0.6034273, size.width * 0.4907923, size.height * 0.6018623,
        size.width * 0.4917789, size.height * 0.6004261);
    path_10.cubicTo(size.width * 0.4927738, size.height * 0.5989778, size.width * 0.4939771, size.height * 0.5980272,
        size.width * 0.4950234, size.height * 0.5972656);
    path_10.cubicTo(size.width * 0.4968341, size.height * 0.5959477, size.width * 0.4979264, size.height * 0.5951240,
        size.width * 0.4979264, size.height * 0.5919744);
    path_10.cubicTo(size.width * 0.4979264, size.height * 0.5901950, size.width * 0.4975605, size.height * 0.5871655,
        size.width * 0.4975605, size.height * 0.5846236);
    path_10.cubicTo(size.width * 0.4975605, size.height * 0.5815319, size.width * 0.5010482, size.height * 0.5825814,
        size.width * 0.5022687, size.height * 0.5830256);
    path_10.cubicTo(size.width * 0.5040614, size.height * 0.5836780, size.width * 0.5055686, size.height * 0.5840909,
        size.width * 0.5073429, size.height * 0.5840909);
    path_10.cubicTo(size.width * 0.5091409, size.height * 0.5840909, size.width * 0.5108278, size.height * 0.5830256,
        size.width * 0.5127830, size.height * 0.5830256);
    path_10.cubicTo(size.width * 0.5145179, size.height * 0.5830256, size.width * 0.5153091, size.height * 0.5814631,
        size.width * 0.5171253, size.height * 0.5814631);
    path_10.cubicTo(size.width * 0.5190010, size.height * 0.5814631, size.width * 0.5201796, size.height * 0.5788565,
        size.width * 0.5207358, size.height * 0.5772372);
    path_10.cubicTo(size.width * 0.5215542, size.height * 0.5748544, size.width * 0.5222765, size.height * 0.5727516,
        size.width * 0.5229069, size.height * 0.5709162);
    path_10.cubicTo(size.width * 0.5231833, size.height * 0.5701116, size.width * 0.5266909, size.height * 0.5689255,
        size.width * 0.5276151, size.height * 0.5682528);
    path_10.cubicTo(size.width * 0.5289427, size.height * 0.5672866, size.width * 0.5305673, size.height * 0.5666101,
        size.width * 0.5319575, size.height * 0.5650923);
    path_10.cubicTo(size.width * 0.5337038, size.height * 0.5631858, size.width * 0.5346146, size.height * 0.5621028,
        size.width * 0.5370316, size.height * 0.5613991);
    path_10.cubicTo(size.width * 0.5387472, size.height * 0.5608997, size.width * 0.5404833, size.height * 0.5572091,
        size.width * 0.5410324, size.height * 0.5561435);
    path_10.cubicTo(size.width * 0.5417991, size.height * 0.5546554, size.width * 0.5421594, size.height * 0.5510302,
        size.width * 0.5424717, size.height * 0.5487571);
    path_10.cubicTo(size.width * 0.5427906, size.height * 0.5464359, size.width * 0.5437620, size.height * 0.5444680,
        size.width * 0.5442769, size.height * 0.5429688);
    path_10.cubicTo(size.width * 0.5453096, size.height * 0.5399624, size.width * 0.5475555, size.height * 0.5376635,
        size.width * 0.5489852, size.height * 0.5355824);
    path_10.cubicTo(size.width * 0.5500733, size.height * 0.5339984, size.width * 0.5514809, size.height * 0.5329669,
        size.width * 0.5529616, size.height * 0.5318892);
    path_10.cubicTo(size.width * 0.5545091, size.height * 0.5307628, size.width * 0.5559375, size.height * 0.5303001,
        size.width * 0.5573283, size.height * 0.5297940);
    path_10.cubicTo(size.width * 0.5594755, size.height * 0.5290126, size.width * 0.5602644, size.height * 0.5316918,
        size.width * 0.5605728, size.height * 0.5334872);
    path_10.cubicTo(size.width * 0.5610876, size.height * 0.5364848, size.width * 0.5613375, size.height * 0.5372405,
        size.width * 0.5620365, size.height * 0.5392756);
    path_10.cubicTo(size.width * 0.5627280, size.height * 0.5412887, size.width * 0.5638085, size.height * 0.5426927,
        size.width * 0.5645492, size.height * 0.5435014);
    path_10.cubicTo(size.width * 0.5657120, size.height * 0.5447710, size.width * 0.5665180, size.height * 0.5402218,
        size.width * 0.5678181, size.height * 0.5392756);
    path_10.cubicTo(size.width * 0.5692011, size.height * 0.5382689, size.width * 0.5698350, size.height * 0.5370263,
        size.width * 0.5710870, size.height * 0.5361151);
    path_10.cubicTo(size.width * 0.5726962, size.height * 0.5349438, size.width * 0.5732547, size.height * 0.5319454,
        size.width * 0.5736241, size.height * 0.5297940);
    path_10.cubicTo(size.width * 0.5740367, size.height * 0.5273919, size.width * 0.5742640, size.height * 0.5254645,
        size.width * 0.5746975, size.height * 0.5229403);
    path_10.cubicTo(size.width * 0.5751720, size.height * 0.5201773, size.width * 0.5767246, size.height * 0.5193520,
        size.width * 0.5783324, size.height * 0.5181818);
    path_10.cubicTo(size.width * 0.5798829, size.height * 0.5170532, size.width * 0.5824700, size.height * 0.5176171,
        size.width * 0.5837480, size.height * 0.5171520);
    path_10.cubicTo(size.width * 0.5857904, size.height * 0.5164087, size.width * 0.5869930, size.height * 0.5156870,
        size.width * 0.5888222, size.height * 0.5150213);
    path_10.cubicTo(size.width * 0.5889021, size.height * 0.5149922, size.width * 0.5889800, size.height * 0.5149904,
        size.width * 0.5890662, size.height * 0.5149858);
    path_10.cubicTo(size.width * 0.5903589, size.height * 0.5149161, size.width * 0.5922845, size.height * 0.5174334,
        size.width * 0.5927986, size.height * 0.5181818);
    path_10.cubicTo(size.width * 0.5947032, size.height * 0.5209542, size.width * 0.5943758, size.height * 0.5192472,
        size.width * 0.5975068, size.height * 0.5192472);
    path_10.cubicTo(size.width * 0.5997000, size.height * 0.5192471, size.width * 0.6016945, size.height * 0.5189039,
        size.width * 0.6036788, size.height * 0.5181818);
    path_10.cubicTo(size.width * 0.6037798, size.height * 0.5181451, size.width * 0.6038890, size.height * 0.5181030,
        size.width * 0.6039959, size.height * 0.5180753);
    path_10.cubicTo(size.width * 0.6042562, size.height * 0.5173780, size.width * 0.6045597, size.height * 0.5166468,
        size.width * 0.6047521, size.height * 0.5160866);
    path_10.cubicTo(size.width * 0.6056235, size.height * 0.5135496, size.width * 0.6070622, size.height * 0.5122009,
        size.width * 0.6094604, size.height * 0.5113281);
    path_10.cubicTo(size.width * 0.6099432, size.height * 0.5111524, size.width * 0.6104412, size.height * 0.5109712,
        size.width * 0.6109241, size.height * 0.5107955);
    path_10.cubicTo(size.width * 0.6132225, size.height * 0.5099590, size.width * 0.6149957, size.height * 0.5081161,
        size.width * 0.6170716, size.height * 0.5066051);
    path_10.cubicTo(size.width * 0.6188812, size.height * 0.5052880, size.width * 0.6200091, size.height * 0.5027405,
        size.width * 0.6206821, size.height * 0.5007812);
    path_10.cubicTo(size.width * 0.6215748, size.height * 0.4981822, size.width * 0.6217799, size.height * 0.4973543,
        size.width * 0.6217799, size.height * 0.4939276);
    path_10.cubicTo(size.width * 0.6217798, size.height * 0.4901569, size.width * 0.6212144, size.height * 0.4902217,
        size.width * 0.6203162, size.height * 0.4876065);
    path_10.cubicTo(size.width * 0.6196041, size.height * 0.4855335, size.width * 0.6193055, size.height * 0.4837814,
        size.width * 0.6188769, size.height * 0.4812855);
    path_10.cubicTo(size.width * 0.6182819, size.height * 0.4778214, size.width * 0.6226614, size.height * 0.4795200,
        size.width * 0.6232192, size.height * 0.4797230);
    path_10.cubicTo(size.width * 0.6249947, size.height * 0.4803692, size.width * 0.6264461, size.height * 0.4802202,
        size.width * 0.6282933, size.height * 0.4802202);
    path_10.cubicTo(size.width * 0.6311084, size.height * 0.4802202, size.width * 0.6321049, size.height * 0.4798670,
        size.width * 0.6340993, size.height * 0.4781250);
    path_10.cubicTo(size.width * 0.6355024, size.height * 0.4768996, size.width * 0.6364987, size.height * 0.4763786,
        size.width * 0.6377098, size.height * 0.4754972);
    path_10.cubicTo(size.width * 0.6381926, size.height * 0.4760243, size.width * 0.6386663, size.height * 0.4765325,
        size.width * 0.6391491, size.height * 0.4770597);
    path_10.cubicTo(size.width * 0.6399412, size.height * 0.4779244, size.width * 0.6425476, size.height * 0.4742432,
        size.width * 0.6431499, size.height * 0.4733665);
    path_10.cubicTo(size.width * 0.6445373, size.height * 0.4713468, size.width * 0.6461835, size.height * 0.4718040,
        size.width * 0.6482240, size.height * 0.4718040);
    path_10.cubicTo(size.width * 0.6501351, size.height * 0.4718040, size.width * 0.6521594, size.height * 0.4702596,
        size.width * 0.6536397, size.height * 0.4686435);
    path_10.cubicTo(size.width * 0.6547187, size.height * 0.4674655, size.width * 0.6564490, size.height * 0.4668651,
        size.width * 0.6576161, size.height * 0.4660156);
    path_10.cubicTo(size.width * 0.6598412, size.height * 0.4643961, size.width * 0.6597742, size.height * 0.4655020,
        size.width * 0.6612510, size.height * 0.4633523);
    path_10.cubicTo(size.width * 0.6622585, size.height * 0.4618856, size.width * 0.6623244, size.height * 0.4593647,
        size.width * 0.6623244, size.height * 0.4570313);
    path_10.cubicTo(size.width * 0.6623244, size.height * 0.4537562, size.width * 0.6621151, size.height * 0.4520487,
        size.width * 0.6616169, size.height * 0.4491477);
    path_10.cubicTo(size.width * 0.6612737, size.height * 0.4471494, size.width * 0.6609364, size.height * 0.4447239,
        size.width * 0.6605191, size.height * 0.4422940);
    path_10.cubicTo(size.width * 0.6601215, size.height * 0.4399786, size.width * 0.6601532, size.height * 0.4377473,
        size.width * 0.6601532, size.height * 0.4349077);
    path_10.cubicTo(size.width * 0.6601532, size.height * 0.4324638, size.width * 0.6601532, size.height * 0.4305477,
        size.width * 0.6601532, size.height * 0.4280540);
    path_10.cubicTo(size.width * 0.6601532, size.height * 0.4256914, size.width * 0.6598056, size.height * 0.4232870,
        size.width * 0.6594457, size.height * 0.4206676);
    path_10.cubicTo(size.width * 0.6591383, size.height * 0.4184301, size.width * 0.6602038, size.height * 0.4158710,
        size.width * 0.6612510, size.height * 0.4143466);
    path_10.cubicTo(size.width * 0.6626246, size.height * 0.4123470, size.width * 0.6623592, size.height * 0.4108944,
        size.width * 0.6641540, size.height * 0.4095881);
    path_10.cubicTo(size.width * 0.6652229, size.height * 0.4088101, size.width * 0.6674120, size.height * 0.4048454,
        size.width * 0.6681304, size.height * 0.4037997);
    path_10.cubicTo(size.width * 0.6692368, size.height * 0.4021891, size.width * 0.6704667, size.height * 0.4019967,
        size.width * 0.6713993, size.height * 0.4006392);
    path_10.cubicTo(size.width * 0.6724554, size.height * 0.3991019, size.width * 0.6679970, size.height * 0.3968490,
        size.width * 0.6673985, size.height * 0.3964134);
    path_10.cubicTo(size.width * 0.6662572, size.height * 0.3955827, size.width * 0.6632925, size.height * 0.3964134,
        size.width * 0.6619828, size.height * 0.3964134);
    path_10.cubicTo(size.width * 0.6594876, size.height * 0.3964134, size.width * 0.6626887, size.height * 0.3932551,
        size.width * 0.6630562, size.height * 0.3927202);
    path_10.cubicTo(size.width * 0.6639897, size.height * 0.3913613, size.width * 0.6642386, size.height * 0.3885698,
        size.width * 0.6645199, size.height * 0.3869318);
    path_10.cubicTo(size.width * 0.6650206, size.height * 0.3840163, size.width * 0.6685686, size.height * 0.3870022,
        size.width * 0.6692037, size.height * 0.3874645);
    path_10.cubicTo(size.width * 0.6710938, size.height * 0.3888402, size.width * 0.6721553, size.height * 0.3882370,
        size.width * 0.6742779, size.height * 0.3874645);
    path_10.cubicTo(size.width * 0.6761366, size.height * 0.3867881, size.width * 0.6765334, size.height * 0.3858665,
        size.width * 0.6789861, size.height * 0.3858665);
    path_10.cubicTo(size.width * 0.6810085, size.height * 0.3858665, size.width * 0.6821127, size.height * 0.3831205,
        size.width * 0.6826210, size.height * 0.3816406);
    path_10.cubicTo(size.width * 0.6832489, size.height * 0.3798127, size.width * 0.6835176, size.height * 0.3783446,
        size.width * 0.6838164, size.height * 0.3766335);
    path_10.cubicTo(size.width * 0.6835417, size.height * 0.3767206, size.width * 0.6832624, size.height * 0.3768174,
        size.width * 0.6829869, size.height * 0.3769176);
    path_10.cubicTo(size.width * 0.6817471, size.height * 0.3773688, size.width * 0.6813478, size.height * 0.3765059,
        size.width * 0.6797180, size.height * 0.3753196);
    path_10.cubicTo(size.width * 0.6778971, size.height * 0.3739943, size.width * 0.6773879, size.height * 0.3734240,
        size.width * 0.6753757, size.height * 0.3726918);
    path_10.cubicTo(size.width * 0.6737143, size.height * 0.3720872, size.width * 0.6715755, size.height * 0.3720900,
        size.width * 0.6703015, size.height * 0.3716264);
    path_10.cubicTo(size.width * 0.6682864, size.height * 0.3708931, size.width * 0.6661940, size.height * 0.3711293,
        size.width * 0.6637881, size.height * 0.3711293);
    path_10.cubicTo(size.width * 0.6620374, size.height * 0.3711293, size.width * 0.6599176, size.height * 0.3693805,
        size.width * 0.6590798, size.height * 0.3684659);
    path_10.cubicTo(size.width * 0.6572945, size.height * 0.3665168, size.width * 0.6568387, size.height * 0.3667353,
        size.width * 0.6558109, size.height * 0.3637429);
    path_10.cubicTo(size.width * 0.6550908, size.height * 0.3616464, size.width * 0.6551034, size.height * 0.3588781,
        size.width * 0.6551034, size.height * 0.3563565);
    path_10.cubicTo(size.width * 0.6551034, size.height * 0.3540135, size.width * 0.6540901, size.height * 0.3518795,
        size.width * 0.6536397, size.height * 0.3505682);
    path_10.cubicTo(size.width * 0.6529394, size.height * 0.3485292, size.width * 0.6529162, size.height * 0.3452190,
        size.width * 0.6525664, size.height * 0.3431818);
    path_10.cubicTo(size.width * 0.6521264, size.height * 0.3406202, size.width * 0.6511054, size.height * 0.3390077,
        size.width * 0.6507367, size.height * 0.3368608);
    path_10.cubicTo(size.width * 0.6502615, size.height * 0.3340936, size.width * 0.6504044, size.height * 0.3315807,
        size.width * 0.6482240, size.height * 0.3331676);
    path_10.cubicTo(size.width * 0.6455818, size.height * 0.3350907, size.width * 0.6447875, size.height * 0.3366354,
        size.width * 0.6431499, size.height * 0.3384233);
    path_10.cubicTo(size.width * 0.6414978, size.height * 0.3402270, size.width * 0.6406447, size.height * 0.3421111,
        size.width * 0.6384416, size.height * 0.3437145);
    path_10.cubicTo(size.width * 0.6369342, size.height * 0.3448117, size.width * 0.6349202, size.height * 0.3467099,
        size.width * 0.6340993, size.height * 0.3479048);
    path_10.cubicTo(size.width * 0.6333659, size.height * 0.3489726, size.width * 0.6311233, size.height * 0.3496626,
        size.width * 0.6300986, size.height * 0.3500355);
    path_10.cubicTo(size.width * 0.6282153, size.height * 0.3527770, size.width * 0.6255383, size.height * 0.3461385,
        size.width * 0.6253903, size.height * 0.3452770);
    path_10.cubicTo(size.width * 0.6249157, size.height * 0.3425135, size.width * 0.6246850, size.height * 0.3410898,
        size.width * 0.6235851, size.height * 0.3394886);
    path_10.cubicTo(size.width * 0.6225118, size.height * 0.3379262, size.width * 0.6213650, size.height * 0.3422589,
        size.width * 0.6210480, size.height * 0.3431818);
    path_10.cubicTo(size.width * 0.6203913, size.height * 0.3450938, size.width * 0.6203162, size.height * 0.3470418,
        size.width * 0.6203162, size.height * 0.3500355);
    path_10.cubicTo(size.width * 0.6203162, size.height * 0.3538290, size.width * 0.6200798, size.height * 0.3540727,
        size.width * 0.6188769, size.height * 0.3558239);
    path_10.cubicTo(size.width * 0.6173256, size.height * 0.3580820, size.width * 0.6161141, size.height * 0.3582831,
        size.width * 0.6149005, size.height * 0.3600497);
    path_10.cubicTo(size.width * 0.6136232, size.height * 0.3619091, size.width * 0.6133052, size.height * 0.3644671,
        size.width * 0.6123634, size.height * 0.3658381);
    path_10.cubicTo(size.width * 0.6110943, size.height * 0.3676854, size.width * 0.6087231, size.height * 0.3656940,
        size.width * 0.6076552, size.height * 0.3653054);
    path_10.cubicTo(size.width * 0.6057803, size.height * 0.3646231, size.width * 0.6040451, size.height * 0.3638762,
        size.width * 0.6022151, size.height * 0.3632102);
    path_10.cubicTo(size.width * 0.6004570, size.height * 0.3625704, size.width * 0.5985681, size.height * 0.3622559,
        size.width * 0.5967994, size.height * 0.3616122);
    path_10.cubicTo(size.width * 0.5952669, size.height * 0.3610545, size.width * 0.5927750, size.height * 0.3611151,
        size.width * 0.5920911, size.height * 0.3611151);
    path_10.cubicTo(size.width * 0.5903857, size.height * 0.3611151, size.width * 0.5883046, size.height * 0.3626085,
        size.width * 0.5866511, size.height * 0.3632102);
    path_10.cubicTo(size.width * 0.5845588, size.height * 0.3639716, size.width * 0.5834798, size.height * 0.3622337,
        size.width * 0.5819428, size.height * 0.3611151);
    path_10.cubicTo(size.width * 0.5804584, size.height * 0.3600346, size.width * 0.5781855, size.height * 0.3601032,
        size.width * 0.5768687, size.height * 0.3605824);
    path_10.cubicTo(size.width * 0.5759286, size.height * 0.3609245, size.width * 0.5754294, size.height * 0.3659743,
        size.width * 0.5754294, size.height * 0.3674361);
    path_10.cubicTo(size.width * 0.5754293, size.height * 0.3703600, size.width * 0.5750634, size.height * 0.3724021,
        size.width * 0.5750634, size.height * 0.3748224);
    path_10.cubicTo(size.width * 0.5750634, size.height * 0.3767711, size.width * 0.5729896, size.height * 0.3799365,
        size.width * 0.5725263, size.height * 0.3806108);
    path_10.cubicTo(size.width * 0.5716794, size.height * 0.3818437, size.width * 0.5689133, size.height * 0.3828401,
        size.width * 0.5678181, size.height * 0.3832386);
    path_10.cubicTo(size.width * 0.5660003, size.height * 0.3839002, size.width * 0.5644346, size.height * 0.3854349,
        size.width * 0.5631099, size.height * 0.3863991);
    path_10.cubicTo(size.width * 0.5618897, size.height * 0.3872873, size.width * 0.5597533, size.height * 0.3869318,
        size.width * 0.5580357, size.height * 0.3869318);
    path_10.cubicTo(size.width * 0.5562020, size.height * 0.3869318, size.width * 0.5550317, size.height * 0.3863991,
        size.width * 0.5529616, size.height * 0.3863991);
    path_10.cubicTo(size.width * 0.5513160, size.height * 0.3863992, size.width * 0.5499036, size.height * 0.3858665,
        size.width * 0.5479118, size.height * 0.3858665);
    path_10.cubicTo(size.width * 0.5461759, size.height * 0.3858665, size.width * 0.5441247, size.height * 0.3868629,
        size.width * 0.5424717, size.height * 0.3874645);
    path_10.cubicTo(size.width * 0.5402334, size.height * 0.3882791, size.width * 0.5391405, size.height * 0.3868056,
        size.width * 0.5381294, size.height * 0.3853338);
    path_10.cubicTo(size.width * 0.5367355, size.height * 0.3833047, size.width * 0.5363237, size.height * 0.3816749,
        size.width * 0.5355923, size.height * 0.3795455);
    path_10.cubicTo(size.width * 0.5346563, size.height * 0.3768202, size.width * 0.5349209, size.height * 0.3754075,
        size.width * 0.5337871, size.height * 0.3737571);
    path_10.cubicTo(size.width * 0.5332459, size.height * 0.3729693, size.width * 0.5292074, size.height * 0.3737571,
        size.width * 0.5283470, size.height * 0.3737571);
    path_10.cubicTo(size.width * 0.5267038, size.height * 0.3737571, size.width * 0.5244942, size.height * 0.3731539,
        size.width * 0.5229069, size.height * 0.3726918);
    path_10.cubicTo(size.width * 0.5220748, size.height * 0.3724495, size.width * 0.5198950, size.height * 0.3737571,
        size.width * 0.5181987, size.height * 0.3737571);
    path_10.cubicTo(size.width * 0.5166801, size.height * 0.3737571, size.width * 0.5157732, size.height * 0.3712562,
        size.width * 0.5149541, size.height * 0.3700639);
    path_10.cubicTo(size.width * 0.5135981, size.height * 0.3680900, size.width * 0.5145762, size.height * 0.3668769,
        size.width * 0.5124171, size.height * 0.3653054);
    path_10.cubicTo(size.width * 0.5110746, size.height * 0.3643283, size.width * 0.5102354, size.height * 0.3632064,
        size.width * 0.5087822, size.height * 0.3626776);
    path_10.cubicTo(size.width * 0.5066056, size.height * 0.3618855, size.width * 0.5057341, size.height * 0.3623234,
        size.width * 0.5040740, size.height * 0.3611151);
    path_10.cubicTo(size.width * 0.5022873, size.height * 0.3598146, size.width * 0.5019408, size.height * 0.3590830,
        size.width * 0.4993657, size.height * 0.3605824);
    path_10.cubicTo(size.width * 0.4973796, size.height * 0.3617389, size.width * 0.4965725, size.height * 0.3608310,
        size.width * 0.4957553, size.height * 0.3632102);
    path_10.cubicTo(size.width * 0.4950520, size.height * 0.3652577, size.width * 0.4966005, size.height * 0.3685936,
        size.width * 0.4968530, size.height * 0.3700639);
    path_10.cubicTo(size.width * 0.4971301, size.height * 0.3716771, size.width * 0.4949210, size.height * 0.3753832,
        size.width * 0.4946575, size.height * 0.3769176);
    path_10.cubicTo(size.width * 0.4942540, size.height * 0.3792671, size.width * 0.4919781, size.height * 0.3804658,
        size.width * 0.4910470, size.height * 0.3811435);
    path_10.cubicTo(size.width * 0.4893407, size.height * 0.3823854, size.width * 0.4870185, size.height * 0.3803065,
        size.width * 0.4859729, size.height * 0.3795455);
    path_10.cubicTo(size.width * 0.4843525, size.height * 0.3783661, size.width * 0.4847846, size.height * 0.3771333,
        size.width * 0.4827283, size.height * 0.3763849);
    path_10.cubicTo(size.width * 0.4822345, size.height * 0.3762052, size.width * 0.4789055, size.height * 0.3786169,
        size.width * 0.4783616, size.height * 0.3790128);
    path_10.cubicTo(size.width * 0.4769874, size.height * 0.3800130, size.width * 0.4762804, size.height * 0.3810603,
        size.width * 0.4747512, size.height * 0.3821733);
    path_10.cubicTo(size.width * 0.4734843, size.height * 0.3830953, size.width * 0.4708044, size.height * 0.3827060,
        size.width * 0.4693111, size.height * 0.3827060);
    path_10.cubicTo(size.width * 0.4675004, size.height * 0.3827060, size.width * 0.4657060, size.height * 0.3827060,
        size.width * 0.4638954, size.height * 0.3827060);
    path_10.cubicTo(size.width * 0.4619951, size.height * 0.3827060, size.width * 0.4607215, size.height * 0.3819939,
        size.width * 0.4595531, size.height * 0.3811435);
    path_10.cubicTo(size.width * 0.4576995, size.height * 0.3797944, size.width * 0.4559554, size.height * 0.3821191,
        size.width * 0.4551864, size.height * 0.3832386);
    path_10.cubicTo(size.width * 0.4539884, size.height * 0.3849825, size.width * 0.4527005, size.height * 0.3853143,
        size.width * 0.4512100, size.height * 0.3863991);
    path_10.cubicTo(size.width * 0.4498161, size.height * 0.3874137, size.width * 0.4482869, size.height * 0.3878447,
        size.width * 0.4465018, size.height * 0.3884943);
    path_10.cubicTo(size.width * 0.4447351, size.height * 0.3891373, size.width * 0.4428280, size.height * 0.3889257,
        size.width * 0.4410861, size.height * 0.3895597);
    path_10.cubicTo(size.width * 0.4392310, size.height * 0.3902348, size.width * 0.4385549, size.height * 0.3911577,
        size.width * 0.4370853, size.height * 0.3911577);
    path_10.cubicTo(size.width * 0.4363581, size.height * 0.3911577, size.width * 0.4388073, size.height * 0.3854550,
        size.width * 0.4388905, size.height * 0.3853338);
    path_10.cubicTo(size.width * 0.4399674, size.height * 0.3837662, size.width * 0.4406971, size.height * 0.3822069,
        size.width * 0.4417935, size.height * 0.3806108);
    path_10.cubicTo(size.width * 0.4440110, size.height * 0.3773829, size.width * 0.4431542, size.height * 0.3779510,
        size.width * 0.4425254, size.height * 0.3742898);
    path_10.cubicTo(size.width * 0.4421412, size.height * 0.3720527, size.width * 0.4412969, size.height * 0.3701452,
        size.width * 0.4407201, size.height * 0.3684659);
    path_10.cubicTo(size.width * 0.4401393, size.height * 0.3667749, size.width * 0.4395650, size.height * 0.3644741,
        size.width * 0.4392564, size.height * 0.3626776);
    path_10.cubicTo(size.width * 0.4388130, size.height * 0.3600953, size.width * 0.4379470, size.height * 0.3595938,
        size.width * 0.4363778, size.height * 0.3584517);
    path_10.cubicTo(size.width * 0.4344984, size.height * 0.3570838, size.width * 0.4341817, size.height * 0.3563928,
        size.width * 0.4363778, size.height * 0.3531960);
    path_10.cubicTo(size.width * 0.4376107, size.height * 0.3514013, size.width * 0.4386239, size.height * 0.3507622,
        size.width * 0.4403542, size.height * 0.3495028);
    path_10.cubicTo(size.width * 0.4415757, size.height * 0.3486138, size.width * 0.4417887, size.height * 0.3453406,
        size.width * 0.4421594, size.height * 0.3431818);
    path_10.cubicTo(size.width * 0.4425697, size.height * 0.3407931, size.width * 0.4420980, size.height * 0.3375681,
        size.width * 0.4417935, size.height * 0.3357955);
    path_10.cubicTo(size.width * 0.4413797, size.height * 0.3333857, size.width * 0.4407132, size.height * 0.3320975,
        size.width * 0.4403542, size.height * 0.3300071);
    path_10.cubicTo(size.width * 0.4399231, size.height * 0.3274966, size.width * 0.4396556, size.height * 0.3254775,
        size.width * 0.4392564, size.height * 0.3231534);
    path_10.cubicTo(size.width * 0.4388433, size.height * 0.3207479, size.width * 0.4382952, size.height * 0.3196160,
        size.width * 0.4378171, size.height * 0.3168324);
    path_10.cubicTo(size.width * 0.4374223, size.height * 0.3145337, size.width * 0.4378171, size.height * 0.3112968,
        size.width * 0.4378171, size.height * 0.3089134);
    path_10.cubicTo(size.width * 0.4378171, size.height * 0.3060396, size.width * 0.4374512, size.height * 0.3037288,
        size.width * 0.4374512, size.height * 0.3009943);
    path_10.cubicTo(size.width * 0.4374512, size.height * 0.3002460, size.width * 0.4362272, size.height * 0.2996669,
        size.width * 0.4360119, size.height * 0.2994318);
    path_10.cubicTo(size.width * 0.4360119, size.height * 0.2986923, size.width * 0.4308227, size.height * 0.2953886,
        size.width * 0.4305718, size.height * 0.2952060);
    path_10.cubicTo(size.width * 0.4292421, size.height * 0.2942381, size.width * 0.4281536, size.height * 0.2932839,
        size.width * 0.4273029, size.height * 0.2920455);
    path_10.cubicTo(size.width * 0.4260755, size.height * 0.2902587, size.width * 0.4250231, size.height * 0.2911611,
        size.width * 0.4240584, size.height * 0.2883523);
    path_10.cubicTo(size.width * 0.4232179, size.height * 0.2859054, size.width * 0.4239047, size.height * 0.2835438,
        size.width * 0.4244243, size.height * 0.2820313);
    path_10.cubicTo(size.width * 0.4252093, size.height * 0.2797458, size.width * 0.4257304, size.height * 0.2791492,
        size.width * 0.4262295, size.height * 0.2762429);
    path_10.cubicTo(size.width * 0.4266925, size.height * 0.2735470, size.width * 0.4246035, size.height * 0.2752455,
        size.width * 0.4233265, size.height * 0.2757102);
    path_10.cubicTo(size.width * 0.4219639, size.height * 0.2762061, size.width * 0.4202983, size.height * 0.2779143,
        size.width * 0.4189842, size.height * 0.2788707);
    path_10.cubicTo(size.width * 0.4177811, size.height * 0.2797464, size.width * 0.4164043, size.height * 0.2810148,
        size.width * 0.4150078, size.height * 0.2820313);
    path_10.cubicTo(size.width * 0.4133708, size.height * 0.2832227, size.width * 0.4122255, size.height * 0.2837722,
        size.width * 0.4110070, size.height * 0.2846591);
    path_10.cubicTo(size.width * 0.4096331, size.height * 0.2856591, size.width * 0.4081931, size.height * 0.2861745,
        size.width * 0.4066647, size.height * 0.2872869);
    path_10.cubicTo(size.width * 0.4050620, size.height * 0.2884535, size.width * 0.4034763, size.height * 0.2881987,
        size.width * 0.4015906, size.height * 0.2888849);
    path_10.cubicTo(size.width * 0.4010071, size.height * 0.2890973, size.width * 0.3992296, size.height * 0.2835385,
        size.width * 0.3990779, size.height * 0.2830966);
    path_10.cubicTo(size.width * 0.3984000, size.height * 0.2811231, size.width * 0.3970416, size.height * 0.2802165,
        size.width * 0.3958089, size.height * 0.2788707);
    path_10.cubicTo(size.width * 0.3942096, size.height * 0.2771247, size.width * 0.3928178, size.height * 0.2769600,
        size.width * 0.3911007, size.height * 0.2757102);
    path_10.cubicTo(size.width * 0.3893106, size.height * 0.2744073, size.width * 0.3883806, size.height * 0.2731401,
        size.width * 0.3867584, size.height * 0.2725497);
    path_10.cubicTo(size.width * 0.3866840, size.height * 0.2725226, size.width * 0.3866253, size.height * 0.2725306,
        size.width * 0.3865632, size.height * 0.2725497);
    path_10.close();
    path_10.moveTo(size.width * 0.2629050, size.height * 0.3650213);
    path_10.cubicTo(size.width * 0.2627625, size.height * 0.3651206, size.width * 0.2626056, size.height * 0.3652172,
        size.width * 0.2624171, size.height * 0.3653054);
    path_10.cubicTo(size.width * 0.2625975, size.height * 0.3652190, size.width * 0.2627686, size.height * 0.3651198,
        size.width * 0.2629050, size.height * 0.3650213);
    path_10.close();
    path_10.moveTo(size.width * 0.6087773, size.height * 0.5303267);
    path_10.cubicTo(size.width * 0.6094569, size.height * 0.5303416, size.width * 0.6101421, size.height * 0.5304749,
        size.width * 0.6108509, size.height * 0.5306463);
    path_10.cubicTo(size.width * 0.6101463, size.height * 0.5304759, size.width * 0.6094535, size.height * 0.5303419,
        size.width * 0.6087773, size.height * 0.5303267);
    path_10.close();
    path_10.moveTo(size.width * 0.2647834, size.height * 0.5531960);
    path_10.cubicTo(size.width * 0.2645229, size.height * 0.5532750, size.width * 0.2642503, size.height * 0.5533290,
        size.width * 0.2639783, size.height * 0.5533736);
    path_10.cubicTo(size.width * 0.2642540, size.height * 0.5533268, size.width * 0.2645193, size.height * 0.5532775,
        size.width * 0.2647834, size.height * 0.5531960);
    path_10.close();
    Paint paint10Fill = Paint()..style = PaintingStyle.fill;
    paint10Fill.color = centralAnatoliaColor;
    canvas.drawPath(path_10, paint10Fill);

    /// İçAnadolu Bölgesi Bitiş
    pathList = [
      path_0,
      path_1,
      path_2,
      path_3,
      path_4,
      path_5,
      path_6,
      path_7,
      path_8,
      path_9,
      path_10,
      pathIst,
      pathAvIst
    ];
    Paint borderStroke = Paint()
      ..strokeWidth = regionModel.unSelectedWidthFactor * .5
      ..style = PaintingStyle.stroke;
    borderStroke.color = regionModel.borderColor;
    borderStroke.strokeCap = StrokeCap.butt;
    borderStroke.strokeJoin = StrokeJoin.miter;
    //borderStroke.maskFilter = MaskFilter.blur(BlurStyle.outer, 1);

    for (int a = 0; a < 10; a++) {
      canvas.drawPath(pathList[a], borderStroke);
    }

    selectRegion(canvas, size);
  }
}
