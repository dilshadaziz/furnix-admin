import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:furnix_admin/bloc/product/product_bloc.dart';
import 'package:furnix_admin/bloc/side_bar/side_menu_bar_bloc.dart';
import 'package:furnix_admin/models/products_model.dart';
import 'package:furnix_admin/utils/constants/colors.dart';
import 'package:furnix_admin/utils/device/responsive.dart';
import 'package:furnix_admin/views/screens/home/pages/product_page/pages/add_product/add_product_page.dart';
import 'package:furnix_admin/views/screens/home/widgets/header.dart';
import 'package:furnix_admin/views/screens/home/widgets/rectangular_button.dart';

class ProductManagementPage extends StatelessWidget {
  
  final String heading;
  const ProductManagementPage({super.key, required this.heading});

  @override
  Widget build(BuildContext context) {
    List<ProductsModel>? products;
    
    final productBloc = context.read<ProductBloc>();
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        header('Product Management'),
        Row(
          children: [
            rectangularButton(
                onTap: () {
                  context
                      .read<SideMenuBarBloc>()
                      .add(const SideMenuBarItemSelected(index: 6));
                  // Navigator.of(context).push(MaterialPageRoute(builder: (context)=> AddProductPage()));
                },
                text: 'Add Product'),
            SizedBox(
              width: 20,
            ),
            rectangularButton(onTap: () {}, text: 'Go To Unlisted Product'),
          ],
        ),
        const SizedBox(
          height: 30,
        ),
        BlocConsumer<ProductBloc, ProductState>(
          listener: (context, state) {
            if (state is ProductDeleted || state is ProductEdited) {
              productBloc.add(LoadProductsRequested());
            }
          },
          builder: (context, state) {
            if (state is ProductsLoaded) {
              products = state.products;
            }
            debugPrint('state is $state');

            return Container(
              width: getWidth(context) * 0.72,
              height: getHeight(context) - getHeight(context) * 0.27,
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(15)),
              padding: const EdgeInsets.all(25.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Search Product to Manage'),
                      Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15)),
                        width: getWidth(context) * 0.2,
                        child: TextField(
                          cursorHeight: 22,
                          decoration: InputDecoration(
                              contentPadding:
                                  EdgeInsets.only(left: 10, right: 10),
                              border: OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                  borderRadius: BorderRadius.circular(15)),
                              fillColor: Colors.grey.shade100,
                              filled: true,
                              alignLabelWithHint: true,
                              labelText: 'Search products'),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  Expanded(
                    child: SizedBox(
                      height:
                          getHeight(context) - getHeight(context) * 0.27 - 60,
                      child: Row(
                        crossAxisAlignment: products != null
                            ? CrossAxisAlignment.start
                            : CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SingleChildScrollView(
                              child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: isLoadingState(state)
                                ? [CircularProgressIndicator()]
                                : products != null
                                    ? products!
                                        .map((product) => Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                Container(
                                                  width:
                                                      getWidth(context) * 0.6,
                                                  height:
                                                      getHeight(context) * 0.2,
                                                  child: Card(
                                                    shadowColor:
                                                        FColors.primaryColor,
                                                    color: Colors.grey.shade200,
                                                    elevation: 0,
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              8.0),
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          Row(
                                                            children: [
                                                              Container(
                                                                color:
                                                                    Colors.red,
                                                                height: getHeight(
                                                                            context) *
                                                                        0.2 -
                                                                    60,
                                                                width: getWidth(
                                                                        context) *
                                                                    0.05,
                                                                child: Image
                                                                    .network(
                                                                  product
                                                                      .imageUrl,
                                                                  fit: BoxFit
                                                                      .cover,
                                                                ),
                                                              ),
                                                              SizedBox(
                                                                width: 20,
                                                              ),
                                                              Column(
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .start,
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .center,
                                                                children: [
                                                                  Text(
                                                                      'Product: ${product.productName}'),
                                                                  Text(
                                                                      'COLOR: ${product.color}'),
                                                                  Text(
                                                                      'Qty: ${product.quantity}'),
                                                                ],
                                                              ),
                                                            ],
                                                          ),
                                                          Text(
                                                              'Price: ${product.price}'),
                                                          Row(
                                                            children: [
                                                              IconButton(
                                                                  onPressed:
                                                                      () {
                                                                    context
                                                                        .read<
                                                                            SideMenuBarBloc>()
                                                                        .add(const SideMenuBarItemSelected(
                                                                            index:
                                                                                7));
                                                                    productBloc.add(EditProductButtonClicked(
                                                                        product:
                                                                            product));
                                                                  },
                                                                  icon: Icon(Icons
                                                                      .edit)),
                                                              IconButton(
                                                                onPressed: () {
                                                                  productBloc.add(
                                                                      DeleteProductRequested(
                                                                          productId:
                                                                              product.productId!));
                                                                },
                                                                icon: Icon(Icons
                                                                    .delete),
                                                              ),
                                                            ],
                                                          )
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 10,
                                                )
                                              ],
                                            ))
                                        .toList()
                                    : [
                                        Center(
                                          child: Text('products is empty'),
                                        )
                                      ],
                          ))
                        ],
                      ),
                    ),
                  )
                ],
              ),
            );
          },
        )
      ],
    );
  }

  bool isLoadingState(ProductState state) {
    return state is DeleteProductLoading || state is ProductsLoading;
  }
}
