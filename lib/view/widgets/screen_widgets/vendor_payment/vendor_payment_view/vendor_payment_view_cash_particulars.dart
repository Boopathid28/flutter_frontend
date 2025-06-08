import 'package:ausales_application/controller/vendor_payment/vendor_payment_view_controller.dart';
import 'package:ausales_application/core/theme/color_palette.dart';
import 'package:ausales_application/core/theme/text_palette.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class VendorPaymentViewCashParticulars extends StatefulWidget {
  const VendorPaymentViewCashParticulars({super.key});

  @override
  State<VendorPaymentViewCashParticulars> createState() =>
      _VendorPaymentViewCashParticularsState();
}

class _VendorPaymentViewCashParticularsState
    extends State<VendorPaymentViewCashParticulars> {

  final VendorPaymentViewController _vendorPaymentViewController = Get.put(VendorPaymentViewController());

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
                  "Method",
                  style: TextPalette.tableHeaderTextStyle,
                ),
              )),
              DataColumn(
                  label: SizedBox(
                child: Text(
                  "Provider",
                  style: TextPalette.tableHeaderTextStyle,
                ),
              )),
              DataColumn(
                  label: SizedBox(
                child: Text(
                  "Amount",
                  style: TextPalette.tableHeaderTextStyle,
                ),
              ))
            ],
            rows: _vendorPaymentViewController.vendorDetails.value.paymentDetails == null ? []:
                _vendorPaymentViewController.vendorDetails.value.paymentDetails!.map((item) {
              return DataRow(cells: [
                DataCell(Text(
                  item.paymentMethod.toString(),
                  style: TextPalette.tableHeaderTextStyle,
                )),
                DataCell(Text(
                  item.paymentProviders??"-",
                  style: TextPalette.tableHeaderTextStyle,
                )),
                DataCell(Text(
                  item.amount!.toStringAsFixed(3),
                  style: TextPalette.tableHeaderTextStyle,
                ))
              ]);
            }).toList(),
          )),
    );
  }
}
