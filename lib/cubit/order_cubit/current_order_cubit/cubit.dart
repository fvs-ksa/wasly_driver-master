import 'package:bloc/bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:wasly_driver/cubit/order_cubit/current_order_cubit/state.dart';

import '../../../component/general_component.dart';

class OrderDetailsBikerCubit extends Cubit<CurrentOrderDetailsState> {
  OrderDetailsBikerCubit() : super(InitialCurrentOrderDetailsState());

  static OrderDetailsBikerCubit get(context) => BlocProvider.of(context);

  int i = 0;

  String orderState = 'في الطريق الي المطعم';

  changeOrderState() {
    switch (i) {
      case 0:
        orderState = 'في المطعم';
        i++;
        showToast(
            text: 'تم اغيير حاله الطلب لدى العميل الي: ${orderState}',
            state: ToastState.SUCCESS);
        emit(ChangeCurrentOrderDetailsState());
        break;
      case 1:
        orderState = 'في الطريق اليك';
        i++;
        showToast(
            text: 'تم تغيير حاله الطلب لدى العميل الي: ${orderState}',
            state: ToastState.SUCCESS);
        emit(ChangeCurrentOrderDetailsState());
        break;
      case 2:
        orderState = 'تم تسليم الطلب وانتهاء الطلب';
        i++;
        showToast(
            text: 'تم تغيير حاله الطلب لدى العميل الي: ${orderState}',
            state: ToastState.SUCCESS);
        emit(ChangeCurrentOrderDetailsState());
        break;
    }
    return i;
  }

  // void openGoogleMap({required double lat, required double lng}) async {
  //   //  var uri = Uri.parse("google.navigation:q=$lat,$lng&mode=d");
  //   String googleMapUrl = 'https://www.google.com/maps/search/?api=1&query=$lat,$lng';
  //   if (await canLaunchUrl(Uri.parse(googleMapUrl))) {
  //     await launchUrl(Uri.parse(googleMapUrl));
  //   } else {
  //     showToast(text: LocaleKeys.We_cannot_access_the_location.tr(), state: ToastState.ERROR);
  //   }
  // }
}