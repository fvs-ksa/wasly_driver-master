import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:sizer/sizer.dart';

void showToast({required String text,required ToastState state})=>Fluttertoast.showToast(
    msg: text,
    toastLength: Toast.LENGTH_SHORT,
    gravity: ToastGravity.BOTTOM,
    timeInSecForIosWeb: 1,
    backgroundColor: chooseColor(state),
    textColor: Colors.white,
    fontSize: 16.0.sp
);
enum ToastState{SUCCESS,ERROR,WARNING}
Color chooseColor(ToastState state){
  Color color;
  switch(state){
    case ToastState.SUCCESS:
      color=Colors.green;
      break;
    case ToastState.WARNING:color=Colors.yellow;
    break;
    case ToastState.ERROR:color=Colors.red;
    break;
  }
  return color;

}
navigateTo({required BuildContext context, required Widget child}) {
  Navigator.of(context).push(MaterialPageRoute(builder: (context) => child));
}

navigateAndReplacement({required BuildContext context, required Widget child}) {
  Navigator.of(context)
      .pushReplacement(MaterialPageRoute(builder: (context) => child));
}

// Widget mainButton(
//     {required double width,
//       required double height,
//       FontWeight? fontWeight,
//       required String text,
//       required Color color,
//       required BuildContext context,
//       required Function fct}) {
//   return InkWell(
//     onTap: () {
//       fct();
//     },
//     child: Container(
//       height: height,
//       width: width,
//       child: Align(
//         alignment: Alignment.center,
//         child: Text(
//           textAlign: TextAlign.center,
//           text,
//           style: Theme.of(context).textTheme.button,
//         ),
//       ),
//       decoration:
//       BoxDecoration(color: color, borderRadius: BorderRadius.circular(15)),
//     ),
//   );
// }