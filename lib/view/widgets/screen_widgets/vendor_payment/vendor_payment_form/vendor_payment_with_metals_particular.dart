import 'package:ausales_application/controller/vendor_payment/vendor_payment_form/vendor_payment_form_controller.dart';
import 'package:ausales_application/core/theme/color_palette.dart';
import 'package:ausales_application/core/theme/text_palette.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class VendorPaymentWithMetalsParticular extends StatefulWidget {
  const VendorPaymentWithMetalsParticular({super.key});

  @override
  State<VendorPaymentWithMetalsParticular> createState() =>
      _VendorPaymentWithMetalsParticularState();
}

class _VendorPaymentWithMetalsParticularState
    extends State<VendorPaymentWithMetalsParticular> {
  final VendorPaymentFormController _vendorPaymentFormController =
      Get.put(VendorPaymentFormController());

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
              DataColumn(
                  label: SizedBox(
                child: Text(
                  "Remarks",
                  style: TextPalette.tableHeaderTextStyle,
                ),
              )),
              DataColumn(
                  label: SizedBox(
                child: Text(
                  "Reffered",
                  style: TextPalette.tableHeaderTextStyle,
                ),
              )),
              DataColumn(
                  label: SizedBox(
                child: Text(
                  "Action",
                  style: TextPalette.tableHeaderTextStyle,
                ),
              )),
            ],
            rows:
                _vendorPaymentFormController.metalPariculars.value.map((item) {
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
                )),
                DataCell(Text(
                  item.remarks.toString(),
                  style: TextPalette.tableHeaderTextStyle,
                )),
                DataCell(Text(
                  item.refferedBy.toString(),
                  style: TextPalette.tableHeaderTextStyle,
                )),
                DataCell(Row(
                  children: [
                    IconButton(onPressed: () {
                      _vendorPaymentFormController.deleteMetalParticulars(item.id!);
                    }, icon: Icon(Icons.delete)),
                  ],
                )),
              ]);
            }).toList(),
          )),
    );
  }
}
