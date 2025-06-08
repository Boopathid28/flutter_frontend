import 'package:ausales_application/controller/melting_receipt/melting_receipt_list_controller.dart';
import 'package:ausales_application/view/widgets/form_widgets/custom_dropdown_field.dart';
import 'package:ausales_application/view/widgets/form_widgets/custom_dropdown_search_field.dart';
import 'package:ausales_application/view/widgets/form_widgets/custom_label_filter.dart';
import 'package:ausales_application/view/widgets/form_widgets/custom_text_input.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class MeltingReceiptHeader extends StatefulWidget {
  const MeltingReceiptHeader({super.key});

  @override
  State<MeltingReceiptHeader> createState() => _MeltingReceiptHeaderState();
}

class _MeltingReceiptHeaderState extends State<MeltingReceiptHeader> {
  final MeltingReceiptListController _meltingReceiptListController = Get.put(MeltingReceiptListController());

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(15.w),
      child: Wrap(
        runSpacing: 10.h,
        spacing: 10.w,
        children: [
          receivedStatusFilter(context),
          cancelStatusFilter(context),
          vendorFilter(context),
          Obx(()=> _meltingReceiptListController.isBranchuser.value ? branch() : SizedBox()),
          searchFilter(context)
        ],
      )
      );
    
  }

  SizedBox searchFilter(BuildContext context) {
    return SizedBox(
         width: 200.w,
          child: Column(
            
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomLabelFilter(label: "Search"),
              SizedBox(  height: 7.h,),
              CustomTextInput(
                  controller: _meltingReceiptListController.searchController,
                  textInputAction: TextInputAction.done,
                  keyboardType: TextInputType.text,
                  filled: true,
                  prefixIcon: Icons.search,
                  hasPrefixIcon: true,
                  hintText: "Search",
                  onChanged: (value) {
                    _meltingReceiptListController.getmeltingReceiptList(context);
                  }),
            ],
          ),
        );
  }

   SizedBox branch() {
    return SizedBox(
      width: 200.w,
      child: Obx(() => Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomLabelFilter(label: "Branch"),
              SizedBox(
                height: 7.h,
              ),
              CustomDropdownSearchField(
                filled: true,
                controller: _meltingReceiptListController.branchSearchController,
                selectedValue: _meltingReceiptListController.selectedBranch.value,
                options: _meltingReceiptListController.branchDropDown.value,
                onChanged: (value) {
                  _meltingReceiptListController.selectedBranch(value);
                  _meltingReceiptListController.getmeltingReceiptList(context);
                },
                hintText: "Branch",
              ),
            ],
          )),
    );
  }

  SizedBox receivedStatusFilter(BuildContext context) {
    return SizedBox(
        width: 200.w,
        child: Obx(() => Column(
            crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomLabelFilter(label: "Received Status"),
            SizedBox(height: 7.h,),
            CustomDropdownField(
              filled: true,
                  selectedValue: _meltingReceiptListController.selectedReceivedStatus.value,
                  options: _meltingReceiptListController.receivedStatusFilterList.value,
                  onChanged: (value) {
                    _meltingReceiptListController.selectedReceivedStatus(value);
                    _meltingReceiptListController.getmeltingReceiptList(context);
                  },
                  hintText: "Received Status",
                ),
          ],
        )));
  }

SizedBox vendorFilter(BuildContext context) {
    return SizedBox(
        width: 200.w,
        child: Obx(() => Column(
            crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomLabelFilter(label: "Vendor"),
            SizedBox(height: 7.h,),
            CustomDropdownSearchField(
                  controller: _meltingReceiptListController.vendorSearchController,
                  filled: true,
                  selectedValue: _meltingReceiptListController.selectedVendor.value,
                  options: _meltingReceiptListController.vendorFilterList.value,
                  onChanged: (value) {
                    _meltingReceiptListController.selectedVendor(value);
                    _meltingReceiptListController.getmeltingReceiptList(context);
                  },
                  hintText: "Vendor",
                ),
          ],
        )));
  }
  
  SizedBox cancelStatusFilter(BuildContext context) {
    return SizedBox(
        width: 200.w,
        child: Obx(() => Column(
            crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomLabelFilter(label: "Cancel Status"),
            SizedBox(height: 7.h,),
            CustomDropdownField(
              filled: true,
                  selectedValue: _meltingReceiptListController.selectedCancelStatus.value,
                  options: _meltingReceiptListController.cancelStatusFilterList.value,
                  onChanged: (value) {
                    _meltingReceiptListController.selectedCancelStatus(value);
                    _meltingReceiptListController.getmeltingReceiptList(context);
                  },
                  hintText: "Cancel Status",
                ),
          ],
        )));
  }
}
