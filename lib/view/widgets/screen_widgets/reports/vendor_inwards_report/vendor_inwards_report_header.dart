import 'package:ausales_application/controller/reports/order_metal_wise_report_list_controller.dart';
import 'package:ausales_application/controller/reports/vendor_inwards_report_list_controller.dart';
import 'package:ausales_application/view/widgets/form_widgets/custom_dropdown_field.dart';
import 'package:ausales_application/view/widgets/form_widgets/custom_dropdown_search_field.dart';
import 'package:ausales_application/view/widgets/form_widgets/custom_label_filter.dart';
import 'package:ausales_application/view/widgets/form_widgets/custom_text_input.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';


class VendorInwardsReportHeader extends StatefulWidget {
  const VendorInwardsReportHeader({super.key});

  @override
  State<VendorInwardsReportHeader> createState() =>
      _VendorInwardsReportHeaderState();
}

class _VendorInwardsReportHeaderState
    extends State<VendorInwardsReportHeader> {
  final VendorInwardsReportListController _vendorInwardsReportListController =
      Get.put(VendorInwardsReportListController());

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.all(15.w),
        child: Wrap(
          spacing: 10.w,
          runSpacing: 10.h,
          children: [
            dateInput(context),
            itemFilterDropDown(),
            vendorFilterDropDown()
          ],
        ));
  }



SizedBox itemFilterDropDown() {
    return SizedBox(
      width: 300.w,
      child: Obx(() => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
            children: [
               CustomLabelFilter(label: "Item"),
                SizedBox(
                  height: 7.w,
                ),
              CustomDropdownSearchField(
                controller: _vendorInwardsReportListController.searchitemController,
                selectedValue: _vendorInwardsReportListController.selectedItem.value,
                onChanged: (value) {
                  _vendorInwardsReportListController.selectedItem(value);
                  _vendorInwardsReportListController
                      .getVendorInwardsListreport(context);
                },
                options: _vendorInwardsReportListController.itemDropDown.value,
                hintText: 'Select Item',
              ),
            ],
          )),
    );
  }


SizedBox vendorFilterDropDown() {
    return SizedBox(
      width: 300.w,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomLabelFilter(label: "Vendor"),
          SizedBox(
            height: 7.w,
          ),
          Obx(
            () => CustomDropdownSearchField(
              controller: _vendorInwardsReportListController.searchitemController,
              isValidate: false,
              selectedValue: _vendorInwardsReportListController.selectedVendor.value,
              onChanged: (value) {
                _vendorInwardsReportListController.selectedVendor(value);
                _vendorInwardsReportListController.getVendorInwardsListreport(context);
              },
              options: _vendorInwardsReportListController.vendorDropDown.value,
              hintText: 'Select Vendor',
            ),
          ),
        ],
      ),
    );
  }
 

  SizedBox dateInput(BuildContext context) {
    return SizedBox(
      width: 300.w,
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomLabelFilter(label: "Date"),
          SizedBox(
            height: 7.w,
          ),
          CustomTextInput(
            controller: _vendorInwardsReportListController.fromDateController,
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.text,
            validator: "default",
            hintText: "Date",
            readOnly: true,
            onTap: () async {
              DateTime? pickedDate = await showDatePicker(
                context: context,
                initialDate: DateTime.now(),
                firstDate: DateTime(1900),
                lastDate: DateTime.now(),
              );
          
              if (pickedDate != null) {
                String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate);
          
                _vendorInwardsReportListController.fromDateController.text = formattedDate;
                _vendorInwardsReportListController.getVendorInwardsListreport(context);
              }
            },
          ),
        ],
      ),
    );
  }
}
