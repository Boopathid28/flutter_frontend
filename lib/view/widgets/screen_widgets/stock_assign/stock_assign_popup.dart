import 'package:ausales_application/controller/item_tag_details/item_tag_details_form_controller.dart';
import 'package:ausales_application/controller/stock_assign/stock_assign_form_controller.dart';
import 'package:ausales_application/core/theme/shadow_palette.dart';
import 'package:ausales_application/responsive.dart';
import 'package:ausales_application/view/widgets/form_widgets/custom_dropdown_field.dart';
import 'package:ausales_application/view/widgets/form_widgets/custom_dropdown_search_field.dart';
import 'package:ausales_application/view/widgets/form_widgets/custom_label.dart';
import 'package:ausales_application/view/widgets/form_widgets/custom_text_input.dart';
import 'package:ausales_application/view/widgets/form_widgets/primary_button.dart';
import 'package:ausales_application/view/widgets/screen_widgets/item_tag_details/diamond_details_popup.dart';
import 'package:ausales_application/view/widgets/screen_widgets/item_tag_details/stone_details_popup.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class StockAssignPopupdetail3 extends StatefulWidget {
  const StockAssignPopupdetail3({super.key});

  @override
  State<StockAssignPopupdetail3> createState() =>
      _StockAssignPopupdetail3State();
}

class _StockAssignPopupdetail3State extends State<StockAssignPopupdetail3> {
  final StockAssignPopupFormController _stockAssignPopupFormController =
      Get.put(StockAssignPopupFormController());

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(15.w),
      margin: EdgeInsets.all(15.w),
      child:SizedBox(
              width: double.infinity,
              child: Wrap(
                spacing: 10.w,
                runSpacing: 10.h,
                children: [
                  tagnumber(),
                ],
              ),
            ),
    );
  }

  SizedBox branch() {
    return SizedBox(
      width: 250.w,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomLabel(label: "Branch"),
          SizedBox(
            height: 7.w,
          ),
          Obx(() => CustomDropdownSearchField(
                selectedValue:
                    _stockAssignPopupFormController.selectedBranch.value,
                options: _stockAssignPopupFormController.branchDropDown.value,
                onChanged: (value) {
                  _stockAssignPopupFormController.selectedBranch(value);
                  // _stockAssignPopupFormController.getTagnumberList(value!.value);
                },
                hintText: "Branch", controller: _stockAssignPopupFormController.branchSearchController,
              ))
        ],
      ),
    );
  }

   SizedBox tagnumber() {
    return SizedBox(
      width: 250.w,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomLabel(label: "Tag Number"),
          SizedBox(
            height: 7.w,
          ),
          Obx(() => CustomDropdownSearchField(
                selectedValue:
                    _stockAssignPopupFormController.selectedTag.value,
                options: _stockAssignPopupFormController.tagnumberDropDown.value,
                onChanged: (value) {
                  _stockAssignPopupFormController.selectedTag(value);
                  _stockAssignPopupFormController.getTagItemList(value!.label, context);
                },
                hintText: "Tag Number", controller: _stockAssignPopupFormController.tagSearchController,
              ))
        ],
      ),
    );
  }

  SizedBox find(BuildContext context) {
    return SizedBox(
        width: Responsive.isDesktop(context) || Responsive.isTablet(context)
            ? 115.w
            : double.infinity,
        child: Obx(() => PrimaryButton(
            btnHeight: 46.h,
            isLoading: _stockAssignPopupFormController.isTableLoading.value,
            text: "Find",
            onPressed: () {
              _stockAssignPopupFormController.getTagItemList(
                  _stockAssignPopupFormController.tagnumController.text,
                  context);
            })));
  }
}
