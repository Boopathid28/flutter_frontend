import 'package:ausales_application/controller/new_purchase/new_purchase_form/new_purchase_item_form_controller.dart';
import 'package:ausales_application/core/constants/app_configuration.dart';
import 'package:ausales_application/core/theme/text_palette.dart';
import 'package:ausales_application/view/widgets/form_widgets/custom_label.dart';
import 'package:ausales_application/view/widgets/form_widgets/custom_text_input.dart';
import 'package:ausales_application/view/widgets/form_widgets/primary_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:toastification/toastification.dart';

class ConvertWeightToAmountPopup extends StatefulWidget {
  const ConvertWeightToAmountPopup({super.key});

  @override
  State<ConvertWeightToAmountPopup> createState() => _ConvertWeightToAmountPopupState();
}

class _ConvertWeightToAmountPopupState extends State<ConvertWeightToAmountPopup> {

  final NewPurchaseItemFormController _newPurchaseItemFormController = Get.put(NewPurchaseItemFormController());

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            width: 300.w,
            child: Text('Convert Weight To Amount', style: TextPalette.screenTitle)),
          IconButton(onPressed: () {
            _newPurchaseItemFormController.isConvertedWeight(false);
            Get.back();
          }, icon: Icon(Icons.close))
        ],
      ),
      content: Container(
        width: 400.w,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomLabel(label: "Payable Weight(grams)"),
                  Obx(() => Text("${_newPurchaseItemFormController.payablPureWeight.value??"0.00"} g"))
                ],
              ),
              SizedBox(
                height: 15.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomLabel(label: "Convertion Rate"),
                  convertionRate()
                ],
              ),
              SizedBox(
                height: 15.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomLabel(label: "Convertion GST"),
                  convertionGst()
                ],
              ),
              SizedBox(
                height: 15.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomLabel(label: "Converted Amount"),
                  Obx(() => Text("₹ ${_newPurchaseItemFormController.convertionWithGst.value}"))
                ],
              ),
              SizedBox(
                height: 35.h,
              ),
              SizedBox(
              width: 400.w,
              child: PrimaryButton(
                  btnHeight: 46.h,
                  isLoading: false,
                  text: "Convert",
                  onPressed: () {
                    if (_newPurchaseItemFormController.convertionRateController.text.isNotEmpty) {
                      _newPurchaseItemFormController.addWithPayable();
                      Get.back();
                    } else {
                      toastification.show(
                        context: context, // optional if you use ToastificationWrapper
                        type: ToastificationType.info,
                        title: Text("Convertion Amount is Required"),
                        autoCloseDuration: notificationDuration,
                        showProgressBar: false,
                        pauseOnHover: false
                      );
                    }
                  })),
            ],
          ),
        ),
      ),
    );
  }

  SizedBox convertionRate() {
    return SizedBox(
      width: 150.w,
      child: CustomTextInput(
            inputFormat: 'double',
            controller: _newPurchaseItemFormController.convertionRateController,
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.number,
            validator: "default",
            hintText: "Rupees",
            onChanged: (value) {
              _newPurchaseItemFormController.convertWeightToAmount(context);
            },
          ),
    );
  }

  SizedBox convertionGst() {
    return SizedBox(
      width: 150.w,
      child: CustomTextInput(
            inputFormat: 'double',
            controller: _newPurchaseItemFormController.convertionGstController,
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.number,
            validator: "default",
            hintText: "Percent",
            onChanged: (value) {
              _newPurchaseItemFormController.convertWeightToAmount(context);
            },
          ),
    );
  }

}