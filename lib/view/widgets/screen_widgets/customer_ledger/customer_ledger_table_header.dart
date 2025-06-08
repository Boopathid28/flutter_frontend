import 'package:ausales_application/controller/customer_ledger/customer_ledger_list_controller.dart';
import 'package:ausales_application/responsive.dart';
import 'package:ausales_application/view/widgets/form_widgets/custom_dropdown_field.dart';
import 'package:ausales_application/view/widgets/form_widgets/custom_dropdown_search_field.dart';
import 'package:ausales_application/view/widgets/form_widgets/custom_label_filter.dart';
import 'package:ausales_application/view/widgets/form_widgets/custom_text_input.dart';
import 'package:ausales_application/view/widgets/form_widgets/secondary_button.dart';
import 'package:ausales_application/view/widgets/screen_widgets/customer_ledger/customer_ledger_print.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class CustomerLedgerTableHeader extends StatefulWidget {
  const CustomerLedgerTableHeader({super.key});

  @override
  State<CustomerLedgerTableHeader> createState() =>
      _CustomerLedgerTableHeaderState();
}

class _CustomerLedgerTableHeaderState extends State<CustomerLedgerTableHeader> {
  final CustomerLedgerListController _customerLedgerListController =
      Get.put(CustomerLedgerListController());

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(15.w),
      child: Responsive.isDesktop(context) || Responsive.isTablet(context)
          ? Wrap(
              spacing: 10.w,
              runSpacing: 10.h,
              children: [
                transactionType(context),
                Obx(() => _customerLedgerListController.isBranchuser.value ? branch(context) : SizedBox()),
                salesentryType(context),
                customer(context),
                entryDateRangeFilter(context),
                cancelledStatusFilter(context),
                searchFilter(context),
                 Container(
              margin: EdgeInsets.symmetric(vertical: 25.h),
              child: SecondaryButton(
                btnWidth: 200,
                isLoading: false,
                text: "print",
                onPressed: () async {
                  await showDialog(
                      barrierDismissible: false,
                      context: context,
                      builder: (_) => CustomerLedgerPrint(
                            items: _customerLedgerListController
                                .tableData.value,
                          ));
                },
              ),
            )
              ],
            )
          : Column(
              children: [
                transactionType(context),
                SizedBox(
                  height: 7.h,
                ),
                salesentryType(context),
                SizedBox(
                  height: 7.h,
                ),
                customer(context),
                SizedBox(
                  height: 7.h,
                ),
                cancelledStatusFilter(context),
                SizedBox(
                  height: 7.h,
                ),
                entryDateRangeFilter(context),
                SizedBox(
                  height: 7.h,
                ),
                searchFilter(context),
                 SizedBox(
                  height: 7.h,
                ),
                 Container(
              margin: EdgeInsets.symmetric(vertical: 25.h),
              child: SecondaryButton(
                btnWidth: 200,
                isLoading: false,
                text: "print",
                onPressed: () async {
                  await showDialog(
                      barrierDismissible: false,
                      context: context,
                      builder: (_) => CustomerLedgerPrint(
                            items: _customerLedgerListController
                                .tableData.value,
                          ));
                },
              ),
            )
              ],
            ),
    );
  }

  SizedBox transactionType(BuildContext context) {
    return SizedBox(
        width: 200.w,
        child: Obx(() => Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomLabelFilter(label: "Transaction Type"),
                SizedBox(
                  height: 7.w,
                ),
                CustomDropdownSearchField(
                  filled: true,
                  selectedValue: _customerLedgerListController
                      .selectedtransactiontype.value,
                  options: _customerLedgerListController
                      .transactiontypeFilterList.value,
                  onChanged: (value) {
                    _customerLedgerListController
                        .selectedtransactiontype(value);
                    _customerLedgerListController
                        .getcustomerledgerList(context);
                  },
                  hintText: "Transaction Type", controller: _customerLedgerListController.searchTransactiontypeController,
                ),
              ],
            )));
  }

   SizedBox branch(BuildContext context) {
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
                  selectedValue: _customerLedgerListController
                      .selectedbranch.value,
                  options: _customerLedgerListController
                      .brachFilterList.value,
                  onChanged: (value) {
                    _customerLedgerListController
                        .selectedbranch(value);
                    _customerLedgerListController
                        .getcustomerledgerList(context);
                  },
                  hintText: "Branch", controller: _customerLedgerListController.searchBranchController,
                ),
              ],
            )));
  }

  SizedBox salesentryType(BuildContext context) {
    return SizedBox(
        width: 200.w,
        child: Obx(() => Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomLabelFilter(label: "Sales Entry Type"),
                SizedBox(
                  height: 7.w,
                ),
                CustomDropdownSearchField(
                  controller: _customerLedgerListController.searchSalesEntrytypeController,
                  filled: true,
                  selectedValue:
                      _customerLedgerListController.selectedentrytype.value,
                  options:
                      _customerLedgerListController.entrytypeFilterList.value,
                  onChanged: (value) {
                    _customerLedgerListController.selectedentrytype(value);
                    _customerLedgerListController
                        .getcustomerledgerList(context);
                  },
                  hintText: "Entry Type",
                ),
              ],
            )));
  }

  SizedBox customer(BuildContext context) {
    return SizedBox(
        width: 200.w,
        child: Obx(() => Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomLabelFilter(label: "Customer"),
                SizedBox(
                  height: 7.w,
                ),
                CustomDropdownSearchField(
                  controller: _customerLedgerListController.searchCustomerController,
                  filled: true,
                  selectedValue:
                      _customerLedgerListController.selectedcustomer.value,
                  options:
                      _customerLedgerListController.customerFilterList.value,
                  onChanged: (value) {
                    _customerLedgerListController.selectedcustomer(value);
                    _customerLedgerListController
                        .getcustomerledgerList(context);
                  },
                  hintText: "Customer",
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
              controller: _customerLedgerListController.searchController,
              textInputAction: TextInputAction.done,
              keyboardType: TextInputType.text,
              filled: true,
              prefixIcon: Icons.search,
              hasPrefixIcon: true,
              hintText: "Search",
              onChanged: (value) {
                _customerLedgerListController.getcustomerledgerList(context);
              }),
        ],
      ),
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
              controller:
                  _customerLedgerListController.customerledgerDateController,
              textInputAction: TextInputAction.done,
              keyboardType: TextInputType.text,
              filled: true,
              hasSuffixIcon: true,
              suffixIcon: Icons.close,
              suffixClicked: () {
                _customerLedgerListController.customerledgerDateController
                    .clear();
                _customerLedgerListController.getcustomerledgerList(context);
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
                  _customerLedgerListController.customerledgerDateController
                      .text = [startDate, endDate].join(" to ");
                } else {
                  _customerLedgerListController.customerledgerDateController
                      .clear();
                }
                _customerLedgerListController.getcustomerledgerList(context);
              }),
        ],
      ),
    );
  }

  

  SizedBox cancelledStatusFilter(BuildContext context) {
    return SizedBox(
        width: 200.w,
        child: Obx(() => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [ CustomLabelFilter(label: "Cancelled Status"),
          SizedBox(
            height: 7.w,
          ),
            CustomDropdownField(
                  filled: true,
                  selectedValue:
                      _customerLedgerListController.selectedCancelledStatus.value,
                  options:
                      _customerLedgerListController.cancelledStatusFilterList.value,
                  onChanged: (value) {
                    _customerLedgerListController.selectedCancelledStatus(value);
                    _customerLedgerListController.getcustomerledgerList(context);
                  },
                  hintText: "Cancelled Status",
                ),
          ],
        )));
  }

  
}
