import 'package:ausales_application/controller/metal_rate_master/metal_rate_master_list_controller.dart';
import 'package:ausales_application/core/theme/color_palette.dart';
import 'package:ausales_application/core/theme/shadow_palette.dart';
import 'package:ausales_application/core/theme/text_palette.dart';
import 'package:ausales_application/model/metal_rates/metal_rate_master.dart';
import 'package:ausales_application/responsive.dart';
import 'package:ausales_application/utils/date_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class MetalRateList extends StatefulWidget {
  const MetalRateList({super.key});

  @override
  State<MetalRateList> createState() => _MetalRateListState();
}

class _MetalRateListState extends State<MetalRateList> {
  final MetalRateMasterListController _metalRateMasterListController =
      Get.put(MetalRateMasterListController());

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(15.w),
      child: Obx(() => GridView.builder(
          shrinkWrap: true,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: Responsive.isDesktop(context) ? 4 : Responsive.isTablet(context) ? 2 : 1, // Number of columns
              crossAxisSpacing: 10.w, // Spacing between columns
              mainAxisSpacing: 10.h,
              mainAxisExtent: 120.h),
          itemCount: _metalRateMasterListController.tableData.value.length,
          itemBuilder: (context, index) {
            final item = _metalRateMasterListController.tableData.value[index];
            return RatesCard(rates: item);
          })),
    );
  }
}

class RatesCard extends StatelessWidget {
  MetalRateMasterListData rates;

  RatesCard({super.key, required this.rates});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 150.w,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.r),
          boxShadow: ShadowPalette.tableElevation,
          color: Colors.white),
      child: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              height: 25.h,
              decoration: BoxDecoration(
                color: ColorPalete.primaryColor,
                borderRadius: BorderRadius.vertical(top: Radius.circular(10.r)),
              ),
              child: Center(
                child: Text(
                  DateHelper.convertDate(rates.date.toString()),
                  style: TextPalette.dataTileTextStyle,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(15.w),
              child: ListView.separated(
                shrinkWrap: true,
                separatorBuilder: (context, index) => SizedBox(
                  height: 5.h,
                ),
                itemCount: rates.rates!.length,
                itemBuilder: (context, index) {
                  final value = rates.rates![index];
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        value.displayName ?? "",
                        style: TextPalette.tableDataTextStyle,
                      ),
                      Text(
                        value.rate.toString(),
                        style: TextPalette.tableDataTextStyle,
                      ),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
