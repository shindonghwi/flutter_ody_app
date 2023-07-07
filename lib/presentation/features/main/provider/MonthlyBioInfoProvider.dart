import 'package:get_it/get_it.dart';
import 'package:ody_flutter_app/domain/usecases/remote/bio/GetBioHistoryMontlyUseCase.dart';
import 'package:ody_flutter_app/presentation/models/UiState.dart';
import 'package:riverpod/riverpod.dart';

final monthlyBioInfoProvider = StateNotifierProvider<MonthlyBioInfoNotifier, UIState<List<String>?>>(
  (_) => MonthlyBioInfoNotifier(),
);

class MonthlyBioInfoNotifier extends StateNotifier<UIState<List<String>?>> {
  MonthlyBioInfoNotifier() : super(Idle());

  Future<List<String>?> requestBioInfo(int year, int month, int day) async {
    state = Loading();
    final res = await GetIt.instance.get<GetBioHistoryMontlyUseCase>().call(year: year, month: month);
    if (res.status == 200) {
      _updateBioInfo(res.list);
    } else {
      state = Failure(res.message);
    }
    return res.list;
  }

  void _updateBioInfo(List<String>? data) {
    if (data != null) {
      state = Success(data);
    } else {
      state = Success(null);
    }
  }

  void init() {
    state = Idle();
  }
}