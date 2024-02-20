import 'package:ecommerce_seller_app/const/const.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  @override
  void onInit() {
    getUserName();
    super.onInit();
  }

  var navIndex = 0.obs;
  var username = '';

  getUserName() async {
    var n = await firestore
        .collection(vendorCollection)
        .where('id', isEqualTo: currentUser!.uid)
        .get()
        .then((value) {
      return value.docs.single['vendor_name'];
    });
    username = n;
  }
}
