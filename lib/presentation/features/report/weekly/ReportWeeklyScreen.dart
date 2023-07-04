import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:ody_flutter_app/presentation/components/appbar/IconTitleIconAppBar.dart';
import 'package:ody_flutter_app/presentation/components/appbar/model/AppBarIcon.dart';
import 'package:ody_flutter_app/presentation/components/divider/DottedDivider.dart';
import 'package:ody_flutter_app/presentation/components/progress/PainterLinearHorizontalProgress.dart';
import 'package:ody_flutter_app/presentation/features/analysis/widget/AnalysisItemTitle.dart';
import 'package:ody_flutter_app/presentation/features/record/glucose/widget/RecordGlucose.dart';
import 'package:ody_flutter_app/presentation/features/report/weekly/provider/ReportWeeklyProvider.dart';
import 'package:ody_flutter_app/presentation/features/report/widget/ReportBloodPressure.dart';
import 'package:ody_flutter_app/presentation/features/report/widget/ReportBloodPressureAnalysis.dart';
import 'package:ody_flutter_app/presentation/features/report/widget/ReportBloodPressureGraph.dart';
import 'package:ody_flutter_app/presentation/features/report/widget/ReportCalorie.dart';
import 'package:ody_flutter_app/presentation/features/report/widget/ReportGlucose.dart';
import 'package:ody_flutter_app/presentation/features/report/widget/ReportGlucoseAnalysis.dart';
import 'package:ody_flutter_app/presentation/features/report/widget/ReportGlucoseGraph.dart';
import 'package:ody_flutter_app/presentation/features/report/widget/ReportHeartRateGraph.dart';
import 'package:ody_flutter_app/presentation/features/report/widget/ReportWalk.dart';
import 'package:ody_flutter_app/presentation/features/report/widget/ReportWalkCompare.dart';
import 'package:ody_flutter_app/presentation/features/report/widget/ReportWalkingAverage.dart';
import 'package:ody_flutter_app/presentation/ui/colors.dart';
import 'package:ody_flutter_app/presentation/ui/typography.dart';
import 'package:ody_flutter_app/presentation/utils/Common.dart';
import 'package:ody_flutter_app/presentation/utils/dto/Pair.dart';
import 'package:ody_flutter_app/presentation/utils/dto/Triple.dart';
import 'package:ody_flutter_app/presentation/utils/snackbar/SnackBarUtil.dart';

class ReportWeeklyScreen extends HookConsumerWidget {
  final int? reportSeq;

  const ReportWeeklyScreen({
    Key? key,
    this.reportSeq,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final uiState = ref.watch(reportWeeklyProvider);
    final uiStateRead = ref.read(reportWeeklyProvider.notifier);

    useEffect(() {
      void handleUiStateChange() async {
        await Future(() {
          uiState.when(
            failure: (event) => SnackBarUtil.show(context, event.errorMessage),
          );
        });
      }

      handleUiStateChange();
      return null;
    }, [uiState]);

    useEffect(() {
      WidgetsBinding.instance.addPostFrameCallback((_) async {
        uiStateRead.init();
        uiStateRead.requestWeeklyInfo();
      });
    }, []);

    return Scaffold(
      appBar: IconTitleIconAppBar(
        leadingIcon: AppBarIcon(
          path: 'assets/imgs/icon_back.svg',
          onPressed: () => Navigator.of(context).pop(),
          tint: getColorScheme(context).colorText,
        ),
        title: getAppLocalizations(context).my_item_subtitle_weekly_report,
      ),
      backgroundColor: getColorScheme(context).colorUI03,
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(15, 24, 15, 64),
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: const [
            ReportCardWalk(),
            SizedBox(height: 24,),
            ReportCardBloodPressure(),
            SizedBox(height: 24,),
            ReportCardGlucose(),
          ],
        ),
      ),
    );
  }
}

class ReportCardWalk extends StatelessWidget {
  const ReportCardWalk({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: getColorScheme(context).colorUI02,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        children: const [
          ReportWalk(),
          DottedDivider(margin: EdgeInsets.symmetric(vertical: 40, horizontal: 12)),
          ReportCalorie(),
          DottedDivider(margin: EdgeInsets.symmetric(vertical: 40, horizontal: 12)),
          ReportWalkingAverage(),
          DottedDivider(margin: EdgeInsets.symmetric(vertical: 40, horizontal: 12)),
          ReportWalkCompare(),
          SizedBox(
            height: 36,
          )
        ],
      ),
    );
  }
}

class ReportCardBloodPressure extends StatelessWidget {
  const ReportCardBloodPressure({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: getColorScheme(context).colorUI02,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        children: const [
          ReportBloodPressure(),
          DottedDivider(margin: EdgeInsets.symmetric(vertical: 40, horizontal: 12)),
          ReportBloodPressureAnalysis(),
          DottedDivider(margin: EdgeInsets.symmetric(vertical: 40, horizontal: 12)),
          ReportBloodPressureGraph(),
          DottedDivider(margin: EdgeInsets.symmetric(vertical: 40, horizontal: 12)),
          ReportHeartRateGraph(),
          SizedBox(height: 40,)
        ],
      ),
    );
  }
}

class ReportCardGlucose extends StatelessWidget {
  const ReportCardGlucose({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: getColorScheme(context).colorUI02,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        children: const [
          ReportGlucose(),
          DottedDivider(margin: EdgeInsets.symmetric(vertical: 40, horizontal: 12)),
          ReportGlucoseAnalysis(),
          DottedDivider(margin: EdgeInsets.symmetric(vertical: 40, horizontal: 12)),
          ReportGlucoseGraph(),
          SizedBox(height: 40,)
        ],
      ),
    );
  }
}


