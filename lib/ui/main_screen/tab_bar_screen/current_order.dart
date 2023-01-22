import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../pallete.dart';
import '../../inner_screen/current_order_details.dart';
import '../../inner_screen/normal_new_order_details.dart';
import '../../inner_screen/salary_over.dart';

class CurrentOrderScreen extends StatelessWidget {
  const CurrentOrderScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size=MediaQuery.of(context).size;
   return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          GestureDetector(
            onTap: (){Navigator.of(context).push(MaterialPageRoute(builder: (context)=>CurrentOrderDetails()));},
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
                    padding:  EdgeInsets.symmetric(vertical: .2.h),
                    child: Column(
                      // mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('طلب حالي',style: TextStyle(fontSize:size.height>1000?14.sp: 17.sp),textAlign: TextAlign.start),
                        Text('مطعم كنتاكي',style: TextStyle(fontSize:size.height>1000?12.sp: 14.sp),)
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
          SizedBox(height: 2.h,),

        ],
      ),
    );
  }
}
