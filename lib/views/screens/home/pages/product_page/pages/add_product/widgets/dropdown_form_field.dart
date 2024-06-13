import 'dart:html';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:furnix_admin/bloc/product/product_bloc.dart';
import 'package:furnix_admin/utils/device/responsive.dart';

BlocBuilder dropDownFormField(BuildContext context, List<String> categories,String currentCategory) {
  return BlocBuilder<ProductBloc, ProductState>(
    builder: (context, state) {
      return Container(
        height: getHeight(context) * 0.08,
        padding: const EdgeInsets.only(
          left: 10,
          right: 10,
        ),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.grey.shade100),
        child: DropdownButtonFormField(
          
            decoration: const InputDecoration(
              border: OutlineInputBorder(borderSide: BorderSide.none),
              labelText: 'Category',
            ),
            value: currentCategory,
            items: categories
                .map<DropdownMenuItem<String>>((String value) =>
                    DropdownMenuItem<String>(
                      value: value,
                      child: Text(
                        value,
                        style: TextStyle(fontSize: getWidth(context) * 0.011),
                      ),
                    ))
                .toList(),
            onChanged: (value) {
              context.read<ProductBloc>().add(CategoryChangeRequested(category:value! as String));
            }),
      );
    },
  );
}
