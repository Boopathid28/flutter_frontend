import 'package:ausales_application/controller/direct_issues/direct_issues_list_controller.dart';
import 'package:ausales_application/controller/estimation_history/estimation_history_list_controller.dart';
import 'package:ausales_application/controller/invoice_history/invoice_history_list_controller.dart';
import 'package:ausales_application/controller/subitem_master/subitem_form_controller.dart';
import 'package:ausales_application/core/constants/app_configuration.dart';
import 'package:ausales_application/core/theme/color_palette.dart';
import 'package:ausales_application/core/theme/text_palette.dart';
import 'package:ausales_application/model/subitem_master/subitem_master_model.dart';
import 'package:ausales_application/responsive.dart';
import 'package:ausales_application/utils/date_helper.dart';
import 'package:ausales_application/view/widgets/form_widgets/custom_label.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class DirectViewPopup extends StatefulWidget {
  const DirectViewPopup({super.key});

  @override
  State<DirectViewPopup> createState() => _DirectViewPopupState();
}

class _DirectViewPopupState extends State<DirectViewPopup> {
  final DirectIssuesListController _directIssuesListController =
      Get.put(DirectIssuesListController());

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return AlertDialog.adaptive(
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Direct Issues Details',
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
                          CustomLabel(label: "Direct Issues Id"),
                          SizedBox(
                            height: 7.w,
                          ),
                          Text(
                            _directIssuesListController.currentdirectdetails
                                    .value?.directIssueId ??
                                "-",
                            style: TextPalette.viewDetailsDataTextStyle,
                          )
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomLabel(label: "Designer Name"),
                          SizedBox(
                            height: 7.w,
                          ),
                          Text(
                            _directIssuesListController
                                    .currentdirectdetails.value?.designerName ??
                                "-",
                            style: TextPalette.viewDetailsDataTextStyle,
                          )
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomLabel(label: "Issues Date"),
                          SizedBox(
                            height: 7.w,
                          ),
                          Text(
                            DateHelper.convertDate(_directIssuesListController
                                    .currentdirectdetails.value?.issuedDate ??
                                "-"),
                            style: TextPalette.viewDetailsDataTextStyle,
                          )
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomLabel(label: "Created By"),
                          SizedBox(
                            height: 7.w,
                          ),
                          Text(
                            _directIssuesListController
                                    .currentdirectdetails.value?.createdBy ??
                                "-",
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
                                width: Responsive.isDesktop(context)
                                    ? size.width
                                    : null,
                                child: Obx(() => DataTable(
                                      headingRowColor: WidgetStateProperty
                                          .resolveWith<Color?>(
                                              (Set<WidgetState> states) =>
                                                  ColorPalete
                                                      .tableHeaderBgColor),
                                      columns: [
                                        DataColumn(
                                          label: SizedBox(
                                            width: 100.w,
                                            child: Text(
                                              'Item Name',
                                              style: TextPalette
                                                  .tableHeaderTextStyle,
                                            ),
                                          ),
                                        ),
                                        DataColumn(
                                          label: SizedBox(
                                            width: 100.w,
                                            child: Text(
                                              'Sub Item Name',
                                              style: TextPalette
                                                  .tableHeaderTextStyle,
                                            ),
                                          ),
                                        ),
                                        DataColumn(
                                          label: SizedBox(
                                            width: 100.w,
                                            child: Text(
                                              'Tag Number',
                                              style: TextPalette
                                                  .tableHeaderTextStyle,
                                            ),
                                          ),
                                        ),
                                        DataColumn(
                                          label: SizedBox(
                                            width: 75.w,
                                            child: Text(
                                              'Gross Weight',
                                              style: TextPalette
                                                  .tableHeaderTextStyle,
                                            ),
                                          ),
                                        ),
                                        DataColumn(
                                          label: SizedBox(
                                            width: 75.w,
                                            child: Text(
                                              'Net Weight',
                                              style: TextPalette
                                                  .tableHeaderTextStyle,
                                            ),
                                          ),
                                        ),
                                        DataColumn(
                                          label: SizedBox(
                                            width: 100.w,
                                            child: Text(
                                              'Pcs',
                                              style: TextPalette
                                                  .tableHeaderTextStyle,
                                            ),
                                          ),
                                        ),
                                        DataColumn(
                                          label: SizedBox(
                                            width: 100.w,
                                            child: Text(
                                              'Total Stone Pcs',
                                              style: TextPalette
                                                  .tableHeaderTextStyle,
                                            ),
                                          ),
                                        ),
                                        DataColumn(
                                          label: SizedBox(
                                            width: 100.w,
                                            child: Text(
                                              'Total Stone Amount',
                                              style: TextPalette
                                                  .tableHeaderTextStyle,
                                            ),
                                          ),
                                        ),
                                        DataColumn(
                                          label: SizedBox(
                                            width: 100.w,
                                            child: Text(
                                              'Total Stone Weight',
                                              style: TextPalette
                                                  .tableHeaderTextStyle,
                                            ),
                                          ),
                                        ),
                                        DataColumn(
                                          label: SizedBox(
                                            width: 100.w,
                                            child: Text(
                                              'Total Diamond Pcs',
                                              style: TextPalette
                                                  .tableHeaderTextStyle,
                                            ),
                                          ),
                                        ),
                                        DataColumn(
                                          label: SizedBox(
                                            width: 100.w,
                                            child: Text(
                                              'Total Diamond Amount',
                                              style: TextPalette
                                                  .tableHeaderTextStyle,
                                            ),
                                          ),
                                        ),
                                        DataColumn(
                                          label: SizedBox(
                                            width: 100.w,
                                            child: Text(
                                              'Total Diamond Weight',
                                              style: TextPalette
                                                  .tableHeaderTextStyle,
                                            ),
                                          ),
                                        ),
                                      ],
                                      rows: _directIssuesListController
                                          .particularData.value
                                          .map((item) {
                                        return DataRow(cells: [
                                          DataCell(Text(
                                              item.itemDetailsName.toString())),
                                          DataCell(Text(item.subItemDetailsName
                                              .toString())),
                                          DataCell(
                                              Text(item.tagNumber.toString())),
                                          DataCell(Text(
                                              item.grossWeight.toString())),
                                          DataCell(
                                              Text(item.netWeight.toString())),
                                          DataCell(
                                              Text(item.pieces.toString())),
                                          DataCell(Text(item.totalStonePieces
                                              .toString())),
                                          DataCell(Text(item.totalStoneAmount
                                              .toString())),
                                          DataCell(Text(item.totalStoneWeight
                                              .toString())),
                                          DataCell(Text(item.totalDiamondPieces
                                              .toString())),
                                          DataCell(Text(item.totalDiamondAmount
                                              .toString())),
                                          DataCell(Text(item.totalDiamondWeight
                                              .toString())),
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
