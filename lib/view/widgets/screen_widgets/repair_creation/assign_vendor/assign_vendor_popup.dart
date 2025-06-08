import 'package:ausales_application/controller/repair_creation/assign_vendor_list_controller.dart';
import 'package:ausales_application/core/theme/text_palette.dart';
import 'package:ausales_application/model/assign_vendor/assign_vendor_models.dart';
import 'package:ausales_application/responsive.dart';
import 'package:ausales_application/view/widgets/form_widgets/custom_dropdown_field.dart';
import 'package:ausales_application/view/widgets/form_widgets/custom_label.dart';
import 'package:ausales_application/view/widgets/form_widgets/custom_text_input.dart';
import 'package:ausales_application/view/widgets/form_widgets/primary_button.dart';
import 'package:ausales_application/view/widgets/form_widgets/secondary_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class AssignVendorPopup extends StatefulWidget {
  final int index;
  final num id;
  const AssignVendorPopup({super.key, required this.index, required this.id});

  @override
  State<AssignVendorPopup> createState() => _AssignVendorPopupState();
}

class _AssignVendorPopupState extends State<AssignVendorPopup> {
  final AssignVendorListController _assignVendorListController =
      Get.put(AssignVendorListController());

  @override
  void initState() {
    super.initState();
    // for(var item in _assignVendorListController.vendorDropDown.value){
    //   if(item.value==_assignVendorListController.repairItemList.value[widget.index].vendorDetails){
    //     _assignVendorListController.selectedVendor.value=item;
    //   }
    // }
    // _assignVendorListController.dueDateController.text=_assignVendorListController.repairItemList[widget.index].dueDate??'';
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog.adaptive(
      insetPadding: EdgeInsets.all(Responsive.isMobile(context) ? 8.w : 0),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Assign Vendor',
            style: Responsive.isMobile(context)
                ? TextPalette.tableDataTextStyle
                : TextPalette.screenTitle,
          ),
          IconButton(onPressed: () => Get.back(), icon: Icon(Icons.close))
        ],
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Column(crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomLabel(label: 'Vendor'), SizedBox(height: 8.w,),
              vendorDropDown(),
            ],
          ),
          SizedBox(
            height: 15.w,
          ),
          Form(
              key: _assignVendorListController.assignEachVendorFormKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomLabel(label: 'Due Date'),
                  SizedBox(height: 8.w,),
                  dateInput(context),
                ],
              )),
          SizedBox(
            height: 15.w,
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: SizedBox(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SecondaryButton(
                    btnWidth: Responsive.isMobile(context) ? 75.w : 150.w,
                    isLoading: false,
                    text: 'Clear',
                    onPressed: () {
                      _assignVendorListController.resetVendorFrom();
                    },
                  ),
                  SizedBox(
                    width: 15.w,
                  ),
                  PrimaryButton(
                    btnWidth: Responsive.isMobile(context) ? 75.w : 150.w,
                    isLoading: false,
                    text: 'Assign',
                    onPressed: () async {
                      _assignVendorListController.addOrUpdateRepairItem(
                       dueDate: _assignVendorListController.dueDateController.text,
                       id: widget.id,
                       vendorDetails: _assignVendorListController.selectedVendor.value?.value
                      );

                      _assignVendorListController.resetVendorFrom();
                      _assignVendorListController.tableData.refresh();
                    },
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  SizedBox dateInput(BuildContext context) {
    return SizedBox(
      width: 300.w,
      child: CustomTextInput(
        controller: _assignVendorListController.dueDateController,
        textInputAction: TextInputAction.next,
        keyboardType: TextInputType.text,
        validator: "default",
        hintText: "Due Date",
        readOnly: true,
        onTap: () async {
          DateTime? pickedDate = await showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime.now(),
            lastDate: DateTime(DateTime.now().year + 100),
          );

          if (pickedDate != null) {
            String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate);

            _assignVendorListController.dueDateController.text = formattedDate;
          }
        },
      ),
    );
  }

  SizedBox vendorDropDown() {
    return SizedBox(
      width: 300.w,
      child: Obx(
        () => CustomDropdownField(
            hintText: 'Select Vendor',
            selectedValue: _assignVendorListController.selectedVendor.value,
            onChanged: (value) {
              _assignVendorListController.selectedVendor(value);
            },
            options: _assignVendorListController.vendorDropDown.value),
      ),
    );
  }
}
