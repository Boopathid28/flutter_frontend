import 'package:ausales_application/controller/lot/lot_form_controller.dart';
import 'package:ausales_application/core/theme/text_palette.dart';
import 'package:ausales_application/view/widgets/form_widgets/custom_dropdown_field.dart';
import 'package:ausales_application/view/widgets/form_widgets/custom_dropdown_search_field.dart';
import 'package:ausales_application/view/widgets/form_widgets/custom_label.dart';
import 'package:ausales_application/view/widgets/form_widgets/custom_text_input.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class LotDetailForm extends StatefulWidget {
  const LotDetailForm({super.key});

  @override
  State<LotDetailForm> createState() => _LotDetailFormState();
}

class _LotDetailFormState extends State<LotDetailForm> {
  final LotFormController _lotFormController = Get.put(LotFormController());

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Form(
      key: _lotFormController.lotDetailsFormKey,
        child: Container(
          padding: EdgeInsets.all(15.w),
          decoration: BoxDecoration(
            color: Colors.white,),
          width: 300.w,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Lot Details", style: TextPalette.tableHeaderTextStyle,),
              Divider(
                thickness: 1.sp,
              ),
              SizedBox(
                height: 7.h,
              ),
              Obx(() => _lotFormController.isBranchuser.value ? branch() : SizedBox()),
              SizedBox(
                height: 7.h,
              ),
              entryDate(),
              SizedBox(
                height: 7.h,
              ),
              entryType(),
              SizedBox(
                height: 7.h,
              ),
              designer(),
              SizedBox(
                height: 7.h,
              ),
              refInvoiceNumber(),
              SizedBox(
                height: 7.h,
              ),
              hallmarkCertificateNo(),
              SizedBox(
                height: 7.h,
              ),
              hallmarkCentreNo()
            ],
          ),
        ));
  }

  SizedBox hallmarkCentreNo() {
    return SizedBox(
      width: 300.w,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomLabel(label: "Hallmark Centre No"),
          SizedBox(height: 7.h),
          CustomTextInput(
            controller: _lotFormController.hallmarkCentreNoController,
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.text,
            validator: "no_validate",
            hintText: "Hallmark Centre No",
          ),
        ],
      ),
    );
  }

  SizedBox hallmarkCertificateNo() {
    return SizedBox(
      width: 300.w,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomLabel(label: "Hallmark Certificate No"),
          SizedBox(height: 7.h),
          CustomTextInput(
            controller: _lotFormController.hallmarkCertificateNoController,
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.text,
            validator: "no_validate",
            hintText: "Hallmark Certificate No",
          ),
        ],
      ),
    );
  }

  SizedBox refInvoiceNumber() {
    return SizedBox(
      width: 300.w,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomLabel(label: "Ref.Invoice No"),
          SizedBox(height: 7.h),
          CustomTextInput(
            controller: _lotFormController.refInvoiceNoController,
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.text,
            validator: "no_validate",
            hintText: "Ref.Invoice No",
          ),
        ],
      ),
    );
  }

  SizedBox designer() {
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
                controller: _lotFormController.designerSearchController,
                selectedValue: _lotFormController.selectedDesigner.value,
                options: _lotFormController.designerDropDown.value,
                onChanged: (value) {
                  _lotFormController.selectedDesigner(value);
                },
                hintText: "Vendor",
              ))
        ],
      ),
    );
  }

  SizedBox entryType() {
    return SizedBox(
      width: 300.w,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomLabel(label: "Entry Type"),
          SizedBox(
            height: 7.w,
          ),
          Obx(() => CustomDropdownField(
                selectedValue: _lotFormController.selectedEntryType.value,
                options: _lotFormController.entryTypeDropDown.value,
                onChanged: (value) {
                  _lotFormController.selectedEntryType(value);
                },
                hintText: "Entry Type",
              ))
        ],
      ),
    );
  }

  SizedBox entryDate() {
    return SizedBox(
      width: 300.w,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomLabel(label: "Entry Date"),
          SizedBox(height: 7.h),
          CustomTextInput(
            readOnly: true,
            onTap: () async {
              final today = DateTime.now();
              final endYear = today.year + 1;
              DateTime? pickedDate = await showDatePicker(
                  context: context,
                  firstDate: DateTime(1900),
                  lastDate: DateTime(endYear));
              if (pickedDate != null) {
                _lotFormController.entryDateController.text =
                    pickedDate.toString().substring(0, 10);
              } else {
                _lotFormController.entryDateController.clear();
              }
            },
            controller: _lotFormController.entryDateController,
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.text,
            validator: "default",
            hintText: "Entry Date",
          ),
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
                controller: _lotFormController.branchSearchController,
                selectedValue: _lotFormController.selectedBranch.value,
                options: _lotFormController.branchDropDown.value,
                onChanged: (value) {
                  _lotFormController.selectedBranch(value);
                },
                hintText: "Branch",
              ))
        ],
      ),
    );
  }
}
