import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';
import 'package:wasly_driver/constant/const_color.dart';
import 'package:wasly_driver/cubit/profile_cubit/cubit.dart';
import 'package:wasly_driver/cubit/profile_cubit/state.dart';
import 'package:wasly_driver/pallete.dart';
import 'package:auto_size_text/auto_size_text.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var cubit=ProfileCubit.get(context);
    return BlocConsumer<ProfileCubit,ProfileState>(
      listener: (context,state){},
      builder: (context,state) {
        return Scaffold(
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Container(
                  height: 13.h,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20.sp),
                    color: Palette.mainColor,
                  ),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            CircleAvatar(
                              backgroundImage: const NetworkImage(
                                  'https://t4.ftcdn.net/jpg/03/32/59/65/240_F_332596535_lAdLhf6KzbW6PWXBWeIFTovTii1drkbT.jpg'),
                              radius: 20.sp,
                            ),
                            SizedBox(
                              width: 2.w,
                            ),
                            Column(
                              children: [
                                Text(
                                  'احمد علي',
                                  style: TextStyle(
                                      fontSize: 20.sp, color: Colors.white),
                                ),
                                const Text(
                                  '4.0',
                                  style: TextStyle(color: Colors.amber),
                                )
                              ],
                            ),
                            SizedBox(
                              width: 24.w,
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: 4.h),
                              child: Container(
                                // padding: EdgeInsets.only(top: 4.h),
                                height: 7.h,
                                width: 28.w,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15.sp),
                                    color: Colors.amber),
                                child: Align(
                                    alignment: Alignment.center,
                                    child: AutoSizeText(
                                      'اجمالي عدد الطلبات\n 16',
                                      style: TextStyle(fontSize: 14.sp),
                                      textAlign: TextAlign.center,
                                    )),
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(height: 2.h,),
               Padding(
                 padding:  EdgeInsets.symmetric(horizontal: 8.0.w),
                 child: Row(
                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                   children: [
                     Text('التنبيهات',style: Theme.of(context).textTheme.headline6,),
                     Switch.adaptive(
                         activeColor: amberColor,
                         value: cubit.isActive,
                         onChanged: (value) {
                           cubit.changeDriverStatus();
                         })
                   ],
                 ),
               ),
                SizedBox(height: 20.h,),
                Text('تسجيل الخروج',style: TextStyle(color: Palette.mainColor,fontSize: 20.sp),)
              ],
            ),
          ),
        );
      }
    );
  }
}
