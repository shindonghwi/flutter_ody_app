import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:odac_flutter_app/app/feature/components/button/FillButton.dart';
import 'package:odac_flutter_app/app/feature/components/common/ShowAnimation.dart';
import 'package:odac_flutter_app/app/feature/welcome/model/PageAction.dart';
import 'package:odac_flutter_app/app/utils/Common.dart';

/**
 * @feature: 질환 선택 화면
 * @author: 2023/02/14 1:42 PM donghwishin
 */
class WelcomeDisease extends ConsumerWidget {
  final Function changePage;

  WelcomeDisease({Key? key, required this.changePage}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: WillPopScope(
        onWillPop: () async => changePage(context, PageAction.PREVIOUS),
        child: Container(
          color: getColorScheme(context).background,
          width: getMediaQuery(context).size.width,
          height: getMediaQuery(context).size.height,
          padding: EdgeInsets.only(top: 120, left: 20, right: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              TitleText(context),
              SizedBox(height: 80),
              DiseaseSelector(context),
            ],
          ),
        ),
      ),
      bottomSheet: BottomButton(context),
    );
  }

  /** 상단 텍스트 ( 질문영역 )*/
  Widget TitleText(BuildContext context) {
    return ShowAnimation(
      child: Text(
        getApplocalizations(context).welcome_text_disease,
        style: getTextTheme(context).titleLarge?.copyWith(
              color: getColorScheme(context).onBackground,
              fontWeight: FontWeight.w700,
            ),
      ),
      type: ShowAnimationType.UP,
      initDelay: showDuration,
    );
  }

  /** 기본 값, 질환 목록 뷰 */
  Widget DiseaseSelector(BuildContext context) {
    List<String> diseaseList = getApplocalizations(context).welcome_disease_items.split(",");

    return ShowAnimation(
      child: Wrap(
        runSpacing: 12,
        spacing: 4, // space between items
        children: diseaseList
            .map(
              (diseaseName) => DiseaseItem(diseaseName: diseaseName),
            )
            .toList(),
      ),
      type: ShowAnimationType.UP,
      initDelay: showDuration,
    );
  }

  /** 바텀 버튼 ( 다음 ) */
  Widget BottomButton(BuildContext context) {
    return Container(
      color: getColorScheme(context).onPrimary,
      padding: EdgeInsets.only(left: 20, right: 20, bottom: 40),
      child: FillButton(
        onTap: () async => changePage(context, PageAction.NEXT),
        child: Text(
          getApplocalizations(context).common_next,
          style: getTextTheme(context).titleLarge?.copyWith(
                color: getColorScheme(context).onPrimary,
              ),
        ),
      ),
    );
  }
}

class DiseaseItem extends StatefulWidget {
  final String diseaseName;

  DiseaseItem({Key? key, required this.diseaseName}) : super(key: key);

  @override
  State<DiseaseItem> createState() => _DiseaseItemState();
}

class _DiseaseItemState extends State<DiseaseItem> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 4),
      decoration: BoxDecoration(
        // color: getColorScheme(context).primary.withOpacity(0.1),
        border: Border.all(
          color: getColorScheme(context).primary.withOpacity(1),
          width: 1,
        ),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {
            debugPrint("onTap: ${widget.diseaseName}");
          },
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.add,
                  color: getColorScheme(context).primary,
                  size: 16,
                ),
                SizedBox(width: 4),
                Text(
                  widget.diseaseName,
                  style: getTextTheme(context).bodyLarge?.copyWith(
                        color: getColorScheme(context).primary,
                      ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
