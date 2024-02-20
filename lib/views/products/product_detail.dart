import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../const/const.dart';
import '../widget/text_style.dart';

class ProductDetails extends StatelessWidget {
  final dynamic data;
  const ProductDetails({super.key, this.data});

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
        title: boldText(text: data['p_name'], color: fontGrey, size: 16.0),
      ),
      backgroundColor: white,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            VxSwiper.builder(
                height: 350,
                autoPlay: true,
                aspectRatio: 16 / 9,
                viewportFraction: 1.00,
                itemCount: data["p_imgs"].length,
                itemBuilder: (context, index) {
                  return Image.network(data["p_imgs"][index],
                      width: double.infinity, fit: BoxFit.cover);
                }),
            10.heightBox,
            Padding(
              padding: EdgeInsets.all(8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  boldText(
                      text: "${data["p_name"]}", color: fontGrey, size: 16.0),
                  Row(
                    children: [
                      boldText(text: "${data['p_category']}", color: fontGrey),
                      10.widthBox,
                      normalText(
                          text: "${data['p_subcategory']}", color: fontGrey),
                    ],
                  ),
                  10.heightBox,
                  VxRating(
                    isSelectable: false,
                    value: double.parse(data['p_rating']),
                    onRatingUpdate: (value) {},
                    normalColor: textfieldGrey,
                    selectionColor: golden,
                    count: 5,
                    size: 25,
                    maxRating: 5,
                  ),
                  10.heightBox,
                  // "${data['p_price']}"
                  //     .numCurrency
                  //     .text
                  //     .color(redColor)
                  //     .fontFamily(bold)
                  //     .size(18)
                  //     .make(),
                  boldText(
                      text: "\$${data['p_price']}", color: red, size: 18.0),
                  10.heightBox,

                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          SizedBox(
                            width: 100,
                            child: boldText(text: "Color :", color: fontGrey),
                            // child: "Color: ".text.color(textfieldGrey).make(),
                          ),
                          Row(
                            children: List.generate(
                              data['p_colors'].length,
                              (index) => VxBox()
                                  .size(40, 40)
                                  .roundedFull
                                  .color(Color(data['p_colors'][index]))
                                  .margin(EdgeInsets.symmetric(horizontal: 6))
                                  .make()
                                  .onTap(() {}),
                            ),
                          )
                        ],
                      ).box.padding(EdgeInsets.all(8)).make(),
                      // quantity row

                      Row(
                        children: [
                          SizedBox(
                              width: 100,
                              child:
                                  boldText(text: "Quantity :", color: fontGrey)
                              // "Quantity: ".text.color(textfieldGrey).make(),
                              ),
                          SizedBox(
                              width: 100,
                              child: normalText(
                                  text: "${data['p_quantity']} items",
                                  color: fontGrey)),
                        ],
                      ),
                    ],
                  ).box.white.padding(EdgeInsets.all(8)).shadowSm.make(),

                  // Divider(),
                  20.heightBox,
                  boldText(text: description, color: fontGrey),
                  10.heightBox,
                  normalText(text: "${data['p_desc']}", color: darkGrey)
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
