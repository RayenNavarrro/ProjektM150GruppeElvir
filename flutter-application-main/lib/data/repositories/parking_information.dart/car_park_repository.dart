import 'package:gibz_mobileapp/data/apis/parking_information/parking_api_data_provider.dart';
import 'package:gibz_mobileapp/data/dio.dart';
import 'package:gibz_mobileapp/models/parking_information/parking_information.dart';

class ParkingRepository {
  final ParkingApiDataProvider _apiDataProvider;

  ParkingRepository({ParkingApiDataProvider? apiDataProvider})
      : _apiDataProvider =
            apiDataProvider ?? ParkingApiDataProvider(DioClient());

  Future<CarPark> getCurrentAvailability() async {
    return await _apiDataProvider.getCurrentAvailability();
  }
}
