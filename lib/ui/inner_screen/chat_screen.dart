import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sizer/sizer.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../../constant/const_color.dart';
import '../../cubit/chat_cubit/cubit.dart';
import '../../cubit/chat_cubit/state.dart';


class Constants {
  static const String FirstItem = 'الغاء الطلب';

  // static const String SecondItem = 'Second Item';
  // static const String ThirdItem = 'Third Item';

  static const List<String> choices = <String>[
    FirstItem,
    // SecondItem,
    // ThirdItem,
  ];
}

void choiceAction(String choice) {
  if (choice == Constants.FirstItem) {
    print('Cancel Success');
  }
  // } else if (choice == Constants.SecondItem) {
  //   print('I Second Item');
  // } else if (choice == Constants.ThirdItem) {
  //   print('I Third Item');
  // }
}

class ChatScreen extends StatelessWidget {
  // int index;
  // String phone;
  // String image;
  // String name;
  //
  // ChatScreen(
  //     {Key? key,
  //       required this.index,
  //       required this.phone,
  //       required this.name,
  //       required this.image})
  //     : super(key: key);
  TextEditingController messageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Size size=MediaQuery.of(context).size;
    var chatCubit = ChatCubit.get(context);
    return BlocConsumer<ChatCubit, ChatState>(
      listener: (context, state) {},
      builder: (context, state) {
        return Directionality(
          textDirection: TextDirection.rtl,
          child: Scaffold(
            appBar: AppBar(
              actions: [
                PopupMenuButton<String>(
                    icon: Icon(Icons.more_vert),
                    onSelected: choiceAction,
                    itemBuilder: (BuildContext context) {
                      return Constants.choices.map((String e) {
                        return PopupMenuItem<String>(
                          child: Text(e),
                          value: e,
                        );
                      }).toList();
                    }),
              ],
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 14.sp,
                        backgroundImage: NetworkImage(''),
                      ),
                      SizedBox(
                        width: 3.w,
                      ),
                      Text(
                        'احمد علي',
                        style: TextStyle(fontSize:size.height>1000?8.sp: 15.sp, color: Colors.white),
                      ),
                    ],
                  ),
                  IconButton(
                      onPressed: () async {
                        await launchUrlString('tel:${0506632217}');
                      },
                      icon: FaIcon(
                        FontAwesomeIcons.phone,
                        color: Colors.white,
                        size:size.height>1000?8.sp: 15.sp,
                      ))
                ],
              ),
            ),
            body: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Padding(
                padding: EdgeInsets.all(8.0.sp),
                child: ListView.separated(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  separatorBuilder: (context, index) {
                    return SizedBox(
                      height: 2.h,
                    );
                  },
                  itemBuilder: (context, index) {
                    // return Align(
                    //   alignment: AlignmentDirectional.topStart,
                    //   child: Container(
                    //     //height: 5.h,
                    //
                    //    // width: 1,
                    //     child: Center(child: Text(customOrderCubit.messages[index],overflow: TextOverflow.ellipsis,)),
                    //
                    //     decoration: BoxDecoration(
                    //         borderRadius: BorderRadius.only(
                    //             topLeft: Radius.circular(15.sp),
                    //             bottomRight: Radius.circular(15.sp),
                    //             bottomLeft: Radius.circular(15.sp)),
                    //         color: Colors.redAccent.shade100),
                    //   ),
                    // );
                    return Align(
                      alignment: AlignmentDirectional.centerStart,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 5),
                        decoration: BoxDecoration(
                          color: Colors.grey[300],
                          borderRadius: const BorderRadiusDirectional.only(
                            bottomEnd: Radius.circular(10),
                            topEnd: Radius.circular(10),
                            topStart: Radius.circular(10),
                          ),
                        ),
                        child:
                        Text(
                          chatCubit.messages[index],
                          style: TextStyle(fontSize: 12.sp),
                        ),
                      ),
                    );
                  },
                  itemCount: chatCubit.messages.length,
                ),
              ),
            ),
            bottomNavigationBar: Padding(
              padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom,
                  right: 5.w,
                  left: 5.w),
              child: Container(
                height: chatCubit.pickImage ? 32.h : 12.h,
                width: MediaQuery.of(context).size.width,
                // color: Colors.green,
                child: Column(
                  children: [
                    //Spacer(flex: 1,),
                    chatCubit.pickImage
                        ? Stack(
                      children: [
                        Align(
                          alignment: Alignment.bottomLeft,
                          child: Container(
                            height: 20.h,
                            width: 40.w,
                            // decoration: BoxDecoration(border: Border.all(color: redColor)),
                            child: Stack(
                              children: [
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 3.w, vertical: 1.h),
                                  child: Container(
                                    height: 16.h,
                                    width: 33.w,
                                    decoration: BoxDecoration(
                                      // border: Border.all(color: Colors.green),
                                        borderRadius:
                                        BorderRadius.circular(20),
                                        image: DecorationImage(
                                            image: FileImage(
                                              chatCubit.file!,
                                            ),
                                            fit: BoxFit.cover)),
                                  ),
                                ),
                                Positioned(
                                  top: 1.h,
                                  left: 1.5.w,
                                  child: GestureDetector(
                                    onTap: () {
                                      chatCubit.clearImage();
                                    },
                                    child: CircleAvatar(
                                        radius: 10.sp,
                                        backgroundColor: redColor,
                                        child: FaIcon(
                                          FontAwesomeIcons.remove,
                                          color: Colors.white,
                                        )),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    )
                        : Container(),
                    SizedBox(
                      height: 1.h,
                    ),
                    Row(
                      children: [
                        FloatingActionButton(
                          onPressed: () {
                            // if (customOrderCubit.pickImage == true) {
                            //   customOrderCubit.sentImage(customOrderCubit.file);
                            //   customOrderCubit.clearImage();
                            // }
                            //else
                            //  {
                            messageController.text.isEmpty
                                ? debugPrint('text')
                                : chatCubit
                                .sentMessage(messageController.text);
                            messageController.clear();
                            // }
                          },
                          child: FaIcon(
                            FontAwesomeIcons.paperPlane,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(
                          width: 3.w,
                        ),
                        //  CircleAvatar(radius: 20.sp,child: IconButton(onPressed: (){}, icon: Icon(Icons.add_photo_alternate))),
                        // SizedBox(width: 3.w,),
                        Expanded(
                            child: TextFormField(
                              controller: messageController,
                              decoration: InputDecoration(
                                  hintText: 'رساله',
                                  prefixIcon: IconButton(
                                      onPressed: () {
                                        chatCubit.pickGalleryImage(context);
                                        print('object');
                                      },
                                      icon:
                                      Icon(Icons.add_photo_alternate_outlined)),
                                  hintStyle: TextStyle(
                                    color: redColor,
                                  ),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20),
                                    borderSide: BorderSide(color: redColor),
                                  )),
                            )),
                      ],
                    ),
                    SizedBox(
                      height: 0.2.h,
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
