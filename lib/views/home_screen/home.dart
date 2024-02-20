import 'package:ecommerce_seller_app/const/const.dart';
import 'package:ecommerce_seller_app/controller/home_controller.dart';
import 'package:ecommerce_seller_app/views/home_screen/home_screen.dart';
import 'package:ecommerce_seller_app/views/order_screen/order_screen.dart';
import 'package:ecommerce_seller_app/views/products/products_screen.dart';
import 'package:ecommerce_seller_app/views/profile_screen.dart/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(HomeController());

    var navScreen = [
      HomeScreen(),
      ProductScreen(),
      OrderScreen(),
      ProfileScreen()
    ];

    var bottomNavBar = [
      const BottomNavigationBarItem(icon: Icon(Icons.home), label: dashboard),
      BottomNavigationBarItem(
          icon: Image.asset(icProduct, color: darkGrey, width: 24),
          label: product),
      BottomNavigationBarItem(
          icon: Image.asset(icOrders, color: darkGrey, width: 24),
          label: orders),
      BottomNavigationBarItem(
          icon: Image.asset(icGeneralSettings, color: darkGrey, width: 24),
          label: settings),
    ];
    return Scaffold(
        backgroundColor: white,
        bottomNavigationBar: Obx(
          () => BottomNavigationBar(
            onTap: (index) {
              controller.navIndex.value = index;
            },
            type: BottomNavigationBarType.fixed,
            currentIndex: controller.navIndex.value,
            items: bottomNavBar,
            selectedItemColor: purpleColor,
            unselectedItemColor: darkGrey,
          ),
        ),
        body: Column(
          children: [
            Obx(() =>
                Expanded(child: navScreen.elementAt(controller.navIndex.value)))
          ],
        ));
  }
}
