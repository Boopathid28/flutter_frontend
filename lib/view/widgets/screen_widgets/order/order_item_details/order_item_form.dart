import 'package:ausales_application/controller/order/order_item_form_controller.dart';
import 'package:ausales_application/core/theme/text_palette.dart';
import 'package:ausales_application/responsive.dart';
import 'package:ausales_application/view/widgets/form_widgets/custom_dropdown_field.dart';
import 'package:ausales_application/view/widgets/form_widgets/custom_dropdown_search_field.dart';
import 'package:ausales_application/view/widgets/form_widgets/custom_label.dart';
import 'package:ausales_application/view/widgets/form_widgets/custom_text_input.dart';
import 'package:ausales_application/view/widgets/form_widgets/custom_text_input_with_popup.dart';
import 'package:ausales_application/view/widgets/form_widgets/primary_button.dart';
import 'package:ausales_application/view/widgets/form_widgets/secondary_button.dart';
import 'package:ausales_application/view/widgets/screen_widgets/order/diamond_details/diamond_details_popup.dart';
import 'package:ausales_application/view/widgets/screen_widgets/order/iamge_popup.dart';
import 'package:ausales_application/view/widgets/screen_widgets/order/stone_details/stone_details_popup.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class OrderItemForm extends StatefulWidget {
  const OrderItemForm({super.key});

  @override
  State<OrderItemForm> createState() => _OrderItemFormState();
}

class _OrderItemFormState extends State<OrderItemForm> {
  final OrderItemFormController _orderItemFormController =
      Get.put(OrderItemFormController());

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Form(
        key: _orderItemFormController.orderitemDetailsFormKey,
        child: Container(
          padding: EdgeInsets.all(15.w),
          decoration: BoxDecoration(
            color: Colors.white,
          ),
          width: size.width * 0.98,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Item Details",
                style: TextPalette.tableHeaderTextStyle,
              ),
              Divider(
                thickness: 1.sp,
              ),
              SizedBox(
                height: 7.h,
              ),
              Wrap(
                spacing: 20.w,
                runSpacing: 10.h,
                children: [
                  purity(),
                  item(),
                  subitem(),
                  grossweight(),
                  netweight(),
                  pieces(),
                  metalRate(),
                  wastagePercent(),
                  makingChargePerGram(),
                  priority(),
                  gender(),
                  measurementtype(),
                  measurementvalue(),
                  stoneDetails(),
                  diamondDetails(),
                  huidAmount(),
                  designerCharges(),
                  totalAmount(),
                  gstAmount(),
                  payableAmount(),
                  remark(),
                  image()
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  addButton(context),
                  SizedBox(
                    width: 10.w,
                  ),
                  clearButton(context)
                ],
              )
            ],
          ),
        ));
  }

  SizedBox clearButton(BuildContext context) {
    return SizedBox(
        width: 100.w,
        child: SecondaryButton(
            btnHeight: 46.h,
            isLoading: false,
            text: "Clear",
            onPressed: () {
              _orderItemFormController.resetOrderItemForm(context);
            }));
  }

  SizedBox image() {
    return SizedBox(
        width: 200.w,
        height: 80.h,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
           PrimaryButton(isLoading: false, btnWidth: 200.w, text: "Upload Image",onPressed: () async {
                await Get.dialog(
                    barrierDismissible: false,
                    ImagePopupForm());})
          ],
        ));
  }

  SizedBox addButton(BuildContext context) {
    return SizedBox(
        width: 100.w,
        child: Obx(() => PrimaryButton(
            btnHeight: 46.h,
            isLoading: false,
            text: _orderItemFormController.orderitemdetailsFormMode.value,
            onPressed: () {
              _orderItemFormController.submitOrderItemdetailsForm(context);
            })));
  }

  SizedBox makingChargePerGram() {
    return SizedBox(
      width: 200.w,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomLabel(label: 'MC/G'),
          SizedBox(
            height: 7,
          ),
          CustomTextInput(
                filled: true,
                validator: 'default',
                controller:
                    _orderItemFormController.makingChargePerGramController,
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.numberWithOptions(),
                inputFormat: 'double',
                hintText: 'MC/G',
                onChanged: (value) {
                  _orderItemFormController.calculateItemValue();
                },
              ),
        ],
      ),
    );
  }

  SizedBox wastagePercent() {
    return SizedBox(
      width: 200.w,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomLabel(label: 'Wastage %'),
          SizedBox(
            height: 7,
          ),
          CustomTextInput(
                filled: true,
                validator: 'default',
                controller: _orderItemFormController.wastagePercentController,
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.numberWithOptions(),
                inputFormat: 'double',
                hintText: 'Wastage %',
                onChanged: (value) {
                  _orderItemFormController.calculateItemValue();
                },
                
              ),
        ],
      ),
    );
  }

  SizedBox purity() {
    return SizedBox(
      width: 200.w,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomLabel(label: "Purity"),
          SizedBox(
            height: 7.w,
          ),
          Obx(() => CustomDropdownSearchField(
                controller: _orderItemFormController.puritySearchController,
                selectedValue: _orderItemFormController.selectedpurity.value,
                options: _orderItemFormController.purityDropDown.value,
                onChanged: (value) {
                  _orderItemFormController.selectedpurity(value);
                  _orderItemFormController.getItemList(value!.value);
                },
                hintText: "Purity",
              ))
        ],
      ),
    );
  }
  
 

  SizedBox subitem() {
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
                controller: _orderItemFormController.subitemSearchController,
                selectedValue: _orderItemFormController.selectedSubitem.value,
                options: _orderItemFormController.subitemDropDown.value,
                onChanged: (value) {
                  _orderItemFormController.selectedSubitem(value);
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
                controller: _orderItemFormController.itemSearchController,
                selectedValue: _orderItemFormController.selecteditem.value,
                options: _orderItemFormController.itemDropDown.value,
                onChanged: (value) {
                  _orderItemFormController.onItemChange(value!);
                  _orderItemFormController.getSubItemList(value.value);
                },
                hintText: "Item",
              ))
        ],
      ),
    );
  }

  SizedBox priority() {
    return SizedBox(
      width: 200.w,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomLabel(label: "Priority"),
          SizedBox(
            height: 7.w,
          ),
          Obx(() => CustomDropdownField(
                selectedValue: _orderItemFormController.selectedPriority.value,
                options: _orderItemFormController.priorityDropDown.value,
                onChanged: (value) {
                  _orderItemFormController.selectedPriority(value);
                },
                hintText: "Priority",
              ))
        ],
      ),
    );
  }

  SizedBox gender() {
    return SizedBox(
      width: 200.w,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomLabel(label: "Gender"),
          SizedBox(
            height: 7.w,
          ),
          Obx(() => CustomDropdownField(
                selectedValue: _orderItemFormController.selectedGendor.value,
                options: _orderItemFormController.genderDropDown.value,
                onChanged: (value) {
                  _orderItemFormController.selectedGendor(value);
                },
                hintText: "Gender",
                isValidate: false,
              ))
        ],
      ),
    );
  }

  SizedBox measurementtype() {
    return SizedBox(
      width: 200.w,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomLabel(label: "Measurement Type"),
          SizedBox(
            height: 7.w,
          ),
          Obx(() => CustomDropdownField(
                selectedValue:
                    _orderItemFormController.selectedMeasurementtype.value,
                options: _orderItemFormController.measurementtypeDropDown.value,
                onChanged: (value) {
                  _orderItemFormController.selectedMeasurementtype(value);
                },
                hintText: "Measurement Type",
              ))
        ],
      ),
    );
  }

  SizedBox metalRate() {
    return SizedBox(
      width: 200.w,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomLabel(label: "Metal Rate"),
          SizedBox(height: 7.h),
          CustomTextInput(
            inputFormat: 'double',
            controller: _orderItemFormController.metalRateController,
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.number,
            validator: "default",
            hintText: "Metal Rate",
            onChanged: (value) {
              
            },
          ),
        ],
      ),
    );
  }

  SizedBox grossweight() {
    return SizedBox(
      width: 200.w,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomLabel(label: "Gross Weight"),
          SizedBox(height: 7.h),
          CustomTextInput(
            inputFormat: 'double',
            controller: _orderItemFormController.grossWeightController,
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.number,
            validator: "default",
            hintText: "Gross Weight",
            onChanged: (value) {
              _orderItemFormController.ongrossweightchange(grossweight: value);
            },
          ),
        ],
      ),
    );
  }

  SizedBox netweight() {
    return SizedBox(
      width: 200.w,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomLabel(label: "Net Weight"),
          SizedBox(height: 7.h),
          CustomTextInput(
            inputFormat: 'double',
            controller: _orderItemFormController.netWeightController,
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.number,
            validator: "default",
            hintText: "Net Weight",
            readOnly: true,
          ),
        ],
      ),
    );
  }

  SizedBox pieces() {
    return SizedBox(
      width: 200.w,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomLabel(label: "Pieces"),
          SizedBox(height: 7.h),
          CustomTextInput(
            inputFormat: 'integer',
            controller: _orderItemFormController.piecesController,
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.number,
            validator: "default",
            hintText: "Pieces",
          ),
        ],
      ),
    );
  }

  SizedBox measurementvalue() {
    return SizedBox(
      width: 200.w,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomLabel(label: "Measurement Value"),
          SizedBox(height: 7.h),
          CustomTextInput(
            inputFormat: 'text',
            controller: _orderItemFormController.measurementvalueController,
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.text,
            validator: "default",
            hintText: "Measurement Value",
          ),
        ],
      ),
    );
  }

  SizedBox remark() {
    return SizedBox(
      width: 200.w,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomLabel(label: "Remark"),
          SizedBox(height: 7.h),
          CustomTextInput(
            inputFormat: 'text',
            controller: _orderItemFormController.remarkController,
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.text,
            validator: "no_validation",
            hintText: "Remark",
          ),
        ],
      ),
    );
  }

  SizedBox stoneDetails() {
    return SizedBox(
      width: Responsive.isMobile(context) ? double.infinity : 275.w,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomLabel(label: "Stone"),
          SizedBox(
            height: 7.w,
          ),
          CustomTextInputWithPopup(
            width: 300.w,
            controller: _orderItemFormController.stoneAmountController,
            textInputAction: TextInputAction.done,
            keyboardType: TextInputType.none,
            popupText: "Stone",
            validator: "no_validate",
            readOnly: true,
            onPopupPressed: () async {
              await Get.dialog(
                  barrierDismissible: false,
                  StoneDetailsPopup());
            },
          ),
        ],
      ),
    );
  }

  SizedBox diamondDetails() {
    return SizedBox(
      width: Responsive.isMobile(context) ? double.infinity : 275.w,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomLabel(label: "Diamond"),
          SizedBox(
            height: 7.w,
          ),
          CustomTextInputWithPopup(
            width: 300.w,
            controller: _orderItemFormController.diamondAmountController,
            textInputAction: TextInputAction.done,
            keyboardType: TextInputType.none,
            popupText: "Diamond",
            validator: "no_validate",
            readOnly: true,
            onPopupPressed: () async {
              await Get.dialog(
                  barrierDismissible: false,
                  DiamondDetailsPopup());
            },
          ),
        ],
      ),
    );
  }

  SizedBox huidAmount() {
    return SizedBox(
      width: 200.w,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomLabel(label: "HUID Amount"),
          SizedBox(height: 7.h),
          CustomTextInput(
            inputFormat: 'double',
            controller: _orderItemFormController.huidAmountController,
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.number,
            validator: "default",
            hintText: "HUID Amount",
            onChanged: (value) {
              _orderItemFormController.calculateItemValue();
            },
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
            controller: _orderItemFormController.totalAmountController,
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.number,
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

  SizedBox designerCharges() {
    return SizedBox(
      width: 200.w,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomLabel(label: 'Vendor Charges'),
          SizedBox(
            height: 7,
          ),
          CustomTextInput(
                filled: true,
                validator: 'default',
                controller: _orderItemFormController.designerChargeController,
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.numberWithOptions(),
                inputFormat: 'double',
                hintText: 'Vendor Charges',
                onChanged: (value) {
                  _orderItemFormController.calculateItemValue();
                },
                
              ),
        ],
      ),
    );
  }

  SizedBox gstAmount() {
    return SizedBox(
      width: 200.w,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomLabel(label: "GST Amount"),
          SizedBox(height: 7.h),
          CustomTextInput(
            inputFormat: 'double',
            controller: _orderItemFormController.gstAmountController,
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.number,
            validator: "default",
            hintText: "GST Amount",
            readOnly: true,
            onChanged: (value) {
              
            },
          ),
        ],
      ),
    );
  }

  SizedBox payableAmount() {
    return SizedBox(
      width: 200.w,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomLabel(label: "Payable Amount"),
          SizedBox(height: 7.h),
          CustomTextInput(
            inputFormat: 'double',
            controller: _orderItemFormController.payableAmountController,
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.number,
            validator: "default",
            hintText: "Payable Amount",
            readOnly: true,
            onChanged: (value) {
              
            },
          ),
        ],
      ),
    );
  }
}
