import 'package:ausales_application/controller/stock_assign/stock_assign_form_controller.dart';
import 'package:ausales_application/controller/stock_assign/stock_assign_list_controller.dart';
import 'package:ausales_application/core/theme/color_palette.dart';
import 'package:ausales_application/core/theme/text_palette.dart';
import 'package:ausales_application/responsive.dart';
import 'package:ausales_application/view/widgets/form_widgets/primary_button.dart';
import 'package:ausales_application/view/widgets/screen_widgets/stock_assign/delete_tag_popup.dart';
import 'package:ausales_application/view/widgets/screen_widgets/stock_assign/stock_assign_popup.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class StockAssignFormPopup extends StatefulWidget {
  const StockAssignFormPopup({super.key});

  @override
  State<StockAssignFormPopup> createState() => _StockAssignFormPopupState();
}

class _StockAssignFormPopupState extends State<StockAssignFormPopup> {
  final StockAssignListController _stockAssignListController =
      Get.put(StockAssignListController());
        final StockAssignPopupFormController _stockAssignPopupFormController =
      Get.put(StockAssignPopupFormController());

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return AlertDialog.adaptive(
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "Tag Details",
            style: TextPalette.screenTitle,
          ),
          IconButton(
              onPressed: () {
                Get.back();
                _stockAssignPopupFormController.resetForm();
                _stockAssignListController.itemtagParticularList([]);
              },
              icon: Icon(Icons.close))
        ],
      ),
      content: Container(
        width: size.width,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              StockAssignPopupdetail3(),
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
                                width: 100.w,
                                child: Text(
                                  'Tag Number',
                                  style: TextPalette.tableHeaderTextStyle,
                                ),
                              ),
                            ),
                            DataColumn(
                              label: SizedBox(
                                width: 75.w,
                                child: Text(
                                  'Sub Item',
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
                          rows: _stockAssignListController
                              .itemtagParticularList.value
                              .map((item) {
                            return DataRow(cells: [
                              DataCell(Text(item.tagNumber.toString())),
                              DataCell(
                                  Text(item.subItemDetailsName.toString())),
                              DataCell(Row(
                                children: [
                                  GestureDetector(
                                      onTap: () async {
                                        await showDialog(
                                            context: context,
                                            builder: (_) => DeleteTagpopup(
                                                itemIndex:
                                                    item.sNo.toString()));
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
      height: 50.h,
      child: SizedBox(
          width: 145.w,
          child: PrimaryButton(
            btnHeight: 46.h,
            isLoading: false,
            text: "Done",
            onPressed: () async {
              _stockAssignListController.getvalidationList(context);
              _stockAssignPopupFormController.resetForm();
            },
          )),
    );
  }
}
