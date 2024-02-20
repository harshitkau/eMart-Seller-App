import 'package:ecommerce_seller_app/const/const.dart';
import 'package:ecommerce_seller_app/views/widget/text_style.dart';

Widget ourButton({title, color = purpleColor, onpress}) {
  return ElevatedButton(
      style: ElevatedButton.styleFrom(
        padding: EdgeInsets.all(12),
        primary: color,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5.0),
        ),
      ),
      onPressed: onpress,
      child: normalText(text: title, size: 16.0));
}
