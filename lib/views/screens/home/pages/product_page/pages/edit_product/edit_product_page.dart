// ignore_for_file: no_leading_underscores_for_local_identifiers
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
import 'package:furnix_admin/views/screens/home/pages/product_page/pages/edit_product/edit_form_container.dart';
import 'package:furnix_admin/views/screens/home/widgets/header.dart';
import 'package:furnix_admin/views/screens/home/widgets/rectangular_button.dart';
import 'package:furnix_admin/views/screens/login/widgets/elevated_button.dart';
import 'package:image_picker/image_picker.dart';

class EditProductPage extends StatelessWidget {
  const EditProductPage({super.key});

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
    late final ProductsModel product;

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
          header('Edit Product'),
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
                if (state is ProductImageUploaded) {
                  imageUrl = state.imageUrl;
                  // debugPrint('uploaded ${state.imageUrl}');

                  debugPrint('new $imageUrl');
                }
                if (state is CategoryChanged) {
                  selectedCategory = state.category;
                }
                if (state is ProductImagePicked) {
                  imageController.text = state.pickedImage.name;
                  image = state.pickedImage;
                }
                if (state is EditProductSuccess) {
                  context
                      .read<SideMenuBarBloc>()
                      .add(const SideMenuBarItemSelected(index: 2));
                }
              },
              builder: (context, state) {
                if (state is EditProductPageLoaded) {
                  product = state.product;
                }
                debugPrint('product state $state');
                return SingleChildScrollView(
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: EditTextFormField(
                                  labelText: 'Product Name',
                                  controller: productController,
                                  previousText: product.productName),
                            ),
                            const SizedBox(
                              width: 30,
                            ),
                            Expanded(
                                child: dropDownFormField(
                                    context, categories, product.category)),
                          ],
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        EditTextFormField(
                            labelText: 'Product Description',
                            controller: descriptionController,
                            previousText: product.productDescription),
                        const SizedBox(
                          height: 30,
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: EditTextFormField(
                                  labelText: 'Price',
                                  controller: priceController,
                                  previousText: product.price),
                            ),
                            const SizedBox(
                              width: 25,
                            ),
                            Expanded(
                              child: EditTextFormField(
                                labelText: 'Color',
                                controller: colorController,
                                previousText: product.color,
                              ),
                            ),
                            const SizedBox(
                              width: 25,
                            ),
                            Expanded(
                              child: EditTextFormField(
                                  labelText: 'Quantity',
                                  controller: quantityController,
                                  previousText: product.quantity),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 25,
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: EditTextFormField(
                                  labelText: 'Image',
                                  controller: imageController,
                                  previousText: product.image),
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
                                debugPrint("this is image : $image");
                                if (image != null) {
                                  debugPrint('image is not null');
                                  productBloc
                                      .add(UploadImageRequested(image: image!));
                                }
                                final newProduct = ProductsModel(
                                  productId: product.productId,
                                  productName: productController.text,
                                  category: selectedCategory,
                                  productDescription:
                                      descriptionController.text,
                                  price: priceController.text,
                                  color: colorController.text,
                                  quantity: quantityController.text,
                                  image: imageController.text,
                                  imageUrl: imageUrl.isEmpty
                                      ? product.imageUrl
                                      : imageUrl,
                                );
                                debugPrint(
                                    'imageUrl : $imageUrl and ${product.imageUrl}');
                                productBloc.add(
                                    EditProductRequested(product: newProduct));

                                debugPrint('state is uploaded $imageUrl');
                              }
                            },
                            text: "Edit Product")
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
