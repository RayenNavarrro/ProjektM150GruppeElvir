import 'package:gibz_mobileapp/data/dio.dart';
import 'package:gibz_mobileapp/models/meal_information/meal_information.dart';

class MealApiDataProvider {
  final DioClient _httpClient;

  MealApiDataProvider(this._httpClient);

  Future<List<Day>> getMealsForWholeWeek() async {
    final response =
        await _httpClient.get('/api/mealInformation/v1/menu?wholeWeek=true');
    return Mapper.fromJson<List<Day>>(response.data);
  }
}
