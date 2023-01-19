import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';
import 'package:wasly_driver/bloc_observe.dart';
import 'package:wasly_driver/cubit/auth_cubit/cubit.dart';
import 'package:wasly_driver/cubit/chat_cubit/cubit.dart';
import 'package:wasly_driver/cubit/general_cubit/cubit.dart';
import 'package:wasly_driver/cubit/main_order_cubit/cubit.dart';
import 'package:wasly_driver/cubit/order_cubit/cubit.dart';
import 'package:wasly_driver/cubit/profile_cubit/cubit.dart';
import 'package:wasly_driver/pallete.dart';
import 'package:wasly_driver/ui/auth_screen/login_screen.dart';
import 'package:wasly_driver/ui/main_screen/tabs_screen.dart';

import 'cubit/order_cubit/current_order_cubit/cubit.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer=MyBlocObserver();
  await EasyLocalization.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(providers: [
      BlocProvider<GeneralCubit>(create: (context)=>GeneralCubit()),
      BlocProvider<AuthCubit>(create: (context)=>AuthCubit(),),
      BlocProvider<ChatCubit>(create: (context)=>ChatCubit(),),
      BlocProvider<OrderDetailsBikerCubit>(create: (context)=>OrderDetailsBikerCubit(),),
      BlocProvider<ProfileCubit>(create: (context)=>ProfileCubit(),),
      BlocProvider<MainOrderCubit>(create: (context)=>MainOrderCubit(),),
      BlocProvider(create: (context)=>OrderCubit()),
    ],
    child: Sizer(
        builder: (context,orientation,deviceType) {
          return MaterialApp(
            locale: const Locale('ar'),
            debugShowCheckedModeBanner: false,
            title: 'سائق وصلي',
            theme: ThemeData(
              primarySwatch: Palette.mainColor,
            ),
            home: LoginScreen(),
          );
        }
    ),
    );

  }
}

