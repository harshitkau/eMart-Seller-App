import 'package:ecommerce_seller_app/const/const.dart';
import 'package:ecommerce_seller_app/controller/product_controller.dart';
import 'package:ecommerce_seller_app/views/widget/text_style.dart';
import 'package:get/get.dart';

Widget productDropdown(
    hint, List<String> list, dropValue, ProductController controller) {
  return Obx(
    () => DropdownButtonHideUnderline(
      child: DropdownButton(
        hint: normalText(text: "$hint", color: fontGrey),
        value: dropValue.value == '' ? null : dropValue.value,
        isExpanded: true,
        items: list.map((e) {
          return DropdownMenuItem(
            value: e,
            child: e.toString().text.make(),
          );
        }).toList(),
        onChanged: (newValue) {
          if (hint == "Category") {
            controller.subCategoryValue.value = '';
            controller.populateSubCategoryList(newValue.toString());
          }
          dropValue.value = newValue.toString();
        },
      ),
    ).box.roundedSM.white.padding(EdgeInsets.symmetric(horizontal: 4)).make(),
  );
}
