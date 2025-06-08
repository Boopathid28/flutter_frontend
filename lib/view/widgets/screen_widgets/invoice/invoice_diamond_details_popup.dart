import 'package:ausales_application/controller/invoice/invoice_diamond_form_controller.dart';
import 'package:ausales_application/controller/invoice/invoice_item_controller.dart';
import 'package:ausales_application/core/theme/color_palette.dart';
import 'package:ausales_application/core/theme/text_palette.dart';
import 'package:ausales_application/responsive.dart';
import 'package:ausales_application/view/widgets/form_widgets/primary_button.dart';
import 'package:ausales_application/view/widgets/screen_widgets/invoice/delete_invoice_diamond_popup.dart';
import 'package:ausales_application/view/widgets/screen_widgets/invoice/invoice_diamond_details_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class InvoiceDiamondDetailsPopup extends StatefulWidget {
  const InvoiceDiamondDetailsPopup({super.key});

  @override
  State<InvoiceDiamondDetailsPopup> createState() => _InvoiceDiamondDetailsPopupState();
}

class _InvoiceDiamondDetailsPopupState extends State<InvoiceDiamondDetailsPopup> {
  final InvoiceDiamondFormController _invoiceDiamondFormController =
      Get.put(InvoiceDiamondFormController());

  final InvoiceItemController _invoiceItemController =
      Get.put(InvoiceItemController());

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return AlertDialog.adaptive(
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "Diamond Details",
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
              InvoiceDiamondDetailsForm(),
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
                                  'Diamond',
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
                          rows: _invoiceItemController
                              .diamondParticularList.value
                              .map((item) {
                            return DataRow(cells: [
                              DataCell(Text(item.diamondName.toString())),
                              DataCell(Text(item.reduceWeight! ? "Yes" : "No")),
                              DataCell(Text(item.diamondPieces.toString())),
                              DataCell(Text(item.diamondWeight.toString())),
                              DataCell(Text(item.diamondAmount.toString())),
                              DataCell(Row(
                                children: [
                                  GestureDetector(
                                      onTap: () {
                                        _invoiceDiamondFormController.editItemtagDiamond(context, item);
                                      }, child: Icon(Icons.edit)),
                                  SizedBox(
                                    width: 10.w,
                                  ),
                                  GestureDetector(
                                      onTap: () async {
                                        await showDialog(
                                          context: context, 
                                          builder: (_) => DeleteInvoiceDiamondPopup(itemIndex: item.id.toString())
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
                    _invoiceDiamondFormController.diamondAddCompleted(context);
                  })),
        ],
      ),
    );
  }
}
