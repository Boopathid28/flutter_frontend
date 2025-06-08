import 'dart:developer';

import 'package:ausales_application/controller/repair_creation/assign_vendor_list_controller.dart';
import 'package:ausales_application/core/constants/app_configuration.dart';
import 'package:ausales_application/model/assign_vendor/assign_vendor_models.dart';
import 'package:ausales_application/responsive.dart';
import 'package:ausales_application/view/widgets/form_widgets/primary_button.dart';
import 'package:ausales_application/view/widgets/layouts/footer.dart';
import 'package:ausales_application/view/widgets/layouts/header.dart';
import 'package:ausales_application/view/widgets/screen_widgets/repair_creation/assign_vendor/assign_vendor_popup.dart';
import 'package:flutter/material.dart';
import 'package:ausales_application/core/theme/color_palette.dart';
import 'package:ausales_application/core/theme/text_palette.dart';
import 'package:ausales_application/model/repair_creation/repair_creation_models.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:toastification/toastification.dart';

class AssignVendorScreen extends StatefulWidget {
  // final RepairTableList item;
  const AssignVendorScreen({super.key});

  @override
  State<AssignVendorScreen> createState() => _AssignVendorScreenState();
}

class _AssignVendorScreenState extends State<AssignVendorScreen> {
  final AssignVendorListController _assignVendorListController =
      Get.put(AssignVendorListController());

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.sizeOf(context);
    return Scaffold(
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(100.0),
        child: HeaderWidget(),
      ),
      bottomNavigationBar: const Footer(),
      body: SingleChildScrollView(
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
                                Responsive.isMobile(context)
                                    ? InkWell(
                                        splashColor: Colors.transparent,
                                        highlightColor: Colors.transparent,
                                        onTap: () => Get.back(),
                                        child: const Icon(
                                            Icons.arrow_back_ios_new),
                                      )
                                    : IconButton(
                                        onPressed: () {
                                          Get.back();
                                        },
                                        icon: const Icon(
                                            Icons.arrow_back_ios_new)),
                                SizedBox(
                                  height: 10.w,
                                ),
                                Text(
                                  "Assign Vendor",
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
                          child: saveButton(context),
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
                                  icon: const Icon(Icons.arrow_back_ios_new)),
                              SizedBox(
                                width: 10.w,
                              ),
                              Text(
                                "Assign Vendor",
                                style: Responsive.isDesktop(context)
                                    ? TextPalette.screenTitle
                                    : TextPalette.tableHeaderTextStyle,
                              ),
                            ],
                          ),
                        ),
                        saveButton(context)
                      ],
                    ),
            ),
            SizedBox(
              height: 25.h,
            ),
            Container(
              height: 550.h,
              decoration: const BoxDecoration(
                color: Colors.white,
              ),
              margin: EdgeInsets.symmetric(horizontal: 15.w),
              child: Stack(
                children: [
                  Obx(() => _assignVendorListController.isTableLoading.value
                      ? Padding(
                          padding: EdgeInsets.symmetric(horizontal: 7.w),
                          child: const LinearProgressIndicator(),
                        )
                      : ListView(
                          children: [
                            Obx(() => PaginatedDataTable(
                                  showEmptyRows: false,
                                  rowsPerPage: _assignVendorListController
                                      .itemsPerPage.value,
                                  headingRowColor:
                                      WidgetStateProperty.resolveWith<Color?>(
                                          (Set<WidgetState> states) =>
                                              ColorPalete.tableHeaderBgColor),
                                  columns: [
                                    DataColumn(
                                        label: Text(
                                      'S.No',
                                      style: TextPalette.tableHeaderTextStyle,
                                    )),
                                    DataColumn(
                                        label: Text(
                                      'Repair ID',
                                      style: TextPalette.tableHeaderTextStyle,
                                    )),
                                    DataColumn(
                                        label: Text(
                                      'Repair Type',
                                      style: TextPalette.tableHeaderTextStyle,
                                    )),
                                    DataColumn(
                                        label: Text(
                                      'Item',
                                      style: TextPalette.tableHeaderTextStyle,
                                    )),
                                    DataColumn(
                                        label: Text(
                                      'Pieces',
                                      style: TextPalette.tableHeaderTextStyle,
                                    )),
                                    DataColumn(
                                        label: Text(
                                      'Gross Weight',
                                      style: TextPalette.tableHeaderTextStyle,
                                    )),
                                    DataColumn(
                                        label: Text(
                                      'Customer',
                                      style: TextPalette.tableHeaderTextStyle,
                                    )),
                                    DataColumn(
                                        label: Text(
                                      'Assign',
                                      style: TextPalette.tableHeaderTextStyle,
                                    )),
                                  ],
                                  source: _DataSource(
                                      context,
                                      _assignVendorListController
                                          .tableData.value),
                                )),
                          ],
                        )),
                  Positioned(
                    bottom: 0,
                    left: 0,
                    child: Container(
                      height: Responsive.isMobile(context) ? 118.h : 60.h,
                      width: size.width - 38,
                      padding: const EdgeInsets.all(16.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.vertical(
                            bottom: Radius.circular(15.r)),
                        color: Colors.white,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          itemsPerPageChange(context),
                          SizedBox(
                            width: 5.w,
                          ),
                          changePage(context),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  SizedBox saveButton(BuildContext context) {
    return SizedBox(
      width:! Responsive.isMobile(context) ? 150.w : 75.w,
      child: PrimaryButton(
        btnHeight:Responsive.isMobile(context)?35.h: 46.h,
        isLoading: _assignVendorListController.isSubmitLoading.value,
        text: 'Save',
        onPressed: () async {
          _assignVendorListController.isSubmitLoading(true);
          bool date = true;
          _assignVendorListController.repairItemList.any(
            (element) {
              if (element.dueDate.toString().isEmpty) {
                date = false;
              }
              return date;
            },
          );
      
          if (!date) {
            toastification.show(
                context: context,
                type: ToastificationType.info,
                title: const Text('Choose Due Date'),
                autoCloseDuration: notificationDuration,
                showProgressBar: false,
                pauseOnHover: false);
          } else if (_assignVendorListController.repairItemList.isNotEmpty) {
            await _assignVendorListController.assignVendor();
          } else {
            toastification.show(
                context: context,
                type: ToastificationType.info,
                title: const Text('Please assign an item'),
                autoCloseDuration: notificationDuration,
                showProgressBar: false,
                pauseOnHover: false);
          }
          _assignVendorListController.isSubmitLoading(false);
        },
      ),
    );
  }

  SizedBox itemsPerPageChange(BuildContext context) {
    return SizedBox(
      child: Responsive.isMobile(context)
          ? Column(
              children: [
                Text(
                  'Rows per page:',
                  style: TextStyle(
                      fontSize: Responsive.isDesktop(context) ||
                              Responsive.isTablet(context)
                          ? 12.sp
                          : 10.sp),
                ),
                SizedBox(
                  width: 15.w,
                ),
                Obx(() => DropdownButton<int>(
                      value: _assignVendorListController.itemsPerPage.value,
                      onChanged: (value) {
                        _assignVendorListController.itemsPerPage(value);
                        _assignVendorListController
                            .getNotIssuedRepairCreationTableList();
                      },
                      items: [1, 5, 10, 20, 50]
                          .map((value) => DropdownMenuItem<int>(
                                value: value,
                                child: Text('$value'),
                              ))
                          .toList(),
                    )),
              ],
            )
          : Row(
              children: [
                Text(
                  'Rows per page:',
                  style: TextStyle(
                      fontSize: Responsive.isDesktop(context) ||
                              Responsive.isTablet(context)
                          ? 12.sp
                          : 10.sp),
                ),
                SizedBox(
                  width: 15.w,
                ),
                Obx(() => DropdownButton<int>(
                      value: _assignVendorListController.itemsPerPage.value,
                      onChanged: (value) {
                        _assignVendorListController.itemsPerPage(value);
                        _assignVendorListController
                            .getNotIssuedRepairCreationTableList();
                      },
                      items: [1, 5, 10, 20, 50]
                          .map((value) => DropdownMenuItem<int>(
                                value: value,
                                child: Text('$value'),
                              ))
                          .toList(),
                    )),
              ],
            ),
    );
  }

  Obx changePage(BuildContext context) {
    return Obx(() => Responsive.isMobile(context)
        ? Column(
            children: [
              Text(
                'Page ${_assignVendorListController.page.value} of ${_assignVendorListController.totalpages.value}',
                style: TextStyle(
                    fontSize: Responsive.isDesktop(context) ||
                            Responsive.isTablet(context)
                        ? 12.sp
                        : 10.sp),
              ),
              Row(
                children: [
                  IconButton(
                      icon: Icon(Icons.arrow_back,
                          size: Responsive.isDesktop(context) ||
                                  Responsive.isTablet(context)
                              ? 20.sp
                              : 15.sp),
                      onPressed: _assignVendorListController.page.value > 1
                          ? () {
                              if (_assignVendorListController.page.value > 1) {
                                _assignVendorListController.page(
                                    _assignVendorListController.page.value - 1);
                                _assignVendorListController
                                    .getNotIssuedRepairCreationTableList();
                              }
                            }
                          : null),
                  IconButton(
                      icon: Icon(Icons.arrow_forward,
                          size: Responsive.isDesktop(context) ||
                                  Responsive.isTablet(context)
                              ? 20.sp
                              : 15.sp),
                      onPressed: _assignVendorListController.page.value <
                              _assignVendorListController.totalpages.value
                          ? () {
                              if (_assignVendorListController.page.value <
                                  _assignVendorListController
                                      .totalpages.value) {
                                _assignVendorListController.page(
                                    _assignVendorListController.page.value + 1);
                                _assignVendorListController
                                    .getNotIssuedRepairCreationTableList();
                              }
                            }
                          : null),
                ],
              ),
            ],
          )
        : Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'Page ${_assignVendorListController.page.value} of ${_assignVendorListController.totalpages.value}',
                style: TextStyle(
                    fontSize: Responsive.isDesktop(context) ||
                            Responsive.isTablet(context)
                        ? 12.sp
                        : 10.sp),
              ),
              IconButton(
                  icon: Icon(Icons.arrow_back,
                      size: Responsive.isDesktop(context) ||
                              Responsive.isTablet(context)
                          ? 20.sp
                          : 15.sp),
                  onPressed: _assignVendorListController.page.value > 1
                      ? () {
                          if (_assignVendorListController.page.value > 1) {
                            _assignVendorListController.page(
                                _assignVendorListController.page.value - 1);
                            _assignVendorListController
                                .getNotIssuedRepairCreationTableList();
                          }
                        }
                      : null),
              IconButton(
                  icon: Icon(Icons.arrow_forward,
                      size: Responsive.isDesktop(context) ||
                              Responsive.isTablet(context)
                          ? 20.sp
                          : 15.sp),
                  onPressed: _assignVendorListController.page.value <
                          _assignVendorListController.totalpages.value
                      ? () {
                          if (_assignVendorListController.page.value <
                              _assignVendorListController.totalpages.value) {
                            _assignVendorListController.page(
                                _assignVendorListController.page.value + 1);
                            _assignVendorListController
                                .getNotIssuedRepairCreationTableList();
                          }
                        }
                      : null),
            ],
          ));
  }
}

class _DataSource extends DataTableSource {
  BuildContext context;
  List<NotIssuesRepairItemTableList> data;
  _DataSource(this.context, this.data);

  int _selectedCount = 0;

  final AssignVendorListController _assignVendorListController =
      Get.put(AssignVendorListController());

  @override
  DataRow? getRow(int index) {
    assert(index >= 0);
    if (index >= data.length) return null;
    final row = data[index];

    return DataRow.byIndex(
      color: WidgetStateProperty.resolveWith<Color?>(
          (Set<WidgetState> states) =>
              index % 2 == 0 ? Colors.white : ColorPalete.tableHeaderBgColor),
      index: index,
      cells: [
        DataCell(Text(
          row.sNo.toString(),
          style: TextPalette.tableDataTextStyle,
        )),
        DataCell(Text(
          row.repairId.toString(),
          style: TextPalette.tableDataTextStyle,
        )),
        DataCell(Text(
          row.repairType!.split('T')[0].toString(),
          style: TextPalette.tableDataTextStyle,
        )),
        DataCell(Text(
          row.itemDetails.toString(),
          style: TextPalette.tableDataTextStyle,
        )),
        DataCell(Text(
          row.pieces.toString(),
          style: TextPalette.tableDataTextStyle,
        )),
        DataCell(Text(
          row.grossWeight.toString(),
          style: TextPalette.tableDataTextStyle,
        )),
        DataCell(Text(
          row.customerName.toString(),
          style: TextPalette.tableDataTextStyle,
        )),
        DataCell(GestureDetector(
          onTap: () {
            bool itemExists = _assignVendorListController.repairItemList.value
                .any((item) => item.id == row.id);
            if (itemExists) {
              _assignVendorListController.addOrUpdateRepairItem(
                  dueDate: _assignVendorListController.dueDateController.text,
                  id: row.id!,
                  vendorDetails:
                      _assignVendorListController.selectedVendor.value?.value);
            } else {
              Get.dialog(
                barrierDismissible: false,
                AssignVendorPopup(
                  index: index,
                  id: row.id!,
                ),
              );
            }
          },
          child: Obx(
            () {
              bool isAssigned = _assignVendorListController.repairItemList.value
                  .any((item) => item.id == row.id);
              return Text(
                isAssigned ? 'Unassign' : 'Assign',
                style: TextStyle(
                  color: isAssigned ? Colors.red : Colors.green,
                ),
              );
            },
          ),
        )),
      ],
    );
  }

  @override
  int get rowCount => data.length;

  @override
  bool get isRowCountApproximate => false;

  @override
  int get selectedRowCount => _selectedCount;
}
