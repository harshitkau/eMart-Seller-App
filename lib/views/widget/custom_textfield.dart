import 'package:ecommerce_seller_app/const/const.dart';
import 'package:ecommerce_seller_app/views/widget/text_style.dart';

Widget customTextField({title, hint, controller, isDes = false}) {
  return TextFormField(
    controller: controller,
    style: TextStyle(color: white),
    maxLines: isDes ? 4 : 1,
    decoration: InputDecoration(
        isDense: true,
        label: normalText(text: title),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: white),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: white),
        ),
        hintText: hint,
        hintStyle: TextStyle(color: white)),
  );
}
