import 'package:flutter_bloc/flutter_bloc.dart';

class MenuInfoCubit extends Cubit<int> {
  MenuInfoCubit() : super(1) {
    var now = DateTime.now();
    var weekday = now.weekday;
    emit(weekday);
  }

  void selectDay(int dayIndex) => emit(dayIndex);
}
