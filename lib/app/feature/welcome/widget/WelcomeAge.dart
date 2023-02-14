import 'package:flutter/material.dart';
import 'package:odac_flutter_app/app/feature/components/button/FillButton.dart';
import 'package:odac_flutter_app/app/feature/components/common/ShowUp.dart';
import 'package:odac_flutter_app/app/feature/components/picker/WheelNumberPicker.dart';
import 'package:odac_flutter_app/app/feature/welcome/model/PageAction.dart';
import 'package:odac_flutter_app/l10n/Common.dart';

/**
 * @feature: 나이 입력화면
 * @author: 2023/02/14 1:42 PM donghwishin
 */
class WelcomeAge extends StatelessWidget {
  final Function changePage;

  WelcomeAge({Key? key, required this.changePage}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WillPopScope(
        onWillPop: () async => changePage(context, PageAction.PREVIOUS),
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height * 0.7,
          margin: EdgeInsets.only(top: 120, left: 20, right: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              TitleText(context),
              SizedBox(height: 80),
              AgePicker(context),
            ],
          ),
        ),
      ),
      bottomSheet: BottomButton(context),
    );
  }

  /** 상단 텍스트 ( 질문영역 )*/
  Widget TitleText(BuildContext context) {
    return ShowUp(
      child: Text(
        getApplocalizations(context)?.welcome_text_age_input ?? "",
        style: Theme.of(context).textTheme.titleLarge?.copyWith(
          color: Theme.of(context).colorScheme.onBackground,
          fontWeight: FontWeight.w700,
        ),
      ),
      delay: 300,
    );
  }

  /** 나이 선택기 위젯 */
  Widget AgePicker(BuildContext context) {
    return ShowUp(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          WheelNumberPicker(initialValue: 52),
          Text(
            getApplocalizations(context)?.welcome_text_age_unit ?? "",
            style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                  color: Theme.of(context).colorScheme.onBackground,
                  fontWeight: FontWeight.w700,
                ),
          ),
        ],
      ),
      delay: 400,
    );
  }

  /** 바텀 버튼 ( 다 ) */
  Widget BottomButton(BuildContext context) {
    return ShowUp(
      child: FillButton(
        onTap: () {
          changePage(context, PageAction.NEXT);
        },
        child: Text(
          getApplocalizations(context)?.welcome_button_next ?? "",
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                color: Theme.of(context).colorScheme.onPrimary,
              ),
        ),
      ),
      delay: 300,
    );
  }
}
