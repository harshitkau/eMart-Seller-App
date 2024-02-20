// import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_seller_app/const/const.dart';
import 'package:ecommerce_seller_app/const/strings.dart';
import 'package:ecommerce_seller_app/services/store_services.dart';
import 'package:ecommerce_seller_app/views/messages/chat_screen.dart';
import 'package:ecommerce_seller_app/views/widget/loadin_indecator_widget.dart';
import 'package:ecommerce_seller_app/views/widget/text_style.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart' as intl;
import '../../const/colors.dart';

class MessageScreen extends StatelessWidget {
  const MessageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: Icon(
              Icons.arrow_back,
              color: fontGrey,
            ),
            color: white),
        title: boldText(text: message, color: fontGrey, size: 16.0),
      ),
      backgroundColor: white,
      body: StreamBuilder(
        stream: StoreService.getMessages(currentUser!.uid),
        builder: (BuildContext context,
            AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
          if (!snapshot.hasData) {
            return Center(child: loadingIndicator());
          } else {
            var data = snapshot.data!.docs;
            return SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Column(
                children: List.generate(data.length, (index) {
                  var t = data[index]['created_on'] == null
                      ? DateTime.now()
                      : data[index]['created_on'].toDate();
                  var time = intl.DateFormat("h:mma").format(t);
                  return ListTile(
                    onTap: () {
                      Get.to(() => ChatScreen(), arguments: [
                        data[index]['sender_name'],
                        data[index]['fromId']
                      ]);
                    },
                    leading: CircleAvatar(
                      backgroundColor: purpleColor,
                      child: Icon(
                        Icons.person,
                        color: white,
                      ),
                    ),
                    title: boldText(
                        text: "${data[index]['sender_name']}", color: fontGrey),
                    subtitle: normalText(
                        text: "${data[index]['last_msg']}", color: darkGrey),
                    trailing: normalText(text: time, color: darkGrey),
                  );
                }),
              ),
            );
          }
        },
      ),
    );
  }
}
