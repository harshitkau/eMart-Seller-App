import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_seller_app/const/const.dart';
import 'package:ecommerce_seller_app/controller/product_controller.dart';
import 'package:ecommerce_seller_app/services/store_services.dart';
import 'package:ecommerce_seller_app/views/products/add_product.dart';
import 'package:ecommerce_seller_app/views/products/product_detail.dart';
import 'package:ecommerce_seller_app/views/widget/appbar_widget.dart';
import 'package:ecommerce_seller_app/views/widget/loadin_indecator_widget.dart';
import 'package:ecommerce_seller_app/views/widget/text_style.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProductScreen extends StatelessWidget {
  const ProductScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(ProductController());
    return Scaffold(
      appBar: appbarWidget(title: product),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await controller.getCategories();
          controller.populateCategoryList();
          Get.to(() => AddProduct());
        },
        child: Icon(
          Icons.add,
          color: white,
        ),
        backgroundColor: purpleColor,
      ),
      body: StreamBuilder(
        stream: StoreService.getProducts(currentUser!.uid),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: loadingIndicator(),
            );
          } else {
            var data = snapshot.data!.docs;
            return Padding(
              padding: EdgeInsets.all(8),
              child: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Column(
                  children: List.generate(
                    data.length,
                    (index) => ListTile(
                      onTap: () {
                        Get.to(() => ProductDetails(data: data[index]));
                      },
                      leading: Image.network(
                        data[index]['p_imgs'][0],
                        width: 100,
                        height: 100,
                        fit: BoxFit.contain,
                      ),
                      title: boldText(
                          text: "${data[index]['p_name']}", color: fontGrey),
                      subtitle: Row(
                        children: [
                          normalText(
                              text: "\$${data[index]["p_price"]}",
                              color: darkGrey,
                              size: 14.0),
                          15.widthBox,
                          boldText(
                              text:
                                  data[index]['is_featured'] ? "Featured" : '',
                              color: green),
                        ],
                      ),
                      trailing: VxPopupMenu(
                          child: Icon(Icons.more_vert_rounded),
                          menuBuilder: () => Column(
                                children: List.generate(
                                    popUpMenuTiles.length,
                                    (i) => Padding(
                                          padding: const EdgeInsets.all(12.0),
                                          child: Row(
                                            children: [
                                              Icon(
                                                popUpMenuIcons[i],
                                                color:
                                                    data[index]['featured_id'] ==
                                                                currentUser!
                                                                    .uid &&
                                                            i == 0
                                                        ? Colors.green
                                                        : darkGrey,
                                              ),
                                              10.widthBox,
                                              normalText(
                                                  text:
                                                      data[index]['featured_id'] ==
                                                                  currentUser!
                                                                      .uid &&
                                                              i == 0
                                                          ? "Removed Featured"
                                                          : popUpMenuTiles[i],
                                                  color: darkGrey)
                                            ],
                                          ).onTap(() {
                                            switch (i) {
                                              case 0:
                                                if (data[index]
                                                        ['is_featured'] ==
                                                    true) {
                                                  controller.removedFeatured(
                                                      data[index].id);
                                                  VxToast.show(context,
                                                      msg: "Removed");
                                                } else {
                                                  controller.addFeatured(
                                                      data[index].id);
                                                  VxToast.show(context,
                                                      msg: "Added");
                                                }
                                                break;

                                              case 1:
                                                break;
                                              case 2:
                                                controller.removeProduct(
                                                    data[index].id);

                                                VxToast.show(context,
                                                    msg: "Product Removed");
                                                break;
                                              default:
                                            }
                                          }),
                                        )),
                              ).box.white.rounded.width(200).make(),
                          clickType: VxClickType.singleClick),
                    ),
                  ),
                ),
              ),
            );
          }
        },
      ),
    );
  }
}
