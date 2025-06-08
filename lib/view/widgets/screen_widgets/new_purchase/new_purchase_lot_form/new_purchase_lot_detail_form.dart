import 'package:ausales_application/controller/lot/lot_form_controller.dart';
import 'package:ausales_application/controller/new_purchase/new_purchase_to_lot/newpurchase_to_lot_form_controller.dart';
import 'package:ausales_application/core/theme/text_palette.dart';
import 'package:ausales_application/view/widgets/form_widgets/custom_dropdown_field.dart';
import 'package:ausales_application/view/widgets/form_widgets/custom_dropdown_search_field.dart';
import 'package:ausales_application/view/widgets/form_widgets/custom_label.dart';
import 'package:ausales_application/view/widgets/form_widgets/custom_text_input.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class NewPurchaseLotDetailForm extends StatefulWidget {
  const NewPurchaseLotDetailForm({super.key});

  @override
  State<NewPurchaseLotDetailForm> createState() => _NewPurchaseLotDetailFormState();
}

class _NewPurchaseLotDetailFormState extends State<NewPurchaseLotDetailForm> {
  final NewpurchaseToLotFormController _newpurchaseToLotFormController = Get.put(NewpurchaseToLotFormController());

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Form(
      key: _newpurchaseToLotFormController.lotDetailsFormKey,
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Container(
            padding: EdgeInsets.all(15.w),
            decoration: BoxDecoration(
              color: Colors.white,),
            width: double.infinity,
            child: Wrap(
              spacing: 10.w,
              runSpacing: 10.h,
              children: [
                Text("Lot Details", style: TextPalette.tableHeaderTextStyle,),
                Divider(
                  thickness: 1.sp,
                ),
                SizedBox(
                  height: 7.h,
                ),
                Obx(() => _newpurchaseToLotFormController.isBranchuser.value ? branch() : SizedBox()),
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
                entryDate(),
                SizedBox(
                  height: 7.h,
                ),
                entryType(),
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
          ),
        ));
  }

  SizedBox hallmarkCentreNo() {
    return SizedBox(
      width: 200.w,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomLabel(label: "Hallmark Centre No"),
          SizedBox(height: 7.h),
          CustomTextInput(
            controller: _newpurchaseToLotFormController.hallmarkCentreNoController,
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
      width: 200.w,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomLabel(label: "Hallmark Certificate No"),
          SizedBox(height: 7.h),
          CustomTextInput(
            controller: _newpurchaseToLotFormController.hallmarkCertificateNoController,
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
      width: 200.w,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomLabel(label: "Ref.Invoice No"),
          SizedBox(height: 7.h),
          CustomTextInput(
            controller: _newpurchaseToLotFormController.refInvoiceNoController,
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
      width: 200.w,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomLabel(label: "Vendor"),
          SizedBox(
            height: 7.w,
          ),
          Obx(() => CustomDropdownSearchField(
                controller: _newpurchaseToLotFormController.designerSearchController,
                selectedValue: _newpurchaseToLotFormController.selectedDesigner.value,
                options: _newpurchaseToLotFormController.designerDropDown.value,
                onChanged: (value) {
                  _newpurchaseToLotFormController.selectedDesigner(value);
                },
                hintText: "Vendor",
              ))
        ],
      ),
    );
  }

  SizedBox entryType() {
    return SizedBox(
      width: 200.w,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomLabel(label: "Entry Type"),
          SizedBox(
            height: 7.w,
          ),
          Obx(() => CustomDropdownField(
                selectedValue: _newpurchaseToLotFormController.selectedEntryType.value,
                options: _newpurchaseToLotFormController.entryTypeDropDown.value,
                onChanged: (value) {
                  _newpurchaseToLotFormController.selectedEntryType(value);
                },
                hintText: "Entry Type",
              ))
        ],
      ),
    );
  }

  SizedBox entryDate() {
    return SizedBox(
      width: 200.w,
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
                _newpurchaseToLotFormController.entryDateController.text =
                    pickedDate.toString().substring(0, 10);
              } else {
                _newpurchaseToLotFormController.entryDateController.clear();
              }
            },
            controller: _newpurchaseToLotFormController.entryDateController,
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
      width: 200.w,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomLabel(label: "Branch"),
          SizedBox(
            height: 7.w,
          ),
          Obx(() => CustomDropdownSearchField(
                controller: _newpurchaseToLotFormController.branchSearchController,
                selectedValue: _newpurchaseToLotFormController.selectedBranch.value,
                options: _newpurchaseToLotFormController.branchDropDown.value,
                onChanged: (value) {
                  _newpurchaseToLotFormController.selectedBranch(value);
                },
                hintText: "Branch",
              ))
        ],
      ),
    );
  }
}
