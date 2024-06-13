import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:furnix_admin/bloc/side_bar/side_menu_bar_bloc.dart';
import 'package:furnix_admin/utils/constants/colors.dart';
import 'package:furnix_admin/utils/device/responsive.dart';

Widget sideNavigationMenu({
  required int currentIndex,
  required double screenHeight,
  required double screenWidth,
  required List<String> sideBarItems,
  required SideMenuBarBloc sideMenuBloc,
  required int hoverIndex,
}) {
  return BlocConsumer<SideMenuBarBloc, SideMenuBarState>(
    listener: (context, state) {
      if (state is SideMenuBarItemSelectedState) {
        if(state.selectedIndex != 6){
          currentIndex = state.selectedIndex;
        }
        
      }
      if(state is SideMenuBarItemHoveredState){
        hoverIndex = state.hoverIndex;
      }
    },
    builder: (context, state) {
      return SizedBox(
        // Fixed width for the left navigation bar
        width: screenWidth * 0.24,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: List.generate(
              sideBarItems.length,
              (index) {
                final isSelected = index == currentIndex;
                final isHovered = index == hoverIndex;
          
                return Padding(
                  padding: const EdgeInsets.only(top: 10, bottom: 10, left: 20),
                  child: InkWell(
                    onTap: () {
                      sideMenuBloc.add(SideMenuBarItemSelected(index: index));
                      HapticFeedback.mediumImpact();
                    },
                    onHover: (value) {
                      sideMenuBloc.add(SideMenuBarItemHovered(index: value ? index : currentIndex));
                    },
                    
                    splashColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    child: Container(
                      decoration: BoxDecoration(
                          color: isSelected ? Colors.grey.shade200 :null,
                          borderRadius: BorderRadius.circular(30)),
                      padding: const EdgeInsets.all(5.0),
                      child: Container(
                        padding: EdgeInsets.all(10.0),
                        decoration: BoxDecoration(
                            color: isSelected ? Colors.white : null,
                            borderRadius: BorderRadius.circular(30)),
                        child: Row(
                          children: [
                            SizedBox(
                                width: 10), // Spacing between indicator and text
                            Flexible(
                              child: Text(
                                maxLines: 2,
                                overflow: TextOverflow.visible,
                                sideBarItems[index],
                                style: TextStyle(
                                  fontSize: getWidth(context)*0.013,
                                  color: isSelected || isHovered ? FColors.primaryColor : Colors.black, // Change text color to white
                                  fontWeight: isSelected
                                      ? FontWeight.bold
                                      : FontWeight.normal,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      );
    },
  );
}
