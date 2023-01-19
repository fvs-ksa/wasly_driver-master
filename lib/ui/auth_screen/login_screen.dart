import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';
import 'package:wasly_driver/constant/const_color.dart';
import 'package:wasly_driver/cubit/auth_cubit/cubit.dart';
import 'package:wasly_driver/cubit/auth_cubit/state.dart';
import 'package:wasly_driver/ui/main_screen/tabs_screen.dart';
import 'package:wasly_driver/widget/component.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);
  TextEditingController userNameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var authCubit = AuthCubit.get(context);
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {},
      builder: (context, state) {
        return Directionality(
          textDirection: TextDirection.rtl,
          child: Scaffold(
            body: Form(
              key: _formKey,
              child: SingleChildScrollView(
                child: Column(
                  // mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/logo_wassly_ar.png',
                    ),
                    textFormField(
                      controller: userNameController,
                      fct: (value) {
                        if (value.isEmpty) {
                          return 'من فضلك قم بادخال الاسم';
                        }
                      },
                      label: 'اسم المستخدم',
                      prefix: Icons.person,
                      //  secure: authCubit.isVisible,
                      // suffix:authCubit.isVisible?Icons.visibility:Icons.visibility_off ,
                      // suffixTap: (){authCubit.changeVisibility();}
                    ),
                    SizedBox(
                      height: 2.h,
                    ),
                    textFormField(
                        controller: passwordController,
                        fct: (value) {
                          if (value.isEmpty) {
                            return 'من فضلك قم بادخال الرقم السري';
                          }
                        },
                        label: 'الرقم السري',
                        prefix: Icons.lock,
                        secure: authCubit.isVisible,
                        suffix: authCubit.isVisible
                            ? Icons.visibility_off
                            : Icons.visibility,
                        suffixTap: () {
                          authCubit.changeVisibility();
                        }),
                    SizedBox(
                      height: 2.h,
                    ),
                    mainButton(
                      width: 40.w,
                      text: 'تسجيل الدخول',
                      fct: () {
                        if (_formKey.currentState!.validate()) {
                          if (kDebugMode) {
                            print('object');
                          }
                          Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=> const TabsScreen()));
                        }
                      },
                      color: redColor,
                      context: context,
                    )
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
