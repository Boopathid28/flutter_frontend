import 'package:ausales_application/controller/reports/live_stock_report_controller.dart';
import 'package:ausales_application/controller/reports/order_metal_wise_report_list_controller.dart';
import 'package:ausales_application/view/widgets/form_widgets/custom_dropdown_search_field.dart';
import 'package:ausales_application/view/widgets/form_widgets/custom_label_filter.dart';
import 'package:ausales_application/view/widgets/form_widgets/custom_text_input.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class LiveStockReportHeader extends StatefulWidget {
  const LiveStockReportHeader({super.key});

  @override
  State<LiveStockReportHeader> createState() =>
      _LiveStockReportHeaderState();
}

class _LiveStockReportHeaderState
    extends State<LiveStockReportHeader> {
  final LiveStockReportController _liveStockReportController =
      Get.put(LiveStockReportController());

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.all(15.w),
        child: Wrap(
          spacing: 10.w,
          runSpacing: 10.h,
          children: [
            Obx(() => _liveStockReportController.isBranchuser.value
                ? branch(context)
                : SizedBox()),
            metal(context),
            item(context),
            stocktype(context)
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
                      _liveStockReportController.searchbranchController,
                  filled: true,
                  selectedValue:
                      _liveStockReportController.selectedbranch.value,
                  options: _liveStockReportController.branchFilterList.value,
                  onChanged: (value) {
                    _liveStockReportController.selectedbranch(value);
                    _liveStockReportController
                        .getlivestockreport(context);
                  },
                  hintText: "Branch",
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
                CustomLabelFilter(label: "Metal"),
                SizedBox(
                  height: 7.w,
                ),
                CustomDropdownSearchField(
                  controller:
                      _liveStockReportController.searchMetalController,
                  filled: true,
                  selectedValue:
                      _liveStockReportController.selectedmetal.value,
                  options:
                      _liveStockReportController.metalFilterList.value,
                  onChanged: (value) {
                    _liveStockReportController.selectedmetal(value);
                    _liveStockReportController
                        .getlivestockreport(context);
                  },
                  hintText: "Metal",
                ),
              ],
            )));
  }

 SizedBox item(BuildContext context) {
    return SizedBox(
        width: 200.w,
        child: Obx(() => Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomLabelFilter(label: "Item"),
                SizedBox(
                  height: 7.w,
                ),
                CustomDropdownSearchField(
                  controller:
                      _liveStockReportController.searchitemController,
                  filled: true,
                  selectedValue:
                      _liveStockReportController.selecteditem.value,
                  options:
                      _liveStockReportController.itemFilterList.value,
                  onChanged: (value) {
                    _liveStockReportController.selecteditem(value);
                    _liveStockReportController
                        .getlivestockreport(context);
                  },
                  hintText: "Item",
                ),
              ],
            )));
  }


SizedBox stocktype(BuildContext context) {
    return SizedBox(
        width: 200.w,
        child: Obx(() => Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomLabelFilter(label: "Stock type"),
                SizedBox(
                  height: 7.w,
                ),
                CustomDropdownSearchField(
                  controller:
                      _liveStockReportController.searchstocktypeController,
                  filled: true,
                  selectedValue:
                      _liveStockReportController.selectedstocktype.value,
                  options:
                      _liveStockReportController.stocktypeFilterList.value,
                  onChanged: (value) {
                    _liveStockReportController.selectedstocktype(value);
                    _liveStockReportController
                        .getlivestockreport(context);
                  },
                  hintText: "Stock type",
                ),
              ],
            )));
  }


}
