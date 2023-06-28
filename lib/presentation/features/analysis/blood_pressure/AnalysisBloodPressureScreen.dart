import 'package:flutter/material.dart';
import 'package:ody_flutter_app/data/models/bio/ResponseBioBloodPressureModel.dart';
import 'package:ody_flutter_app/presentation/components/appbar/IconTitleIconAppBar.dart';
import 'package:ody_flutter_app/presentation/components/appbar/model/AppBarIcon.dart';
import 'package:ody_flutter_app/presentation/components/divider/DottedDivider.dart';
import 'package:ody_flutter_app/presentation/features/analysis/blood_pressure/widget/AverageBloodPressure.dart';
import 'package:ody_flutter_app/presentation/features/analysis/blood_pressure/widget/BpFigure.dart';
import 'package:ody_flutter_app/presentation/features/analysis/blood_pressure/widget/BpRecordAnalysis.dart';
import 'package:ody_flutter_app/presentation/features/analysis/blood_pressure/widget/HeartRateFigure.dart';
import 'package:ody_flutter_app/presentation/ui/colors.dart';
import 'package:ody_flutter_app/presentation/utils/Common.dart';

class AnalysisBloodPressureScreen extends StatelessWidget {
  final List<ResponseBioBloodPressureModel>? bpList;

  const AnalysisBloodPressureScreen({
    Key? key,
    this.bpList,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: getColorScheme(context).colorUI02,
      appBar: IconTitleIconAppBar(
        leadingIcon: AppBarIcon(
          path: 'assets/imgs/icon_back.svg',
          onPressed: () => Navigator.of(context).pop(),
          tint: getColorScheme(context).colorText,
        ),
        title: getAppLocalizations(context).analysis_blood_pressure_title,
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Container(
          padding: const EdgeInsets.fromLTRB(40, 24, 40, 64),
          child: Column(
            children:  [
              AverageBloodPressure(count: bpList?.length ?? 0),
              DottedDivider(margin: EdgeInsets.symmetric(vertical: 40)),
              BpRecordAnalysis(),
              DottedDivider(margin: EdgeInsets.symmetric(vertical: 40)),
              BpFigure(),
              DottedDivider(margin: EdgeInsets.symmetric(vertical: 40)),
              HeartRateFigure()
            ],
          ),
        ),
      ),
    );
  }
}
