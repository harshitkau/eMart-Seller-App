import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:ecommerce_seller_app/const/const.dart';
import 'package:ecommerce_seller_app/controller/chat_controller.dart';
import 'package:ecommerce_seller_app/services/store_services.dart';
import 'package:ecommerce_seller_app/views/messages/component/chat_bubble.dart';
import 'package:ecommerce_seller_app/views/widget/loadin_indecator_widget.dart';
import 'package:ecommerce_seller_app/views/widget/text_style.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(ChatsController());
    return Scaffold(
        backgroundColor: white,
        appBar: AppBar(title: boldText(text: controller.senderName)),
        body: Obx(
          () => Padding(
            padding: EdgeInsets.all(12),
            child: Column(
              children: [
                controller.isLoading.value
                    ? Center(child: loadingIndicator())
                    : Expanded(
                        child: StreamBuilder(
                          stream: StoreService.getChatsMessages(
                              controller.chatDocId.toString()),
                          builder: (BuildContext context,
                              AsyncSnapshot<QuerySnapshot> snapshot) {
                            if (!snapshot.hasData) {
                              return Center(child: loadingIndicator());
                            } else if (snapshot.data!.docs.isEmpty) {
                              return Center(
                                  child: "Send a message..."
                                      .text
                                      .color(darkGrey)
                                      .make());
                            } else {
                              return ListView(
                                  children: snapshot.data!.docs
                                      .mapIndexed((currentValue, index) {
                                var data = snapshot.data!.docs[index];

                                return Align(
                                  alignment: data['uid'] == currentUser!.uid
                                      ? Alignment.centerRight
                                      : Alignment.centerLeft,
                                  child: senderBubble(data),
                                );
                              }).toList());
                            }
                          },
                        ),
                      ),
                10.heightBox,
                Row(
                  children: [
                    Expanded(
                        child: TextFormField(
                      controller: controller.msgController,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(
                            borderSide: BorderSide(color: textfieldGrey)),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: textfieldGrey)),
                        hintText: "Type a message...",
                      ),
                    )),
                    IconButton(
                        onPressed: () {
                          controller.sendMsg(controller.msgController.text);
                          controller.msgController.clear();
                        },
                        icon: Icon(
                          Icons.send,
                          color: purpleColor,
                        ))
                  ],
                )
                    .box
                    .height(80)
                    .padding(EdgeInsets.all(12))
                    .margin(EdgeInsets.only(bottom: 8))
                    .make()
              ],
            ),
          ),
        ));
  }
}
