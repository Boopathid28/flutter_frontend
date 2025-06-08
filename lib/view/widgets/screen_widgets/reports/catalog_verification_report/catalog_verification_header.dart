import 'package:ausales_application/controller/reports/catalog_verfication_report_controller.dart';
import 'package:ausales_application/view/widgets/form_widgets/custom_dropdown_search_field.dart';
import 'package:ausales_application/view/widgets/form_widgets/custom_label_filter.dart';
import 'package:ausales_application/view/widgets/form_widgets/custom_text_input.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class CatalogVerificationHeader extends StatefulWidget {
  const CatalogVerificationHeader({super.key});

  @override
  State<CatalogVerificationHeader> createState() =>
      _CatalogVerificationHeaderState();
}

class _CatalogVerificationHeaderState extends State<CatalogVerificationHeader> {
  final CatalogVerficationReportController _catalogVerficationReportController =
      Get.put(CatalogVerficationReportController());

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.all(15.w),
        child: Wrap(
          spacing: 10.w,
          runSpacing: 10.h,
          children: [
            Obx(() => _catalogVerficationReportController.isBranchuser.value
                ? branch(context)
                : SizedBox()),
            catalogtype(context),
            entryDateRangeFilter(context),
          ],
        ));
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
                  controller:
                      _catalogVerficationReportController.searchbranchController,
                  filled: true,
                  selectedValue:
                      _catalogVerficationReportController.selectedbranch.value,
                  options:
                      _catalogVerficationReportController.branchFilterList.value,
                  onChanged: (value) {
                    _catalogVerficationReportController.selectedbranch(value);
                    _catalogVerficationReportController
                        .getcatalogverificationListreport(context);
                  },
                  hintText: "Branch",
                ),
              ],
            )));
  }

  SizedBox catalogtype(BuildContext context) {
    return SizedBox(
        width: 200.w,
        child: Obx(() => Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomLabelFilter(label: "catalogtype"),
                SizedBox(
                  height: 7.w,
                ),
                CustomDropdownSearchField(
                  controller:
                      _catalogVerficationReportController.searchcatalogverificationController,
                  filled: true,
                  selectedValue:
                      _catalogVerficationReportController.selectedcatalogverification.value,
                  options:
                      _catalogVerficationReportController.catalogverificationFilterList.value,
                  onChanged: (value) {
                    _catalogVerficationReportController.selectedcatalogverification(value);
                    _catalogVerficationReportController
                        .getcatalogverificationListreport(context);
                  },
                  hintText: "vendor",
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
              controller:
                  _catalogVerficationReportController.datarangefilterController,
              textInputAction: TextInputAction.done,
              keyboardType: TextInputType.text,
              filled: true,
              hasSuffixIcon: true,
              suffixIcon: Icons.close,
              suffixClicked: () {
                _catalogVerficationReportController.datarangefilterController
                    .clear();
                _catalogVerficationReportController
                    .getcatalogverificationListreport(context);
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
                  _catalogVerficationReportController.datarangefilterController
                      .text = [startDate, endDate].join(" to ");
                } else {
                  _catalogVerficationReportController.datarangefilterController
                      .clear();
                }
                _catalogVerficationReportController
                    .getcatalogverificationListreport(context);
              }),
        ],
      ),
    );
  }

}
