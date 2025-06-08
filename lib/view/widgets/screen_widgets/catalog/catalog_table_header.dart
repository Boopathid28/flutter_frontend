import 'package:ausales_application/controller/catalog/catalog_list_controller.dart';
import 'package:ausales_application/responsive.dart';
import 'package:ausales_application/view/widgets/form_widgets/custom_dropdown_field.dart';
import 'package:ausales_application/view/widgets/form_widgets/custom_dropdown_search_field.dart';
import 'package:ausales_application/view/widgets/form_widgets/custom_text_input.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class CatalogTableHeader extends StatefulWidget {
  const CatalogTableHeader({super.key});

  @override
  State<CatalogTableHeader> createState() => _CatalogTableHeaderState();
}

class _CatalogTableHeaderState extends State<CatalogTableHeader> {
  final CatalogListController _catalogListController =
      Get.put(CatalogListController());

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(15.w),
      child: Responsive.isDesktop(context) || Responsive.isTablet(context)
          ? Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                searchFilter(context),
                SizedBox(
                  width: 7.h,
                ),
                floor(),
                SizedBox(
                  width: 7.h,
                ),
                counter(),
                SizedBox(
                  width: 7.h,
                ),
                catalogType()
              ],
            )
          : Column(
              children: [
                floor(),
                SizedBox(
                  height: 7.h,
                ),
                counter(),
                SizedBox(
                  height: 7.h,
                ),
                catalogType(),
                SizedBox(
                  height: 7.h,
                ),
                searchFilter(context)
              ],
            ),
    );
  }

  SizedBox searchFilter(BuildContext context) {
    return SizedBox(
      width: 300.w,
      child: CustomTextInput(
          controller: _catalogListController.searchController,
          textInputAction: TextInputAction.done,
          keyboardType: TextInputType.text,
          filled: true,
          prefixIcon: Icons.search,
          hasPrefixIcon: true,
          hintText: "Search",
          onChanged: (value) {
            _catalogListController.getCatalogList(context);
          }),
    );
  }

  SizedBox counter() {
    return SizedBox(
      width: 300.w,
      child: Obx(() => CustomDropdownSearchField(
            filled: true,
            controller: _catalogListController.searchCounterController,
            selectedValue: _catalogListController.selectedCounter.value,
            options: _catalogListController.counterDropDown.value,
            onChanged: (value) {
              _catalogListController.selectedCounter(value);
              _catalogListController.getCatalogList(context);
            },
            hintText: "Counter",
          )),
    );
  }

  SizedBox floor() {
    return SizedBox(
      width: 300.w,
      child: Obx(() => CustomDropdownSearchField(
            filled: true,
            controller: _catalogListController.searchFloorController,
            selectedValue: _catalogListController.selectedFloor.value,
            options: _catalogListController.floorDropDown.value,
            onChanged: (value) {
              _catalogListController.selectedFloor(value);
              _catalogListController.getCatalogList(context);
            },
            hintText: "Floor",
          )),
    );
  }

  SizedBox catalogType() {
    return SizedBox(
      width: 300.w,
      child: Obx(() => CustomDropdownField(
            filled: true,
            selectedValue: _catalogListController.selectedCatalogType.value,
            options: _catalogListController.catalogTypeDropDown.value,
            onChanged: (value) {
              _catalogListController.selectedCatalogType(value);
              _catalogListController.getCatalogList(context);
            },
            hintText: "Floor",
          )),
    );
  }
}
