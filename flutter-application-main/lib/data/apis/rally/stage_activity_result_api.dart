import 'package:gibz_mobileapp/bloc/loading_indicator_cubit.dart';
import 'package:gibz_mobileapp/data/dio.dart';

import '../../../models/rally/rally_models.dart';

class StageActivityResultApi {
  final DioClient _httpClient;
  final LoadingIndicatorCubit _loadingIndicatorCubit;

  StageActivityResultApi(this._httpClient, this._loadingIndicatorCubit);

  Future<StageActivityResult?> submitStageActivityResult(
    String rallyId,
    String stageId,
    StageActivityResultCreationRequestDto payload,
  ) async {
    try {
      final response = await _httpClient.post(
        '/api/rally/v1/rally/$rallyId/stage/$stageId/stageActivityResult',
        data: Mapper.toJson(payload),
      );

      return Mapper.fromJson<StageActivityResult>(response.data);
    } catch (error) {
      return null;
    } finally {
      _loadingIndicatorCubit
          .finishLoading(LoadingAspect.submitStageActivityAnswer);
    }
  }
}
