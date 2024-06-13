import 'package:flutter/widgets.dart';
import 'package:furnix_admin/utils/constants/colors.dart';

Widget header(String heading) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(heading),
      Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            'Dashboard',
            style: TextStyle(color: FColors.onBoardingSubTitleColor),
          ),
          // Text('')
        ],
      )
    ],
  );
}
