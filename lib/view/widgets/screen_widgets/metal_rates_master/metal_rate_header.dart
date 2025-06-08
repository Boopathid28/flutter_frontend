import 'package:ausales_application/controller/metal_rate_master/metal_rate_master_list_controller.dart';
import 'package:ausales_application/responsive.dart';
import 'package:ausales_application/view/widgets/form_widgets/custom_label_filter.dart';
import 'package:ausales_application/view/widgets/form_widgets/custom_text_input.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class MetalRateHeader extends StatefulWidget {
  const MetalRateHeader({super.key});

  @override
  State<MetalRateHeader> createState() => _MetalRateHeaderState();
}

class _MetalRateHeaderState extends State<MetalRateHeader> {
  final MetalRateMasterListController _metalRateMasterListController = Get.put(MetalRateMasterListController());

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(15.w),
      child: Responsive.isDesktop(context) || Responsive.isTablet(context) ? Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          entryDateRangeFilter(context)
        ],
      ) : Column(
        children: [
          entryDateRangeFilter(context)
        ],
      ),
    );
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
              controller: _metalRateMasterListController.datarangefilterController,
              textInputAction: TextInputAction.done,
              keyboardType: TextInputType.text,
              filled: true,
              hasSuffixIcon: true,
              suffixIcon: Icons.close,
              suffixClicked: () {
                _metalRateMasterListController.datarangefilterController.clear();
                _metalRateMasterListController.getMetalRateMasterList(context);
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
                  _metalRateMasterListController.datarangefilterController.text =
                      [startDate, endDate].join(" to ");
                } else {
                  _metalRateMasterListController.datarangefilterController.clear();
                }
                _metalRateMasterListController.getMetalRateMasterList(context);
              }),
        ],
      ),
    );
  }

}
