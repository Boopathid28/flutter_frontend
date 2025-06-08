import 'package:ausales_application/controller/purification/update_purification_form_controller.dart';
import 'package:ausales_application/core/theme/text_palette.dart';
import 'package:ausales_application/responsive.dart';
import 'package:ausales_application/view/widgets/form_widgets/custom_label.dart';
import 'package:ausales_application/view/widgets/form_widgets/custom_text_input.dart';
import 'package:ausales_application/view/widgets/form_widgets/primary_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class PurificationFormUpdate extends StatefulWidget {
  const PurificationFormUpdate({super.key});

  @override
  State<PurificationFormUpdate> createState() => _PurificationFormUpdateState();
}

class _PurificationFormUpdateState extends State<PurificationFormUpdate> {
  final UpdatePurificationFormController _updatePurificationFormController = Get.put(UpdatePurificationFormController());
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return AlertDialog.adaptive(
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "Update Purification",
            style: TextPalette.screenTitle,
          ),
          IconButton(onPressed: (){
            Get.back();
             _updatePurificationFormController.resetForm();
          }, icon: Icon(Icons.close))
        ],
      ),
      content: Container(
        width: 300.w,
        child: Form(
          key: _updatePurificationFormController.updatepurificationFormKey,
          child: Wrap(
            spacing: 10.w,
            runSpacing: 10.h,
            children: [
              receivedweight(),
              receivedtouch(),
              purificationcharge(),
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
            isLoading: _updatePurificationFormController.isFormSubmit.value,
            text: "Save",
            onPressed: () {
              _updatePurificationFormController
                  .UpdatePurification(context);

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
            controller: _updatePurificationFormController.gstpercentController,
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.numberWithOptions(),
            validator: "default",
            hintText: "Gst Percent",
            onChanged: ( value ) {
              _updatePurificationFormController.calculateGstAmount(purificationcharge: _updatePurificationFormController.purificationChargesController.text, gstPercent: _updatePurificationFormController.gstpercentController.text);
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
            controller: _updatePurificationFormController.gstamountController,
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
            controller: _updatePurificationFormController.vendorchargesController,
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
            controller: _updatePurificationFormController.receivedweightController,
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.numberWithOptions(),
            validator: "default",
            hintText: "Received Weight",
          ),
        ],
      ),
    );
  }


 SizedBox receivedtouch() {
    return SizedBox(
      width: 300.w,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomLabel(label: "Received touch"),
          SizedBox(
            height: 7.w,
          ),
          CustomTextInput(
            inputFormat: 'double',
            controller: _updatePurificationFormController.receivedtouchController,
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.numberWithOptions(),
            validator: "default",
            hintText: "Received touch",
          ),
        ],
      ),
    );
  }

 SizedBox purificationcharge() {
    return SizedBox(
      width: 300.w,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomLabel(label: "Purification Charge"),
          SizedBox(
            height: 7.w,
          ),
          CustomTextInput(
            inputFormat: 'double',
            controller: _updatePurificationFormController.purificationChargesController,
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.numberWithOptions(),
            validator: "default",
            hintText: "Purification Charge",
            onChanged: ( value ) {
              _updatePurificationFormController.calculateGstAmount(purificationcharge: _updatePurificationFormController.purificationChargesController.text, gstPercent: _updatePurificationFormController.gstpercentController.text);
            },
          ),
        ],
      ),
    );
  }
}
