import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

enum LoadingAspect {
  none,
  joiningRally,
  startingRally,
  submitStageActivityAnswer,
}

class LoadingIndicatorCubit extends Cubit<LoadingState> {
  LoadingIndicatorCubit() : super(const LoadingState([]));

  void startLoading(LoadingAspect loadingAspect) {
    emit(state.add(loadingAspect));
  }

  void finishLoading(LoadingAspect loadingAspect) {
    emit(state.remove(loadingAspect));
  }

  @override
  void onChange(Change<LoadingState> change) {
    super.onChange(change);
  }
}

class LoadingState extends Equatable {
  final List<LoadingAspect> _loadingAspects;

  const LoadingState(this._loadingAspects);

  LoadingState add(LoadingAspect loadingAspect) {
    final newState = List<LoadingAspect>.from(_loadingAspects)
      ..add(loadingAspect);
    return copyWith(loadingAspects: () => newState);
  }

  LoadingState remove(LoadingAspect loadingAspect) {
    final newState = List<LoadingAspect>.from(_loadingAspects)
      ..remove(loadingAspect);
    return copyWith(loadingAspects: () => newState);
  }

  bool contains(LoadingAspect loadingAspect) {
    return _loadingAspects.contains(loadingAspect);
  }

  LoadingState copyWith({ValueGetter<List<LoadingAspect>>? loadingAspects}) {
    return LoadingState(
        loadingAspects != null ? loadingAspects() : _loadingAspects);
  }

  @override
  List<Object?> get props => [..._loadingAspects];
}
