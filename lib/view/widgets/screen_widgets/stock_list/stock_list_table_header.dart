import 'dart:developer';

import 'package:ausales_application/controller/stock_list/stock_list_controller.dart';
import 'package:ausales_application/responsive.dart';
import 'package:ausales_application/view/widgets/form_widgets/custom_dropdown_search_field.dart';
import 'package:ausales_application/view/widgets/form_widgets/custom_label_filter.dart';
import 'package:ausales_application/view/widgets/form_widgets/custom_text_input.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class StockListTableHeader extends StatefulWidget {
  const StockListTableHeader({super.key});

  @override
  State<StockListTableHeader> createState() => _StockListTableHeaderState();
}

class _StockListTableHeaderState extends State<StockListTableHeader> {
  final StockListController _stockListController =
      Get.put(StockListController());

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(15.w),
      child: Responsive.isDesktop(context) || Responsive.isTablet(context)
          ? Wrap(
              spacing: 10.w,
              runSpacing: 10.h,
              children: [
                MetalType(context),
                Purity(context),
                Item(context),
                SubItem(context),
                vendordesignerFilter(context),
                StockType(context),
                Obx(
                  () => _stockListController.isBranchuser.value
                      ? branch()
                      : SizedBox(),
                ),
                CalculationType(context),
                entryDateRangeFilter(context),
                searchFilter(context),
              ],
            )
          : Column(
              children: [
                MetalType(context),
                SizedBox(
                  height: 7.h,
                ),
                Purity(context),
                SizedBox(
                  height: 7.h,
                ),
                Item(context),
                SizedBox(
                  height: 7.h,
                ),
                SubItem(context),
                SizedBox(
                  height: 7.h,
                ),
                vendordesignerFilter(context),
                SizedBox(
                  height: 7.h,
                ),
                StockType(context),
                SizedBox(
                  height: 7.h,
                ),
                Obx(
                  () => _stockListController.isBranchuser.value
                      ? branch()
                      : SizedBox(),
                ),
                SizedBox(
                  height: 7.h,
                ),
                CalculationType(context),
                SizedBox(
                  height: 7.h,
                ),
                entryDateRangeFilter(context),
                SizedBox(
                  height: 7.h,
                ),
                searchFilter(context),
              ],
            ),
    );
  }

  SizedBox MetalType(BuildContext context) {
    return SizedBox(
        width: 200.w,
        child: Obx(() => Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomLabelFilter(label: "Metal"),
                SizedBox(
                  height: 7.w,
                ),
                CustomDropdownSearchField(
                  controller: _stockListController.searchMetalController,
                  filled: true,
                  selectedValue: _stockListController.selectedMetal.value,
                  options: _stockListController.metalFilterList.value,
                  onChanged: (value) {
                    _stockListController.selectedMetal(value);
                    _stockListController.getstockList(context);
                  },
                  hintText: "Stock Type",
                ),
              ],
            )));
  }

  SizedBox StockType(BuildContext context) {
    return SizedBox(
        width: 200.w,
        child: Obx(() => Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomLabelFilter(label: "Stock"),
                SizedBox(
                  height: 7.w,
                ),
                CustomDropdownSearchField(
                  controller: _stockListController.searchStockTypeController,
                  filled: true,
                  selectedValue: _stockListController.selectedStockType.value,
                  options: _stockListController.stocktypeFilterList.value,
                  onChanged: (value) {
                    _stockListController.selectedStockType(value);
                    _stockListController.getstockList(context);
                  },
                  hintText: "Stock Type",
                ),
              ],
            )));
  }

  SizedBox CalculationType(BuildContext context) {
    return SizedBox(
        width: 200.w,
        child: Obx(() => Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomLabelFilter(label: "Calculation Type"),
                SizedBox(
                  height: 7.w,
                ),
                CustomDropdownSearchField(
                  controller:
                      _stockListController.searchCalculationTypeController,
                  filled: true,
                  selectedValue:
                      _stockListController.selectedCalculationType.value,
                  options: _stockListController.calculationTypeFilterList.value,
                  onChanged: (value) {
                    _stockListController.selectedCalculationType(value);
                     _stockListController.getstockList(context);
                  },
                  hintText: "Calculation Type",
                ),
              ],
            )));
  }

  SizedBox Purity(BuildContext context) {
    return SizedBox(
        width: 200.w,
        child: Obx(() => Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomLabelFilter(label: "Purity"),
                SizedBox(
                  height: 7.w,
                ),
                CustomDropdownSearchField(
                  controller: _stockListController.searchPurityController,
                  filled: true,
                  selectedValue: _stockListController.selectedPurity.value,
                  options: _stockListController.purityFilterList.value,
                  onChanged: (value) {
                    _stockListController.selectedPurity(value);
                    _stockListController.getstockList(context);
                  },
                  hintText: "Stock Type",
                ),
              ],
            )));
  }

  SizedBox Item(BuildContext context) {
    return SizedBox(
        width: 200.w,
        child: Obx(() => Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomLabelFilter(label: "Item"),
                SizedBox(
                  height: 7.w,
                ),
                CustomDropdownSearchField(
                  controller: _stockListController.searchItemController,
                  filled: true,
                  selectedValue: _stockListController.selectedItem.value,
                  options: _stockListController.itemFilterList.value,
                  onChanged: (value) {
                    _stockListController.selectedItem(value);
                    _stockListController.getstockList(context);
                  },
                  hintText: "Item",
                ),
              ],
            )));
  }

  SizedBox SubItem(BuildContext context) {
    return SizedBox(
        width: 200.w,
        child: Obx(() => Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomLabelFilter(label: "Sub Item"),
                SizedBox(
                  height: 7.w,
                ),
                CustomDropdownSearchField(
                  controller: _stockListController.searchSubItemController,
                  filled: true,
                  selectedValue: _stockListController.selectedSubitem.value,
                  options: _stockListController.subitemFilterList.value,
                  onChanged: (value) {
                    _stockListController.selectedSubitem(value);
                    _stockListController.getstockList(context);
                  },
                  hintText: "Sub Item",
                ),
              ],
            )));
  }

  SizedBox searchFilter(BuildContext context) {
    return SizedBox(
      width: 200.w,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomLabelFilter(label: "Search"),
          SizedBox(
            height: 7.w,
          ),
          CustomTextInput(
              controller: _stockListController.searchController,
              textInputAction: TextInputAction.done,
              keyboardType: TextInputType.text,
              filled: true,
              prefixIcon: Icons.search,
              hasPrefixIcon: true,
              hintText: "Search",
              onChanged: (value) {
                _stockListController.getstockList(context);
              }),
        ],
      ),
    );
  }

  SizedBox vendordesignerFilter(BuildContext context) {
    return SizedBox(
        width: 200.w,
        child: Obx(() => Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomLabelFilter(label: "Vendor"),
                SizedBox(
                  height: 7.w,
                ),
                CustomDropdownSearchField(
                  controller:
                      _stockListController.searchVendorDesignerController,
                  filled: true,
                  selectedValue:
                      _stockListController.selectedvendorDesiner.value,
                  options: _stockListController.vendordesignerFilterList.value,
                  onChanged: (value) {
                    _stockListController.selectedvendorDesiner(value);
                    _stockListController.getstockList(context);
                  },
                  hintText: "Designer Status",
                ),
              ],
            )));
  }

  SizedBox branch() {
    return SizedBox(
      width: 200.w,
      child: Obx(() => Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomLabelFilter(label: "Branch"),
              SizedBox(
                height: 7.w,
              ),
              CustomDropdownSearchField(
                filled: true,
                controller: _stockListController.branchSearchController,
                selectedValue: _stockListController.selectedBranch.value,
                options: _stockListController.branchDropDown.value,
                onChanged: (value) {
                  _stockListController.selectedBranch(value);
                  _stockListController.getstockList(context);
                },
                hintText: "Branch",
              ),
            ],
          )),
    );
  }

  SizedBox entryDateRangeFilter(BuildContext context) {
    return SizedBox(
     width: 200.w,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomLabelFilter(label: "Date Filter"),
          SizedBox(
            height: 7.w,
          ),
          CustomTextInput(
              readOnly: true,
              controller: _stockListController.StockEntryDateFilterController,
              textInputAction: TextInputAction.done,
              keyboardType: TextInputType.text,
              filled: true,
              hasSuffixIcon: true,
              suffixIcon: Icons.close,
              suffixClicked: () {
                _stockListController.StockEntryDateFilterController.clear();
                _stockListController.getstockList(context);
              },
              hintText: "Entry Date Range",
              onTap: () async {
                final today = DateTime.now();
                final endYear = today.year + 1;
                DateTimeRange? pickedDate = await showDateRangePicker(
                  context: context,
                  firstDate: DateTime(1900),
                  lastDate: DateTime(endYear),
                  builder: (context, child) {
                    return Center(
                      child: Container(
                        height: 450.h,
                        width: 400.w,
                        child: child,
                      ),
                    );
                  },
                );
                if (pickedDate != null) {
                  var startDate = pickedDate.start.toString().substring(0, 10);
                  var endDate = pickedDate.end
                      .add(Duration(days: 1))
                      .toString()
                      .substring(0, 10);
                  _stockListController.StockEntryDateFilterController.text =
                      [startDate, endDate].join(" to ");
                } else {
                  _stockListController.StockEntryDateFilterController.clear();
                }
                _stockListController.getstockList(context);
              }),
        ],
      ),
    );
  }
}
