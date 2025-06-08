import 'package:ausales_application/controller/estimation_history/estimation_history_list_controller.dart';
import 'package:ausales_application/controller/invoice_history/invoice_history_list_controller.dart';
import 'package:ausales_application/controller/manual_estimation_history/manual_estimation_history_list_controller.dart';
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

class ManualEstimationViewPopup extends StatefulWidget {
  const ManualEstimationViewPopup({super.key});

  @override
  State<ManualEstimationViewPopup> createState() => _ManualEstimationViewPopupState();
}

class _ManualEstimationViewPopupState extends State<ManualEstimationViewPopup> {
  final ManualEstimationHistoryListController _manualEstimationHistoryListController =
      Get.put(ManualEstimationHistoryListController());

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return AlertDialog.adaptive(
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Manual Estimation Details',
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
                          CustomLabel(label: "Estimation Id"),
                          SizedBox(
                            height: 7.w,
                          ),
                          Text(
                            _manualEstimationHistoryListController
                                    .currentestimationdetails.value?.estimationId ??
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
                            _manualEstimationHistoryListController
                                    .currentestimationdetails.value?.customerDetailsName ??
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
                            '${_manualEstimationHistoryListController
                                    .currentestimationdetails.value?.totalAmount}',
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
                            '${_manualEstimationHistoryListController
                                    .currentestimationdetails.value?.gstAmount ??
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
                             _manualEstimationHistoryListController
                                    .currentestimationdetails.value?.payableAmount ??
                                "-"
                           }',
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
                            '${_manualEstimationHistoryListController
                                    .currentestimationdetails.value?.balanceAmount?.toStringAsFixed(2) ??
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
                                width: 75.w,
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
                          rows: _manualEstimationHistoryListController
                              .particularData.value
                              .map((item) {
                            return DataRow(cells: [
                              DataCell(Text(item.itemName.toString())),
                              DataCell(Text(item.subItemName.toString())),
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
