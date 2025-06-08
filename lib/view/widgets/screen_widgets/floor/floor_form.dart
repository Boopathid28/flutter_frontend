import 'package:ausales_application/controller/floor/floor_form_controller.dart';
import 'package:ausales_application/core/theme/shadow_palette.dart';
import 'package:ausales_application/responsive.dart';
import 'package:ausales_application/view/widgets/form_widgets/custom_dropdown_search_field.dart';
import 'package:ausales_application/view/widgets/form_widgets/custom_label.dart';
import 'package:ausales_application/view/widgets/form_widgets/custom_text_input.dart';
import 'package:ausales_application/view/widgets/form_widgets/primary_button.dart';
import 'package:ausales_application/view/widgets/form_widgets/secondary_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class FloorForm extends StatefulWidget {
  const FloorForm({super.key});

  @override
  State<FloorForm> createState() => _FloorFormState();
}

class _FloorFormState extends State<FloorForm> {
  final FloorFormController _floorFormController =
      Get.put(FloorFormController());

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(15.w),
      margin: EdgeInsets.all(15.w),
      decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: ShadowPalette.formElevation,
          borderRadius: BorderRadius.circular(15.r)),
      child: Form(
        key: _floorFormController.floorFormKey,
        child: Responsive.isDesktop(context)
            ? Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  floorname(),
                  SizedBox(
                    width: 10.w,
                  ),
               Obx(() => _floorFormController.isBranchuser.value ? branch() : SizedBox(),),
                  SizedBox(
                    width: 10.w,
                  ),
                  actions(context)
                ],
              )
            : Responsive.isTablet(context)
                ? Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        children: [
                          floorname(),
                          SizedBox(
                            height: 10.h,
                          ),
                         Obx(() => _floorFormController.isBranchuser.value ? branch() : SizedBox(),),
                        ],
                      ),
                      SizedBox(
                        width: 10.w,
                      ),
                      Column(
                        children: [actions(context)],
                      ),
                    ],
                  )
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      floorname(),
                      SizedBox(
                        height: 10.w,
                      ),
                       Obx(() => _floorFormController.isBranchuser.value ? branch() : SizedBox(),),
                       SizedBox(
                        height: 10.w,
                      ),
                      actions(context)
                    ],
                  ),
      ),
    );
  }

  SizedBox actions(BuildContext context) {
    return SizedBox(
      width: 300.w,
      height: 73.h,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          SizedBox(
              width: 145.w,
              child: Obx(() => PrimaryButton(
                  btnHeight: 46.h,
                  isLoading: _floorFormController.isFormSubmit.value,
                  text: "Save",
                  onPressed: () {
                    _floorFormController.submitFloorForm(context);
                  }))),
          SizedBox(
            width: 10.w,
          ),
          SizedBox(
              width: 145.w,
              child: SecondaryButton(
                  btnHeight: 46.h,
                  isLoading: _floorFormController.isFormSubmit.value,
                  text: "Clear",
                  onPressed: () {
                    _floorFormController.resetForm();
                  }))
        ],
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
                controller: _floorFormController.branchSearchController,
                selectedValue: _floorFormController.selectedBranch.value,
                options: _floorFormController.branchDropDown.value,
                onChanged: (value) {
                  _floorFormController.selectedBranch(value);
                },
                hintText: "Branch",
              ))
        ],
      ),
    );
  }

  SizedBox floorname() {
    return SizedBox(
      width: 300.w,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomLabel(label: "Floor Name"),
          SizedBox(height: 7.h),
          CustomTextInput(
            controller: _floorFormController.floornameController,
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.text,
            validator: "default",
            hintText: "Floor Name",
          ),
        ],
      ),
    );
  }
}
