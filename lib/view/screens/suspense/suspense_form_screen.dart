import 'package:ausales_application/controller/suspense/suspense_form_controller.dart';
import 'package:ausales_application/controller/suspense/suspense_item_form_controller.dart';
import 'package:ausales_application/core/keyboard_listeners/shortcut_keyboard_handler.dart';
import 'package:ausales_application/core/theme/color_palette.dart';
import 'package:ausales_application/core/theme/text_palette.dart';
import 'package:ausales_application/responsive.dart';
import 'package:ausales_application/view/widgets/form_widgets/primary_button.dart';
import 'package:ausales_application/view/widgets/layouts/end_menu_drawer_widget.dart';
import 'package:ausales_application/view/widgets/layouts/footer.dart';
import 'package:ausales_application/view/widgets/layouts/header.dart';
import 'package:ausales_application/view/widgets/screen_widgets/suspense/item_details/delete_item_popup.dart';
import 'package:ausales_application/view/widgets/screen_widgets/suspense/item_details/item_form.dart';
import 'package:ausales_application/view/widgets/screen_widgets/suspense/item_details/suspense_details_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class SuspenseFormScreen extends StatefulWidget {
  const SuspenseFormScreen({super.key});

  @override
  State<SuspenseFormScreen> createState() => _SuspenseFormScreenState();
}

class _SuspenseFormScreenState extends State<SuspenseFormScreen> {
  final SuspenseFormController _suspenseFormController =
      Get.put(SuspenseFormController());

  final SuspenseItemFormController _suspenseItemFormController =
      Get.put(SuspenseItemFormController());

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return ShorcutKeyboardHandler(
      scaffoldKey: _suspenseFormController.scaffoldKey,
      onRefresh: () {},
      child: Scaffold(
        backgroundColor: ColorPalete.appBgColor,
        appBar: PreferredSize(
          child: HeaderWidget(),
          preferredSize: Size.fromHeight(100.0),
        ),
        bottomNavigationBar: Footer(),
        endDrawer: EndMenuDrawerWidget(),
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 25.h,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 15.w),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                              onPressed: () {
                                Get.back();
                              },
                              icon: Icon(Icons.arrow_back_ios_new)),
                          SizedBox(
                            width: 10.w,
                          ),
                          Text(
                            "Create Suspense",
                            style: Responsive.isDesktop(context)
                                ? TextPalette.screenTitle
                                : TextPalette.tableHeaderTextStyle,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                        width: Responsive.isDesktop(context) ? 150.w : 75.w,
                        child: Obx(() => PrimaryButton(
                            btnHeight: 46.h,
                            isLoading:
                                _suspenseFormController.isFormSubmit.value,
                            text: "Create",
                            onPressed: () {
                              _suspenseFormController.CreateSuspense(context);
                            }))),
                  ],
                ),
              ),
              SizedBox(
                height: 15.h,
              ),
              SuspenseDetailsForm(),
              SizedBox(
                height: 15.h,
              ),
              SuspenseItemForm(),
              SizedBox(
                height: 15.h,
              ),
              itemparticulars(size)
            ],
          ),
        ),
      ),
    );
  }

  Container itemparticulars(Size size) {
    return Container(
      padding: EdgeInsets.all(15.w),
      decoration: BoxDecoration(
        color: Colors.white,
      ),
      width: size.width * 0.98,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: SizedBox(
          width: Responsive.isDesktop(context) ? size.width : null,
          child: Obx(() => DataTable(
                headingRowColor: WidgetStateProperty.resolveWith<Color?>(
                    (Set<WidgetState> states) =>
                        ColorPalete.tableHeaderBgColor),
                columns: [
                  DataColumn(
                    label: SizedBox(
                      width: 125.w,
                      child: Text(
                        'Metal Name',
                        style: TextPalette.tableHeaderTextStyle,
                      ),
                    ),
                  ),
                  DataColumn(
                    label: SizedBox(
                      width: 125.w,
                      child: Text(
                        'Item',
                        style: TextPalette.tableHeaderTextStyle,
                      ),
                    ),
                  ),
                  DataColumn(
                    label: SizedBox(
                      width: 125.w,
                      child: Text(
                        'SubItem',
                        style: TextPalette.tableHeaderTextStyle,
                      ),
                    ),
                  ),
                  DataColumn(
                    label: SizedBox(
                      width: 125.w,
                      child: Text(
                        'Metal Amount',
                        style: TextPalette.tableHeaderTextStyle,
                      ),
                    ),
                  ),
                  DataColumn(
                    label: SizedBox(
                      width: 100.w,
                      child: Text(
                        'Metal Weight',
                        style: TextPalette.tableHeaderTextStyle,
                      ),
                    ),
                  ),
                  DataColumn(
                    label: SizedBox(
                      width: 125.w,
                      child: Text(
                        'Total Amount',
                        style: TextPalette.tableHeaderTextStyle,
                      ),
                    ),
                  ),
                  DataColumn(
                    label: SizedBox(
                      width: 125.w,
                      child: Text(
                        'Action',
                        style: TextPalette.tableHeaderTextStyle,
                      ),
                    ),
                  ),
                ],
                rows: _suspenseFormController.itemdetailsParticularList.value
                    .map((item) {
                  return DataRow(cells: [
                    DataCell(SizedBox(
                        width: 100.w, child: Text(item.metalName.toString()))),
                    DataCell(SizedBox(
                        width: 100.w, child: Text(item.itemDetailsName.toString()))),
                    DataCell(SizedBox(
                        width: 100.w, child: Text(item.subItemDetailsName.toString()))),
                    DataCell(SizedBox(
                        width: 100.w,
                        child: Text(item.metalAmount.toString()))),
                    DataCell(SizedBox(
                        width: 100.w,
                        child: Text(item.metalWeight.toString()))),
                    DataCell(SizedBox(
                        width: 100.w,
                        child: Text(item.totalAmount.toString()))),
                    DataCell(Row(
                      children: [
                        GestureDetector(
                            onTap: () {
                              _suspenseItemFormController.editItem(
                                  context, item);
                            },
                            child: Icon(Icons.visibility)),
                        SizedBox(
                          width: 10.w,
                        ),
                        GestureDetector(
                            onTap: () {
                              _suspenseItemFormController.editItem(
                                  context, item);
                            },
                            child: Icon(Icons.edit)),
                        SizedBox(
                          width: 10.w,
                        ),
                        GestureDetector(
                            onTap: () async {
                              await showDialog(
                                  context: context,
                                  builder: (_) =>
                                      DeleteItemPopup(itemIndex: item.sNo));
                            },
                            child: Icon(Icons.delete)),
                      ],
                    )),
                  ]);
                }).toList(),
              )),
        ),
      ),
    );
  }
}
