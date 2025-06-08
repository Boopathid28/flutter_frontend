import 'package:ausales_application/controller/melting_receipt/update_melting_receipt_form_controller.dart';
import 'package:ausales_application/core/theme/text_palette.dart';
import 'package:ausales_application/responsive.dart';
import 'package:ausales_application/view/widgets/form_widgets/custom_dropdown_search_field.dart';
import 'package:ausales_application/view/widgets/form_widgets/custom_label.dart';
import 'package:ausales_application/view/widgets/form_widgets/custom_text_input.dart';
import 'package:ausales_application/view/widgets/form_widgets/primary_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class MeltingReceiptFormUpdate extends StatefulWidget {
  const MeltingReceiptFormUpdate({super.key});

  @override
  State<MeltingReceiptFormUpdate> createState() => _MeltingReceiptFormUpdateState();
}

class _MeltingReceiptFormUpdateState extends State<MeltingReceiptFormUpdate> {
  final UpdateMeltingReceiptFormController _updateMeltingReceiptFormController = Get.put(UpdateMeltingReceiptFormController());
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return AlertDialog.adaptive(
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "Update Melting",
            style: TextPalette.screenTitle,
          ),
          IconButton(onPressed: (){
            Get.back();
             _updateMeltingReceiptFormController.resetForm();
          }, icon: Icon(Icons.close))
        ],
      ),
      content: Container(
        width: 300.w,
        child: Form(
          key: _updateMeltingReceiptFormController.updatemeltingreceiptFormKey,
          child: Wrap(
            spacing: 10.w,
            runSpacing: 10.h,
            children: [
              receivedweight(),
              meltingcharge(),
              gstpercent(),
              gstamount(),
              vendorcharges(),
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
            isLoading: _updateMeltingReceiptFormController.isFormSubmit.value,
            text: "Save",
            onPressed: () {
              _updateMeltingReceiptFormController
                  .UpdateCreateMeltingReceipt(context);

            })))

      ],
    );
  }

  SizedBox gstpercent() {
    return SizedBox(
      width: 300.w,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomLabel(label: "Gst Percent"),
          SizedBox(
            height: 7.w,
          ),
          CustomTextInput(
            inputFormat: 'double',
            controller: _updateMeltingReceiptFormController.gstpercentController,
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.numberWithOptions(),
            validator: "default",
            hintText: "Gst Percent",
            onChanged: ( value ) {
              _updateMeltingReceiptFormController.calculateGstAmount(meltingcharge: _updateMeltingReceiptFormController.meltingChargesController.text, gstPercent: _updateMeltingReceiptFormController.gstpercentController.text);
            },
          ),
        ],
      ),
    );
  }

   SizedBox gstamount() {
    return SizedBox(
      width: 300.w,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomLabel(label: "Gst Amount"),
          SizedBox(
            height: 7.w,
          ),
          CustomTextInput(
            inputFormat: 'double',
            controller: _updateMeltingReceiptFormController.gstamountController,
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.numberWithOptions(),
            validator: "default",
            hintText: "Gst Amount",
            readOnly: true,
          ),
        ],
      ),
    );
  }

     SizedBox vendorcharges() {
    return SizedBox(
      width: 300.w,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomLabel(label: "Vendor Charges"),
          SizedBox(
            height: 7.w,
          ),
          CustomTextInput(
            inputFormat: 'double',
            controller: _updateMeltingReceiptFormController.vendorchargesController,
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.numberWithOptions(),
            validator: "default",
            hintText: "Vendor Charges",
            readOnly: true,
          ),
        ],
      ),
    );
  }

 SizedBox receivedweight() {
    return SizedBox(
      width: 300.w,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomLabel(label: "Received Weight"),
          SizedBox(
            height: 7.w,
          ),
          CustomTextInput(
            inputFormat: 'double',
            controller: _updateMeltingReceiptFormController.receivedweightController,
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.numberWithOptions(),
            validator: "default",
            hintText: "Received Weight",
          ),
        ],
      ),
    );
  }


 SizedBox meltingcharge() {
    return SizedBox(
      width: 300.w,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomLabel(label: "Melting Charge"),
          SizedBox(
            height: 7.w,
          ),
          CustomTextInput(
            inputFormat: 'double',
            controller: _updateMeltingReceiptFormController.meltingChargesController,
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.numberWithOptions(),
            validator: "default",
            hintText: "Melting Charge",
            onChanged: ( value ) {
              _updateMeltingReceiptFormController.calculateGstAmount(meltingcharge: _updateMeltingReceiptFormController.meltingChargesController.text, gstPercent: _updateMeltingReceiptFormController.gstpercentController.text);
            },
          ),
        ],
      ),
    );
  }
}
