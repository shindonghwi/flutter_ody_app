import 'package:get_it/get_it.dart';
import 'package:ody_flutter_app/data/models/ApiListResponse.dart';
import 'package:ody_flutter_app/domain/repositories/remote/bio/RemoteBioRepository.dart';

class GetBioHistoryMontlyUseCase {
  GetBioHistoryMontlyUseCase();

  final RemoteBioRepository _remoteBioRepository = GetIt.instance<RemoteBioRepository>();

  Future<ApiListResponse<List<String>>> call({
    required int year,
    required int month,
  }) async {
    final res = await _remoteBioRepository.getBioHistoryMontly(year, month);
    return res;
  }
}
