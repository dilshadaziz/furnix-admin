import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:furnix_admin/bloc/product/product_bloc.dart';
import 'package:furnix_admin/utils/constants/colors.dart';
import 'package:furnix_admin/views/screens/login/widgets/elevated_button.dart';
import 'package:lottie/lottie.dart';

Widget rectangularButton({required VoidCallback onTap, required String text}) {
  return BlocBuilder<ProductBloc, ProductState>(
    builder: (context, state) {
      return ElevatedButton(
        onPressed: () => onTap(),
        child: Text(
          text,
          style: TextStyle(
              color: FColors.secondaryColor, fontWeight: FontWeight.bold),
        ),
        style: ButtonStyle(
            backgroundColor: MaterialStatePropertyAll(
              FColors.primaryColor,
            ),
            shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8)))),
      );
    },
  );
}


bool isLoading(ProductState state){
  return state is AddProductLoading ? || state is ProductImageLoading;
}