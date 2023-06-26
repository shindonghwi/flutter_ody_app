import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:ody_flutter_app/presentation/components/loading/CircleLoading.dart';
import 'package:ody_flutter_app/presentation/features/record/blood_pressure/notifier/BloodPressureRecorderNotifier.dart';
import 'package:ody_flutter_app/presentation/features/record/blood_pressure/notifier/RecordBloodPressureUiStateNotifier.dart';
import 'package:ody_flutter_app/presentation/features/record/blood_pressure/widget/RecordBloodPressure.dart';
import 'package:ody_flutter_app/presentation/features/record/blood_pressure/widget/RecordBloodPressureAppBar.dart';
import 'package:ody_flutter_app/presentation/features/record/model/RecordType.dart';
import 'package:ody_flutter_app/presentation/features/record/widget/RecordDateSelector.dart';
import 'package:ody_flutter_app/presentation/models/UiState.dart';
import 'package:ody_flutter_app/presentation/ui/colors.dart';
import 'package:ody_flutter_app/presentation/utils/Common.dart';
import 'package:ody_flutter_app/presentation/utils/snackbar/SnackBarUtil.dart';

class RecordBloodPressureScreen extends HookConsumerWidget {
  const RecordBloodPressureScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final uiState = ref.watch<UIState<dynamic>>(recordBloodPressureUiStateProvider);
    final uiStateRead = ref.read(recordBloodPressureUiStateProvider.notifier);
    final bpRecorderRead = ref.read(bloodPressureRecorderProvider.notifier);

    useEffect(() {
      void handleUiStateChange() async {
        await Future(() {
          uiState.when(
            success: (event) async {
              SnackBarUtil.show(
                context,
                getAppLocalizations(context).message_record_complete_blood_pressure,
              );
              Navigator.of(context).pop(bpRecorderRead.getBioBpModel());
            },
            failure: (event) {
              SnackBarUtil.show(context, event.errorMessage);
            },
          );
        });
      }
      handleUiStateChange();
      return null;
    }, [uiState]);

    useEffect(() {
      WidgetsBinding.instance.addPostFrameCallback((_) async {
        uiStateRead.init();
        bpRecorderRead.init();
      });
    }, []);

    return Stack(
      children: [
        Scaffold(
          backgroundColor: getColorScheme(context).colorUI03,
          appBar: const RecordBloodPressureAppBar(),
          body: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              children: const [
                RecordDateSelector(
                  type: RecordType.BloodPressure,
                ),
                RecordBloodPressure(),
              ],
            ),
          ),
        ),
        if (uiState is Loading) const CircleLoading(),
      ],
    );
  }
}
