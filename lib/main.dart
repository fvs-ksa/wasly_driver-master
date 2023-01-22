import 'package:device_preview/device_preview.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:overlay_support/overlay_support.dart';
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
import 'package:wasly_driver/utiles/shared_pref.dart';
import 'constant/const_color.dart';
import 'cubit/order_cubit/current_order_cubit/cubit.dart';
import 'fcm/fcm.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FirebaseNotifications().setUpFirebase();
  FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);
  Bloc.observer=MyBlocObserver();
  await EasyLocalization.ensureInitialized();
  await CacheHelper.init();
  await FirebaseMessaging.instance.getToken().then((value) {
    CacheHelper.saveData(key: 'fcmToken', value: value);
  });
  fcmToken = CacheHelper.getData(key: 'fcmToken');
  print('<<<<<<<<<<<<<$fcmToken>>>>>>>>>>>>>');
  runApp( DevicePreview(
    enabled: false,
    builder: (context) {
      return MyApp();
    }
  ));
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
          return OverlaySupport.global(

            child: MaterialApp(
              useInheritedMediaQuery: true,
              locale: DevicePreview.locale(context),
              builder: DevicePreview.appBuilder,
            //  locale: const Locale('ar'),
              debugShowCheckedModeBanner: false,
              title: 'سائق وصلي',
              theme: ThemeData(
                primarySwatch: Palette.mainColor,
              ),
              home: LoginScreen(),
            ),
          );
        }
    ),
    );

  }
}

