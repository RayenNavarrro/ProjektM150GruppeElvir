import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gibz_mobileapp/bloc/menu_info/menu_info_cubit.dart';
import 'package:gibz_mobileapp/data/repositories/meal_information/meal_repository.dart';
import 'package:gibz_mobileapp/models/meal_information/meal_information.dart';
import 'package:gibz_mobileapp/widgets/gibz_progress_indicator.dart';

import 'menu_item.dart';

class MenuDayPageView extends StatefulWidget {
  const MenuDayPageView({Key? key}) : super(key: key);

  @override
  _MenuDayPageViewState createState() => _MenuDayPageViewState();
}

class _MenuDayPageViewState extends State<MenuDayPageView> {
  late PageController _pageController;
  late bool _pageTransitionInProgress;

  List<Day>? mealDays;

  @override
  void initState() {
    super.initState();
    loadMealData();
    _pageController =
        PageController(initialPage: context.read<MenuInfoCubit>().state - 1);
    _pageTransitionInProgress = false;
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  Future<void> loadMealData() async {
    var days = await context.read<MealRepository>().getMealsForWholeWeek();
    setState(() {
      mealDays = days;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<MenuInfoCubit, int>(
      listener: (context, state) {
        if (_pageController.hasClients) {
          setState(() {
            _pageTransitionInProgress = true;
          });
          _pageController
              .animateToPage(
                state - 1,
                duration: const Duration(milliseconds: 250),
                curve: Curves.easeInOut,
              )
              .then((_) => {
                    setState(() {
                      _pageTransitionInProgress = false;
                    })
                  });
        }
      },
      child: PageView(
        controller: _pageController,
        onPageChanged: (index) {
          if (_pageTransitionInProgress) return;
          BlocProvider.of<MenuInfoCubit>(context).selectDay(index + 1);
        },
        children: [
          if (mealDays == null || mealDays!.isEmpty)
            const GibzProgressIndicator(
                indicatorText: 'Aktuelle Menüs werden geladen...'),
          ...?mealDays?.map((day) => MealListView(mealDay: day)),
        ],
      ),
    );
  }
}

class MealListView extends StatelessWidget {
  final Day mealDay;

  const MealListView({required this.mealDay, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (mealDay.menus.isEmpty) {
      return const Center(
        child: Text(
          'Für den ausgewählten Tag sind\nkeine Menü-Informationen verfügbar.',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.black54,
            fontSize: 18,
            height: 1.2,
          ),
        ),
      );
    }
    return ListView(
      children: [...mealDay.menus.map((menuItem) => MealBox(meal: menuItem))],
    );
  }
}
