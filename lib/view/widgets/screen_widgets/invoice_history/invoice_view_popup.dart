import 'package:ausales_application/controller/invoice_history/invoice_history_list_controller.dart';
import 'package:ausales_application/controller/subitem_master/subitem_form_controller.dart';
import 'package:ausales_application/core/constants/app_configuration.dart';
import 'package:ausales_application/core/theme/color_palette.dart';
import 'package:ausales_application/core/theme/text_palette.dart';
import 'package:ausales_application/model/subitem_master/subitem_master_model.dart';
import 'package:ausales_application/responsive.dart';
import 'package:ausales_application/view/widgets/form_widgets/custom_label.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class InvoiceViewPopup extends StatefulWidget {
  const InvoiceViewPopup({super.key});

  @override
  State<InvoiceViewPopup> createState() => _InvoiceViewPopupState();
}

class _InvoiceViewPopupState extends State<InvoiceViewPopup> {
  final InvoiceHistoryListController _invoiceHistoryListController =
      Get.put(InvoiceHistoryListController());

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return AlertDialog.adaptive(
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'BILL Details',
            style: TextPalette.screenTitle,
          ),
          IconButton(
              iconSize: 25.sp,
              onPressed: () {
                Get.back();
              },
              icon: Icon(Icons.close))
        ],
      ),
      content: Container(
        width: MediaQuery.of(context).size.width * 0.5,
        child: Obx(() => SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
                children: [
                  Divider(
                    thickness: 1.sp,
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  Wrap(
                    spacing: 50.w,
                    runSpacing: 50.h,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomLabel(label: "Bill Id"),
                          SizedBox(
                            height: 7.w,
                          ),
                          Text(
                            _invoiceHistoryListController
                                    .currentBilldetails.value?.billId ??
                                "-",
                            style: TextPalette.viewDetailsDataTextStyle,
                          )
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomLabel(label: "Customer Name"),
                          SizedBox(
                            height: 7.w,
                          ),
                          Text(
                            _invoiceHistoryListController
                                    .currentBilldetails.value?.customerName ??
                                "-",
                            style: TextPalette.viewDetailsDataTextStyle,
                          )
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomLabel(label: "Total Amount"),
                          SizedBox(
                            height: 7.w,
                          ),
                          Text(
                            '${_invoiceHistoryListController
                                    .currentBilldetails.value?.totalAmount}',
                            style: TextPalette.viewDetailsDataTextStyle,
                          )
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomLabel(label: "Gst Amount"),
                          SizedBox(
                            height: 7.w,
                          ),
                          Text(
                            '${_invoiceHistoryListController
                                    .currentBilldetails.value?.gstAmount ??
                                "-"}',
                            style: TextPalette.viewDetailsDataTextStyle,
                          )
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomLabel(label: "Payable Amount"),
                          SizedBox(
                            height: 7.w,
                          ),
                          Text(
                           '${
                             _invoiceHistoryListController
                                    .currentBilldetails.value?.payableAmount ??
                                "-"
                           }',
                            style: TextPalette.viewDetailsDataTextStyle,
                          )
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomLabel(label: "Paid Amount"),
                          SizedBox(
                            height: 7.w,
                          ),
                          Text(
                            '${_invoiceHistoryListController
                                    .currentBilldetails.value?.paidAmount ??
                                "-"}',
                            style: TextPalette.viewDetailsDataTextStyle,
                          )
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomLabel(label: "Balance Amount"),
                          SizedBox(
                            height: 7.w,
                          ),
                          Text(
                            // ignore: unnecessary_string_interpolations
                            '${_invoiceHistoryListController
                                    .currentBilldetails.value?.balanceAmount?.toStringAsFixed(2) ??
                                "-"}',
                            style: TextPalette.viewDetailsDataTextStyle,
                          )
                        ],
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  Divider(
                    thickness: 1.sp,
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                   Container(
        width: size.width,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Flexible(
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: SizedBox(
                    width: Responsive.isDesktop(context) ? size.width : null,
                    child: Obx(() => DataTable(
                          headingRowColor:
                              WidgetStateProperty.resolveWith<Color?>(
                                  (Set<WidgetState> states) =>
                                      ColorPalete.tableHeaderBgColor),
                          columns: [
                            DataColumn(
                              label: SizedBox(
                                width: 100.w,
                                child: Text(
                                  'Item Name',
                                  style: TextPalette.tableHeaderTextStyle,
                                ),
                              ),
                            ),
                            DataColumn(
                              label: SizedBox(
                                width: 100.w,
                                child: Text(
                                  'Sub Item Name',
                                  style: TextPalette.tableHeaderTextStyle,
                                ),
                              ),
                            ),
                            DataColumn(
                              label: SizedBox(
                                width: 100.w,
                                child: Text(
                                  'Tag Number',
                                  style: TextPalette.tableHeaderTextStyle,
                                ),
                              ),
                            ),
                            DataColumn(
                              label: SizedBox(
                                width: 100.w,
                                child: Text(
                                  'Net Weight',
                                  style: TextPalette.tableHeaderTextStyle,
                                ),
                              ),
                            ),
                            DataColumn(
                              label: SizedBox(
                                width: 100.w,
                                child: Text(
                                  'Rate',
                                  style: TextPalette.tableHeaderTextStyle,
                                ),
                              ),
                            ),
                            DataColumn(
                              label: SizedBox(
                                width: 100.w,
                                child: Text(
                                  'Wastage Percent',
                                  style: TextPalette.tableHeaderTextStyle,
                                ),
                              ),
                            ),
                            DataColumn(
                              label: SizedBox(
                                width: 100.w,
                                child: Text(
                                  'Making Charge Per Gram',
                                  style: TextPalette.tableHeaderTextStyle,
                                ),
                              ),
                            ),
                          ],
                          rows: _invoiceHistoryListController
                              .particularData.value
                              .map((item) {
                            return DataRow(cells: [
                              DataCell(Text(item.itemDetailsName.toString())),
                              DataCell(Text(item.subItemDetailsName.toString())),
                              DataCell(Text(item.tagNumber.toString())),
                              DataCell(Text(item.netWeight.toString())),
                              DataCell(Text(item.rate.toString())),
                              DataCell(Text(item.wastagePercent.toString())),
                              DataCell(Text(item.makingChargePerGram.toString())),
                            ]);
                          }).toList(),
                        )),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
                ],
              ),
        )),
      ),
    );
  }
}
