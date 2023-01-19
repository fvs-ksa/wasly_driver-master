import 'package:bloc/bloc.dart';
import 'package:flutter/animation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:wasly_driver/cubit/main_order_cubit/state.dart';

class MainOrderCubit extends Cubit<MainOrderState>{
  MainOrderCubit():super(InitialMainOrderState());
  static MainOrderCubit get(context)=>BlocProvider.of(context);
  bool isAccept=false;
  changeMainOrderState(){
    isAccept =true;
    emit(ChangeMainOrderState());
  }
  static Future<void> openMap(double latitude, double longitude) async {
    String googleUrl = 'https://www.google.com/maps/search/?api=1&query=$latitude,$longitude';
    if (await canLaunch(googleUrl)) {
      await launch(googleUrl);
    } else {
      throw 'Could not open the map.';
    }
  }
}