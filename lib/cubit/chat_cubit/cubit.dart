import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

import 'package:wasly_driver/cubit/chat_cubit/state.dart';

class ChatCubit extends Cubit<ChatState>{
  ChatCubit():super(InitialChatState());
  static ChatCubit get(context)=>BlocProvider.of(context);


  File? file;
  bool pickImage=false;
  // pickCameraImage(BuildContext context)async{
  //   final XFile? pickedFile=await ImagePicker().pickImage(source: ImageSource.camera);
  //   file=(File(pickedFile!.path));
  //   pickImage=true;
  //   emit(PickImageChatGalleryState());
  //   Navigator.pop(context);
  // }
  pickGalleryImage(BuildContext context)async{
    final XFile? pickedFile=await ImagePicker().pickImage(source: ImageSource.gallery);
    file=(File(pickedFile!.path));
    pickImage=true;
    emit(PickImageChatGalleryState());
    //Navigator.pop(context);
  }
  clearImage(){
    pickImage=false;
    emit(ClearImageChatState());
  }


  List<dynamic> messages = [];
  //static String? textMessage;
  sentMessage(String message)async{
    //  textMessage=message;
    messages.add(message);
    emit(SentTextMessageSuccessState());
  }
// List<File>images=[];
  bool isSent=false;
//   String? photo;
  sentImage(File? image)async{
    isSent=true;
    // photo=image?.path;
    messages.add(image);

    print(messages.length);;
    emit(SentImageMessageSuccessState());
    isSent=false;

    // Uint8List? bytes = image?.readAsBytesSync();
    // String base64Image = base64Encode(bytes!);
    // print(base64Image);
  }


}