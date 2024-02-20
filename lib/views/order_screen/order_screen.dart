import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_seller_app/const/const.dart';
import 'package:ecommerce_seller_app/services/store_services.dart';
import 'package:ecommerce_seller_app/views/order_screen/order_details.dart';
import 'package:ecommerce_seller_app/views/widget/appbar_widget.dart';
import 'package:ecommerce_seller_app/views/widget/loadin_indecator_widget.dart';
import 'package:ecommerce_seller_app/views/widget/text_style.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart' as intl;

class OrderScreen extends StatelessWidget {
  const OrderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appbarWidget(title: orders),
      body: StreamBuilder(
        stream: StoreService.getOrders(currentUser!.uid),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData)
            return Center(
              child: loadingIndicator(),
            );
          else if (snapshot.data!.docs.isEmpty) {
            return Center(
              child: "No Orders Available".text.semiBold.color(fontGrey).make(),
            );
          } else {
            var data = snapshot.data!.docs;
            return Padding(
              padding: EdgeInsets.all(8),
              child: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Column(
                  children: List.generate(data.length, (index) {
                    var time = data[index]['order_date'].toDate();

                    return ListTile(
                      onTap: () {
                        Get.to(() => OrderDetails(data: data[index]));
                      },
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12)),
                      tileColor: textfieldGrey,
                      title: boldText(
                          text: "${data[index]['order_code']}",
                          color: fontGrey),
                      subtitle: Column(
                        children: [
                          Row(
                            children: [
                              Icon(
                                Icons.calendar_month,
                                color: fontGrey,
                              ),
                              10.widthBox,
                              boldText(
                                  color: darkGrey,
                                  text: intl.DateFormat.yMd()
                                      .add_jm()
                                      .format(time))
                            ],
                          ),
                          Row(
                            children: [
                              Icon(
                                Icons.payment,
                                color: fontGrey,
                              ),
                              10.widthBox,
                              boldText(text: unpaid, color: red)
                            ],
                          ),
                        ],
                      ),
                      trailing: boldText(
                          text: "\$${data[index]["total_amount"]}",
                          color: purpleColor,
                          size: 16.0),
                    ).box.margin(EdgeInsets.only(bottom: 5)).make();
                  }),
                ),
              ),
            );
          }
        },
      ),
    );
  }
}
