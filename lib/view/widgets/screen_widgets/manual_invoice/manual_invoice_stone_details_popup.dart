import 'package:ausales_application/controller/manual_invoice/manual_invoice_item_controller.dart';
import 'package:ausales_application/controller/manual_invoice/manual_invoice_stone_form_controller.dart';
import 'package:ausales_application/core/theme/color_palette.dart';
import 'package:ausales_application/core/theme/text_palette.dart';
import 'package:ausales_application/responsive.dart';
import 'package:ausales_application/view/widgets/form_widgets/primary_button.dart';
import 'package:ausales_application/view/widgets/screen_widgets/manual_invoice/manual_delete_invoice_stone_popup.dart';
import 'package:ausales_application/view/widgets/screen_widgets/manual_invoice/manual_invoice_stone_details_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class ManualInvoiceStoneDetailsPopup extends StatefulWidget {
  const ManualInvoiceStoneDetailsPopup({super.key});

  @override
  State<ManualInvoiceStoneDetailsPopup> createState() => _ManualInvoiceStoneDetailsPopupState();
}

class _ManualInvoiceStoneDetailsPopupState extends State<ManualInvoiceStoneDetailsPopup> {
  final ManualInvoiceStoneFormController _manualInvoiceStoneFormController =
      Get.put(ManualInvoiceStoneFormController());

  final ManualInvoiceItemController _manualInvoiceItemController =
      Get.put(ManualInvoiceItemController());

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return AlertDialog.adaptive(
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "Stone Details",
            style: TextPalette.screenTitle,
          ),
          IconButton(onPressed: () {
            Get.back();
          }, icon: Icon(Icons.close))
        ],
      ),
      content: Container(
        width: size.width,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              ManualInvoiceStoneDetailsForm(),
              SizedBox(
                height: 15.h,
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
                                width: 75.w,
                                child: Text(
                                  'Stone',
                                  style: TextPalette.tableHeaderTextStyle,
                                ),
                              ),
                            ),
                            DataColumn(
                              label: SizedBox(
                                width: 100.w,
                                child: Text(
                                  'Reduce Weight',
                                  style: TextPalette.tableHeaderTextStyle,
                                ),
                              ),
                            ),
                            DataColumn(
                              label: SizedBox(
                                width: 75.w,
                                child: Text(
                                  'Pieces',
                                  style: TextPalette.tableHeaderTextStyle,
                                ),
                              ),
                            ),
                            DataColumn(
                              label: SizedBox(
                                width: 75.w,
                                child: Text(
                                  'Weight',
                                  style: TextPalette.tableHeaderTextStyle,
                                ),
                              ),
                            ),
                            DataColumn(
                              label: SizedBox(
                                width: 75.w,
                                child: Text(
                                  'Amount',
                                  style: TextPalette.tableHeaderTextStyle,
                                ),
                              ),
                            ),
                            DataColumn(
                              label: SizedBox(
                                width: 75.w,
                                child: Text(
                                  'Action',
                                  style: TextPalette.tableHeaderTextStyle,
                                ),
                              ),
                            ),
                          ],
                          rows: _manualInvoiceItemController
                              .stoneParticularList.value
                              .map((item) {
                            return DataRow(cells: [
                              DataCell(Text(item.stoneName.toString())),
                              DataCell(Text(item.reduceWeight! ? "Yes" : "No")),
                              DataCell(Text(item.stonePieces.toString())),
                              DataCell(Text(item.stoneWeight.toString())),
                              DataCell(Text(item.stoneAmount.toString())),
                              DataCell(Row(
                                children: [
                                  GestureDetector(
                                      onTap: () {
                                        _manualInvoiceStoneFormController.editManualItemtagStone(context, item);
                                      }, child: Icon(Icons.edit)),
                                  SizedBox(
                                    width: 10.w,
                                  ),
                                  GestureDetector(
                                      onTap: () async {
                                        await Get.dialog(
                                          ManualDeleteInvoiceStonePopup(itemIndex: item.id.toString())
                                        );
                                      },
                                      child: Icon(Icons.delete)),
                                ],
                              )),
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
      actions: [actions(context)],
    );
  }

  SizedBox actions(BuildContext context) {
    return SizedBox(
      width: 145.w,
      height: 73.h,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          // SizedBox(
          //     width: 145.w,
          //     child: SecondaryButton(
          //         btnHeight: 46.h,
          //         isLoading: false,
          //         text: "Cancel",
          //         onPressed: () {})),
          // SizedBox(
          //   width: 10.w,
          // ),
          SizedBox(
              width: 145.w,
              child: PrimaryButton(
                  btnHeight: 46.h,
                  isLoading: false,
                  text: "Done",
                  onPressed: () {
                    _manualInvoiceStoneFormController.stoneAddCompleted(context);
                  })),
        ],
      ),
    );
  }
}
