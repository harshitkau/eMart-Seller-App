import 'dart:io';

import 'package:ecommerce_seller_app/const/const.dart';
import 'package:ecommerce_seller_app/controller/profile_controller.dart';
import 'package:ecommerce_seller_app/views/widget/custom_textfield.dart';
import 'package:ecommerce_seller_app/views/widget/loadin_indecator_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../widget/text_style.dart';

class EditProfileScreen extends StatefulWidget {
  final String? username;
  const EditProfileScreen({super.key, this.username});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  var controller = Get.find<ProfileController>();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller.nameController.text = widget.username!;
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        appBar: AppBar(
          leading: IconButton(
              onPressed: () {
                Get.back();
              },
              icon: Icon(Icons.arrow_back),
              color: white),
          title: boldText(text: editprofile, size: 16.0),
          actions: [
            controller.isloading.value
                ? Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: loadingIndicator(circleColor: white),
                  )
                : TextButton(
                    onPressed: () async {
                      controller.isloading(true);

                      // if image is not selected
                      if (controller.profileImagePath.value.isNotEmpty) {
                        await controller.uploadProfileImage();
                      } else {
                        controller.profileImageLink =
                            controller.snapshotData['imageUrl'];
                      }
                      // if old password is matched with database
                      if (controller.snapshotData['password'] ==
                          controller.oldpassController.text) {
                        await controller.changeAuthPassword(
                            email: controller.snapshotData['email'],
                            password: controller.oldpassController.text,
                            newPassword: controller.newpassController.text);
                        await controller.updateProfile(
                            imgUrl: controller.profileImageLink,
                            name: controller.nameController.text,
                            password: controller.newpassController.text);
                        VxToast.show(context, msg: "Updated");
                      } else if (controller
                              .oldpassController.text.isEmptyOrNull &&
                          controller.newpassController.text.isEmptyOrNull) {
                        await controller.updateProfile(
                            imgUrl: controller.profileImageLink,
                            name: controller.nameController.text,
                            password: controller.snapshotData['password']);
                        VxToast.show(context, msg: "Updated");
                      } else {
                        VxToast.show(context, msg: "Wrong Old Password");
                        controller.isloading(false);
                      }
                    },
                    child: normalText(text: save))
          ],
        ),
        backgroundColor: purpleColor,
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(8),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  controller.snapshotData['imageUrl'] == '' &&
                          controller.profileImagePath.isEmpty
                      ? Image.asset(usericon, width: 100, fit: BoxFit.cover)
                          .box
                          .roundedFull
                          .clip(Clip.antiAlias)
                          .make()
                      : controller.snapshotData['imageUrl'] != '' &&
                              controller.profileImagePath.isEmpty
                          ? Image.network(controller.snapshotData['imageUrl'],
                                  width: 100, fit: BoxFit.cover)
                              .box
                              .roundedFull
                              .clip(Clip.antiAlias)
                              .make()
                          : Image.file(File(controller.profileImagePath.value),
                                  width: 100, fit: BoxFit.cover)
                              .box
                              .roundedFull
                              .clip(Clip.antiAlias)
                              .make(),
                  // Image.asset(
                  //   imgProduct,
                  //   width: 150,
                  // ).box.roundedFull.clip(Clip.antiAlias).make(),
                  10.heightBox,
                  ElevatedButton(
                      onPressed: () {
                        controller.changeImage(context);
                      },
                      child: normalText(text: "Change Image", color: fontGrey)),
                  10.heightBox,
                  Divider(
                    color: darkGrey,
                  ),
                  10.heightBox,
                  customTextField(
                      title: name,
                      hint: "eg. Harshit Kumar Kaushal",
                      controller: controller.nameController),
                  10.heightBox,
                  Align(
                      alignment: Alignment.centerLeft,
                      child: boldText(text: "Change your password")),
                  10.heightBox,
                  customTextField(
                      title: password,
                      hint: passwordHint,
                      controller: controller.oldpassController),
                  10.heightBox,
                  customTextField(
                      title: confirmpassword,
                      hint: passwordHint,
                      controller: controller.newpassController),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
