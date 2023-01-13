import 'dart:convert';

import 'package:gibz_mobileapp/bloc/loading_indicator_cubit.dart';
import 'package:gibz_mobileapp/data/dio.dart';

import '../../../models/rally/rally_models.dart';

class ParticipatingPartyApi {
  final DioClient _httpClient;
  final LoadingIndicatorCubit _loadingIndicatorCubit;

  ParticipatingPartyApi(this._httpClient, this._loadingIndicatorCubit);

  Future<SuccessfulRallyJoinResponse?> createParticipatingParty(
      int joiningCode) async {
    final payload = jsonEncode({"joiningCode": joiningCode});
    try {
      final response = await _httpClient.post(
        '/api/rally/v1/party',
        data: payload,
      );

      if ((response.statusCode ?? 999) > 299) {
        _loadingIndicatorCubit.finishLoading(LoadingAspect.joiningRally);
        return null;
      }

      _loadingIndicatorCubit.finishLoading(LoadingAspect.joiningRally);
      return Mapper.fromJson<SuccessfulRallyJoinResponse>(response.data);
    } catch (error) {
      _loadingIndicatorCubit.finishLoading(LoadingAspect.joiningRally);
      return null;
    } finally {
      _loadingIndicatorCubit.finishLoading(LoadingAspect.joiningRally);
    }
  }

  Future<Stage?> updateParticipatingParty({
    required String id,
    required String title,
    required List<String> names,
  }) async {
    final updateRequest = ParticipatingPartyUpdateRequestDto(
      id: id,
      title: title,
      names: names,
    );
    final payload = Mapper.toJson(updateRequest);
    final response =
        await _httpClient.put('/api/rally/v1/party/' + id, data: payload);

    if (response.statusCode == 204) {
      return null;
    }

    return Mapper.fromJson<Stage>(response.data);
  }
}
