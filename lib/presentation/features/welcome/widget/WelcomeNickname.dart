import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:odac_flutter_app/presentation/components/appbar/LeftIconAppBar.dart';
import 'package:odac_flutter_app/presentation/components/button/FillButton.dart';
import 'package:odac_flutter_app/presentation/components/common/ShowAnimation.dart';
import 'package:odac_flutter_app/presentation/components/input/OutlineTextField.dart';
import 'package:odac_flutter_app/presentation/features/welcome/model/PageAction.dart';
import 'package:odac_flutter_app/presentation/features/welcome/provider/PageViewNavigator.dart';
import 'package:odac_flutter_app/presentation/utils/Common.dart';
import 'package:provider/provider.dart';

/**
 * @feature: 닉네임 입력화면
 * @author: 2023/02/14 1:42 PM donghwishin
 */
class WelcomeNickname extends HookWidget {
  WelcomeNickname({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: getColorScheme(context).background,
      appBar: LeftIconAppBar(
        leftIcon: IconButton(
          icon: Icon(
            Icons.arrow_back,
            size: 20,
            color: getColorScheme(context).onBackground,
          ),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: WillPopScope(
        onWillPop: () async => context
            .read<PageViewNavigatorProvider>()
            .changePage(context, PageAction.PREVIOUS),
        child: Container(
          color: getColorScheme(context).background,
          padding: EdgeInsets.only(top: 48),
          width: getMediaQuery(context).size.width,
          child: Column(
            children: [
              TitleText(context),
              SizedBox(height: 70),
              InputNickname(context),
            ],
          ),
        ),
      ),
      bottomSheet: BottomButton(context),
    );
  }

  /** 상단 텍스트 - 앱 소개 글 */
  Widget TitleText(BuildContext context) {
    return ShowAnimation(
      child: Text(
        getApplocalizations(context).welcome_text_nickname_title,
        style: getTextTheme(context).headlineSmall?.copyWith(
              color: getColorScheme(context).onBackground,
              fontWeight: FontWeight.w500,
            ),
        textAlign: TextAlign.center,
      ),
      type: ShowAnimationType.UP,
      initDelay: showDuration,
    );
  }

  /** 닉네임 입력공간 */
  Widget InputNickname(BuildContext context) {
    return ShowAnimation(
      child: Container(
        width: getMediaQuery(context).size.width * 0.6,
        child: OutlineTextField(
          maxLength: 7,
          hintText: getApplocalizations(context).common_input_hint,
          textCallback: (value) {
            debugPrint("value : $value");
          },
        ),
      ),
      type: ShowAnimationType.UP,
      initDelay: showDuration,
    );
  }

  /** 바텀 버튼 ( 시작하기 ) */
  Widget BottomButton(BuildContext context) {
    return Container(
      color: getColorScheme(context).onPrimary,
      padding: EdgeInsets.only(left: 20, right: 20, bottom: 40),
      child: FillButton(
        onTap: () async => context
            .read<PageViewNavigatorProvider>()
            .changePage(context, PageAction.NEXT),
        child: Text(
          getApplocalizations(context).common_start,
          style: getTextTheme(context).titleMedium?.copyWith(
                color: getColorScheme(context).onPrimary,
                fontWeight: FontWeight.w600,
              ),
        ),
      ),
    );
  }
}
