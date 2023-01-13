import 'dart:convert';

import 'package:gibz_mobileapp/data/dio.dart';

import '../../../models/rally/rally_models.dart';

class RallyStageApi {
  final DioClient _httpClient;

  RallyStageApi(this._httpClient);

  Future<Stage?> getNext(
    String rallyId,
    String stageId,
    String participatingPartyId,
  ) async {
    final response = await _httpClient.get(
      '/api/rally/v1/rally/$rallyId/stage/$stageId/next/$participatingPartyId',
    );
    if (response.statusCode == 204) {
      return null;
    }

    return Mapper.fromJson<Stage>(response.data);
  }

  Future<ParticipatingPartyAppearance> addParticipatingPartyAppearance({
    required String rallyId,
    required String stageId,
    required String participatingPartyId,
    required String locationMarkerId,
  }) async {
    final response = await _httpClient.post(
      '/api/rally/v1/rally/$rallyId/stage/$stageId/appearance',
      data: jsonEncode({
        "participatingPartyId": participatingPartyId,
        "locationMarkerId": locationMarkerId,
      }),
    );

    return Mapper.fromJson<ParticipatingPartyAppearance>(response.data);
  }
}
