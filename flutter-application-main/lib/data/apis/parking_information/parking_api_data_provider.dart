import 'package:gibz_mobileapp/data/dio.dart';
import 'package:gibz_mobileapp/models/parking_information/parking_information.dart';

class ParkingApiDataProvider {
  final DioClient _httpClient;

  ParkingApiDataProvider(this._httpClient);

  Future<CarPark> getCurrentAvailability({int plsId = 61}) async {
    final response = await _httpClient.get('/api/parking/v1/availability/61');
    return Mapper.fromJson<CarPark>(response.data);
  }
}
