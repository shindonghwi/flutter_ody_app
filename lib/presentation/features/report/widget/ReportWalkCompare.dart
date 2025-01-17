import 'package:flutter/material.dart';
import 'package:ody_flutter_app/presentation/components/progress/PainterLinearHorizontalProgress.dart';
import 'package:ody_flutter_app/presentation/features/analysis/widget/AnalysisItemTitle.dart';
import 'package:ody_flutter_app/presentation/ui/colors.dart';
import 'package:ody_flutter_app/presentation/ui/typography.dart';
import 'package:ody_flutter_app/presentation/utils/Common.dart';
import 'package:ody_flutter_app/presentation/utils/date/DateParser.dart';
import 'package:ody_flutter_app/presentation/utils/dto/Triple.dart';
import 'package:ody_flutter_app/presentation/utils/regex/RegexUtil.dart';

class ReportWalkCompare extends StatelessWidget {
  final bool isWeekly;
  final int beforeSteps;
  final int totalSteps;

  const ReportWalkCompare({
    Key? key,
    required this.isWeekly,
    required this.beforeSteps,
    required this.totalSteps,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
      child: Column(
        children: [
          AnalysisItemTitle(
            title: isWeekly
                ? getAppLocalizations(context).report_weekly_pre_subtitle
                : getAppLocalizations(context).report_monthly_pre_subtitle,
            secondTitle: Triple(
              isWeekly
                  ? getAppLocalizations(context).report_weekly_pre_text1
                  : getAppLocalizations(context).report_monthly_pre_text1,
              "${RegexUtil.commaNumber((beforeSteps - totalSteps).abs())} ${getAppLocalizations(context).common_walk}",
              totalSteps >= beforeSteps
                  ? getAppLocalizations(context).report_monthly_pre_walk_more
                  : getAppLocalizations(context).report_monthly_pre_walk_less,
            ),
            description: getAppLocalizations(context).report_pre_description,
          ),
          const SizedBox(height: 32),
          _CompareItem(
            label:
                isWeekly ? getAppLocalizations(context).common_week_cur : getAppLocalizations(context).common_month_cur,
            progressColor: totalSteps > beforeSteps
                ? getColorScheme(context).primary100
                : getColorScheme(context).primary100.withOpacity(0.1),
            walkCount: totalSteps,
            percentage: totalSteps / (10000 * (isWeekly ? 7 : DateParser.getLastDayFromCurrentMonth())),
          ),
          const SizedBox(height: 24),
          _CompareItem(
            label:
                isWeekly ? getAppLocalizations(context).common_week_pre : getAppLocalizations(context).common_month_pre,
            progressColor: beforeSteps >= totalSteps
                ? getColorScheme(context).primary100
                : getColorScheme(context).primary100.withOpacity(0.1),
            walkCount: beforeSteps,
            percentage: totalSteps / (10000 * (isWeekly ? 7 : DateParser.getLastDayFromCurrentMonth())),
          ),
        ],
      ),
    );
  }
}

class _CompareItem extends StatelessWidget {
  final String label;
  final Color progressColor;
  final int walkCount;
  final double percentage;

  const _CompareItem({
    super.key,
    required this.label,
    required this.progressColor,
    required this.walkCount,
    required this.percentage,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 16,
      child: Row(
        children: [
          Flexible(
            flex: 10,
            fit: FlexFit.tight,
            child: Text(
              label,
              style: getTextTheme(context).c3m.copyWith(
                    color: getColorScheme(context).neutral70,
                  ),
            ),
          ),
          Flexible(
            flex: 74,
            fit: FlexFit.loose,
            child: SizedBox(
              width: double.infinity,
              height: 16,
              child: CustomPaint(
                painter: PainterLinearHorizontalProgress(
                  progress: percentage,
                  defaultColor: getColorScheme(context).colorPrimaryDisable.withOpacity(0.3),
                  activeColor: progressColor,
                  radius: 100,
                ),
              ),
            ),
          ),
          Flexible(
            flex: 16,
            fit: FlexFit.tight,
            child: Align(
              alignment: Alignment.centerRight,
              child: Text(
                "${RegexUtil.commaNumber(walkCount)} ${getAppLocalizations(context).common_walk}",
                style: getTextTheme(context).c3m.copyWith(
                      color: getColorScheme(context).neutral70,
                    ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
