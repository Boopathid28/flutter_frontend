import 'package:ausales_application/controller/item_tag_details/item_tag_details_form_controller.dart';
import 'package:ausales_application/core/theme/shadow_palette.dart';
import 'package:ausales_application/responsive.dart';
import 'package:ausales_application/view/widgets/form_widgets/custom_label.dart';
import 'package:ausales_application/view/widgets/form_widgets/custom_text_input.dart';
import 'package:ausales_application/view/widgets/form_widgets/primary_button.dart';
import 'package:ausales_application/view/widgets/screen_widgets/item_tag_details/diamond_details_popup.dart';
import 'package:ausales_application/view/widgets/screen_widgets/item_tag_details/stone_details_popup.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class TagDetailsForm extends StatefulWidget {
  const TagDetailsForm({super.key});

  @override
  State<TagDetailsForm> createState() => _TagDetailsFormState();
}

class _TagDetailsFormState extends State<TagDetailsForm> {
  final TagDetailsFormController _tagDetailsFormController =
      Get.put(TagDetailsFormController());

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(15.w),
      margin: EdgeInsets.all(15.w),
      decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: ShadowPalette.formElevation,
          borderRadius: BorderRadius.circular(15.r)),
      child: Responsive.isDesktop(context)
          ? SizedBox(
              width: double.infinity,
              child: Wrap(
                spacing: 10.w,
                children: [
                  SizedBox(
                    width: double.infinity,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomLabel(label: "Tag Number"),
                        SizedBox(height: 7.h),
                        Row(
                          children: [
                            SizedBox(
                              width: 250.w,
                              child: CustomTextInput(
                                controller: _tagDetailsFormController
                                    .tagnumberController,
                                textInputAction: TextInputAction.next,
                                keyboardType: TextInputType.text,
                                validator: "default",
                                hintText: "Tag Number",
                              ),
                            ),
                            SizedBox(
                              width: 20.w,
                            ),
                            SizedBox(
                                width: Responsive.isDesktop(context) ||
                                        Responsive.isTablet(context)
                                    ? 115.w
                                    : double.infinity,
                                child: Obx(() => PrimaryButton(
                                    btnHeight: 46.h,
                                    isLoading: _tagDetailsFormController
                                        .isFormFind.value,
                                    text: "Find",
                                    onPressed: () {
                                      _tagDetailsFormController
                                          .getTagItemList(
                                              _tagDetailsFormController
                                                      .tagnumberController
                                                      .text ??
                                                  null,
                                              context);
                                    }))),
                                      SizedBox(
                              width: 20.w,
                            ),
                            SizedBox(
                                width: Responsive.isDesktop(context) ||
                                        Responsive.isTablet(context)
                                    ? 115.w
                                    : double.infinity,
                                child: Obx(() => PrimaryButton(
                                    btnHeight: 46.h,
                                    isLoading: _tagDetailsFormController
                                        .isFormFind.value,
                                    text: "Stone Details",
                                    onPressed: () async {
                                      await Get.dialog(
                                          barrierDismissible: false,
                                              TagStoneDetailsPopup());
                                    }))),
                                      SizedBox(
                              width: 20.w,
                            ),
                                     SizedBox(
                                width: Responsive.isDesktop(context) ||
                                        Responsive.isTablet(context)
                                    ? 115.w
                                    : double.infinity,
                                child: Obx(() => PrimaryButton(
                                    btnHeight: 46.h,
                                    isLoading: _tagDetailsFormController
                                        .isFormFind.value,
                                    text: "Diamond Details",
                                   onPressed: () async {
                                      await Get.dialog(
                                          barrierDismissible: false,
                                              TagDiamondDetailsPopup());
                                    }))),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            )
          : SizedBox(),
    );
  }
}
