import 'package:ausales_application/controller/order/order_item_form_controller.dart';
import 'package:ausales_application/controller/order/stone_diamond_form_controller.dart/order_stone_form_controller.dart';
import 'package:ausales_application/core/theme/color_palette.dart';
import 'package:ausales_application/core/theme/text_palette.dart';
import 'package:ausales_application/responsive.dart';
import 'package:ausales_application/view/widgets/form_widgets/primary_button.dart';
import 'package:ausales_application/view/widgets/screen_widgets/order/stone_details/delete_stone_popup.dart';
import 'package:ausales_application/view/widgets/screen_widgets/order/stone_details/stone_details_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class StoneDetailsPopup extends StatefulWidget {
  const StoneDetailsPopup({super.key});

  @override
  State<StoneDetailsPopup> createState() => _StoneDetailsPopupState();
}

class _StoneDetailsPopupState extends State<StoneDetailsPopup> {
  final OrderStoneFormController _orderStoneFormController =
      Get.put(OrderStoneFormController());

  final OrderItemFormController _orderItemFormController =
      Get.put(OrderItemFormController());

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
              StoneDetailsForm(),
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
                          rows: _orderItemFormController
                              .stonedetailsParticulars.value
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
                                        _orderStoneFormController.editOrderStone(context, item);
                                      }, child: Icon(Icons.edit)),
                                  SizedBox(
                                    width: 10.w,
                                  ),
                                  GestureDetector(
                                      onTap: () async {
                                        await showDialog(
                                          context: context, 
                                          builder: (_) => DeleteStonePopup(itemIndex: item.sNo.toString())
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
                    _orderStoneFormController.stoneAddCompleted(context);
                  })),
        ],
      ),
    );
  }
}
