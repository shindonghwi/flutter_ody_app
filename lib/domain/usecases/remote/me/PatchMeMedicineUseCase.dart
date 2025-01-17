import 'package:get_it/get_it.dart';
import 'package:ody_flutter_app/data/models/ApiResponse.dart';
import 'package:ody_flutter_app/data/models/me/RequestMeMedicineUpdateModel.dart';
import 'package:ody_flutter_app/data/models/me/ResponseMeMedicineModel.dart';
import 'package:ody_flutter_app/domain/models/me/GenderType.dart';
import 'package:ody_flutter_app/domain/repositories/remote/me/RemoteMeRepository.dart';

class PatchMeMedicineUseCase {
  PatchMeMedicineUseCase();

  final RemoteMeRepository _remoteMeRepository = GetIt.instance<RemoteMeRepository>();

  Future<ApiResponse<ResponseMeMedicineModel>> call({required RequestMeMedicineUpdateModel data}) async {
    return await _remoteMeRepository.patchMedicine(data);
  }
}
