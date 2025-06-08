import 'package:ausales_application/controller/counter/counter_form_controller.dart';
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

class CounterForm extends StatefulWidget {
  const CounterForm({super.key});

  @override
  State<CounterForm> createState() => _CounterFormState();
}

class _CounterFormState extends State<CounterForm> {
  final CounterFormController _counterFormController =
      Get.put(CounterFormController());

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
        key: _counterFormController.counterFormKey,
        child: Responsive.isDesktop(context)
            ? Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  countername(),
                  SizedBox(
                    width: 10.w,
                  ),
                       Obx(() => _counterFormController.isBranchuser.value ? branch() : SizedBox(),),
                  SizedBox(
                    width: 10.w,
                  ),
                  floor(),
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
                          countername(),
                          SizedBox(
                            height: 10.h,
                          ),
                               Obx(() => _counterFormController.isBranchuser.value ? branch() : SizedBox(),),
                          SizedBox(
                            height: 10.w,
                          ),
                          floor(),
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
                      countername(),
                      SizedBox(
                        height: 10.w,
                      ),
                           Obx(() => _counterFormController.isBranchuser.value ? branch() : SizedBox(),),
                      SizedBox(
                        height: 10.w,
                      ),
                      floor(),
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
                  isLoading: _counterFormController.isFormSubmit.value,
                  text: "Save",
                  onPressed: () {
                    _counterFormController.submitCounterForm(context);
                  }))),
          SizedBox(
            width: 10.w,
          ),
          SizedBox(
              width: 145.w,
              child: SecondaryButton(
                  btnHeight: 46.h,
                  isLoading: _counterFormController.isFormSubmit.value,
                  text: "Clear",
                  onPressed: () {
                    _counterFormController.resetForm();
                  }))
        ],
      ),
    );
  }

  SizedBox branch() {
    return SizedBox(
      width: 335.w,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomLabel(label: "Branch"),
          SizedBox(
            height: 7.w,
          ),
          Obx(() => CustomDropdownSearchField(
                controller: _counterFormController.branchSearchController,
                selectedValue: _counterFormController.selectedBranch.value,
                options: _counterFormController.branchDropDown.value,
                onChanged: (value) {
                  _counterFormController.selectedBranch(value);
                  _counterFormController.getFloorList(value!.value);
                },
                hintText: "Branch",
              ))
        ],
      ),
    );
  }

  SizedBox countername() {
    return SizedBox(
      width: 335.w,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomLabel(label: "CounterName"),
          SizedBox(height: 7.h),
          CustomTextInput(
            controller: _counterFormController.counternameController,
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.text,
            validator: "default",
            hintText: "Countername",
          ),
        ],
      ),
    );
  }

  SizedBox floor() {
    return SizedBox(
      width: 335.w,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomLabel(label: "Floor"),
          SizedBox(
            height: 7.w,
          ),
          Obx(() => CustomDropdownSearchField(
                controller: _counterFormController.searchFloorController,
                selectedValue: _counterFormController.selectedFloor.value,
                options: _counterFormController.floorDropDown.value,
                onChanged: (value) {
                  _counterFormController.selectedFloor(value);
                },
                hintText: "Floor",
              ))
        ],
      ),
    );
  }
}
