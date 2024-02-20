import 'package:ecommerce_seller_app/const/const.dart';
import 'package:ecommerce_seller_app/views/widget/text_style.dart';
import 'package:intl/intl.dart' as intl;

AppBar appbarWidget({title}) {
  return AppBar(
    backgroundColor: white,
    automaticallyImplyLeading: false,
    title: boldText(text: title, size: 18.0, color: fontGrey),
    actions: [
      Center(
        child: normalText(
            text: intl.DateFormat('EEE, MMM d, ' 'yy').format(DateTime.now()),
            color: purpleColor),
      ),
      10.widthBox,
    ],
  );
}
