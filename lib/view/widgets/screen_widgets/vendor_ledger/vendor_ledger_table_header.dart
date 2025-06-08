import 'package:ausales_application/controller/vendor_ledger/vendor_ledger_list_controller.dart';
import 'package:ausales_application/responsive.dart';
import 'package:ausales_application/view/widgets/form_widgets/custom_dropdown_field.dart';
import 'package:ausales_application/view/widgets/form_widgets/custom_dropdown_search_field.dart';
import 'package:ausales_application/view/widgets/form_widgets/custom_text_input.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class VendorLedgerTableHeader extends StatefulWidget {
  const VendorLedgerTableHeader({super.key});

  @override
  State<VendorLedgerTableHeader> createState() =>
      _VendorLedgerTableHeaderState();
}

class _VendorLedgerTableHeaderState extends State<VendorLedgerTableHeader> {
  final VendorLedgerListController _vendorLedgerListController =
      Get.put(VendorLedgerListController());

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(15.w),
      child: Responsive.isDesktop(context) || Responsive.isTablet(context)
          ? Wrap(
              spacing: 10.w,
              runSpacing: 10.h,
              children: [
                activeStatusFilter(context),
                Obx(() => _vendorLedgerListController.isBranchuser.value
                    ? branch(context)
                    : SizedBox()),
                vendordesignerFilter(context),
                TransactionType(context),
                searchFilter(context)
              ],
            )
          : Column(
              children: [
                activeStatusFilter(context),
                SizedBox(
                  height: 7.h,
                ),
                vendordesignerFilter(context),
                SizedBox(
                  height: 7.h,
                ),
                TransactionType(context),
                SizedBox(
                  height: 7.h,
                ),
                searchFilter(context),
              ],
            ),
    );
  }

  SizedBox branch(BuildContext context) {
    return SizedBox(
        width: 200.w,
        child: Obx(() => CustomDropdownSearchField(
              controller: _vendorLedgerListController.searchBranchController,
              filled: true,
              selectedValue: _vendorLedgerListController.selectedBranch.value,
              options: _vendorLedgerListController.branchDropdown.value,
              onChanged: (value) {
                _vendorLedgerListController.selectedBranch(value);
                _vendorLedgerListController.getvendorledgerList(context);
              },
              hintText: "Branch",
            )));
  }

  SizedBox TransactionType(BuildContext context) {
    return SizedBox(
        width: 200.w,
        child: Obx(() => CustomDropdownSearchField(
              controller:
                  _vendorLedgerListController.searchTransactionController,
              filled: true,
              selectedValue:
                  _vendorLedgerListController.selectedtransactiontype.value,
              options:
                  _vendorLedgerListController.transactionTypeFilterList.value,
              onChanged: (value) {
                _vendorLedgerListController.selectedtransactiontype(value);
                _vendorLedgerListController.getvendorledgerList(context);
              },
              hintText: "Transaction Type",
            )));
  }

  SizedBox searchFilter(BuildContext context) {
    return SizedBox(
      width: 300.w,
      child: CustomTextInput(
          controller: _vendorLedgerListController.searchController,
          textInputAction: TextInputAction.done,
          keyboardType: TextInputType.text,
          filled: true,
          prefixIcon: Icons.search,
          hasPrefixIcon: true,
          hintText: "Search",
          onChanged: (value) {
            _vendorLedgerListController.getvendorledgerList(context);
          }),
    );
  }

  SizedBox activeStatusFilter(BuildContext context) {
    return SizedBox(
        width: 200.w,
        child: Obx(() => CustomDropdownField(
              filled: true,
              selectedValue:
                  _vendorLedgerListController.selectedActiveStatus.value,
              options: _vendorLedgerListController.activeStatusFilterList.value,
              onChanged: (value) {
                _vendorLedgerListController.selectedActiveStatus(value);
                _vendorLedgerListController.getvendorledgerList(context);
              },
              hintText: "Purity Status",
            )));
  }

  SizedBox vendordesignerFilter(BuildContext context) {
    return SizedBox(
        width: 200.w,
        child: Obx(() => CustomDropdownSearchField(
              controller:
                  _vendorLedgerListController.searchVendorDesignerController,
              filled: true,
              selectedValue:
                  _vendorLedgerListController.selectedvendorDesiner.value,
              options:
                  _vendorLedgerListController.vendordesignerFilterList.value,
              onChanged: (value) {
                _vendorLedgerListController.selectedvendorDesiner(value);
                _vendorLedgerListController.getvendorledgerList(context);
              },
              hintText: "Designer Status",
            )));
  }
}
