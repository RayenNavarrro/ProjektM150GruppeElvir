import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gibz_mobileapp/bloc/menu_info/menu_info_cubit.dart';

class MenuDaySelector extends StatelessWidget {
  const MenuDaySelector({Key? key}) : super(key: key);

  static const List<String> _weekdays = ["MO", "DI", "MI", "DO", "FR"];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10, left: 00, right: 0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: _weekdays
            .asMap()
            .entries
            .map((entry) => MenuDaySelectorItem(
                  label: entry.value,
                  dayIndex: entry.key + 1,
                ))
            .toList(),
      ),
    );
  }
}

class MenuDaySelectorItem extends StatelessWidget {
  final String label;
  final int dayIndex;

  const MenuDaySelectorItem({
    Key? key,
    required this.label,
    required this.dayIndex,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: BlocBuilder<MenuInfoCubit, int>(
        builder: (context, selectedDayIndex) => Container(
          decoration: BoxDecoration(
            color: selectedDayIndex == dayIndex
                ? Colors.white70
                : const Color.fromARGB(255, 0, 98, 160),
            borderRadius: const BorderRadius.all(Radius.circular(20)),
          ),
          padding: const EdgeInsets.symmetric(vertical: 3, horizontal: 10),
          width: 50,
          child: Text(
            label,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: selectedDayIndex == dayIndex
                  ? const Color.fromARGB(255, 0, 98, 160)
                  : Colors.white70,
              fontWeight: selectedDayIndex == dayIndex
                  ? FontWeight.w800
                  : FontWeight.normal,
            ),
          ),
        ),
      ),
      onTap: () {
        context.read<MenuInfoCubit>().selectDay(dayIndex);
      },
    );
  }
}
