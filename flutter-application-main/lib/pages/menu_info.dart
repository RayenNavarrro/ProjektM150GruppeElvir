import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gibz_mobileapp/bloc/menu_info/menu_info_cubit.dart';
import 'package:gibz_mobileapp/pages/page_wrapper.dart';

class MenuInfoPage extends StatelessWidget {
  const MenuInfoPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<MenuInfoCubit>(
      create: (context) => MenuInfoCubit(),
      child: const PageWrapper(
        title: 'Menüplan',
        child: SliverToBoxAdapter(
          child: Text('Menüplan!!!'),
        ),
      ),
    );
  }
}
