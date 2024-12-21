import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../common/util/app_util.dart';
import '../../../data/message_model.dart';
import '../../../data/native_bridge.dart';
import '../../../data/native_bridge_result.dart';
import '../../controller/app_controller.dart';
import '../../theme/app_color.dart';

enum ChatStatus {
  chatting,
  chatted,
}

class ChatController extends GetxController {
  final AppController appController = Get.find<AppController>();

  Rx<ChatStatus> currentChatStatus = ChatStatus.chatted.obs;

  TextEditingController textFieldController = TextEditingController();
  ScrollController listScrollController = ScrollController();

  RxList listMessage = <MessageModel>[].obs;

  RxList listMessageSendApi = <MessageModel>[].obs;
  RxList listSendApi = <String>[].obs;

  RxBool isTyping = false.obs;

  List<String> listSuggest = [
    "Heart rate",
    "Blood sugar",
    "Weight & BMI",
    "Calories",
    "Blood pressure",
    "Medicine",
  ];

  List<String> listSuggestContent = [
    "How are you feeling today? How can I help you?",
    "Do you have any questions about your health states?",
    "You are feeling unwell today. Tell me what's wrong?",
  ];

  String message = "";

  @override
  void onInit() {
    super.onInit();

    int indexMessage = Random().nextInt(listSuggestContent.length);
    message = listSuggestContent[indexMessage];
  }

  void onPressItemSuggest(int index) async {
    currentChatStatus.value = ChatStatus.chatting;

    isTyping.value = true;

    listMessage.add(
      MessageModel(
        messageContent: "What is ${listSuggest[index]}?",
        isSender: true,
      ),
    );

    if (listMessage.length <= 4) {
      listMessageSendApi.value = listMessage.sublist(0);
    } else {
      listMessageSendApi.value = listMessage.sublist(listMessage.length - 4);
    }

    listSendApi.value = listMessageSendApi
        .map((element) {
          return element.messageContent;
        })
        .toList()
        .cast<String>();

    NativeBridgeResult answer = await NativeBridge.getInstance().sendMessage(listSendApi as List<String>);

    listMessage.add(MessageModel(
      messageContent: answer.data as String,
      isSender: false,
    ));

    isTyping.value = false;
  }

  void onTapTextField() {
    if (listMessage.isEmpty) {
      int indexMessage = Random().nextInt(listSuggestContent.length);
      String message = listSuggestContent[indexMessage];

      listMessage.add(
        MessageModel(
          messageContent: message,
          isSender: false,
        ),
      );

      currentChatStatus.value = ChatStatus.chatting;
    }
  }

  Future<void> onPressSend() async {
    if (isTyping.value) {
      // Get.snackbar(
      //   "Error",
      //   "You cant send multiple messages at a time",
      //   backgroundColor: AppColor.red600,
      // );

      showToast("You can't send multiple messages at a time");
      return;
    }

    if (textFieldController.text.isEmpty) {
      // Get.snackbar(
      //   "Error",
      //   "Please type a message",
      //   backgroundColor: AppColor.red600,
      // );

      showToast("Please type a message");
      return;
    }

    try {
      isTyping.value = true;

      String message = textFieldController.text;
      textFieldController.clear();

      listMessage.add(MessageModel(
        messageContent: message,
        isSender: true,
      ));

      if (listMessage.length <= 4) {
        listMessageSendApi.value = listMessage.sublist(0);
      } else {
        listMessageSendApi.value = listMessage.sublist(listMessage.length - 4);
      }

      listSendApi.value = listMessageSendApi
          .map((element) {
            return element.messageContent;
          })
          .toList()
          .cast<String>();

      NativeBridgeResult answer = await NativeBridge.getInstance().sendMessage(listSendApi as List<String>);

      listMessage.add(MessageModel(
        messageContent: answer.data as String,
        isSender: false,
      ));

      textFieldController.text = "";

      final SharedPreferences prefs = await SharedPreferences.getInstance();
      int iCntSend = prefs.getInt("cnt_send") ?? 0;
      prefs.setInt("cnt_send", ++iCntSend);

      isTyping.value = false;
    } catch (error) {
      debugPrint("Error send message: ${error.toString()}");
      Get.snackbar(
        "Error",
        error.toString(),
        backgroundColor: AppColor.red600,
      );
    } finally {
      isTyping.value = false;
    }
  }
}
