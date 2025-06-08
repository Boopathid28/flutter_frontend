import 'package:ausales_application/controller/repair_creation/repair_creation_form_controller.dart';
import 'package:ausales_application/controller/repair_creation/repair_creation_table_list_controller.dart';
import 'package:ausales_application/core/constants/app_configuration.dart';
import 'package:ausales_application/core/keyboard_listeners/shortcut_keyboard_handler.dart';
import 'package:ausales_application/core/theme/color_palette.dart';
import 'package:ausales_application/core/theme/text_palette.dart';
import 'package:ausales_application/responsive.dart';
import 'package:ausales_application/view/widgets/form_widgets/primary_button.dart';
import 'package:ausales_application/view/widgets/layouts/end_menu_drawer_widget.dart';
import 'package:ausales_application/view/widgets/layouts/footer.dart';
import 'package:ausales_application/view/widgets/layouts/header.dart';
import 'package:ausales_application/view/widgets/screen_widgets/repair_creation/new_repair_form/new_repair_details_form.dart';
import 'package:ausales_application/view/widgets/screen_widgets/repair_creation/new_repair_form/new_repair_item_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:toastification/toastification.dart';

class RepairCreationFormScreen extends StatefulWidget {
  const RepairCreationFormScreen({super.key});

  @override
  State<RepairCreationFormScreen> createState() =>
      _RepairCreationFormScreenState();
}

class _RepairCreationFormScreenState extends State<RepairCreationFormScreen> {
  final RepairCreationFormController _repairCreationFormController =
      Get.put(RepairCreationFormController());
  final RepairCreationTableListController _repairCreationTableListController =
      Get.put(RepairCreationTableListController());

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return ShorcutKeyboardHandler(
      scaffoldKey: _repairCreationFormController.scaffoldKey,
      onRefresh: () {},
      child: Scaffold(
        backgroundColor: ColorPalete.appBgColor,
        appBar: const PreferredSize(
          preferredSize: Size.fromHeight(100.0),
          child: HeaderWidget(),
        ),
        bottomNavigationBar: const Footer(),
        endDrawer: const EndMenuDrawerWidget(),
        body: Form(
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: 25.h,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15.w),
                  child: Responsive.isMobile(context)
                      ? Column(
                          children: [
                            SizedBox(
                              child: Align(
                                alignment: Alignment.topLeft,
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Responsive.isMobile(context)?
                                    InkWell(
                                      splashColor: Colors.transparent,
                                      highlightColor: Colors.transparent,
                                      onTap: () => Get.back(),
                                      child: const Icon(
                                        
                                              Icons.arrow_back_ios_new),
                                    ):
                                    IconButton(
                                        onPressed: () {
                                          Get.back();
                                        },
                                        icon: const Icon(
                                            Icons.arrow_back_ios_new)),
                                    SizedBox(
                                      height: 10.w,
                                    ),
                                    Text(
                                      "Create New Repair",
                                      style: Responsive.isDesktop(context)
                                          ? TextPalette.screenTitle
                                          : TextPalette.tableHeaderTextStyle,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Align(
                              alignment: Alignment.bottomRight,
                              child: createNewRepairButton(context),
                            ),
                          ],
                        )
                      : Row(
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
                                      icon:
                                          const Icon(Icons.arrow_back_ios_new)),
                                  SizedBox(
                                    width: 10.w,
                                  ),
                                  Text(
                                    "Create New Repair",
                                    style: Responsive.isDesktop(context)
                                        ? TextPalette.screenTitle
                                        : TextPalette.tableHeaderTextStyle,
                                  ),
                                ],
                              ),
                            ),
                            createNewRepairButton(context)
                          ],
                        ),
                ),
                SizedBox(
                  height: 15.h,
                ),
                const NewRepairDetailsForm(),
                SizedBox(
                  height: 15.h,
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 15.w),
                    child: PrimaryButton(
                        btnWidth: 150.w,
                        btnHeight:Responsive.isMobile(context)?25.h: 46.h,
                        isLoading: false,
                        text: "Create Item",
                        onPressed: () async {
                          _repairCreationFormController
                              .itemFormMode('create');
                          await Get.dialog(
                              barrierDismissible: false,
                              const NewRepairItemForm());
                        }),
                  ),
                ),
                SizedBox(
                  height: 15.h,
                ),
                addedItemDetailsList(size)
              ],
            ),
          ),
        ),
      ),
    );
  }

  SizedBox createNewRepairButton(BuildContext context) {
    return SizedBox(
        width:! Responsive.isMobile(context) ? 150.w : 75.w,
        child: Obx(() => PrimaryButton(
            btnHeight:Responsive.isMobile(context)?35.h: 46.h,
            isLoading: _repairCreationFormController.isSubmitLoading.value,
            text: "Create",
            onPressed: () async {
              _repairCreationFormController.isSubmitLoading(true);
              _repairCreationFormController.formMode('create');
              if (_repairCreationFormController.newRepairFormKey.currentState!
                  .validate()) {
                if (_repairCreationFormController
                    .repairItemDetails.value.isNotEmpty) {
                  await _repairCreationFormController
                      .submitRepairCreation(null);
                  await _repairCreationTableListController
                      .getRepairCreationTableList();
                  _repairCreationFormController.resetForm();
                } else {
                  toastification.show(
                      context:
                          context, // optional if you use ToastificationWrapper
                      type: ToastificationType.info,
                      title: const Text('Add atleast one item'),
                      autoCloseDuration: notificationDuration,
                      showProgressBar: false,
                      pauseOnHover: false);
                }
              }
              _repairCreationFormController.isSubmitLoading(false);
            })));
  }

  Container addedItemDetailsList(Size size) {
    return Container(
      padding: EdgeInsets.all(15.w),
      decoration: const BoxDecoration(
        color: Colors.white,
      ),
      width: size.width * 0.98,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Obx(() => DataTable(
            headingRowColor: WidgetStateProperty.resolveWith<Color?>(
                (Set<WidgetState> states) => ColorPalete.tableHeaderBgColor),
            columns: [
              DataColumn(
                label: Expanded(
                  child: SizedBox(
                    width: 75.w,
                    child: Text(
                      'No',
                      style: TextPalette.tableHeaderTextStyle,
                    ),
                  ),
                ),
              ),
              DataColumn(
                label: Expanded(
                  child: SizedBox(
                    width: 200.w,
                    child: Text(
                      'Action',
                      style: TextPalette.tableHeaderTextStyle,
                    ),
                  ),
                ),
              ),
              DataColumn(
                label: SizedBox(
                  width: 200.w,
                  child: Text(
                    'Item',
                    style: TextPalette.tableHeaderTextStyle,
                  ),
                ),
              ),
              DataColumn(
                label: SizedBox(
                  width: 200.w,
                  child: Text(
                    'Gross Weight',
                    style: TextPalette.tableHeaderTextStyle,
                  ),
                ),
              ),
              DataColumn(
                label: SizedBox(
                  width: 200.w,
                  child: Text(
                    'Pieces',
                    style: TextPalette.tableHeaderTextStyle,
                  ),
                ),
              ),
              DataColumn(
                label: SizedBox(
                  width: 200.w,
                  child: Text(
                    'Repair Type',
                    style: TextPalette.tableHeaderTextStyle,
                  ),
                ),
              ),
            ],
            rows: _repairCreationFormController.repairItemDetails.value
                .asMap()
                .entries
                .map((entry) {
              int index = entry.key;
              var item = entry.value;
              String itemName = '';
              String repaiTypeName = '';

              for (var eachItem
                  in _repairCreationFormController.itemsDropDown) {
                if (eachItem.value == item.itemDetails.toString()) {
                  itemName = eachItem.label;
                  break;
                }
              }
              for (var eachItem
                  in _repairCreationFormController.repairTypesDropDown) {
                if (eachItem.value == item.repairType.toString()) {
                  repaiTypeName = eachItem.label;
                  break;
                }
              }

              return DataRow(cells: [
                DataCell(SizedBox(
                  child: Text(
                    '${index + 1}',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      fontSize: 13.sp,
                    ),
                  ),
                )),
                DataCell(Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        _repairCreationFormController.itemFormMode('edit');

                        Get.dialog(
                          NewRepairItemForm(
                            item: item,
                            index: index,
                          ),
                        );
                      },
                      child: const Icon(Icons.edit),
                    ),
                    SizedBox(
                      width: 10.w,
                    ),
                    GestureDetector(
                      onTap: () {
                        _repairCreationFormController.deleteRepairItem(index);
                      },
                      child: const Icon(Icons.delete),
                    ),
                  ],
                )),
                DataCell(SizedBox(
                  child: Text(
                    itemName,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: ColorPalete.primaryColor,
                      fontSize: 13.sp,
                    ),
                  ),
                )),
                DataCell(SizedBox(
                  child: Text(
                    item.grossWeight.toString(),
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: ColorPalete.primaryColor,
                      fontSize: 13.sp,
                    ),
                  ),
                )),
                DataCell(SizedBox(
                  child: Text(
                    item.pieces.toString(),
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: ColorPalete.primaryColor,
                      fontSize: 13.sp,
                    ),
                  ),
                )),
                DataCell(SizedBox(
                  child: Text(
                    repaiTypeName,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: ColorPalete.primaryColor,
                      fontSize: 13.sp,
                    ),
                  ),
                )),
              ]);
            }).toList())),
      ),
    );
  }
}
