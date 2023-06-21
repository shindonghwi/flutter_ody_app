import 'package:flutter/cupertino.dart';
import 'package:get_it/get_it.dart';
import 'package:odac_flutter_app/data/models/me/ResponseMeMedicineModel.dart';
import 'package:odac_flutter_app/domain/usecases/remote/me/DeleteMedicineUseCase.dart';
import 'package:odac_flutter_app/domain/usecases/remote/me/GetMeMedicinesUseCase.dart';
import 'package:odac_flutter_app/presentation/models/UiState.dart';
import 'package:odac_flutter_app/presentation/utils/CollectionUtil.dart';
import 'package:odac_flutter_app/presentation/utils/Common.dart';
import 'package:riverpod/riverpod.dart';

enum MedicineActionType {
  GET_LIST,
  ADD_ITEM,
  REMOVE_ITEM,
  NONE,
}

final medicineListProvider =
    StateNotifierProvider<MedicineListNotifier, UIState<List<ResponseMeMedicineModel>?>>(
  (_) => MedicineListNotifier(),
);

class MedicineListNotifier extends StateNotifier<UIState<List<ResponseMeMedicineModel>?>> {
  MedicineListNotifier() : super(Idle());

  AppLocalization get _getAppLocalization => GetIt.instance<AppLocalization>();


  var actionType = MedicineActionType.NONE;

  void requestMedicineList() async {
    actionType = MedicineActionType.GET_LIST;
    state = Loading();
    final res = await GetIt.instance.get<GetMeMedicinesUseCase>().call();
    if (res.status == 200) {
      _updateMedicineList(res.list);
    } else {
      state = Failure(res.message);
    }
  }

  void _updateMedicineList(List<ResponseMeMedicineModel>? data) {
    if (!CollectionUtil.isNullorEmpty(data)) {
      state = Success(data);
    } else {
      state = Success(null);
    }
  }

  // 약 추가화면에서 약을 등록하고 돌아왔을때 리스트에 추가
  void addMedicine(ResponseMeMedicineModel data) {
    actionType = MedicineActionType.ADD_ITEM;
    if (state is Success) {
      final currentList = (state as Success<List<ResponseMeMedicineModel>>).value;
      final updatedList = [data, ...currentList];
      state = Success(updatedList);
    }
  }

  void removeMedicines(List<ResponseMeMedicineModel> checkList) async {
    actionType = MedicineActionType.REMOVE_ITEM;
    List<ResponseMeMedicineModel> currentList = [];
    if (state is Success) {
      currentList = (state as Success<List<ResponseMeMedicineModel>>).value;
    }
    state = Loading();
    List<ResponseMeMedicineModel> removeSuccessList = [];
    List<ResponseMeMedicineModel> removeFailList = [];
    for (var element in checkList) {
      final res = await GetIt.instance.get<DeleteMedicineUseCase>().call(element.medicineSeq ?? -1);
      if (res.status == 200) {
        removeSuccessList.add(element);
      } else {
        removeFailList.add(element);
      }
    }

    if (removeSuccessList.isNotEmpty) {
      final updatedList = currentList..removeWhere((item) => removeSuccessList.contains(item));
      state = Success([...updatedList]);
    }

    if (removeFailList.isNotEmpty) {
      final removeFailMedicineNameList = removeFailList.map((e) => e.name).join(", ");
      state = Failure("$removeFailMedicineNameList ${_getAppLocalization.get().message_delete_fail}");
    }
  }
}
