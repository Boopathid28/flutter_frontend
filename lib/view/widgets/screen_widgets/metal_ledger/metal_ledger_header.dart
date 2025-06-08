import 'package:ausales_application/controller/metal_ledger/metal_ledger_list_controller.dart';
import 'package:ausales_application/view/widgets/form_widgets/custom_dropdown_field.dart';
import 'package:ausales_application/view/widgets/form_widgets/custom_dropdown_search_field.dart';
import 'package:ausales_application/view/widgets/form_widgets/custom_label_filter.dart';
import 'package:ausales_application/view/widgets/form_widgets/custom_text_input.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class MetalLedgerHeader extends StatefulWidget {
  const MetalLedgerHeader({super.key});

  @override
  State<MetalLedgerHeader> createState() => _MetalLedgerHeaderState();
}

class _MetalLedgerHeaderState extends State<MetalLedgerHeader> {
  final MetalLedgerListController _metalLedgerListController = Get.put(MetalLedgerListController());

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(15.w),
      child: Wrap(
        spacing: 10.w,
        runSpacing: 10.h,
        children: [
          Obx(() => _metalLedgerListController.isBranchuser.value ? branch(context) : SizedBox()),
          vendor(context),
          cancelledStatusFilter(context),
          oldledgerentrytype(context),
          touch(context),
          entryDateRangeFilter(context),
          searchFilter(context)
        ],
      )
    );
  }

  SizedBox branch(BuildContext context) {
    return SizedBox(
        width: 200.w,
        child: Obx(() => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [  
          CustomLabelFilter(label: "Branch"),
          SizedBox(
            height: 7.w,
          ),
            CustomDropdownSearchField(
                  controller: _metalLedgerListController.searchbranchController,
                  filled: true,
                  selectedValue: _metalLedgerListController.selectedbranch.value,
                  options: _metalLedgerListController.branchFilterList.value,
                  onChanged: (value) {
                    _metalLedgerListController.selectedbranch(value);
                    _metalLedgerListController.getmetalledgerList(context);
                  },
                  hintText: "Branch",
                ),
          ],
        )));
  }


    SizedBox cancelledStatusFilter(BuildContext context) {
    return SizedBox(
        width: 200.w,
        child: Obx(() => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomLabelFilter(label: "Cancelled Status"),
          SizedBox(
            height: 7.w,
          ),
            CustomDropdownField(
              filled: true,
                  selectedValue: _metalLedgerListController.selectedCancelledStatus.value,
                  options: _metalLedgerListController.CancelledFilterList.value,
                  onChanged: (value) {
                    _metalLedgerListController.selectedCancelledStatus(value);
                    _metalLedgerListController.getmetalledgerList(context);
                  },
                  hintText: "Cancelled Status",
                ),
          ],
        )));
  }

    SizedBox metal(BuildContext context) {
    return SizedBox(
        width: 200.w,
        child: Obx(() => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomLabelFilter(label: "metal"),
          SizedBox(
            height: 7.w,
          ),
            CustomDropdownSearchField(
                  controller: _metalLedgerListController.searchmetalController,
                  filled: true,
                  selectedValue: _metalLedgerListController.selectedmetal.value,
                  options: _metalLedgerListController.metalFilterList.value,
                  onChanged: (value) {
                    _metalLedgerListController.selectedmetal(value);
                    _metalLedgerListController.getmetalledgerList(context);
                  },
                  hintText: "metal",
                ),
          ],
        )));
  }


  SizedBox vendor(BuildContext context) {
    return SizedBox(
        width: 200.w,
        child: Obx(() => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomLabelFilter(label: "vendor"),
          SizedBox(
            height: 7.w,
          ),
            CustomDropdownSearchField(
                  controller: _metalLedgerListController.searchvendorController,
                  filled: true,
                  selectedValue: _metalLedgerListController.selectedvendor.value,
                  options: _metalLedgerListController.vendorFilterList.value,
                  onChanged: (value) {
                    _metalLedgerListController.selectedvendor(value);
                    _metalLedgerListController.getmetalledgerList(context);
                  },
                  hintText: "vendor",
                ),
          ],
        )));
  }

  SizedBox oldledgerentrytype(BuildContext context) {
    return SizedBox(
        width: 200.w,
        child: Obx(() => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomLabelFilter(label: "Old Ledger Entry type"),
          SizedBox(
            height: 7.w,
          ),
            CustomDropdownSearchField(
                  controller: _metalLedgerListController.searcholdledgerentrytypeController,
                  filled: true,
                  selectedValue: _metalLedgerListController.selectedoldledgerentrytype.value,
                  options: _metalLedgerListController.oldledgerentrytypeFilterList.value,
                  onChanged: (value) {
                    _metalLedgerListController.selectedoldledgerentrytype(value);
                    _metalLedgerListController.getmetalledgerList(context);
                  },
                  hintText: "Old Ledger Entry type",
                ),
          ],
        )));
  }

  SizedBox touch(BuildContext context) {
    return SizedBox(
        width: 200.w,
        child: Obx(() => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomLabelFilter(label: "Touch"),
          SizedBox(
            height: 7.w,
          ),
            CustomDropdownSearchField(
                  controller: _metalLedgerListController.searchtouchController,
                  filled: true,
                  selectedValue: _metalLedgerListController.selectedtouch.value,
                  options: _metalLedgerListController.touchFilterList.value,
                  onChanged: (value) {
                    _metalLedgerListController.selectedtouch(value);
                    _metalLedgerListController.getmetalledgerList(context);
                  },
                  hintText: "Touch",
                ),
          ],
        )));
  }

  SizedBox entryDateRangeFilter(BuildContext context) {
    return SizedBox(
      width: 200.w,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomLabelFilter(label: "Date Filter"),
          SizedBox(
            height: 7.w,
          ),
          CustomTextInput(
              readOnly: true,
              controller: _metalLedgerListController.datarangefilterController,
              textInputAction: TextInputAction.done,
              keyboardType: TextInputType.text,
              filled: true,
              hasSuffixIcon: true,
              suffixIcon: Icons.close,
              suffixClicked: () {
                _metalLedgerListController.datarangefilterController.clear();
                _metalLedgerListController.getmetalledgerList(context);
              },
              hintText: "Entry Date Range",
              onTap: () async {
                final today = DateTime.now();
                final endYear = today.year + 1;
                DateTimeRange? pickedDate = await showDateRangePicker(
                  context: context,
                  firstDate: DateTime(1900),
                  lastDate: DateTime(endYear),
                  builder: (context, child) {
                    return Center(
                      child: Container(
                        height: 450.h,
                        width: 400.w,
                        child: child,
                      ),
                    );
                  },
                );
                if (pickedDate != null) {
                  var startDate = pickedDate.start.toString().substring(0, 10);
                  var endDate = pickedDate.end
                      .add(Duration(days: 1))
                      .toString()
                      .substring(0, 10);
                  _metalLedgerListController.datarangefilterController.text =
                      [startDate, endDate].join(" to ");
                } else {
                  _metalLedgerListController.datarangefilterController.clear();
                }
                _metalLedgerListController.getmetalledgerList(context);
              }),
        ],
      ),
    );
  }

  
    SizedBox searchFilter(BuildContext context) {
    return SizedBox(
          width: 300.w,
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomLabelFilter(label: "Search Filter"),
          SizedBox(
            height: 7.w,
          ),
              CustomTextInput(
                  controller: _metalLedgerListController.searchController,
                  textInputAction: TextInputAction.done,
                  keyboardType: TextInputType.text,
                  filled: true,
                  prefixIcon: Icons.search,
                  hasPrefixIcon: true,
                  hintText: "Search",
                  onChanged: (value) {
                    _metalLedgerListController.getmetalledgerList(context);
                  }),
            ],
          ),
        );
  }
}
