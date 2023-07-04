import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:ody_flutter_app/presentation/components/graph/RecordGraph.dart';
import 'package:ody_flutter_app/presentation/components/graph/model/AxisEmphasisModel.dart';
import 'package:ody_flutter_app/presentation/components/graph/model/GraphPointModel.dart';
import 'package:ody_flutter_app/presentation/components/graph/widget/SymbolWidget.dart';
import 'package:ody_flutter_app/presentation/features/analysis/widget/AnalysisItemTitle.dart';
import 'package:ody_flutter_app/presentation/ui/colors.dart';
import 'package:ody_flutter_app/presentation/utils/Common.dart';
import 'package:ody_flutter_app/presentation/utils/date/DateChecker.dart';
import 'package:ody_flutter_app/presentation/utils/dto/Triple.dart';

class ReportGlucoseGraph extends StatelessWidget {
  const ReportGlucoseGraph({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final sampleXAxisList = [
      AxisEmphasisModel(label: "월", color: getColorScheme(context).neutral60),
      AxisEmphasisModel(label: "화", color: getColorScheme(context).neutral60),
      AxisEmphasisModel(label: "수", color: getColorScheme(context).neutral60),
      AxisEmphasisModel(label: "목", color: getColorScheme(context).neutral60),
      AxisEmphasisModel(label: "금", color: getColorScheme(context).neutral60),
      AxisEmphasisModel(label: "토", color: getColorScheme(context).neutral60),
      AxisEmphasisModel(label: "일", color: getColorScheme(context).neutral60),
    ];

    final sampleYAxisList = [
      AxisEmphasisModel(label: "60", color: getColorScheme(context).neutral60),
      AxisEmphasisModel(label: "80", color: getColorScheme(context).neutral60),
      AxisEmphasisModel(label: "100", color: getColorScheme(context).neutral60),
      AxisEmphasisModel(label: "120", color: getColorScheme(context).neutral60),
      AxisEmphasisModel(label: "140", color: getColorScheme(context).neutral60),
      AxisEmphasisModel(label: "160", color: getColorScheme(context).neutral60),
    ].reversed.toList();

    final sampleGraphPointModel = GraphPointModel(
      pointData: [
        GraphPointDataModel(
          label: "월",
          yValue: 120,
          pointColor: DateChecker.isTodayCheckFromYoil("월")
              ? getColorScheme(context).primary100
              : getColorScheme(context).primary20,
        ),
        GraphPointDataModel(
          label: "화",
          yValue: 130,
          pointColor: DateChecker.isTodayCheckFromYoil("화")
              ? getColorScheme(context).primary100
              : getColorScheme(context).primary20,
        ),
        GraphPointDataModel(
          label: "수",
          yValue: 80,
          pointColor: DateChecker.isTodayCheckFromYoil("수")
              ? getColorScheme(context).primary100
              : getColorScheme(context).primary20,
        ),
        GraphPointDataModel(
          label: "목",
          yValue: 110,
          pointColor: DateChecker.isTodayCheckFromYoil("목")
              ? getColorScheme(context).primary100
              : getColorScheme(context).primary20,
        ),
        GraphPointDataModel(
          label: "금",
          yValue: 150,
          pointColor: DateChecker.isTodayCheckFromYoil("금")
              ? getColorScheme(context).primary100
              : getColorScheme(context).primary20,
        ),
        GraphPointDataModel(
          label: "토",
          yValue: 130,
          pointColor: DateChecker.isTodayCheckFromYoil("토")
              ? getColorScheme(context).primary100
              : getColorScheme(context).primary20,
        ),
        GraphPointDataModel(
          label: "일",
          yValue: 100,
          pointColor: DateChecker.isTodayCheckFromYoil("일")
              ? getColorScheme(context).primary100
              : getColorScheme(context).primary20,
        ),
      ],
    );

    return Container(
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          AnalysisItemTitle(
            title: getAppLocalizations(context).report_blood_pressure_weekly_analysis_subtitle,
            secondTitle: Triple(
                getAppLocalizations(context).report_blood_pressure_graph_text1,
                "${110} - ${100} ${getAppLocalizations(context).record_blood_pressure_input1_unit}",
                getAppLocalizations(context).report_blood_pressure_graph_text2),
            description: getAppLocalizations(context).report_blood_pressure_weekly_description,
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
                child: RecordGraph.point(
                  xAxisList: sampleXAxisList,
                  yAxisList: sampleYAxisList,
                  shadowAreaList: [],
                  symbolWidget: const _SymbolList(),
                  xAxisInnerHorizontalPadding: 0,
                  dividerColor: getColorScheme(context).neutral50,
                  graphPointModel: sampleGraphPointModel,
                  xAxisType: RecordXAxisType.YOIL,
                ),
              )
            ],
          ),
        ],
      ),
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
          label: getAppLocalizations(context).record_range_figure_normal,
          color: getColorScheme(context).colorPrimaryFocus,
        ),
        const SizedBox(
          width: 16,
        ),
        SymbolWidget(
          label: getAppLocalizations(context).record_range_figure_warning,
          color: getColorScheme(context).error40,
        ),
        const SizedBox(
          width: 16,
        ),
        SymbolWidget(
          label: getAppLocalizations(context).record_range_figure_danger,
          color: getColorScheme(context).colorError,
        ),
      ],
    );
  }
}
