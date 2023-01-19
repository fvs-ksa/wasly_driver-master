import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:wasly_driver/pallete.dart';
import 'package:wasly_driver/ui/main_screen/order_screen.dart';
import 'package:wasly_driver/widget/component.dart';

import '../../component/general_component.dart';
import '../main_screen/tabs_screen.dart';

class SalaryOverScreen extends StatelessWidget {
 // const SalaryOverScreen({Key? key}) : super(key: key);
TextEditingController priceController=TextEditingController();
final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title: Text('تقديم عرض السعر'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Align(
                    alignment: AlignmentDirectional.topStart,
                    child: Text('تفاصيل الطلب',style: TextStyle(color: Palette.mainColor,fontSize: 16.sp),)),
                Container(
                  height: 13.h,
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
                            Text('جبلي : دواء من صيديله النهدي',
                                style: TextStyle(fontSize: 17.sp),
                                textAlign: TextAlign.start),
                            Text('طريقه الدفع : كاش',textAlign: TextAlign.start,)
                          ],
                        ),
                      ),
                     // IconButton(onPressed: (){}, icon: Icon(Icons.chat))
                    ],
                  ),
                ),
                SizedBox(height: 3.h,),
                Align(
                    alignment: AlignmentDirectional.topStart,
                    child: Text('عرض سعر',style: TextStyle(color: Palette.mainColor,fontSize: 16.sp),)),
                SizedBox(height: 1.h,),
                TextFormField(
                  controller:priceController ,
                  validator: (String? value){
                    if(value!.isEmpty){
                      return 'من فضلك قم باضافه السعر';
                    }
                    return null;
                  },
                  keyboardType: TextInputType.number,
                  decoration:  InputDecoration(
                   border: OutlineInputBorder(borderRadius: BorderRadius.circular(20.sp)),
                      hintText: 'عرض السعر ريال سعودي', label: Text('السعر')),
                ),
                SizedBox(height: 3.h,),
                mainButton(width: 50.w, text: 'تقديم عرض السعر', color: Palette.mainColor, context: context, fct: (){
                    if(_formKey.currentState!.validate()){
                      Navigator.of(context).pop();
                      showToast(text: 'تم ارسال عرض السعر للعميل', state: ToastState.SUCCESS);
                    }
                })
              ],
            ),
          ),
        ),
      ),
    );
  }
}
