import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';
import 'package:wasly_driver/cubit/order_cubit/cubit.dart';
import 'package:wasly_driver/cubit/order_cubit/state.dart';
import 'package:wasly_driver/ui/main_screen/tab_bar_screen/current_order.dart';
import 'package:wasly_driver/ui/main_screen/tab_bar_screen/new_order.dart';
import 'package:wasly_driver/ui/main_screen/tab_bar_screen/previous_screen.dart';
import 'package:wasly_driver/widget/item_bar.dart';

import '../../constant/const_color.dart';

class OrderScreen extends StatefulWidget {
  const OrderScreen({Key? key}) : super(key: key);

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen>
    with TickerProviderStateMixin {
  late TabController controller;

  _setActiveTap() {
    OrderCubit.get(context).changeTabBar(value: controller.index);
  }

  @override
  void initState() {
    controller = TabController(
        length: 3, vsync: this, initialIndex: OrderCubit.get(context).tabIndex);
    controller.addListener(_setActiveTap);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<OrderCubit, OrderState>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            elevation: 0,
            bottom: PreferredSize(
              preferredSize:
                  Size.fromHeight(MediaQuery.of(context).size.height * 0.03),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 4.w),
                child: Card(
                  elevation: 3,
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Container(
                  //  height: 15.h,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: Colors.white),
                    ),
                    child: TabBar(
                      physics: const BouncingScrollPhysics(),
                      controller: controller,
                      labelPadding: const EdgeInsets.all(8),
                      labelColor: redColor,
                      indicatorWeight: 0.8,
                      unselectedLabelColor: Colors.black,
                      isScrollable: true,
                      onTap: (int i) {},
                      tabs: [
                        Tab(
                          child: ItemBar(tabIndex: 0, text: 'الجديده'),
                        ),
                        Tab(
                          child: ItemBar(tabIndex: 1, text: 'الحاليه'),
                        ),
                        Tab(
                          child: ItemBar(tabIndex: 2, text: 'السابقه'),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
          body: Align(
            alignment: Alignment.topCenter,
            child: TabBarView(controller: controller, children: const [
              NewOrderScreen(),
              CurrentOrderScreen(),
              PreviousOrderScreen(),
            ]),
          ),
        );
      },
    );
  }
}
