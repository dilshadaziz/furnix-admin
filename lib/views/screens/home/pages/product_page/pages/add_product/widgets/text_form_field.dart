import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:furnix_admin/bloc/product/product_bloc.dart';
import 'package:furnix_admin/utils/device/responsive.dart';
import 'package:furnix_admin/utils/validator/add_product_validator.dart';

Container textFormField({
  required String labelText,
  required BuildContext context,
  TextEditingController? controller,
  // required VoidCallback onTap,
}) {
  return Container(
      height: labelText == 'Product Description'
          ? getHeight(context) * 0.21
          : getHeight(context) * 0.08,
      padding: const EdgeInsets.only(
        left: 10,
        right: 10,
      ),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10), color: Colors.grey.shade100),
      child: TextFormField(
        // onTap: onTap,
        readOnly: labelText == 'Image',
        scrollPhysics: const AlwaysScrollableScrollPhysics(),
        maxLines: labelText == 'Product Description' ? 5 : 2,
        validator: (value) {
          return productValidator(labelText: labelText,value: value);
        },
        inputFormatters: [],
        autovalidateMode: AutovalidateMode.onUserInteraction,
        controller: controller,
        textAlignVertical: TextAlignVertical.top,
        decoration: InputDecoration(
          
          suffixIcon: labelText == "Image" ? GestureDetector(onTap: (){
            // Add Image Requested
            context.read<ProductBloc>().add(GetImageRequested());

          },child: Icon(Icons.add_a_photo_outlined)):null,
          border: const OutlineInputBorder(borderSide: BorderSide.none),
          labelText: labelText,
          labelStyle: TextStyle(fontSize: getWidth(context) * 0.0125),
        ),
        cursorHeight: getWidth(context) * 0.02,
      ));
}
