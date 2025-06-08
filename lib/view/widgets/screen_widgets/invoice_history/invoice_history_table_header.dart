import 'package:ausales_application/controller/invoice_history/invoice_history_list_controller.dart';
import 'package:ausales_application/responsive.dart';
import 'package:ausales_application/view/widgets/form_widgets/custom_dropdown_search_field.dart';
import 'package:ausales_application/view/widgets/form_widgets/custom_text_input.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class InvoiceHistoryTableHeader extends StatefulWidget {
  const InvoiceHistoryTableHeader({super.key});

  @override
  State<InvoiceHistoryTableHeader> createState() =>
      _InvoiceHistoryTableHeaderState();
}

class _InvoiceHistoryTableHeaderState
    extends State<InvoiceHistoryTableHeader> {
  final InvoiceHistoryListController _invoiceHistoryListController =
      Get.put(InvoiceHistoryListController());

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(15.w),
      child: Responsive.isDesktop(context) || Responsive.isTablet(context)
          ? Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Obx(
                  () => _invoiceHistoryListController.isBranchuser.value
                      ? branch()
                      : SizedBox(),
                ),
                customer(),
                estimationDateRangeFilter(context),
                searchFilter(context)
              ],
            )
          : Column(
              children: [
                SizedBox(
                  height: 7.h,
                ),
                Obx(
                  () => _invoiceHistoryListController.isBranchuser.value
                      ? branch()
                      : SizedBox(),
                ),
                SizedBox(
                  height: 7.h,
                ),
                customer(),
                SizedBox(
                  height: 7.h,
                ),
                estimationDateRangeFilter(context),
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
          controller: _invoiceHistoryListController.searchController,
          textInputAction: TextInputAction.done,
          keyboardType: TextInputType.text,
          filled: true,
          prefixIcon: Icons.search,
          hasPrefixIcon: true,
          hintText: "Search",
          onChanged: (value) {
            _invoiceHistoryListController.getInvoiceList(context);
          }),
    );
  }

  SizedBox branch() {
    return SizedBox(
      width: 300.w,
      child: Obx(() => CustomDropdownSearchField(
            filled: true,
            controller: _invoiceHistoryListController.branchSearchController,
            selectedValue:
                _invoiceHistoryListController.selectedBranch.value,
            options: _invoiceHistoryListController.branchDropDown.value,
            onChanged: (value) {
              _invoiceHistoryListController.selectedBranch(value);
              _invoiceHistoryListController.getInvoiceList(context);
            },
            hintText: "Branch",
          )),
    );
  }

  SizedBox customer() {
    return SizedBox(
      width: 300.w,
      child: Obx(() => CustomDropdownSearchField(
            filled: true,
            controller:
                _invoiceHistoryListController.customerSearchController,
            selectedValue:
                _invoiceHistoryListController.selectedCustomer.value,
            options: _invoiceHistoryListController.customerDropDown.value,
            onChanged: (value) {
              _invoiceHistoryListController.selectedCustomer(value);
              _invoiceHistoryListController.getInvoiceList(context);
            },
            hintText: "Customer",
          )),
    );
  }


  SizedBox estimationDateRangeFilter(BuildContext context) {
    return SizedBox(
      width: 250.w,
      child: CustomTextInput(
          readOnly: true,
          controller: _invoiceHistoryListController
              .estimtaitonEntryDateFilterController,
          textInputAction: TextInputAction.done,
          keyboardType: TextInputType.text,
          filled: true,
          hasSuffixIcon: true,
          suffixIcon: Icons.close,
          suffixClicked: () {
            _invoiceHistoryListController
                .estimtaitonEntryDateFilterController
                .clear();
            _invoiceHistoryListController.getInvoiceList(context);
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
              var endDate = pickedDate.end.toString().substring(0, 10);
              _invoiceHistoryListController
                  .estimtaitonEntryDateFilterController
                  .text = [startDate, endDate].join(" to ");
            } else {
              _invoiceHistoryListController
                  .estimtaitonEntryDateFilterController
                  .clear();
            }
            _invoiceHistoryListController.getInvoiceList(context);
          }),
    );
  }
}
