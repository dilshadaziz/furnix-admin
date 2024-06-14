import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:furnix_admin/bloc/product/product_bloc.dart';
import 'package:furnix_admin/bloc/side_bar/side_menu_bar_bloc.dart';
import 'package:furnix_admin/utils/constants/colors.dart';
import 'package:furnix_admin/utils/device/responsive.dart';
import 'package:furnix_admin/views/screens/home/pages/banner_page/banner_page.dart';
import 'package:furnix_admin/views/screens/home/pages/category_page/category_page.dart';
import 'package:furnix_admin/views/screens/home/pages/dashboard_page/dashboard_page.dart';
import 'package:furnix_admin/views/screens/home/pages/order_page/order_page.dart';
import 'package:furnix_admin/views/screens/home/pages/product_page/pages/add_product/add_product_page.dart';
import 'package:furnix_admin/views/screens/home/pages/product_page/pages/edit_product/edit_product_page.dart';
import 'package:furnix_admin/views/screens/home/pages/product_page/product_page.dart';
import 'package:furnix_admin/views/screens/home/pages/user_page/user_page.dart';
import 'package:furnix_admin/views/screens/home/widgets/side_nav_bar.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final sideMenuBloc = context.read<SideMenuBarBloc>();
    int currentIndex = 0;
    final double screenWidth = getWidth(context);
    final double screenHeight = getHeight(context);
    final List<String> sideBarItems = [
      'Dashboard',
      'Banner Management',
      'Product Management',
      'Category Management',
      'User Management',
      'Order Management',
      // 'Coupon Management',
      // 'Offer Management',
    ];

    List<Widget> homePages = [
      const DashboardPage(),
      const BannerManagement(),
      ProductManagementPage(heading: sideBarItems[2]),
      const CategoryManagementPage(),
      const UserManagementPage(),
      const OrderManagementPage(),
      const AddProductPage(),
      const EditProductPage(),
    ];
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      body: SingleChildScrollView(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              color: Colors.white,
              width: getWidth(context) * 0.22,
              height: screenHeight,
              child: Column(
                children: [
                  // Heading

                  const Text("ADMIN FURNIX"),

                  SizedBox(
                    height: getHeight(context) * 0.06,
                  ),
                  sideNavigationMenu(
                      currentIndex: currentIndex,
                      screenHeight: screenHeight,
                      screenWidth: screenWidth,
                      sideBarItems: sideBarItems,
                      sideMenuBloc: sideMenuBloc,
                      hoverIndex: currentIndex),
                ],
              ),
            ),
            BlocConsumer<SideMenuBarBloc, SideMenuBarState>(
              listener: (context, state) {
                if (state is SideMenuBarItemSelectedState) {
                  currentIndex = state.selectedIndex;
                  loadContents(currentIndex: currentIndex,context: context);
                }
              },
              builder: (context, state) {
                return Padding(
                  padding: EdgeInsets.all(getWidth(context) * 0.03),
                  child: Expanded(child: homePages[currentIndex]),
                );
              },
            )
          ],
        ),
      ),
    );
  }

  void loadContents({required int currentIndex,required BuildContext context}) {
    if (currentIndex == 0) {
    } else if (currentIndex == 1) {
    } else if (currentIndex == 2) {
      context.read<ProductBloc>().add(LoadProductsRequested());
    } else if (currentIndex == 3) {
    } else if (currentIndex == 4) {
    } else {
      debugPrint('current $currentIndex');
    }
  }
}
