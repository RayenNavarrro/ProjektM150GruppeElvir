import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gibz_mobileapp/navigation/navigation_stack.dart';
import 'package:gibz_mobileapp/navigation/page_configuration.dart';

class RallyNavigationCubit extends Cubit<NavigationStack> {
  RallyNavigationCubit({required initialStack}) : super(initialStack);

  void push(PageConfiguration pageConfiguration) {
    emit(state.push(pageConfiguration));
  }

  void pop() {
    emit(state.pop());
  }
}
