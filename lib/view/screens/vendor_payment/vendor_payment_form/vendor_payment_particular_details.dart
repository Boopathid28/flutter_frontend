import 'package:ausales_application/core/theme/color_palette.dart';
import 'package:ausales_application/core/theme/text_palette.dart';
import 'package:ausales_application/model/vendor_payment/vendor_payment_models.dart';
import 'package:ausales_application/utils/date_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class VendorPaymentParticularDetails extends StatefulWidget {
  List<LedgerList> dataList;

  VendorPaymentParticularDetails({super.key, required this.dataList});

  @override
  State<VendorPaymentParticularDetails> createState() =>
      _VendorPaymentParticularDetailsState();
}

class _VendorPaymentParticularDetailsState
    extends State<VendorPaymentParticularDetails> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Container(
      width: size.width * 0.98,
      color: Colors.white,
      padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 15.h),
      margin: EdgeInsets.symmetric(horizontal: 15.w),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: DataTable(
          headingRowColor: WidgetStateProperty.resolveWith<Color?>(
              (Set<WidgetState> states) => ColorPalete.tableHeaderBgColor),
          columns: [
            DataColumn(
                label: SizedBox(
              width: 200.w,
              child: Text(
                "Transaction Type",
                style: TextPalette.tableHeaderTextStyle,
              ),
            )),
            DataColumn(
                label: SizedBox(
              width: 200.w,
              child: Text(
                "Transaction Date",
                style: TextPalette.tableHeaderTextStyle,
              ),
            )),
            DataColumn(
                label: SizedBox(
              width: 200.w,
              child: Text(
                "Ref No",
                style: TextPalette.tableHeaderTextStyle,
              ),
            )),
            DataColumn(
                label: SizedBox(
              width: 200.w,
              child: Text(
                "Transaction Weight",
                style: TextPalette.tableHeaderTextStyle,
              ),
            )),
            DataColumn(
                label: SizedBox(
              width: 200.w,
              child: Text(
                "Transaction Amount",
                style: TextPalette.tableHeaderTextStyle,
              ),
            )),
            DataColumn(
                label: SizedBox(
              width: 200.w,
              child: Text(
                "Cancelled",
                style: TextPalette.tableHeaderTextStyle,
              ),
            )),
          ],
          rows: widget.dataList.map((item) {
            return DataRow(cells: [
              DataCell(Text(
                item.transactionType.toString(),
                style: TextPalette.tableDataTextStyle,
              )),
              DataCell(Text(
                DateHelper.convertDate(item.transactionDate.toString()),
                style: TextPalette.tableDataTextStyle,
              )),
              DataCell(Text(
                item.refferenceNumber.toString(),
                style: TextPalette.tableDataTextStyle,
              )),
              DataCell(Text(
                item.transactionWeight.toString(),
                style: TextPalette.tableDataTextStyle,
              )),
              DataCell(Text(
                item.transactionAmount.toString(),
                style: TextPalette.tableDataTextStyle,
              )),
              DataCell(Text(
                item.isCanceled! ? "Cancelled" : "Active",
                style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 15,
                    color: item.isCanceled! ? Colors.red : Colors.green),
              )),
            ]);
          }).toList(),
        ),
      ),
    );
  }
}
