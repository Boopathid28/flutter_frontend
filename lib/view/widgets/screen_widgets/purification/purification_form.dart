import 'package:ausales_application/controller/purification/purification_form_controller.dart';
import 'package:ausales_application/core/theme/text_palette.dart';
import 'package:ausales_application/responsive.dart';
import 'package:ausales_application/utils/date_helper.dart';
import 'package:ausales_application/view/widgets/form_widgets/custom_dropdown_search_field.dart';
import 'package:ausales_application/view/widgets/form_widgets/custom_label.dart';
import 'package:ausales_application/view/widgets/form_widgets/custom_text_input.dart';
import 'package:ausales_application/view/widgets/form_widgets/primary_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class PurificationForm extends StatefulWidget {
  const PurificationForm({super.key});

  @override
  State<PurificationForm> createState() => _PurificationFormState();
}

class _PurificationFormState extends State<PurificationForm> {
  final PurificationFormController _purificationFormController =
      Get.put(PurificationFormController());
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return AlertDialog.adaptive(
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "Purification",
            style: TextPalette.screenTitle,
          ),
          IconButton(
              onPressed: () {
                Get.back();
                _purificationFormController.resetForm();
              },
              icon: Icon(Icons.close))
        ],
      ),
      content: Container(
        width: size.width,
        child: Form(
          key: _purificationFormController.purificationFormKey,
          child: Wrap(
            spacing: 10.w,
            runSpacing: 10.h,
            children: [
              vendor(),
              Obx(() => _purificationFormController.isBranchuser.value
                  ? branch()
                  : SizedBox()),
              metal(),
              melting(),
              issuedweight(),
              remark(),
              duedate(),
            ],
          ),
        ),
      ),
      actions: [
        SizedBox(
            width: Responsive.isDesktop(context) || Responsive.isTablet(context)
                ? 115.w
                : double.infinity,
            child: Obx(() => PrimaryButton(
                btnHeight: 46.h,
                isLoading: _purificationFormController.isFormSubmit.value,
                text: "Save",
                onPressed: () {
                  _purificationFormController.CreatePurification(context);
                })))
      ],
    );
  }

  SizedBox duedate() {
    return SizedBox(
      width: 300.w,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomLabel(label: "Due Date"),
          SizedBox(height: 7.h),
          CustomTextInput(
            controller: _purificationFormController.duedateController,
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.text,
            validator: "no_validation",
            hintText: "Due Date",
            readOnly: true,
            onTap: () async {
              DateTime? pickedDate = await showDatePicker(
                context: context,
                initialDate: DateTime.now(),
                firstDate: DateTime(1900),
                lastDate: DateTime.now(),
              );

              if (pickedDate != null) {
                _purificationFormController.duedateController.text =
                    DateHelper.convertDateYearMonthDate(pickedDate.toString());
              }
            },
          ),
        ],
      ),
    );
  }

  SizedBox vendor() {
    return SizedBox(
      width: 300.w,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomLabel(label: "Vendor"),
          SizedBox(
            height: 7.w,
          ),
          Obx(() => CustomDropdownSearchField(
                controller:
                    _purificationFormController.searchVendorDesignerController,
                selectedValue:
                    _purificationFormController.selectedvendorDesiner.value,
                options:
                    _purificationFormController.vendordesignerdropdown.value,
                onChanged: (value) {
                  _purificationFormController.selectedvendorDesiner(value);
                },
                hintText: "Vendor",
                isValidate: true,
              ))
        ],
      ),
    );
  }

  SizedBox melting() {
    return SizedBox(
      width: 300.w,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomLabel(label: "Melting"),
          SizedBox(
            height: 7.w,
          ),
          Obx(() => CustomDropdownSearchField(
                controller: _purificationFormController.meltingSearchController,
                selectedValue: _purificationFormController.selectedMelting.value,
                options: _purificationFormController.meltingDropDown.value,
                onChanged: (value) {
                  _purificationFormController.selectedMelting(value);

                  for (var i in _purificationFormController.meltingList.value) {
                    if (i.id.toString() == value?.value) {
                      _purificationFormController.issuedweightController.text = i.receivedWeight!.toStringAsFixed(3);
                      break;
                    }
                  }
                },
                hintText: "Melting",
                isValidate: true,
              ))
        ],
      ),
    );
  }

  SizedBox metal() {
    return SizedBox(
      width: 300.w,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomLabel(label: "Metal"),
          SizedBox(
            height: 7.w,
          ),
          Obx(() => CustomDropdownSearchField(
                controller: _purificationFormController.metalSearchController,
                selectedValue: _purificationFormController.selectedMetal.value,
                options: _purificationFormController.metalDropDown.value,
                onChanged: (value) {
                  _purificationFormController.selectedMetal(value);
                  if (_purificationFormController.selectedBranch.value !=
                      null) {
                    _purificationFormController.getMeltingList(
                        _purificationFormController.selectedBranch.value?.value,
                        value?.value);
                  } else {
                    _purificationFormController.getMeltingList(
                        null, value?.value);
                  }
                },
                hintText: "Metal",
                isValidate: true,
              ))
        ],
      ),
    );
  }

  SizedBox branch() {
    return SizedBox(
      width: 300.w,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomLabel(label: "Branch"),
          SizedBox(
            height: 7.w,
          ),
          Obx(() => CustomDropdownSearchField(
                controller: _purificationFormController.branchSearchController,
                selectedValue: _purificationFormController.selectedBranch.value,
                options: _purificationFormController.branchDropDown.value,
                onChanged: (value) {
                  _purificationFormController.selectedBranch(value);
                  _purificationFormController.getMeltingList(value?.value,
                      _purificationFormController.selectedMetal.value?.value);
                },
                hintText: "Branch",
                isValidate: true,
              ))
        ],
      ),
    );
  }

  SizedBox issuedweight() {
    return SizedBox(
      width: 300.w,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomLabel(label: "Issued Weight"),
          SizedBox(
            height: 7.w,
          ),
          CustomTextInput(
            inputFormat: 'double',
            controller: _purificationFormController.issuedweightController,
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.numberWithOptions(),
            validator: "default",
            hintText: "Issued Weight",
          ),
        ],
      ),
    );
  }

  SizedBox remark() {
    return SizedBox(
      width: 300.w,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomLabel(label: "Remark"),
          SizedBox(height: 7.h),
          CustomTextInput(
            controller: _purificationFormController.remarkController,
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.text,
            validator: "no_validation",
            hintText: "Remark",
          ),
        ],
      ),
    );
  }
}
