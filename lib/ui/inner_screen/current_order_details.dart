import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../../component/general_component.dart';
import '../../constant/const_color.dart';
import '../../cubit/order_cubit/current_order_cubit/cubit.dart';
import '../../cubit/order_cubit/current_order_cubit/state.dart';
import '../../pallete.dart';
import '../../widget/component.dart';
import 'chat_screen.dart';

class CurrentOrderDetails extends StatelessWidget {
  TextEditingController locationController = TextEditingController();

  //const CurrentOrderScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size=MediaQuery.of(context).size;
    var cubit = OrderDetailsBikerCubit.get(context);
    return BlocConsumer<OrderDetailsBikerCubit, CurrentOrderDetailsState>(
        listener: (context, state) {},
        builder: (context, state) {
          return Directionality(
            textDirection: TextDirection.rtl,
            child: Scaffold(
              appBar: AppBar(title: Text('طلب حالي'),),
              body: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 5.0.w, vertical: 3.h),
                  child: Align(
                    alignment: Alignment.topRight,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              'رقم الطلب : ',
                              style: Theme.of(context).textTheme.bodyLarge,
                            ),
                            Text('#3252')
                          ],
                        ),
                        Row(
                          children: [
                            Text(
                              'حاله الطلب : ',
                              style: Theme.of(context).textTheme.bodyLarge,
                            ),
                            Text(cubit.orderState)
                          ],
                        ),
                        SizedBox(height: 2.h,),
                        Container(
                          height: size.height>1000?48.h: 38.8.h,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20.sp),
                              border: Border.all(color: redColor)),
                          child: Row(
                            children: [
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 1.0.w),
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
                                    IconButton(onPressed: (){}, icon: Icon(Icons.location_on,color: Palette.mainColor,)),
                                     IconButton(onPressed: (){
                                      navigateTo(context: context, child: ChatScreen());
                                    }, icon: const Icon(Icons.chat,color: Colors.green,))
                                  ],
                                ),
                              )


                            ],
                          ),
                        ),
                        SizedBox(height: 2.h,),
                        cubit.i == 3
                            ? SizedBox()
                            : Align(
                          alignment: Alignment.center,
                          child: mainButton(
                              width: 80.w,
                              //height: 7.h,
                              text:'تحديث حاله الطلب',
                              color: redColor,
                              context: context,
                              fct: () {
                                cubit.changeOrderState();
                                print(cubit.i.toString());
                              }),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        });
  }
}