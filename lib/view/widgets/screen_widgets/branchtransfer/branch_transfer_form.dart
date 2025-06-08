import 'package:ausales_application/controller/branchtransfer/branch_transfer_form.dart';
import 'package:ausales_application/controller/branchtransfer/branch_transfer_list_controller.dart';
import 'package:ausales_application/core/theme/color_palette.dart';
import 'package:ausales_application/core/theme/text_palette.dart';
import 'package:ausales_application/responsive.dart';
import 'package:ausales_application/view/widgets/form_widgets/primary_button.dart';
import 'package:ausales_application/view/widgets/screen_widgets/branchtransfer/branch_transfer_field.dart';
import 'package:ausales_application/view/widgets/screen_widgets/branchtransfer/delete_tag_popup.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class BranchTransferFormPopup extends StatefulWidget {
  const BranchTransferFormPopup({super.key});

  @override
  State<BranchTransferFormPopup> createState() => _BranchTransferFormPopupState();
}

class _BranchTransferFormPopupState extends State<BranchTransferFormPopup> {
  final BranchTransferListController _branchTransferListController = Get.put(BranchTransferListController());
  final BranchTransferFormController _branchTransferFormController = Get.put(BranchTransferFormController());
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return AlertDialog.adaptive(
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text("Branch Transfer"),
          IconButton(onPressed: () {
            Get.back();
            _branchTransferFormController.resetForm();
            _branchTransferListController.itemtagParticularList([]);
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
              BranchTransferField(),
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
                          rows: _branchTransferListController
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
                                            builder: (_) => DeleteBranchTagpopup(
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
      actions: [
         SizedBox(
              width: 145.w,
              child: Obx(() => PrimaryButton(
                  btnHeight: 46.h,
                  isLoading: _branchTransferListController.isDeleteLoading.value,
                  text: "Save",
                  onPressed: () {
                    _branchTransferFormController.CreateBranchTransfer(context);
                  }))),
      ],
    );
  }
}