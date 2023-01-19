import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wasly_driver/cubit/general_cubit/state.dart';
import 'package:wasly_driver/ui/main_screen/order_screen.dart';
import 'package:wasly_driver/ui/main_screen/profile_screen.dart';

class GeneralCubit extends Cubit<GeneralState>{
  GeneralCubit():super(InitialState());
  static GeneralCubit get(context)=>BlocProvider.of(context);
  int changeIndex=0;
  List<Widget> screens=[
    OrderScreen(),
    ProfileScreen(),
  ];
  List<String> titles=[
    'الطلبات',
    'حسابي',
  ];
 void changeIndexTab(int index){
    changeIndex=index;
    emit(ChangeNavBarState());
  }
}