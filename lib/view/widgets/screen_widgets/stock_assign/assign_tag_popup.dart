import 'package:ausales_application/controller/stock_assign/stock_assign_list_controller.dart';
import 'package:ausales_application/core/theme/color_palette.dart';
import 'package:ausales_application/core/theme/text_palette.dart';
import 'package:ausales_application/responsive.dart';
import 'package:ausales_application/view/widgets/form_widgets/primary_button.dart';
import 'package:ausales_application/view/widgets/form_widgets/secondary_button.dart';
import 'package:ausales_application/view/widgets/screen_widgets/itemtag/itemtag_form/delete_stone_popup.dart';
import 'package:ausales_application/view/widgets/screen_widgets/stock_assign/stock_assign_popup.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class AssignTagPopup extends StatefulWidget {
  const AssignTagPopup({super.key});

  @override
  State<AssignTagPopup> createState() => _AssignTagPopupState();
}

class _AssignTagPopupState extends State<AssignTagPopup> {
  final StockAssignListController _stockAssignListController =
      Get.put(StockAssignListController());

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return AlertDialog.adaptive(
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "Assign Details",
            style: TextPalette.screenTitle,
          ),
          IconButton(
              onPressed: () {
                Get.back();
              },
              icon: Icon(Icons.close))
        ],
      ),
      content: Container(
        width: size.width,
        child: SingleChildScrollView(
          child: Row(
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
                                'Box Details',
                                style: TextPalette.tableHeaderTextStyle,
                              ),
                            ),
                          ),
                          DataColumn(
                            label: SizedBox(
                              width: 100.w,
                              child: Text(
                                'Tag number',
                                style: TextPalette.tableHeaderTextStyle,
                              ),
                            ),
                          ),
                          DataColumn(
                            label: SizedBox(
                              width: 100.w,
                              child: Text(
                                'Counter',
                                style: TextPalette.tableHeaderTextStyle,
                              ),
                            ),
                          ),
                            DataColumn(
                            label: SizedBox(
                              width: 100.w,
                              child: Text(
                                'Floor',
                                style: TextPalette.tableHeaderTextStyle,
                              ),
                            ),
                          ),
                             DataColumn(
                            label: SizedBox(
                              width: 100.w,
                              child: Text(
                                'Branch',
                                style: TextPalette.tableHeaderTextStyle,
                              ),
                            ),
                          ),
                        ],
                        rows: _stockAssignListController
                            .tableDataValidation.value!.assignedTags!
                            .map((item) {
                          return DataRow(cells: [
                            DataCell(Text(item.catalogDetails.toString())),
                            DataCell(Text(item.tagNumber.toString())),
                            DataCell(Text(item.counter.toString())),
                            DataCell(Text(item.floor.toString())),
                            DataCell(Text(item.branch.toString())),
                          ]);
                        }).toList(),
                      )),
                ),
              )),
              SizedBox(
                width:15.w,
              ),
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
                                'Tag number',
                                style: TextPalette.tableHeaderTextStyle,
                              ),
                            ),
                          )
                        ],
                        rows: _stockAssignListController
                            .tableDataValidation.value!.newTag!
                            .map((item) {
                          return DataRow(cells: [
                            DataCell(Text(item.toString())),
                          ]);
                        }).toList(),
                      )),
                ),
              )),
            ],
          ),
        ),
      ),
      actions: [
        Text("Some of the tags are already assigned do you want to transfer to the new box",style: TextStyle(fontSize: 15.sp,color: Colors.red),),
        savebtn(context),
        No()
      ],
    );
  }

  SizedBox No() {
    return SizedBox(
        width: Responsive.isDesktop(context) || Responsive.isTablet(context)
            ? 115.w
            : double.infinity,
        child: SecondaryButton(
            btnHeight: 46.h,
            isLoading: _stockAssignListController.isTableLoading.value,
            text: "No",
            onPressed: () {
              Get.back();
            }));
  }

  SizedBox savebtn(BuildContext context) {
    return SizedBox(
        width: Responsive.isDesktop(context) || Responsive.isTablet(context)
            ? 115.w
            : double.infinity,
        child: Obx(() => PrimaryButton(
            btnHeight: 46.h,
            isLoading: _stockAssignListController.isTableLoading.value,
            text: "Save",
            onPressed: () {
              _stockAssignListController.CreateAssignStock(context);
            })));
  }
}
