// ignore_for_file: no_leading_underscores_for_local_identifiers

import 'dart:math';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:furnix_admin/bloc/product/product_bloc.dart';
import 'package:furnix_admin/bloc/side_bar/side_menu_bar_bloc.dart';
import 'package:furnix_admin/models/products_model.dart';
import 'package:furnix_admin/utils/device/responsive.dart';
import 'package:furnix_admin/views/screens/home/pages/product_page/pages/add_product/widgets/dropdown_form_field.dart';
import 'package:furnix_admin/views/screens/home/pages/product_page/pages/add_product/widgets/text_form_field.dart';
import 'package:furnix_admin/views/screens/home/widgets/header.dart';
import 'package:furnix_admin/views/screens/home/widgets/rectangular_button.dart';
import 'package:furnix_admin/views/screens/login/widgets/elevated_button.dart';
import 'package:image_picker/image_picker.dart';

class AddProductPage extends StatelessWidget {
  const AddProductPage({super.key});

  @override
  Widget build(BuildContext context) {
    final productBloc = context.read<ProductBloc>();
    final productController = TextEditingController();
    final descriptionController = TextEditingController();
    final priceController = TextEditingController();
    final colorController = TextEditingController();
    final quantityController = TextEditingController();
    final imageController = TextEditingController();
    final _formKey = GlobalKey<FormState>();
    PlatformFile? image;
    String imageUrl = '';

    List<String> categories = [
      'Wood',
      'Metal',
      'Fabric',
      'Leather',
    ];
    String selectedCategory = categories[0];
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          header('Add Product'),
          rectangularButton(
              onTap: () {
                context
                    .read<SideMenuBarBloc>()
                    .add(const SideMenuBarItemSelected(index: 2));
              },
              text: 'Go Back'),
          const SizedBox(
            height: 30,
          ),
          Container(
            width: getWidth(context) * 0.7,
            height: getHeight(context) - getHeight(context) * 0.27,
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(15)),
            padding: const EdgeInsets.all(25.0),
            child: BlocConsumer<ProductBloc, ProductState>(
              listener: (context, state) {
                debugPrint('current state $state');
                if (state is AddProductSuccess) {
                  debugPrint('successfully added');
                }
                if (state is ProductImageUploaded) {
                  imageUrl = state.imageUrl;
                  // debugPrint('uploaded ${state.imageUrl}');
                  final newProduct = ProductsModel(
                      productName: productController.text,
                      category: selectedCategory,
                      productDescription: descriptionController.text,
                      price: priceController.text,
                      color: colorController.text,
                      quantity: quantityController.text,
                      image: imageController.text,
                      imageUrl: imageUrl,
                      );
                  debugPrint('new $imageUrl');
                  productBloc.add(AddProductRequested(product: newProduct));
                }
                if (state is CategoryChanged) {
                  selectedCategory = state.category;
                }
                if (state is ProductImagePicked) {
                  imageController.text = state.pickedImage.name;
                  image = state.pickedImage;
                }
              },
              builder: (context, state) {
                return SingleChildScrollView(
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: textFormField(
                                labelText: 'Product Name',
                                controller: productController,
                                context: context,
                              ),
                            ),
                            const SizedBox(
                              width: 30,
                            ),
                            Expanded(
                                child: dropDownFormField(context, categories,categories[0])),
                          ],
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        textFormField(
                          labelText: 'Product Description',
                          controller: descriptionController,
                          context: context,
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: textFormField(
                                labelText: 'Price',
                                controller: priceController,
                                context: context,
                              ),
                            ),
                            const SizedBox(
                              width: 25,
                            ),
                            Expanded(
                              child: textFormField(
                                labelText: 'Color',
                                controller: colorController,
                                context: context,
                              ),
                            ),
                            const SizedBox(
                              width: 25,
                            ),
                            Expanded(
                              child: textFormField(
                                labelText: 'Quantity',
                                controller: quantityController,
                                context: context,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 25,
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: textFormField(
                                labelText: 'Image',
                                context: context,
                                controller: imageController,
                              ),
                            ),
                            Expanded(child: Container())
                          ],
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        rectangularButton(
                            onTap: () async {
                              if (_formKey.currentState!.validate()) {
                                productBloc
                                    .add(UploadImageRequested(image: image!));
                                debugPrint('state is uploaded $imageUrl');
                              }
                            },
                            text: "Add Product")
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
