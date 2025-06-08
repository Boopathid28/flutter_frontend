import 'package:ausales_application/controller/stock_ledger/stock_ledger_list_controller.dart';
import 'package:ausales_application/responsive.dart';
import 'package:ausales_application/view/widgets/form_widgets/custom_dropdown_search_field.dart';
import 'package:ausales_application/view/widgets/form_widgets/custom_label_filter.dart';
import 'package:ausales_application/view/widgets/form_widgets/custom_text_input.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class StockLedgerTableHeader extends StatefulWidget {
  const StockLedgerTableHeader({super.key});

  @override
  State<StockLedgerTableHeader> createState() =>
      _StockLedgerTableHeaderState();
}

class _StockLedgerTableHeaderState extends State<StockLedgerTableHeader> {
  final StockLedgerListController _stockLedgerListController =
      Get.put(StockLedgerListController());

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
                  controller:
                      _stockLedgerListController.searchMetalController,
                  filled: true,
                  selectedValue:
                      _stockLedgerListController.selectedMetal.value,
                  options:
                      _stockLedgerListController.metalFilterList.value,
                  onChanged: (value) {
                    _stockLedgerListController.selectedMetal(value);
                    _stockLedgerListController.getstockledgerList(context);
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
                  controller:
                      _stockLedgerListController.searchStockTypeController,
                  filled: true,
                  selectedValue:
                      _stockLedgerListController.selectedStockTypeLedger.value,
                  options:
                      _stockLedgerListController.stocktypeledgerFilterList.value,
                  onChanged: (value) {
                    _stockLedgerListController.selectedStockTypeLedger(value);
                    _stockLedgerListController.getstockledgerList(context);
                  },
                  hintText: "Stock Type",
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
                  controller:
                      _stockLedgerListController.searchPurityController,
                  filled: true,
                  selectedValue:
                      _stockLedgerListController.selectedPurity.value,
                  options:
                      _stockLedgerListController.purityFilterList.value,
                  onChanged: (value) {
                    _stockLedgerListController.selectedPurity(value);
                    _stockLedgerListController.getstockledgerList(context);
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
                  controller:
                      _stockLedgerListController.searchItemController,
                  filled: true,
                  selectedValue:
                      _stockLedgerListController.selectedItem.value,
                  options:
                      _stockLedgerListController.itemFilterList.value,
                  onChanged: (value) {
                    _stockLedgerListController.selectedItem(value);
                    _stockLedgerListController.getstockledgerList(context);
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
                  controller:
                      _stockLedgerListController.searchSubItemController,
                  filled: true,
                  selectedValue:
                      _stockLedgerListController.selectedSubitem.value,
                  options:
                      _stockLedgerListController.subitemFilterList.value,
                  onChanged: (value) {
                    _stockLedgerListController.selectedSubitem(value);
                    _stockLedgerListController.getstockledgerList(context);
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
              controller: _stockLedgerListController.searchController,
              textInputAction: TextInputAction.done,
              keyboardType: TextInputType.text,
              filled: true,
              prefixIcon: Icons.search,
              hasPrefixIcon: true,
              hintText: "Search",
              onChanged: (value) {
                _stockLedgerListController.getstockledgerList(context);
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
                      _stockLedgerListController.searchVendorDesignerController,
                  filled: true,
                  selectedValue:
                      _stockLedgerListController.selectedvendorDesiner.value,
                  options:
                      _stockLedgerListController.vendordesignerFilterList.value,
                  onChanged: (value) {
                    _stockLedgerListController.selectedvendorDesiner(value);
                    _stockLedgerListController.getstockledgerList(context);
                  },
                  hintText: "Designer Status",
                ),
          ],
        )));
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
              controller: _stockLedgerListController.stockListDateController,
              textInputAction: TextInputAction.done,
              keyboardType: TextInputType.text,
              filled: true,
              hasSuffixIcon: true,
              suffixIcon: Icons.close,
              suffixClicked: () {
                _stockLedgerListController.stockListDateController.clear();
                _stockLedgerListController.getstockledgerList(context);
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
                  _stockLedgerListController.stockListDateController.text =
                      [startDate, endDate].join(" to ");
                } else {
                  _stockLedgerListController.stockListDateController.clear();
                }
                _stockLedgerListController.getstockledgerList(context);
              }),
        ],
      ),
    );
  }
}
