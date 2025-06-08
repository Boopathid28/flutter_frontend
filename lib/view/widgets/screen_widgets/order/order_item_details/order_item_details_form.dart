import 'dart:developer';

import 'package:ausales_application/controller/order/order_form_controller.dart';
import 'package:ausales_application/core/theme/color_palette.dart';
import 'package:ausales_application/core/theme/text_palette.dart';
import 'package:ausales_application/model/drop_down_model.dart';
import 'package:ausales_application/view/widgets/form_widgets/custom_dropdown_field.dart';
import 'package:ausales_application/view/widgets/form_widgets/custom_dropdown_search_field.dart';
import 'package:ausales_application/view/widgets/form_widgets/custom_label.dart';
import 'package:ausales_application/view/widgets/form_widgets/custom_text_input.dart';
import 'package:ausales_application/view/widgets/screen_widgets/customer/customer_creation_common_popup.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class OrderItemDetailsForm extends StatefulWidget {
  const OrderItemDetailsForm({super.key});

  @override
  State<OrderItemDetailsForm> createState() => _OrderItemDetailsFormState();
}

class _OrderItemDetailsFormState extends State<OrderItemDetailsForm> {
  final OrderFormController _orderFormController =
      Get.put(OrderFormController());

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Form(
        key: _orderFormController.orderformkey,
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
                "Customer Details",
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
                  Obx(() => _orderFormController.isBranchuser.value
                      ? branch()
                      : SizedBox()),
                  gstType(),
                  dueDate(),
                  metal(),
                  customer(),
                  fixedValue()
                ],
              ),
            ],
          ),
        ));
  }

  SizedBox fixedValue() {
    return SizedBox(
      width: 200.w,
      child: Row(
        children: [
          CustomLabel(label: "Rate Fixed"),
          SizedBox(height: 7.h),
          Obx(() => Checkbox(
                value: _orderFormController.fixedValue.value,
                onChanged: (bool? newValue) {
                  _orderFormController.fixedValue(newValue);
                },
              )),
        ],
      ),
    );
  }

  SizedBox dueDate() {
    return SizedBox(
      width: 200.w,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomLabel(label: "Due Date"),
          SizedBox(height: 7.h),
          CustomTextInput(
            readOnly: true,
            onTap: () async {
              final today = DateTime.now();
              final endYear = today.year + 1;
              DateTime? pickedDate = await showDatePicker(
                  context: context,
                  initialDate: today,
                  firstDate: DateTime(1900),
                  lastDate: DateTime(endYear));
              if (pickedDate != null) {
                _orderFormController.dueDateController.text =
                    pickedDate.toString().substring(0, 10);
              } else {
                _orderFormController.dueDateController.clear();
              }
            },
            controller: _orderFormController.dueDateController,
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.text,
            validator: "default",
            hintText: "Due Date",
          ),
        ],
      ),
    );
  }

  SizedBox branch() {
    return SizedBox(
      width: 275.w,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomLabel(label: "Branch"),
          SizedBox(
            height: 7.w,
          ),
          Obx(() => CustomDropdownSearchField(
                controller: _orderFormController.branchSearchController,
                selectedValue: _orderFormController.selectedBranch.value,
                options: _orderFormController.branchDropDown.value,
                onChanged: (value) {
                  _orderFormController.selectedBranch(value);
                },
                hintText: "Branch",
              ))
        ],
      ),
    );
  }

  SizedBox gstType() {
    return SizedBox(
      width: 200.w,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomLabel(label: "GST Type"),
          SizedBox(
            height: 7.w,
          ),
          Obx(() => CustomDropdownField(
                filled: true,
                selectedValue: _orderFormController.selectedGstType.value,
                options: _orderFormController.gstTypeDropDown.value,
                onChanged: _orderFormController
                        .orderitemdetailsParticularList.isNotEmpty
                    ? null
                    : (DropdownModel? value) {
                        _orderFormController.selectedGstType(value);
                      },
                hintText: "GST Type",
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
                controller: _orderFormController.metalSearchController,
                selectedValue: _orderFormController.selectedMetal.value,
                options: _orderFormController.metalDropDown.value,
                onChanged: (value) {
                  _orderFormController.selectedMetal(value);
                },
                hintText: "Metal",
              ))
        ],
      ),
    );
  }

  SizedBox customer() {
    return SizedBox(
      width: 300.w,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomLabel(label: "Customer Mobile"),
          SizedBox(height: 7.h),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: 200.w,
                child: CustomTextInput(
                  filled: true,
                  maxLength: 10,
                  inputFormat: 'integer',
                  controller: _orderFormController.customerSearchController,
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.number,
                  validator: "phone",
                  hintText: "Customer Mobile",
                  onChanged: (value) {
                    _orderFormController.findCustomer(value, context);
                  },
                ),
              ),
              SizedBox(
                width: 5.w,
              ),
              Obx(() => _orderFormController.isVerifyCustomerLoading.value
                  ? CircularProgressIndicator()
                  : _orderFormController.isValidCustomer.value
                      ? Container(
                          width: 35,
                          height: 35,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5.r),
                            color: ColorPalete.primaryBtnColor,
                          ),
                          child: Icon(
                            Icons.person,
                            size: 25.sp,
                            color: Colors.white,
                          ),
                        )
                      : IconButton(
                          onPressed: () async {
                            await Get.dialog(
                                barrierDismissible: false,
                                CustomerCreationCommonPopup(
                                      onSubmit: _orderFormController
                                          .submitCustomerCreationForm,
                                    ));
                          },
                          icon: Icon(Icons.add_circle_outline_outlined,
                              size: 25.sp, color: ColorPalete.primaryColor))),
              Obx(() => Text(
                    _orderFormController
                            .customerDetails.value.customerName?.capitalize ??
                        "",
                    style: TextStyle(
                        color: ColorPalete.primaryColor,
                        fontSize: 15.sp,
                        fontWeight: FontWeight.bold),
                  ))
            ],
          ),
        ],
      ),
    );
  }
}
