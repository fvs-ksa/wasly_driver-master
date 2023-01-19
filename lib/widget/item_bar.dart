import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:wasly_driver/cubit/order_cubit/cubit.dart';

import '../constant/const_color.dart';
import '../cubit/general_cubit/cubit.dart';

class ItemBar extends StatelessWidget {
  late Color backgroundColor;
  late Color textColor;
  late String text;
  late int tabIndex;

  // const ItemBar({Key? key}) : super(key: key);
  ItemBar({required this.tabIndex, required this.text});

  @override
  Widget build(BuildContext context) {
    backgroundColor = tabIndex == OrderCubit.get(context).tabIndex
        ? redColor
        : Colors.white;
    textColor = tabIndex == OrderCubit.get(context).tabIndex
        ? Colors.white
        : Colors.black;
    return Container(
      padding: EdgeInsets.only(bottom: 5.sp),
      margin: const EdgeInsets.only(left: 2, right: 2),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: backgroundColor,
          border: Border.all(color: Colors.white)),
      width: MediaQuery.of(context).size.width * 0.28,
      alignment: Alignment.center,
      child: Text(
        text,
        style: TextStyle(
          fontSize: 16.sp,
          color: textColor,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
