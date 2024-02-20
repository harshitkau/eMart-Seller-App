import 'package:ecommerce_seller_app/const/const.dart';

Widget loadingIndicator({circleColor = purpleColor}) {
  return CircularProgressIndicator(
      valueColor: AlwaysStoppedAnimation(circleColor));
}
