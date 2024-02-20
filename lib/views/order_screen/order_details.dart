import 'package:ecommerce_seller_app/controller/orders_controller.dart';
import 'package:ecommerce_seller_app/views/widget/our_button.dart';
import 'package:ecommerce_seller_app/views/widget/text_style.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart' as intl;
import '../../const/const.dart';
import 'compnents/order_place_details.dart';

class OrderDetails extends StatefulWidget {
  final dynamic data;
  const OrderDetails({super.key, this.data});

  @override
  State<OrderDetails> createState() => _OrderDetailsState();
}

class _OrderDetailsState extends State<OrderDetails> {
  // var controller = Get.find<OrdersController>();
  var controller = Get.put(OrdersController());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller.getOrder(widget.data);
    controller.confirmed.value = widget.data['order_confirmed'];
    controller.onDelivery.value = widget.data['order_on_delivery'];
    controller.deliverd.value = widget.data['order_delivered'];
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
                icon: Icon(
                  Icons.arrow_back,
                  color: fontGrey,
                ),
                color: white),
            title: boldText(text: "Order Details", color: fontGrey, size: 16.0),
          ),
          backgroundColor: white,
          bottomNavigationBar: Visibility(
            visible: !controller.confirmed.value,
            child: SizedBox(
              height: 60,
              width: context.screenWidth,
              child: ourButton(
                  color: green,
                  onpress: () {
                    controller.confirmed(true);
                    controller.changeStatus(
                        title: "order_confirmed",
                        status: true,
                        docId: widget.data.id);
                  },
                  title: "Confirm Order"),
            ),
          ),
          body: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Column(
              children: [
                Visibility(
                  visible: controller.confirmed.value,
                  child: Column(
                    children: [
                      boldText(text: "Order Status", color: fontGrey),
                      SwitchListTile(
                        activeColor: green,
                        value: true,
                        onChanged: (value) {},
                        title: boldText(text: "Order Placed", color: darkGrey),
                      ),
                      SwitchListTile(
                        activeColor: green,
                        value: controller.confirmed.value,
                        onChanged: (value) {
                          controller.confirmed.value = value;
                        },
                        title: boldText(text: "Confirmed", color: darkGrey),
                      ),
                      SwitchListTile(
                        activeColor: green,
                        value: controller.onDelivery.value,
                        onChanged: (value) {
                          controller.onDelivery.value = value;
                          controller.changeStatus(
                              title: "order_on_delivery",
                              status: value,
                              docId: widget.data.id);
                        },
                        title: boldText(text: "On Delivery", color: darkGrey),
                      ),
                      SwitchListTile(
                        activeColor: green,
                        value: controller.deliverd.value,
                        onChanged: (value) {
                          controller.deliverd.value = value;
                          controller.changeStatus(
                              title: "order_delivered",
                              status: value,
                              docId: widget.data.id);
                        },
                        title: boldText(text: "Deliverd", color: darkGrey),
                      ),
                    ],
                  )
                      .box
                      .outerShadowMd
                      .white
                      .border(color: lightGrey)
                      .roundedSM
                      .make(),
                ),

                10.heightBox,
                Column(
                  children: [
                    OrderPlaceDetails(
                        title1: "Order Code",
                        detail1: "${widget.data['order_code']}",
                        title2: "Shipping Method",
                        detail2: "${widget.data['shipping_method']}"),
                    OrderPlaceDetails(
                        title1: "Order Date",
                        detail1: intl.DateFormat()
                            .add_yMd()
                            .format((widget.data['order_date'].toDate())),
                        // detail1: DateTime.now(),
                        title2: "Payment Method",
                        detail2: "${widget.data['payment_method']}"),
                    OrderPlaceDetails(
                        title1: "Payment Status",
                        detail1: "Unpaid",
                        title2: "Delivery Status",
                        detail2: "Order Placed"),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            width: context.screenWidth - 200,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // "Shipping Address"
                                //     .text
                                //     .fontFamily(semibold)
                                //     .make(),
                                boldText(
                                    text: "Shipping Address", color: darkGrey),
                                "${widget.data['order_by_name']}".text.make(),
                                "${widget.data['order_by_email']}".text.make(),
                                "${widget.data['order_by_address']}"
                                    .text
                                    .make(),
                                "${widget.data['order_by_city']}".text.make(),
                                "${widget.data['order_by_state']}".text.make(),
                                "${widget.data['order_by_phone']}".text.make(),
                                "${widget.data['order_by_postal_code']}"
                                    .text
                                    .make(),
                              ],
                            ),
                          ),
                          SizedBox(
                              width: 120,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  boldText(
                                      text: "Total Amount", color: purpleColor),
                                  boldText(
                                      text: "\$${widget.data['total_amount']}",
                                      color: red,
                                      size: 16.0)
                                ],
                              ))
                        ],
                      ),
                    )
                  ],
                )
                    .box
                    .outerShadowMd
                    .white
                    .border(color: lightGrey)
                    .roundedSM
                    .make(),
                10.heightBox,
                // "Ordered Product"
                //     .text
                //     .size(16)
                //     .color(darkFontGrey)
                //     .fontFamily(semibold)
                //     .make(),
                boldText(
                    text: "Ordered Product", size: 18.0, color: purpleColor),
                10.heightBox,
                ListView(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    children: List.generate(controller.orders.length, (index) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          OrderPlaceDetails(
                            title1: "${controller.orders[index]['title']}",
                            detail1:
                                "Quantity: ${controller.orders[index]['quantity']}",
                            title2:
                                "${controller.orders[index]['total_price']}",
                            detail2:
                                "Quantity: ${controller.orders[index]['quantity']}",
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 16),
                            child: Container(
                                width: 30,
                                height: 20,
                                color:
                                    Color(controller.orders[index]['color'])),
                          ),
                          Divider(),
                        ],
                      );
                    })).box.outerShadowMd.white.make(),
                30.heightBox,
              ],
            ),
          )),
    );
  }
}
