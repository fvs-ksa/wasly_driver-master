import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wasly_driver/cubit/order_cubit/state.dart';

class OrderCubit extends Cubit<OrderState>{
  OrderCubit():super(InitialOrderState());
  static OrderCubit get(context)=>BlocProvider.of(context);
  int tabIndex=0;
 void changeTabBar({required int value}){
    tabIndex=value;
    emit(ChangeTapBarItemState());
  }
}