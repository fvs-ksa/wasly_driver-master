import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:wasly_driver/cubit/general_cubit/cubit.dart';
import 'package:wasly_driver/cubit/general_cubit/state.dart';

class TabsScreen extends StatelessWidget {
  const TabsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var generalCubit = GeneralCubit.get(context);
    return BlocConsumer<GeneralCubit, GeneralState>(
      listener: (context, state) {},
      builder: (context, state) {
        return Directionality(
          textDirection: TextDirection.rtl,
          child: Scaffold(
            appBar: AppBar(
              title: Text(generalCubit.titles[generalCubit.changeIndex]),
            ),
            body: generalCubit.screens[generalCubit.changeIndex],
            bottomNavigationBar: BottomNavigationBar(
              items:  const [
                BottomNavigationBarItem(
                    icon: FaIcon(FontAwesomeIcons.paperPlane), label: 'الطلبات'),
                BottomNavigationBarItem(
                    icon: FaIcon(FontAwesomeIcons.personCircleCheck), label: 'حسابي'),
              ],
              currentIndex: generalCubit.changeIndex,
              onTap: generalCubit.changeIndexTab,
            ),
          ),
        );
      },
    );
  }
}
