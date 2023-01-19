import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:wasly_driver/pallete.dart';
import 'package:wasly_driver/ui/inner_screen/normal_new_order_details.dart';

import '../../inner_screen/salary_over.dart';

class NewOrderScreen extends StatelessWidget {
  const NewOrderScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          GestureDetector(
            onTap: (){Navigator.of(context).push(MaterialPageRoute(builder: (context)=>SalaryOverScreen()));},
            child: Container(
              height: 13.h,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20.sp),
                border: Border.all(color: Palette.mainColor)
              ),
              child: Row(
                children: [
                  Padding(
                    padding:  EdgeInsets.symmetric(horizontal: 3.0.w),
                    child: Container(
                     // padding: EdgeInsets.symmetric(horizontal: 3.w),
                      height: 13.h,
                      width: 10.w,
                      decoration: BoxDecoration(
                        image: DecorationImage(image: AssetImage('assets/logo_Wasly.png'))
                      ),
                    ),
                  ),
                  VerticalDivider(width: 2.w,thickness: 0.4.w,endIndent: 2.h,indent: 2.h,),
                  Padding(
                    padding:  EdgeInsets.symmetric(vertical: 3.0.h),
                    child: Column(
                     // mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('طلب جديد',style: TextStyle(fontSize: 17.sp),textAlign: TextAlign.start),
                        Text('عليك تقديم عرض سعر',style: TextStyle(fontSize: 14.sp),)
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
          SizedBox(height: 2.h,),
          GestureDetector(
            onTap: (){Navigator.of(context).push(MaterialPageRoute(builder: (context)=>OrderDetailsAndAcceptOrRefuse()));},
            child: Container(
              height: 13.h,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20.sp),
                  border: Border.all(color: Palette.mainColor)
              ),
              child: Row(
                children: [
                  Padding(
                    padding:  EdgeInsets.symmetric(horizontal: 3.0.w),
                    child: Container(
                      // padding: EdgeInsets.symmetric(horizontal: 3.w),
                      height: 13.h,
                      width: 10.w,
                      decoration: BoxDecoration(
                          image: DecorationImage(image: AssetImage('assets/logo_Wasly.png'))
                      ),
                    ),
                  ),
                  VerticalDivider(width: 2.w,thickness: 0.4.w,endIndent: 2.h,indent: 2.h,),
                  Padding(
                    padding:  EdgeInsets.symmetric(vertical: 3.0.h),
                    child: Column(
                      // mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('طلب جديد',style: TextStyle(fontSize: 17.sp),textAlign: TextAlign.start),
                        Text('مطعم هيرفي',style: TextStyle(fontSize: 14.sp),)
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
