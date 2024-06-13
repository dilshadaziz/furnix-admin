import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:furnix_admin/bloc/product/product_bloc.dart';
import 'package:furnix_admin/utils/device/responsive.dart';
import 'package:furnix_admin/utils/validator/add_product_validator.dart';


class EditTextFormField extends StatefulWidget {
  final String labelText;
  final TextEditingController controller;
  final String previousText;

  const EditTextFormField({super.key, required this.labelText,required this.controller, required this.previousText});

  @override
  State<EditTextFormField> createState() => _EditTextFormFieldState();
}

class _EditTextFormFieldState extends State<EditTextFormField> {

  @override
  void initState() {
    widget.controller.text = widget.previousText;
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Container(
        height: widget.labelText == 'Product Description'
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
          readOnly: widget.labelText == 'Image',
          scrollPhysics: const AlwaysScrollableScrollPhysics(),
          maxLines: widget.labelText == 'Product Description' ? 5 : 2,
          validator: (value) {
            return productValidator(labelText: widget.labelText,value: value);
          },
          inputFormatters: [],
          autovalidateMode: AutovalidateMode.onUserInteraction,
          controller: widget.controller,
          textAlignVertical: TextAlignVertical.top,
          decoration: InputDecoration(
            
            suffixIcon: widget.labelText == "Image" ? GestureDetector(onTap: (){
              // Add Image Requested
              context.read<ProductBloc>().add(GetImageRequested());
    
            },child: Icon(Icons.add_a_photo_outlined)):null,
            border: const OutlineInputBorder(borderSide: BorderSide.none),
            labelText: widget.labelText,
            labelStyle: TextStyle(fontSize: getWidth(context) * 0.0125),
          ),
          cursorHeight: getWidth(context) * 0.02,
        ));
  }
}
