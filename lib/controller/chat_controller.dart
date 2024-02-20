import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_seller_app/const/firebase_const.dart';
import 'package:ecommerce_seller_app/controller/home_controller.dart';
import 'package:get/get.dart';

import '../const/const.dart';

class ChatsController extends GetxController {
  @override
  void onInit() {
    getChatId();
    super.onInit();
  }

  var chats = firestore.collection(chatsCollection);
  var senderName = Get.arguments[0];
  var sendorId = Get.arguments[1];

  var friendName = Get.find<HomeController>().username;
  var currentId = currentUser!.uid;

  var msgController = TextEditingController();
  dynamic chatDocId;

  var isLoading = false.obs;

  getChatId() async {
    isLoading(true);
    await chats
        .where('users', isEqualTo: {sendorId: null, currentId: null})
        .limit(1)
        .get()
        .then(
          (QuerySnapshot snapshot) {
            if (snapshot.docs.isNotEmpty) {
              chatDocId = snapshot.docs.single.id;
            } else {
              chats.add({
                'created_on': null,
                'last_msg': '',
                'users': {sendorId: null, currentId: null},
                'toId': sendorId,
                'friend_name': friendName,
                'sender_name': senderName,
              }).then((value) {
                chatDocId = value.id;
              });
            }
          },
        );
    isLoading(false);
  }

  sendMsg(String msg) async {
    if (msg.trim().isNotEmpty) {
      chats.doc(chatDocId).update({
        'created_on': FieldValue.serverTimestamp(),
        'last_msg': msg,
        'toId': currentId,
        'fromId': sendorId,
      });

      chats.doc(chatDocId).collection(messagesCollection).doc().set({
        'created_on': FieldValue.serverTimestamp(),
        'msg': msg,
        'uid': currentId,
      });
    }
  }

  removeChat(docsId, context) async {
    await firestore.collection(productsCollection).doc(docsId).set({
      'fromId': FieldValue.arrayRemove([currentUser!.uid])
    }, SetOptions(merge: true));
    VxToast.show(context, msg: "Chat Deleted");
  }
}
