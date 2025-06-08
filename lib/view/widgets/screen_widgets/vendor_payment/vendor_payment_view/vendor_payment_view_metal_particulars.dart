import 'package:ausales_application/controller/vendor_payment/vendor_payment_view_controller.dart';
import 'package:ausales_application/core/theme/color_palette.dart';
import 'package:ausales_application/core/theme/text_palette.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class VendorPaymentViewMetalParticulars extends StatefulWidget {
  const VendorPaymentViewMetalParticulars({super.key});

  @override
  State<VendorPaymentViewMetalParticulars> createState() =>
      _VendorPaymentViewMetalParticularsState();
}

class _VendorPaymentViewMetalParticularsState
    extends State<VendorPaymentViewMetalParticulars> {
  final VendorPaymentViewController _vendorPaymentViewController =
      Get.put(VendorPaymentViewController());

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Container(
      width: size.width * 0.48,
      color: Colors.white,
      padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 15.h),
      margin: EdgeInsets.symmetric(
        horizontal: 15.w,
      ),
      child: Obx(() => DataTable(
            headingRowColor: WidgetStateProperty.resolveWith<Color?>(
                (Set<WidgetState> states) => ColorPalete.tableHeaderBgColor),
            columns: [
              DataColumn(
                  label: SizedBox(
                child: Text(
                  "Metal Weight",
                  style: TextPalette.tableHeaderTextStyle,
                ),
              )),
              DataColumn(
                  label: SizedBox(
                child: Text(
                  "Touch",
                  style: TextPalette.tableHeaderTextStyle,
                ),
              )),
              DataColumn(
                  label: SizedBox(
                child: Text(
                  "Pure Weight",
                  style: TextPalette.tableHeaderTextStyle,
                ),
              )),
            ],
            rows: _vendorPaymentViewController.vendorDetails.value.weightDetails == null ? [] :
                _vendorPaymentViewController.vendorDetails.value.weightDetails!.map((item) {
              return DataRow(cells: [
                DataCell(Text(
                  item.metalWeight!.toStringAsFixed(3),
                  style: TextPalette.tableHeaderTextStyle,
                )),
                DataCell(Text(
                  item.touch.toString(),
                  style: TextPalette.tableHeaderTextStyle,
                )),
                DataCell(Text(
                  item.pureWeight!.toStringAsFixed(3),
                  style: TextPalette.tableHeaderTextStyle,
                ))
              ]);
            }).toList(),
          )),
    );
  }
}
