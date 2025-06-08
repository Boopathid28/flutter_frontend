import 'package:ausales_application/controller/metal_rate_master/metal_rate_master_list_controller.dart';
import 'package:ausales_application/core/theme/color_palette.dart';
import 'package:ausales_application/core/theme/shadow_palette.dart';
import 'package:ausales_application/model/drop_down_model.dart';
import 'package:ausales_application/model/metal_rates/metal_rate_master.dart';
import 'package:ausales_application/responsive.dart';
import 'package:ausales_application/view/widgets/form_widgets/custom_label.dart';
import 'package:ausales_application/view/widgets/form_widgets/custom_text_input.dart';
import 'package:ausales_application/view/widgets/form_widgets/primary_button.dart';
import 'package:ausales_application/view/widgets/form_widgets/secondary_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class MetalRateForm extends StatefulWidget {
  const MetalRateForm({super.key});

  @override
  State<MetalRateForm> createState() => _MetalRateFormState();
}

class _MetalRateFormState extends State<MetalRateForm> {
  final MetalRateMasterListController _metalRateMasterListController =
      Get.put(MetalRateMasterListController());

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
        key: _metalRateMasterListController.metalRateFormKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Obx(() => GridView.builder(
              shrinkWrap: true,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: Responsive.isDesktop(context)
                      ? 4
                      : Responsive.isTablet(context)
                          ? 2
                          : 1, // Number of columns
                  crossAxisSpacing: 10.w, // Spacing between columns
                  mainAxisSpacing: 10.h,
                  mainAxisExtent: 100.h),
              itemCount: _metalRateMasterListController.fieldList.value.length,
              itemBuilder: (context, index) {
                final item =
                    _metalRateMasterListController.fieldList.value[index];
                return MetalRateField(item: item, index: index);
              })),
          actions(context),
        ],
      )),
    );
  }

  SizedBox actions(BuildContext context) {
    return SizedBox(
      width: 300.w,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          SizedBox(
              width: 145.w,
              child: Obx(() => PrimaryButton(
                  btnHeight: 46.h,
                  isLoading: _metalRateMasterListController.isFormSubmit.value,
                  text: "Save",
                  onPressed: () {
                    _metalRateMasterListController.submitMetalRateForm(context);
                  }))),
          SizedBox(
            width: 10.w,
          ),
          SizedBox(
              width: 145.w,
              child: SecondaryButton(
                  btnHeight: 46.h,
                  isLoading: _metalRateMasterListController.isFormSubmit.value,
                  text: "Clear",
                  onPressed: () {
                    _metalRateMasterListController.resetForm();
                  }))
        ],
      ),
    );
  }
}

class MetalRateField extends StatefulWidget {
  MetalRateFormFieldModel item;
  int index;

  MetalRateField({super.key, required this.item, required this.index});

  @override
  State<MetalRateField> createState() => _MetalRateFieldState();
}

class _MetalRateFieldState extends State<MetalRateField> {
  final MetalRateMasterListController _metalRateMasterListController =
      Get.put(MetalRateMasterListController());

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomLabel(label: widget.item.label.toString()),
        TextFormField(
          validator: (value) {
         
            return null;
          },
          inputFormatters: [
            FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d*$'))
          ],
          onChanged: (value) {
            _metalRateMasterListController.onFieldValueUpdate(widget.index, value);
          },
          decoration: InputDecoration(
              fillColor: ColorPalete.inputFilledColor,
              hintText: widget.item.label,
              hintStyle:
                  TextStyle(color: ColorPalete.filledInputPlaceholderColor),
              border: _borderInput(),
              focusedBorder: _borderFocusInput(),
              enabledBorder: _borderInput(),
              contentPadding:
                  Responsive.isDesktop(context) || Responsive.isTablet(context)
                      ? EdgeInsets.symmetric(vertical: 15.h, horizontal: 10.w)
                      : EdgeInsets.symmetric(vertical: 5.h, horizontal: 10.w)),
        ),
      ],
    );
  }

  OutlineInputBorder _borderInput() {
    return OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(5.r)),
        borderSide: BorderSide(
          color: ColorPalete.inputBorderColor,
          width: 1,
        ));
  }

  OutlineInputBorder _borderFocusInput() {
    return OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(5.r)),
        borderSide: BorderSide(
          color: ColorPalete.inputFocusBorderColor,
          width: 1,
        ));
  }
}
