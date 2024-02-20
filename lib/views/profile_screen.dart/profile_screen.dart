import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_seller_app/const/colors.dart';
import 'package:ecommerce_seller_app/const/const.dart';
import 'package:ecommerce_seller_app/controller/auth_controller.dart';
import 'package:ecommerce_seller_app/controller/profile_controller.dart';
import 'package:ecommerce_seller_app/services/store_services.dart';
import 'package:ecommerce_seller_app/views/auth_screen/login_screen.dart';
import 'package:ecommerce_seller_app/views/messages/message_screen.dart';
import 'package:ecommerce_seller_app/views/profile_screen.dart/edit_profile_screen.dart';
import 'package:ecommerce_seller_app/views/shop_screen/shop_settings_screen.dart';
import 'package:ecommerce_seller_app/views/widget/loadin_indecator_widget.dart';
import 'package:ecommerce_seller_app/views/widget/text_style.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(ProfileController());
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: boldText(text: settings, size: 16.0),
          actions: [
            IconButton(
                onPressed: () {
                  Get.to(() => EditProfileScreen(
                        username: controller.snapshotData['vendor_name'],
                      ));
                },
                icon: Icon(Icons.edit, color: white)),
            TextButton(
                onPressed: () async {
                  await Get.find<AuthController>().signOutMethod(context);
                  Get.offAll(() => LoginScreen());
                },
                child: normalText(text: logout))
          ],
        ),
        backgroundColor: purpleColor,
        body: FutureBuilder(
            future: StoreService.getProfile(currentUser!.uid),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (!snapshot.hasData) {
                return Center(child: loadingIndicator(circleColor: white));
              } else {
                controller.snapshotData = snapshot.data!.docs[0];
                return Column(children: [
                  ListTile(
                    leading: controller.snapshotData['imageUrl'] == ""
                        ? Image.asset(usericon, fit: BoxFit.cover)
                            .box
                            .roundedFull
                            .width(100)
                            .clip(Clip.antiAlias)
                            .make()
                        : Image.network(controller.snapshotData['imageUrl'],
                                fit: BoxFit.cover)
                            .box
                            .roundedFull
                            .width(100)
                            .clip(Clip.antiAlias)
                            .make(),
                    title: boldText(
                        text: "${controller.snapshotData['vendor_name']}"),
                    subtitle:
                        normalText(text: "${controller.snapshotData['email']}"),
                  ),
                  Divider(
                    color: darkGrey,
                  ),
                  Padding(
                    padding: EdgeInsets.all(8),
                    child: Column(
                        children: List.generate(
                            profileButtonIcons.length,
                            (index) => ListTile(
                                  onTap: () {
                                    switch (index) {
                                      case 0:
                                        Get.to(() => ShopSettingsScreen());
                                      case 1:
                                        Get.to(() => MessageScreen());

                                        break;
                                      default:
                                    }
                                  },
                                  leading: Icon(
                                    profileButtonIcons[index],
                                    color: white,
                                  ),
                                  title: normalText(
                                      text: profileButtonTitles[index]),
                                ))),
                  )
                ]);
              }
            }));
  }
}
