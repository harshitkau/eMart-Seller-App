import 'package:ecommerce_seller_app/controller/product_controller.dart';
import 'package:ecommerce_seller_app/views/products/components/product_dropdown.dart';
import 'package:ecommerce_seller_app/views/products/components/product_images.dart';
import 'package:ecommerce_seller_app/views/products/products_screen.dart';
import 'package:ecommerce_seller_app/views/widget/custom_textfield.dart';
import 'package:ecommerce_seller_app/views/widget/loadin_indecator_widget.dart';
import 'package:ecommerce_seller_app/views/widget/text_style.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../const/const.dart';

class AddProduct extends StatelessWidget {
  const AddProduct({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<ProductController>();
    return Obx(
      () => Scaffold(
        appBar: AppBar(
          leading: IconButton(
              onPressed: () {
                Get.back();
              },
              icon: Icon(
                Icons.arrow_back,
              ),
              color: white),
          title: boldText(text: "Add Product", size: 16.0),
          actions: [
            controller.isloading.value
                ? loadingIndicator(circleColor: white)
                : TextButton(
                    onPressed: () async {
                      controller.isloading(true);
                      await controller.uploadImages();
                      await controller.addColors();
                      await controller.uploadProduct(context);

                      Get.off(() => ProductScreen());
                    },
                    child: boldText(text: save),
                  )
          ],
        ),
        backgroundColor: purpleColor,
        body: Padding(
          padding: EdgeInsets.all(8),
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                customTextField(
                    hint: "eg. Toys",
                    title: "Product Name",
                    controller: controller.pnameController),
                10.heightBox,
                customTextField(
                    hint: "eg. Nice Product",
                    title: "Description",
                    isDes: true,
                    controller: controller.pDescController),
                10.heightBox,
                customTextField(
                    hint: "eg. \$100",
                    title: "Price",
                    controller: controller.pPriceController),
                10.heightBox,
                customTextField(
                    hint: "eg. 100",
                    title: "Quantity",
                    controller: controller.pQuantiyController),
                // 10.heightBox,
                // customTextField(
                //     title: "eg. Nice Product", hint: "Description", isDes: true),
                10.heightBox,
                productDropdown("Category", controller.categoryList,
                    controller.categoryValue, controller),
                10.heightBox,
                productDropdown("Sub Category", controller.subCategoryList,
                    controller.subCategoryValue, controller),

                10.heightBox,
                Divider(color: darkGrey),
                10.heightBox,

                boldText(text: "Choose product Images"),
                10.heightBox,
                Obx(
                  () => Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: List.generate(
                      3,
                      (index) => controller.pImagesList[index] != null
                          ? Image.file(
                              controller.pImagesList[index],
                              width: context.width / 4,
                              height: 100,
                              fit: BoxFit.cover,
                            ).onTap(() {
                              controller.pickImage(context, index);
                            })
                          : productImages(label: "${index + 1}").onTap(() {
                              controller.pickImage(context, index);
                            }),
                    ),
                  ),
                ),
                10.heightBox,
                normalText(
                    text: "First Image will be your display Image ",
                    color: lightGrey),
                10.heightBox,
                Divider(color: darkGrey),
                10.heightBox,
                boldText(text: "Choose Product Color"),
                10.heightBox,
                // Obx(
                //   () => Wrap(
                //     spacing: 10.0,
                //     runSpacing: 10.0,
                //     children: List.generate(
                //       9,
                //       (index) => Stack(
                //         alignment: Alignment.center,
                //         children: [
                //           VxBox()
                //               .color(productColor[index])
                //               .roundedFull
                //               .size(50, 50)
                //               .make()
                //               .onTap(() {

                //           }),
                //           controller.selectedColorIndex.value == index
                //               ? Icon(
                //                   Icons.done,
                //                   color: Colors.black,
                //                 )
                //               : SizedBox()
                //         ],
                //       ),
                //     ),
                //   ),
                // )

                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: controller.availableColors
                        .map((color) => _buildColorTile(color, controller))
                        .toList(),
                  ),
                ),

                Padding(
                  padding: EdgeInsets.all(10),
                  child: Text(
                    'Selected Colors:',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(
                  height: 100,
                  width: 100,
                  child: GetX<ProductController>(
                    builder: (controller) => ListView.builder(
                      itemCount: controller.selectedColorsList.length,
                      itemBuilder: (context, index) {
                        return _buildColorTile(
                            controller.selectedColorsList[index], controller);
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildColorTile(Color color, ProductController controller) {
    return GestureDetector(
      onTap: () {
        if (controller.selectedColorsList.length < 3 ||
            controller.selectedColorsList.contains(color)) {
          controller.toggleColorSelection(color);
        }
      },
      child: Container(
        width: 50,
        height: 50,
        margin: EdgeInsets.all(5),
        decoration: BoxDecoration(
          color: color,
          border: Border.all(
            color: controller.selectedColorsList.contains(color)
                ? Colors.black
                : Colors.transparent,
            width: 2,
          ),
        ),
      ),
    );
  }
}
