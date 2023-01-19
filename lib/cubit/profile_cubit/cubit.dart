import 'package:bloc/bloc.dart';
import 'package:flutter/animation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wasly_driver/cubit/profile_cubit/state.dart';

class ProfileCubit extends Cubit<ProfileState>{
  ProfileCubit():super(InitialProfileState());
  static ProfileCubit get(context)=>BlocProvider.of(context);
  bool isActive=false;
  changeDriverStatus(){
    isActive=!isActive;
    emit(ChangeStatusOfDriverState());
  }
}