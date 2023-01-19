import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wasly_driver/cubit/auth_cubit/state.dart';

class AuthCubit extends Cubit<AuthState>{
  AuthCubit():super(InitialAuthState());
  static AuthCubit get(context)=>BlocProvider.of(context);

  bool isVisible=true;
  void changeVisibility(){
    isVisible =! isVisible;
    emit(ChangeSuffixIconState());
  }
}