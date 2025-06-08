import 'package:ausales_application/controller/payment_controllers/suspense_payment_controller.dart';
import 'package:ausales_application/model/payment/suspense_payment_model.dart';
import 'package:ausales_application/view/widgets/form_widgets/custom_dropdown_search_field.dart';
import 'package:ausales_application/view/widgets/form_widgets/custom_label.dart';
import 'package:ausales_application/view/widgets/form_widgets/custom_text_input.dart';
import 'package:ausales_application/view/widgets/form_widgets/primary_button.dart';
import 'package:ausales_application/view/widgets/form_widgets/secondary_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class SuspensePaymentItemForm extends StatefulWidget {
  String branch;
  String customer;
  RxList<SuspensePaymentItemModel> itemsList;
  SuspensePaymentItemForm(
      {super.key, required this.branch, required this.customer, required this.itemsList});

  @override
  State<SuspensePaymentItemForm> createState() =>
      _SuspensePaymentItemFormState();
}

class _SuspensePaymentItemFormState extends State<SuspensePaymentItemForm> {
  final SuspensePaymentController _suspensePaymentController =
      Get.put(SuspensePaymentController());

  @override
  Widget build(BuildContext context) {
    return Form(
        key: _suspensePaymentController.suspensePaymentFormKey,
        child: Wrap(
          spacing: 20.w,
          runSpacing: 10.h,
          children: [
            metal(),
            item(),
            subItem(),
            metalWeight(),
            metalAmount(),
            totalAmount(),
            actions(context)],
        ));
  }

  SizedBox actions(BuildContext context) {
    return SizedBox(
      width: 200.w,
      height: 65.h,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              PrimaryButton(
                  btnWidth: 95.w,
                  isLoading: false,
                  text: _suspensePaymentController.formMode.value,
                  onPressed: () {
                    _suspensePaymentController.addItemInList(context, widget.itemsList);
                  }),
              SecondaryButton(
                  btnWidth: 95.w,
                  isLoading: false,
                  text: 'Clear',
                  onPressed: () {})
            ],
          ),
        ],
      ),
    );
  }

  SizedBox totalAmount() {
    return SizedBox(
      width: 200.w,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomLabel(label: "Total Amount"),
          SizedBox(height: 7.h),
          CustomTextInput(
            inputFormat: 'double',
            controller: _suspensePaymentController.totalAmountController,
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.text,
            validator: "default",
            hintText: "Total Amount",
            readOnly: true,
            onChanged: (value) {
              
            },
          ),
        ],
      ),
    );
  }

  SizedBox metalAmount() {
    return SizedBox(
      width: 200.w,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomLabel(label: "Metal Amount"),
          SizedBox(height: 7.h),
          CustomTextInput(
            inputFormat: 'double',
            controller: _suspensePaymentController.metalAmountController,
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.text,
            validator: "default",
            hintText: "Metal Amount",
            onChanged: (value) {
              double metalAmt = double.parse(value.isNotEmpty ? value : "0");
              double metalWgt = double.parse(_suspensePaymentController.metalWeightController.text.isEmpty ? "0": _suspensePaymentController.metalWeightController.text);

              _suspensePaymentController.totalAmountController.text = (metalAmt * metalWgt).toStringAsFixed(2);
            },
          ),
        ],
      ),
    );
  }

  SizedBox metalWeight() {
    return SizedBox(
      width: 200.w,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomLabel(label: "Metal Weight"),
          SizedBox(height: 7.h),
          CustomTextInput(
            inputFormat: 'double',
            controller: _suspensePaymentController.metalWeightController,
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.text,
            validator: "default",
            hintText: "Metal Weight",
            onChanged: (value) {
              double metalWgt = double.parse(value.isNotEmpty ? value : "0");
              double metalAmt = double.parse(_suspensePaymentController.metalAmountController.text.isEmpty ? "0": _suspensePaymentController.metalAmountController.text);

              _suspensePaymentController.totalAmountController.text = (metalAmt * metalWgt).toStringAsFixed(2);
            },
          ),
        ],
      ),
    );
  }
  
  SizedBox subItem() {
    return SizedBox(
      width: 200.w,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomLabel(label: "Sub Item"),
          SizedBox(
            height: 7.w,
          ),
          Obx(() => CustomDropdownSearchField(
                controller: _suspensePaymentController.subItemSearchController,
                selectedValue: _suspensePaymentController.selectedSubItem.value,
                options: _suspensePaymentController.subItemDropDown.value,
                onChanged: (value) {
                  _suspensePaymentController.selectedSubItem(value);
                },
                hintText: "Sub Item",
              ))
        ],
      ),
    );
  }

  SizedBox item() {
    return SizedBox(
      width: 200.w,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomLabel(label: "Item"),
          SizedBox(
            height: 7.w,
          ),
          Obx(() => CustomDropdownSearchField(
                controller: _suspensePaymentController.itemSearchController,
                selectedValue: _suspensePaymentController.selectedItem.value,
                options: _suspensePaymentController.itemDropDown.value,
                onChanged: (value) {
                  _suspensePaymentController.selectedItem(value);
                  if (_suspensePaymentController.selectedMetal.value != null) {
                    _suspensePaymentController.getSubItemList(_suspensePaymentController.selectedMetal.value?.value, value?.value, null);
                  } else {
                    _suspensePaymentController.getSubItemList(null, value?.value, null);
                  }
                },
                hintText: "Item",
              ))
        ],
      ),
    );
  }

  SizedBox metal() {
    return SizedBox(
      width: 200.w,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomLabel(label: "Metal"),
          SizedBox(
            height: 7.w,
          ),
          Obx(() => CustomDropdownSearchField(
                controller: _suspensePaymentController.metalSearchController,
                selectedValue: _suspensePaymentController.selectedMetal.value,
                options: _suspensePaymentController.metalDropDown.value,
                onChanged: (value) {
                  _suspensePaymentController.selectedMetal(value);
                  _suspensePaymentController.getItemList(value?.value, null);
                },
                hintText: "Metal",
              ))
        ],
      ),
    );
  }
}
