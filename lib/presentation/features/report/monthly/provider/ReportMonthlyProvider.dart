import 'package:get_it/get_it.dart';
import 'package:ody_flutter_app/data/models/bio/ResponseBioReportInfoModel.dart';
import 'package:ody_flutter_app/domain/usecases/remote/bio/GetBioReportMonthlyInfoUseCase.dart';
import 'package:ody_flutter_app/presentation/models/UiState.dart';
import 'package:riverpod/riverpod.dart';

final reportMonthlyProvider =
    StateNotifierProvider<ReportMonthlyNotifier, UIState<ResponseBioReportInfoModel?>>(
  (_) => ReportMonthlyNotifier(),
);

class ReportMonthlyNotifier extends StateNotifier<UIState<ResponseBioReportInfoModel?>> {
  ReportMonthlyNotifier() : super(Idle());

  void requestMonthlyInfo(int? reportSeq) async {
    state = Loading();
    final res = await GetIt.instance.get<GetBioReportMonthlyInfoUseCase>().call(reportSeq ?? -1);
    if (res.status == 200) {
      Future.delayed(const Duration(milliseconds: 300), () {
        state = Success(res.data);
      });
    } else {
      state = Failure(res.message);
    }
  }

  void init() {
    state = Idle();
  }
}