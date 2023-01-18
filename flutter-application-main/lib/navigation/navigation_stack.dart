import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:gibz_mobileapp/navigation/page_configuration.dart';

class NavigationStack extends Equatable {
  final List<PageConfiguration> _stack;

  const NavigationStack(this._stack);

  @override
  List<Object> get props => [_stack];

  List<Page> get pages => List.unmodifiable(
      _stack.map((pageConfiguration) => pageConfiguration.page));

  NavigationStack push(PageConfiguration pageConfiguration) {
    List<PageConfiguration> newPages = [];
    newPages.add(pageConfiguration);

    while (pageConfiguration.pageBefore != null) {
      pageConfiguration = pageConfiguration.pageBefore!;
      if (!_stack.contains(pageConfiguration)) {
        newPages.add(pageConfiguration);
      }
    }

    if (newPages.length > 1) newPages = newPages.reversed.toList();

    return copyWith(stack: () => List.from(_stack)..addAll(newPages));
  }

  bool canPop() {
    return _stack.isNotEmpty;
  }

  NavigationStack pop() {
    final newPageConfigurations = List<PageConfiguration>.from(_stack);
    if (canPop()) {
      newPageConfigurations.removeLast();
    }
    return copyWith(stack: () => newPageConfigurations);
  }

  NavigationStack copyWith({ValueGetter<List<PageConfiguration>>? stack}) {
    return NavigationStack(stack != null ? stack() : _stack);
  }
}
