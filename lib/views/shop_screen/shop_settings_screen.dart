import 'package:ecommerce_seller_app/controller/profile_controller.dart';
import 'package:ecommerce_seller_app/views/widget/custom_textfield.dart';
import 'package:ecommerce_seller_app/views/widget/loadin_indecator_widget.dart';
import 'package:get/get.dart';
import '../../const/const.dart';
import '../widget/text_style.dart';

class ShopSettingsScreen extends StatelessWidget {
  const ShopSettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<ProfileController>();
    return Obx(
      () => Scaffold(
        appBar: AppBar(
          leading: IconButton(
              onPressed: () {
                Get.back();
              },
              icon: Icon(Icons.arrow_back),
              color: white),
          title: boldText(text: shopSettings, size: 16.0),
          actions: [
            controller.isloading.value
                ? loadingIndicator(circleColor: white)
                : TextButton(
                    onPressed: () async {
                      controller.isloading(true);
                      await controller.updateShop(
                        shopName: controller.shopNameController.text,
                        shopAddress: controller.shopAddressController.text,
                        shopMobile: controller.shopMobileController.text,
                        shopDesc: controller.shopDescController.text,
                        shopWeb: controller.shopWebsiteController.text,
                      );

                      VxToast.show(context, msg: "Shop Updated");
                    },
                    child: normalText(text: save))
          ],
        ),
        backgroundColor: purpleColor,
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                customTextField(
                    title: shopname,
                    hint: nameHint,
                    controller: controller.shopNameController),
                10.heightBox,
                customTextField(
                    title: shopaddress,
                    hint: shopAddressHint,
                    controller: controller.shopAddressController),
                10.heightBox,
                customTextField(
                    title: mobile,
                    hint: shopMobileHint,
                    controller: controller.shopMobileController),
                10.heightBox,
                customTextField(
                    title: website,
                    hint: shopWebsiteHint,
                    controller: controller.shopWebsiteController),
                10.heightBox,
                customTextField(
                    title: description,
                    hint: shopDescHint,
                    isDes: true,
                    controller: controller.shopDescController),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
