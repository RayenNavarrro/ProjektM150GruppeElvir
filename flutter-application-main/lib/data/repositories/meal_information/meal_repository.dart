import 'package:gibz_mobileapp/data/dio.dart';
import 'package:gibz_mobileapp/models/meal_information/meal_information.dart';

import '../../apis/meal_information/meal_api_data_provider.dart';

class MealRepository {
  final MealApiDataProvider _apiDataProvider;

  MealRepository({MealApiDataProvider? apiDataProvider})
      : _apiDataProvider = apiDataProvider ?? MealApiDataProvider(DioClient());

  Future<List<Day>> getMealsForWholeWeek() async {
    return _apiDataProvider.getMealsForWholeWeek();
  }
}
