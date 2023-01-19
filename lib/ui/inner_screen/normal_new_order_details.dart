
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'package:wasly_driver/cubit/main_order_cubit/cubit.dart';
import 'package:wasly_driver/cubit/main_order_cubit/state.dart';

import '../../component/general_component.dart';
import '../../pallete.dart';
import '../../widget/component.dart';
import 'chat_screen.dart';
class OrderDetailsAndAcceptOrRefuse extends StatelessWidget {
  //const OrderDetails({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var cubit=MainOrderCubit.get(context);
    return BlocConsumer<MainOrderCubit,MainOrderState>(
      listener: (context,state){},
      builder: (context,state) {
        return Directionality(
          textDirection: TextDirection.rtl,
          child: Scaffold(
            appBar: AppBar(
              title: Text('طلب جديد'),
            ),
            body: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Align(
                      alignment: AlignmentDirectional.topStart,
                      child: Text('تفاصيل الطلب',style: TextStyle(color: Palette.mainColor,fontSize: 16.sp),)),
                  Container(
                    height: 30.h,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20.sp),
                        border: Border.all(color: Palette.mainColor)),
                    child: Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 3.0.w),
                          child: Container(
                            // padding: EdgeInsets.symmetric(horizontal: 3.w),
                            height: 13.h,
                            width: 10.w,
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: AssetImage('assets/logo_Wasly.png'))),
                          ),
                        ),
                        VerticalDivider(
                          width: 2.w,
                          thickness: 0.4.w,
                          endIndent: 2.h,
                          indent: 2.h,
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 3.0.h),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            // mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text('العميل : احمد علي',style: TextStyle(fontSize: 14.sp),),
                             // Text('رقم الجوال :+966501233536'),
                              Text('المطعم: مطعم كنتاكي',
                                  style: TextStyle(fontSize: 14.sp),
                                  textAlign: TextAlign.start),
                              Text('الطلب : سموكن تشيزي تويست',textAlign: TextAlign.start,style: TextStyle(fontSize: 14.sp)),
                              Text('العدد : 3',textAlign: TextAlign.start,style: TextStyle(fontSize: 14.sp)),
                              Text('سعر الطلب : 130 SAR',style: TextStyle(fontSize: 14.sp),),
                              Text('رسوم التوصيل : 20 SAR',style: TextStyle(fontSize: 14.sp),),
                              Text('الاجمالي : 150 SAR',style: TextStyle(fontSize: 14.sp),),
                            ],
                          ),
                        ),
                         SizedBox(width: 11.w),

                         Padding(
                           padding:  EdgeInsets.symmetric(vertical: 4.0.h),
                           child: Column(
                             children: [
                               IconButton(onPressed: ()async{
                                 await launchUrlString('tel:${0506632217}');
                               }, icon: Icon(Icons.call,color: Colors.blueAccent,)),
                               IconButton(onPressed: (){MainOrderCubit.openMap(21.5529449, 39.1843989);}, icon: Icon(Icons.location_on,color: Palette.mainColor,)),
                             cubit.isAccept?  IconButton(onPressed: (){
                               navigateTo(context: context, child: ChatScreen());
                             }, icon: Icon(Icons.chat,color: Colors.green,)):SizedBox()
                             ],
                           ),
                         )


                      ],
                    ),
                  ),
                  SizedBox(height: 3.h,),

                  SizedBox(height: 1.h,),
                  cubit.isAccept?SizedBox(): Row(

                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      mainButton(width: 25.w, text: 'قبول', color: Palette.mainColor, context: context, fct: (){
                        // if(_formKey.currentState!.validate()){
                         cubit.changeMainOrderState();
                         showToast(text: 'تم تحديث حاله الطلب لدي العميل الي تم قبول الطلب من قبل كابتن وصلي', state: ToastState.SUCCESS);
                       // }
                      }),
                      SizedBox(width: 3.w,),
                      mainButton(width: 25.w, text: 'رفض', color: Palette.mainColor, context: context, fct: (){
                        // if(_formKey.currentState!.validate()){
                        Navigator.of(context).pop();
                        showToast(text: 'تم رفض الطلب', state: ToastState.SUCCESS);
                        // }
                      }),
                    ],
                  )
                ],
              ),
            ),
          ),
        );
      }
    );
  }
}
