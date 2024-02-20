import 'package:ecommerce_seller_app/const/const.dart';
import 'package:ecommerce_seller_app/views/widget/text_style.dart';

Widget OrderPlaceDetails({title1, detail1, title2, detail2}) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            boldText(text: "$title1", color: purpleColor),
            boldText(text: "$detail1", color: red),
          ],
        ),
        SizedBox(
          width: 120,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              boldText(text: "$title2", color: purpleColor),
              boldText(text: "$detail2", color: red),
            ],
          ),
        )
      ],
    ),
  );
}
