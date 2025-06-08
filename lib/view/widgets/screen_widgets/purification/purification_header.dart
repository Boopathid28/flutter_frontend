import 'package:ausales_application/controller/purification/purification_list_controller.dart';
import 'package:ausales_application/view/widgets/form_widgets/custom_dropdown_field.dart';
import 'package:ausales_application/view/widgets/form_widgets/custom_dropdown_search_field.dart';
import 'package:ausales_application/view/widgets/form_widgets/custom_label_filter.dart';
import 'package:ausales_application/view/widgets/form_widgets/custom_text_input.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class PurificationHeader extends StatefulWidget {
  const PurificationHeader({super.key});

  @override
  State<PurificationHeader> createState() => _PurificationHeaderState();
}

class _PurificationHeaderState extends State<PurificationHeader> {
  final PurificationListController _purificationListController = Get.put(PurificationListController());

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
          metal(),
          Obx(()=> _purificationListController.isBranchuser.value ? branch() : SizedBox()),
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
                  controller: _purificationListController.searchController,
                  textInputAction: TextInputAction.done,
                  keyboardType: TextInputType.text,
                  filled: true,
                  prefixIcon: Icons.search,
                  hasPrefixIcon: true,
                  hintText: "Search",
                  onChanged: (value) {
                    _purificationListController.getPurificationList(context);
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
                controller: _purificationListController.branchSearchController,
                selectedValue: _purificationListController.selectedBranch.value,
                options: _purificationListController.branchDropDown.value,
                onChanged: (value) {
                  _purificationListController.selectedBranch(value);
                  _purificationListController.getPurificationList(context);
                },
                hintText: "Branch",
              ),
            ],
          )),
    );
  }

SizedBox metal() {
    return SizedBox(
      width: 200.w,
      child: Obx(() => Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomLabelFilter(label: "Metal"),
              SizedBox(
                height: 7.h,
              ),
              CustomDropdownSearchField(
                filled: true,
                controller: _purificationListController.metalSearchFilterController,
                selectedValue: _purificationListController.selectedMetal.value,
                options: _purificationListController.metalFilterList.value,
                onChanged: (value) {
                  _purificationListController.selectedMetal(value);
                  _purificationListController.getPurificationList(context);
                },
                hintText: "Metal",
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
                  selectedValue: _purificationListController.selectedReceivedStatus.value,
                  options: _purificationListController.receivedStatusFilterList.value,
                  onChanged: (value) {
                    _purificationListController.selectedReceivedStatus(value);
                    _purificationListController.getPurificationList(context);
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
                  controller: _purificationListController.vendorSearchController,
                  filled: true,
                  selectedValue: _purificationListController.selectedVendor.value,
                  options: _purificationListController.vendorFilterList.value,
                  onChanged: (value) {
                    _purificationListController.selectedVendor(value);
                    _purificationListController.getPurificationList(context);
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
                  selectedValue: _purificationListController.selectedCancelStatus.value,
                  options: _purificationListController.cancelStatusFilterList.value,
                  onChanged: (value) {
                    _purificationListController.selectedCancelStatus(value);
                    _purificationListController.getPurificationList(context);
                  },
                  hintText: "Cancel Status",
                ),
          ],
        )));
  }
}
