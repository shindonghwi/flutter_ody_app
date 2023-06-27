import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:ody_flutter_app/presentation/components/graph/RecordGraph.dart';
import 'package:ody_flutter_app/presentation/components/graph/model/AxisEmphasisModel.dart';
import 'package:ody_flutter_app/presentation/components/graph/model/GraphLineModel.dart';
import 'package:ody_flutter_app/presentation/components/graph/model/GraphPointModel.dart';
import 'package:ody_flutter_app/presentation/components/graph/model/ShadowAreaModel.dart';
import 'package:ody_flutter_app/presentation/components/graph/widget/SymbolWidget.dart';
import 'package:ody_flutter_app/presentation/features/analysis/widget/AnalysisItemTitle.dart';
import 'package:ody_flutter_app/presentation/ui/colors.dart';
import 'package:ody_flutter_app/presentation/utils/Common.dart';
import 'package:ody_flutter_app/presentation/utils/dto/Triple.dart';

class BpFigure extends StatelessWidget {
  const BpFigure({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final sampleXAxisList = [
      AxisEmphasisModel(label: "04:00", color: getColorScheme(context).neutral60),
      AxisEmphasisModel(label: "08:00", color: getColorScheme(context).neutral60),
      AxisEmphasisModel(label: "12:00", color: getColorScheme(context).colorPrimaryFocus),
      AxisEmphasisModel(label: "16:00", color: getColorScheme(context).neutral60),
      AxisEmphasisModel(label: "20:00", color: getColorScheme(context).neutral60),
      AxisEmphasisModel(label: "24:00", color: getColorScheme(context).neutral60),
    ];

    final sampleYAxisList = [
      AxisEmphasisModel(label: "60", color: getColorScheme(context).neutral60),
      AxisEmphasisModel(label: "80", color: getColorScheme(context).neutral60),
      AxisEmphasisModel(label: "100", color: getColorScheme(context).neutral60),
      AxisEmphasisModel(label: "120", color: getColorScheme(context).neutral60),
      AxisEmphasisModel(label: "140", color: getColorScheme(context).neutral60),
      AxisEmphasisModel(label: "160", color: getColorScheme(context).neutral60),
    ].reversed.toList();

    final shadowAreaList = [
      ShadowAreaModel(
        min: 90,
        max: 120,
        color: getColorScheme(context).colorError.withOpacity(0.05),
      ),
      ShadowAreaModel(
        min: 60,
        max: 80,
        color: getColorScheme(context).colorPrimaryFocus.withOpacity(0.05),
      ),
    ];

    final sampleGraphLineModel = GraphLineModel(
      pointData: [
        GraphPointDataModel(
          label: "08:00",
          yValue: Random().nextInt(100) + 60.toDouble(),
          pointColor: getColorScheme(context).colorError,
        ),
        GraphPointDataModel(
          label: "12:00",
          yValue: Random().nextInt(100) + 60.toDouble(),
          pointColor: getColorScheme(context).colorError,
        ),
      ],
      lineColor: getColorScheme(context).colorError,
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        AnalysisItemTitle(
          title: getAppLocalizations(context).analysis_blood_pressure_figure_title,
          secondTitle: Triple(
            getAppLocalizations(context).analysis_blood_pressure_figure_text1,
            "110 - 80 ${getAppLocalizations(context).record_blood_pressure_input1_unit}",
            getAppLocalizations(context).analysis_blood_pressure_figure_text2,
          ),
          description: getAppLocalizations(context).analysis_blood_pressure_figure_description,
        ),
        const SizedBox(
          height: 40,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: getMediaQuery(context).size.width,
              height: getMediaQuery(context).size.width * 0.6,
              child: RecordGraph.line(
                xAxisList: sampleXAxisList,
                yAxisList: sampleYAxisList,
                shadowAreaList: shadowAreaList,
                symbolWidget: const _SymbolList(),
                xAxisInnerHorizontalPadding: 0,
                dividerColor: getColorScheme(context).neutral50,
                xAxisUnitWidth: 28,
                // graphPointModel: sampleGraphPointList,
                graphLineModel: sampleGraphLineModel,
              ),
            )
          ],
        ),
      ],
    );
  }
}

class _SymbolList extends HookWidget {
  const _SymbolList({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        SymbolWidget(
          label: getAppLocalizations(context).analysis_blood_pressure_figure_symbol_systolic,
          color: getColorScheme(context).colorError,
        ),
        const SizedBox(
          width: 16,
        ),
        SymbolWidget(
          label: getAppLocalizations(context).analysis_blood_pressure_figure_symbol_diastolic,
          color: getColorScheme(context).colorPrimaryFocus,
        ),
      ],
    );
  }
}
