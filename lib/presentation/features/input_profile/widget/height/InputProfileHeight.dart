import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:ody_flutter_app/presentation/components/button/fill/FillButton.dart';
import 'package:ody_flutter_app/presentation/components/button/model/ButtonNotifier.dart';
import 'package:ody_flutter_app/presentation/components/button/model/ButtonSizeType.dart';
import 'package:ody_flutter_app/presentation/components/button/model/ButtonState.dart';
import 'package:ody_flutter_app/presentation/components/loading/CircleLoading.dart';
import 'package:ody_flutter_app/presentation/components/textfield/InputTextField.dart';
import 'package:ody_flutter_app/presentation/components/toast/Toast.dart';
import 'package:ody_flutter_app/presentation/features/input_profile/notifier/ui/InputHeightUiStateNotifier.dart';
import 'package:ody_flutter_app/presentation/features/input_profile/provider/InputProfilePageViewController.dart';
import 'package:ody_flutter_app/presentation/features/main/my/provider/meInfoProvider.dart';
import 'package:ody_flutter_app/presentation/models/UiState.dart';
import 'package:ody_flutter_app/presentation/ui/colors.dart';
import 'package:ody_flutter_app/presentation/ui/typography.dart';
import 'package:ody_flutter_app/presentation/utils/Common.dart';
import 'package:ody_flutter_app/presentation/utils/regex/FixedInputFormatter.dart';

class InputProfileHeight extends HookConsumerWidget {
  const InputProfileHeight({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isButtonActive = useState<bool>(false);

    void onChanged(bool flag) => isButtonActive.value = flag;

    final meInfoRead = ref.read(meInfoProvider.notifier);
    final uiState = ref.watch(inputHeightUiStateProvider);
    final uiStateRead = ref.read(inputHeightUiStateProvider.notifier);
    final pageController = ref.read(inputProfilePageViewControllerProvider);

    useEffect(() {
      WidgetsBinding.instance.addPostFrameCallback((_) async {
        uiState.when(
          success: (event) async {
            meInfoRead.updateMeInfoHeight(uiStateRead.height);
            uiStateRead.resetState();
            pageController.nextPage(
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut,
            );
          },
          failure: (event) {
            ToastUtil.errorToast(event.errorMessage);
          },
        );
      });
      return null;
    }, [uiState]);

    return Stack(
      children: [
        Container(
          padding: const EdgeInsets.fromLTRB(35, 40, 35, 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _title(context),
              const SizedBox(height: 24),
              _InputTextField(onChanged: onChanged),
              _NextButton(isButtonActive: isButtonActive.value),
            ],
          ),
        ),
        if (uiState is Loading) const CircleLoading()
      ],
    );
  }

  /// 키를 입력해주세요
  Widget _title(BuildContext context) {
    return Text(
      getAppLocalizations(context).input_profile_height_title,
      style: getTextTheme(context).h4sb.copyWith(
            color: getColorScheme(context).colorText,
          ),
    );
  }
}

class _InputTextField extends HookConsumerWidget {
  final Function(bool flag) onChanged;

  const _InputTextField({
    super.key,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final meInfoRead = ref.read(meInfoProvider.notifier);
    final heightRead = ref.read(inputHeightUiStateProvider.notifier);
    final pattern = RegExp(r'^(12[0-9]|1[3-9][0-9]|2[0-2][0-9]|230)$'); // 120 <= x <= 230
    const fixedContent = "cm";

    useEffect(() {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (heightRead.height != 0) {
          final height = heightRead.height.toString();
          onChanged(pattern.hasMatch(height.toString()));
          heightRead.updateHeight(int.tryParse(height) ?? 0);
        }
        if (meInfoRead.getMeProfile()?.birthday != null) {
          final height = meInfoRead.getMeProfile()!.height.toString();
          onChanged(pattern.hasMatch(height));
          heightRead.updateHeight(int.tryParse(height) ?? 0);
        }
      });
      return null;
    }, []);

    return InputTextField(
      autoFocus: true,
      initText: heightRead.height != 0
          ? heightRead.height.toString()
          : meInfoRead.getMeProfile()!.height == 0
              ? ""
              : meInfoRead.getMeProfile()!.height.toString(),
      hint: getAppLocalizations(context).input_profile_height_hint,
      textInputAction: TextInputAction.next,
      textInputType: TextInputType.number,
      limit: 3 + fixedContent.length,
      onChanged: (String value) {
        onChanged(pattern.hasMatch(value));
        heightRead.updateHeight(int.tryParse(value) ?? 0);
      },
      successMessage: getAppLocalizations(context).input_profile_message_success,
      errorMessage: getAppLocalizations(context).input_profile_message_error,
      fixedContent: fixedContent,
      showCounter: true,
      regList: [pattern],
      inputFormatters: [
        FilteringTextInputFormatter.digitsOnly,
        FixedInputFormatter(suffix: fixedContent),
      ],
    );
  }
}

class _NextButton extends HookConsumerWidget {
  final bool isButtonActive;

  const _NextButton({
    super.key,
    required this.isButtonActive,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final heightRead = ref.read(inputHeightUiStateProvider.notifier);

    return Expanded(
      child: Align(
        alignment: Alignment.bottomCenter,
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 5),
          child: FillButton(
            text: getAppLocalizations(context).common_next,
            type: ButtonSizeType.Normal,
            onPressed: () => heightRead.patchHeight(),
            buttonProvider: StateNotifierProvider<ButtonNotifier, ButtonState>(
              (_) => ButtonNotifier(
                state: isButtonActive ? ButtonState.Activated : ButtonState.Disabled,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
