import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

Widget textFormField(
    {required TextEditingController controller,
    TextInputType? inputType,
    String? label,
    Function? fct,
    bool secure = false,
    Function? suffixTap,
    IconData? suffix,
    IconData? prefix}) {
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: 4.w),
    child: TextFormField(

     // textAlign: TextAlign.justify,
    //  textDirection: TextDirection.r,
     // textCapitalization: TextCapitalization.sentences,
      cursorHeight:15.sp ,
      controller: controller,

      keyboardType: inputType,
      obscureText: secure,
      decoration: InputDecoration(
        suffixIcon: IconButton(
          icon: Icon(suffix),
          onPressed: () {
            suffixTap!();
          },
        ),
        prefixIcon: Icon(
          prefix,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        labelText: label,
      ),
      validator: (v) {
        return fct!(v);
      },
    ),
  );
}
Widget mainButton({
  required double width,
  FontWeight? fontWeight,
  required String text,required Color color,required BuildContext context,required Function fct}){
  return InkWell(
    onTap: () {
      fct();
      // if (key.currentState!.validate()) {
      //   navigateAndReplacement(
      //       context: context, child: OtpScreen());
      // }
    },
    child: Container(
      height: 6.h,
      width: width,
      decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(15)),
      child: Center(child: Text(
        text,
        // cubit.isRegister
        //     ? 'انشاء حساب'
        //     : 'ارسال كود تحقق',
        style: TextStyle(
            color: Colors.white,
            fontWeight: fontWeight,
            fontSize: 18.sp),
      ),),
    ),
  );

}
