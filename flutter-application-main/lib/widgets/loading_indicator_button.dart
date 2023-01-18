import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gibz_mobileapp/bloc/loading_indicator_cubit.dart';

abstract class LoadingIndicatorButton extends StatelessWidget {
  final LoadingAspect loadingAspect;
  final double height;
  final double width;
  final void Function() onPressed;
  final bool Function()? onPressedCondition;

  const LoadingIndicatorButton({
    required this.loadingAspect,
    required this.onPressed,
    this.onPressedCondition,
    this.height = 50,
    this.width = 50,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final viewportWidth = MediaQuery.of(context).size.width;
    return BlocBuilder<LoadingIndicatorCubit, LoadingState>(
      builder: (context, state) => AnimatedContainer(
        duration: const Duration(milliseconds: 225),
        height: height,
        width: state.contains(loadingAspect) ? width : viewportWidth,
        child: buildButton(
          state: state,
          onPressed: _onPressed(context, state),
          childWrapper: _buildChildWrapper(state),
        ),
      ),
    );
  }

  Widget buildButton({
    required LoadingState state,
    required void Function()? onPressed,
    required Widget Function(Widget) childWrapper,
  });

  void Function()? _onPressed(BuildContext context, LoadingState state) {
    return (onPressedCondition ?? placeholder)() &&
            !state.contains(loadingAspect)
        ? () {
            if (loadingAspect != LoadingAspect.none) {
              context.read<LoadingIndicatorCubit>().startLoading(loadingAspect);
            }
            onPressed();
          }
        : null;
  }

  Widget Function(Widget) _buildChildWrapper(LoadingState state) {
    return (Widget child) => state.contains(loadingAspect)
        ? const SizedBox(
            width: 18,
            height: 18,
            child: CircularProgressIndicator(
              strokeWidth: 3,
            ),
          )
        : child;
  }

  bool placeholder() {
    return true;
  }
}

class OutlinedLoadingIndicatorButton extends LoadingIndicatorButton {
  final Widget child;

  const OutlinedLoadingIndicatorButton({
    required this.child,
    required loadingAspect,
    required onPressed,
    bool Function()? onPressedCondition,
    double height = 50,
    double width = 50,
    Key? key,
  }) : super(
          loadingAspect: loadingAspect,
          onPressed: onPressed,
          onPressedCondition: onPressedCondition,
          height: height,
          width: width,
          key: key,
        );

  @override
  Widget buildButton({
    required LoadingState state,
    required void Function()? onPressed,
    required Widget Function(Widget) childWrapper,
  }) {
    return OutlinedButton(
      onPressed: onPressed,
      child: childWrapper(child),
    );
  }
}

class ElevatedLoadingIndicatorButton extends LoadingIndicatorButton {
  final Widget child;

  const ElevatedLoadingIndicatorButton({
    required this.child,
    required loadingAspect,
    required onPressed,
    bool Function()? onPressedCondition,
    double height = 50,
    double width = 50,
    Key? key,
  }) : super(
          loadingAspect: loadingAspect,
          onPressed: onPressed,
          onPressedCondition: onPressedCondition,
          height: height,
          width: width,
          key: key,
        );

  @override
  Widget buildButton({
    required LoadingState state,
    required void Function()? onPressed,
    required Widget Function(Widget) childWrapper,
  }) {
    return ElevatedButton(
      onPressed: onPressed,
      child: childWrapper(child),
    );
  }
}
