import 'package:ausales_application/controller/melting_receipt/melting_receipt_form_controller.dart';
import 'package:ausales_application/core/theme/text_palette.dart';
import 'package:ausales_application/responsive.dart';
import 'package:ausales_application/view/widgets/form_widgets/custom_dropdown_search_field.dart';
import 'package:ausales_application/view/widgets/form_widgets/custom_label.dart';
import 'package:ausales_application/view/widgets/form_widgets/primary_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class MeltingReceiptForm extends StatefulWidget {
  const MeltingReceiptForm({super.key});

  @override
  State<MeltingReceiptForm> createState() => _MeltingReceiptFormState();
}

class _MeltingReceiptFormState extends State<MeltingReceiptForm> {
  final MeltingReceiptFormController _meltingReceiptFormController = Get.put(MeltingReceiptFormController());
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return AlertDialog.adaptive(
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "Melting",
            style: TextPalette.screenTitle,
          ),
          IconButton(onPressed: (){
            Get.back();
             _meltingReceiptFormController.resetForm();
          }, icon: Icon(Icons.close))
        ],
      ),
      content: Container(
        width: size.width,
        child: Form(
          key: _meltingReceiptFormController.meltingreceiptFormKey,
          child: Wrap(
            spacing: 10.w,
            runSpacing: 10.h,
            children: [
              vendor(),
              Obx(()=> _meltingReceiptFormController.isBranchuser.value ? Branch() : SizedBox()),
              bag()
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
            isLoading: _meltingReceiptFormController.isFormSubmit.value,
            text: "Save",
            onPressed: () {
              _meltingReceiptFormController
                  .CreateMeltingReceipt(context);

            })))

      ],
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
              controller: _meltingReceiptFormController.searchVendorDesignerController,
              selectedValue: _meltingReceiptFormController.selectedvendorDesiner.value,
              options: _meltingReceiptFormController.vendordesignerdropdown.value,
              onChanged: (value) {
                _meltingReceiptFormController.selectedvendorDesiner(value);
              },
              hintText: "Vendor",
              
                isValidate: true,
            ))
      ],
    ),
  );
  }

 SizedBox bag() {
    return SizedBox(
    width: 300.w,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomLabel(label: "Bag"),
        SizedBox(
          height: 7.w,
        ),
        Obx(() => CustomDropdownSearchField(
              controller: _meltingReceiptFormController.searchBagController,
              selectedValue: _meltingReceiptFormController.selectedbag.value,
              options: _meltingReceiptFormController.bagdropdown.value,
              onChanged: (value) {
                _meltingReceiptFormController.selectedbag(value);
              },
              hintText: "Bag",
                isValidate: true,
            ))
      ],
    ),
  );
  }


  SizedBox Branch() {
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
              controller: _meltingReceiptFormController.branchSearchController,
              selectedValue: _meltingReceiptFormController.selectedBranch.value,
              options: _meltingReceiptFormController.branchDropDown.value,
              onChanged: (value) {
                _meltingReceiptFormController.selectedBranch(value);
                _meltingReceiptFormController.getbagdetails(value?.value);
              },
              hintText: "Branch",
              isValidate: true,
            ))
      ],
    ),
  );
  }
}
