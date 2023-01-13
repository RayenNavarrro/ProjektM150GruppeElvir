import 'package:flutter_bloc/flutter_bloc.dart';

/// This cubit might be used to control navigation on app level.
class RootNavigationCubit extends Cubit<int> {
  RootNavigationCubit() : super(0);

  void activateView(int viewIndicator) {
    emit(viewIndicator);
  }
}
