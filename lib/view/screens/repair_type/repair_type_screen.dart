import 'package:ausales_application/controller/repair_type/repair_type_controller.dart';
import 'package:ausales_application/core/constants/app_configuration.dart';
import 'package:ausales_application/core/shared_preferences/home_shared_prefs.dart';
import 'package:ausales_application/core/theme/color_palette.dart';
import 'package:ausales_application/core/theme/text_palette.dart';
import 'package:ausales_application/model/repair_type/repair_type_models.dart';
import 'package:ausales_application/responsive.dart';
import 'package:ausales_application/view/widgets/form_widgets/custom_switch.dart';
import 'package:ausales_application/view/widgets/form_widgets/primary_button.dart';
import 'package:ausales_application/view/widgets/layouts/header.dart';
import 'package:ausales_application/view/widgets/screen_widgets/repair_type/repair_type_create_form.dart';
import 'package:ausales_application/view/widgets/screen_widgets/repair_type/repair_type_delete_popup.dart';
import 'package:ausales_application/view/widgets/screen_widgets/repair_type/repair_type_table_header.dart';
import 'package:ausales_application/view/widgets/screen_widgets/repair_type/repair_type_update_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class RepairTypeScreen extends StatefulWidget {
  const RepairTypeScreen({super.key});

  @override
  State<RepairTypeScreen> createState() => _RepairTypeScreenState();
}

class _RepairTypeScreenState extends State<RepairTypeScreen> {
  final RepairTypeController _repairTypeController =
      Get.put(RepairTypeController());

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.sizeOf(context);

    return Scaffold(
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(100.0),
        child: HeaderWidget(),
      ),
      body: SingleChildScrollView(
        child: Form(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 15.h,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 15.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          "Repair Type",
                          style: Responsive.isMobile(context)
                              ? TextPalette.tableDataTextStyle
                              : TextPalette.screenTitle,
                        ),
                        SizedBox(
                          width: 10.w,
                        ),
                        IconButton(
                            onPressed: () {
                              _repairTypeController.getAllRepairTypes();
                            },
                            icon: const Icon(Icons.refresh)),
                        const Spacer(),
                        SizedBox(
                          width: Responsive.isDesktop(context) ? 145.w : 70.w,
                          height: 46.h,
                          child: PrimaryButton(
                            isLoading: false,
                            text: 'Add +',
                            onPressed: () => Get.dialog(
                                  const RepairTypeCreateForm(),
                            ),
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 16.h,
                    ),
                    const RepairTypeTableHeader(),
                    SizedBox(
                      height: 16.h,
                    ),
                  ],
                ),
              ),
              Container(
                height: 550.h,
                decoration: const BoxDecoration(
                  color: Colors.white,
                ),
                margin: EdgeInsets.symmetric(horizontal: 15.w),
                child: Stack(
                  children: [
                    Obx(() => _repairTypeController.isTableLoading.value
                        ? Padding(
                            padding: EdgeInsets.symmetric(horizontal: 7.w),
                            child: const LinearProgressIndicator(),
                          )
                        : ListView(
                            children: [
                              Obx(() => PaginatedDataTable(
                                    showEmptyRows: false,
                                    rowsPerPage: _repairTypeController
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
                                        'Repair type',
                                        style: TextPalette.tableHeaderTextStyle,
                                      )),
                                      DataColumn(
                                          label: Text(
                                        'Created Date',
                                        style: TextPalette.tableHeaderTextStyle,
                                      )),
                                      DataColumn(
                                          label: Text(
                                        'Created By',
                                        style: TextPalette.tableHeaderTextStyle,
                                      )),
                                      DataColumn(
                                          label: Text(
                                        'Active',
                                        style: TextPalette.tableHeaderTextStyle,
                                      )),
                                      DataColumn(
                                          label: Text(
                                        'Action',
                                        style: TextPalette.tableHeaderTextStyle,
                                      )),
                                    ],
                                    source: _DataSource(context,
                                        _repairTypeController.tableData.value),
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
              SizedBox(
                height: defaultBottombarHeight,
              )
            ],
          ),
        ),
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
                      value: _repairTypeController.itemsPerPage.value,
                      onChanged: (value) {
                        _repairTypeController.itemsPerPage(value);
                        _repairTypeController.getAllRepairTypes();
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
                      value: _repairTypeController.itemsPerPage.value,
                      onChanged: (value) {
                        _repairTypeController.itemsPerPage(value);
                        _repairTypeController.getAllRepairTypes();
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
                'Page ${_repairTypeController.page.value} of ${_repairTypeController.totalpages.value}',
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
                      onPressed: _repairTypeController.page.value > 1
                          ? () {
                              if (_repairTypeController.page.value > 1) {
                                _repairTypeController
                                    .page(_repairTypeController.page.value - 1);
                                _repairTypeController.getAllRepairTypes();
                              }
                            }
                          : null),
                  IconButton(
                      icon: Icon(Icons.arrow_forward,
                          size: Responsive.isDesktop(context) ||
                                  Responsive.isTablet(context)
                              ? 20.sp
                              : 15.sp),
                      onPressed: _repairTypeController.page.value <
                              _repairTypeController.totalpages.value
                          ? () {
                              if (_repairTypeController.page.value <
                                  _repairTypeController.totalpages.value) {
                                _repairTypeController
                                    .page(_repairTypeController.page.value + 1);
                                _repairTypeController.getAllRepairTypes();
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
                'Page ${_repairTypeController.page.value} of ${_repairTypeController.totalpages.value}',
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
                  onPressed: _repairTypeController.page.value > 1
                      ? () {
                          if (_repairTypeController.page.value > 1) {
                            _repairTypeController
                                .page(_repairTypeController.page.value - 1);
                            _repairTypeController.getAllRepairTypes();
                          }
                        }
                      : null),
              IconButton(
                  icon: Icon(Icons.arrow_forward,
                      size: Responsive.isDesktop(context) ||
                              Responsive.isTablet(context)
                          ? 20.sp
                          : 15.sp),
                  onPressed: _repairTypeController.page.value <
                          _repairTypeController.totalpages.value
                      ? () {
                          if (_repairTypeController.page.value <
                              _repairTypeController.totalpages.value) {
                            _repairTypeController
                                .page(_repairTypeController.page.value + 1);
                            _repairTypeController.getAllRepairTypes();
                          }
                        }
                      : null),
            ],
          ));
  }
}

class _DataSource extends DataTableSource {
  BuildContext context;
  List<GetAllRepairTypes> data;
  _DataSource(this.context, this.data);

  int _selectedCount = 0;

  final RepairTypeController _repairTypeController =
      Get.put(RepairTypeController());
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
          row.repairType.toString(),
          style: TextPalette.tableDataTextStyle,
        )),
        DataCell(Text(
          row.createdAt!.split('T')[0].toString(),
          style: TextPalette.tableDataTextStyle,
        )),
        DataCell(Text(
          row.createdBy.toString(),
          style: TextPalette.tableDataTextStyle,
        )),
        DataCell(CustomSwitch(
            value: row.isActive!,
            onChanged: (index) async {
              int? menuId = await HomeSharedPrefs.getCurrentMenu();
              if (menuId != null) {
                _repairTypeController.repairController.text =
                    row.repairType ?? '';
                await _repairTypeController.changeRepairTypeStatus(
                    context, row.id.toString());
              }
            })),
        DataCell(Row(
          children: [
            IconButton(
                onPressed: () {
                  _repairTypeController.fromMode('update');

                  _repairTypeController.repairController.text =
                      row.repairType ?? '';
                  Get.dialog(
                    RepairTypeUpdateForm(id: row.id!),
                  );
                },
                icon: const Icon(Icons.edit)),
            SizedBox(
              width: 10.w,
            ),
            GestureDetector(
                onTap: () async {
                  await Get.dialog(
                      barrierDismissible: false,
                      RepairTypeDeletePopup(item: row));
                },
                child: const Icon(Icons.delete)),
          ],
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
