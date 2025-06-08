import 'package:ausales_application/controller/repair_creation/repair_creation_form_controller.dart';
import 'package:ausales_application/model/drop_down_model.dart';
import 'package:ausales_application/model/repair_creation/repair_creation_models.dart';
import 'package:ausales_application/responsive.dart';
import 'package:ausales_application/view/widgets/form_widgets/custom_dropdown_search_field.dart';
import 'package:ausales_application/view/widgets/form_widgets/custom_label.dart';
import 'package:ausales_application/view/widgets/form_widgets/custom_text_input.dart';
import 'package:ausales_application/view/widgets/form_widgets/primary_button.dart';
import 'package:ausales_application/view/widgets/form_widgets/secondary_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class NewRepairItemForm extends StatefulWidget {
  final RepairItemDetails? item;
  final int? index;
  const NewRepairItemForm({
    this.item,
    this.index,
    super.key,});

  @override
  State<NewRepairItemForm> createState() => _NewRepairItemFormState();
}

class _NewRepairItemFormState extends State<NewRepairItemForm> {
  final RepairCreationFormController _repairCreationFormController =
      Get.put(RepairCreationFormController());

@override
  void initState() {
    super.initState();
    if(_repairCreationFormController.itemFormMode.value=='edit'){
      String itemlLabel='';
      String repairlLabel='';
      
      for(var dropDownItem in _repairCreationFormController.itemsDropDown.value){
        if(dropDownItem.value==widget.item!.itemDetails.toString()){
          itemlLabel=dropDownItem.label;
        }
      }
      for(var dropDownItem in _repairCreationFormController.repairTypesDropDown.value){
        if(dropDownItem.value==widget.item!.repairType.toString()){
          repairlLabel=dropDownItem.label;
        }
      }
      _repairCreationFormController.selectedItem(DropdownModel(value: widget.item!.itemDetails.toString(), label: itemlLabel));
      _repairCreationFormController.piecesController.text=widget.item!.pieces.toString();
      _repairCreationFormController.grossWeightController.text=widget.item!.grossWeight.toString();
      _repairCreationFormController.selectedRepairType(DropdownModel(value: widget.item!.repairType.toString(), label: repairlLabel));
    }
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return AlertDialog(
      contentPadding: EdgeInsets.all(8.w),
      insetPadding: EdgeInsets.all(Responsive.isMobile(context)?8.w:0.w),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text('Create Item'),
          IconButton(
              onPressed: () {
                Get.back();
                _repairCreationFormController.resteItemForm();
              },
              icon: const Icon(Icons.close))
        ],
      ),
      content: Form(
          key: _repairCreationFormController.newRepairItemFormKey,
          child: Container(
            padding: EdgeInsets.all(15.w),
            decoration: const BoxDecoration(
              color: Colors.white,
            ),
            width: size.width * 0.98,
            child: SingleChildScrollView(
              child: Wrap(
                spacing: 20.w,
                runSpacing: 15.h,
                children: [
                  itemDetailsDropDown(),
                  piecesInput(),
                  grossWeightInput(),
                  repairTypeDropDown(),
                  remarksInput()
                ],
              ),
            ),
          )),
      actions: [actions(context)],
    );
  }

  SizedBox actions(BuildContext context) {
    return SizedBox(
      width: 250.w,
      height: 73.h,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          SizedBox(
              width: 115.w,
              child: PrimaryButton(
                  btnHeight: 46.h,
                  isLoading: false,
                  text: "Save",
                  
                  onPressed: () {
                    setState(() {
                      
                    if (_repairCreationFormController
                        .newRepairItemFormKey.currentState!
                        .validate()) {
                      if(_repairCreationFormController.itemFormMode.value=='create'){
                        _repairCreationFormController.addRepairItemsDetails();
                      }else if(_repairCreationFormController.itemFormMode.value=='edit'){
                        _repairCreationFormController.editRepairItem(widget.index!);
                      }
                      _repairCreationFormController.resteItemForm();
                      Get.back();
                    }
                    });
                  })),
          SizedBox(
            width: 10.w,
          ),
          SizedBox(
              width: 115.w,
              child: SecondaryButton(
                  btnHeight: 46.h,
                  isLoading: false,
                  text: "Clear",
                  onPressed: () {
                    _repairCreationFormController.resteItemForm();
                  }))
        ],
      ),
    );
  }

  SizedBox grossWeightInput() {
    return SizedBox(
      width: 300.w,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomLabel(label: "Gross Weight"),
          SizedBox(height: 7.h),
          CustomTextInput(
            inputFormat: 'double',
            controller: _repairCreationFormController.grossWeightController,
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.number,
            validator: "default",
            hintText: "Gross Weight",
          ),
        ],
      ),
    );
  }

  SizedBox piecesInput() {
    return SizedBox(
      width: 300.w,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomLabel(label: "Pieces"),
          SizedBox(height: 7.h),
          CustomTextInput(
            inputFormat: 'integer',
            controller: _repairCreationFormController.piecesController,
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.number,
            validator: "default",
            hintText: "Pieces",
          ),
        ],
      ),
    );
  }

  SizedBox remarksInput() {
    return SizedBox(
      width: 300.w,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomLabel(label: "Remarks"),
          SizedBox(height: 7.h),
          CustomTextInput(
            controller: _repairCreationFormController.remarksController,
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.number,
            validator: 'no_validation',
            hintText: "Remarks",
          ),
        ],
      ),
    );
  }

  SizedBox itemDetailsDropDown() {
    return SizedBox(
      width: 300.w,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomLabel(label: "Item"),
          SizedBox(
            height: 7.w,
          ),
          Obx(() => CustomDropdownSearchField(
                controller: _repairCreationFormController.itemSearchController,
                selectedValue: _repairCreationFormController.selectedItem.value,
                options: _repairCreationFormController.itemsDropDown.value,
                onChanged: (value) {
                  _repairCreationFormController.selectedItem(value);
                },
                hintText: "Item",
              ))
        ],
      ),
    );
  }

  SizedBox repairTypeDropDown() {
    return SizedBox(
      width: 300.w,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomLabel(label: "Repair Type"),
          SizedBox(
            height: 7.w,
          ),
          Obx(() => CustomDropdownSearchField(
                controller:
                    _repairCreationFormController.repairSearchController,
                selectedValue:
                    _repairCreationFormController.selectedRepairType.value,
                options:
                    _repairCreationFormController.repairTypesDropDown.value,
                onChanged: (value) {
                  _repairCreationFormController.selectedRepairType(value);
                },
                hintText: "Repair Type",
              ))
        ],
      ),
    );
  }
}
