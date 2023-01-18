import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gibz_mobileapp/navigation/page_configuration.dart';

class TabBarNavigationCubit extends Cubit<String> {
  static const mainMenuState = 'mainMenu';
  PageConfiguration? lastState;

  TabBarNavigationCubit(String initialState) : super(initialState);

  void showMainMenu() {
    emit(mainMenuState);
  }

  void toggleMainMenu() {
    if (state == mainMenuState && lastState != null) {
      emit(lastState!.firstPathSegment);
    } else {
      emit(mainMenuState);
    }
  }

  void navigateTo(PageConfiguration pageConfiguration) {
    lastState = pageConfiguration;
    emit(pageConfiguration.firstPathSegment);
  }
}
