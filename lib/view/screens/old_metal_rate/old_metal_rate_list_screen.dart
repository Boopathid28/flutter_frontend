import 'package:ausales_application/controller/old_metal_rate/old_metal_rate_form_controller.dart';
import 'package:ausales_application/controller/old_metal_rate/old_metal_rate_list_controller.dart';
import 'package:ausales_application/core/constants/app_configuration.dart';
import 'package:ausales_application/core/keyboard_listeners/shortcut_keyboard_handler.dart';
import 'package:ausales_application/core/theme/color_palette.dart';
import 'package:ausales_application/core/theme/text_palette.dart';
import 'package:ausales_application/model/drop_down_model.dart';
import 'package:ausales_application/model/old_metal_rate/old_metal_rate_models.dart';
import 'package:ausales_application/responsive.dart';
import 'package:ausales_application/view/widgets/layouts/end_menu_drawer_widget.dart';
import 'package:ausales_application/view/widgets/layouts/footer.dart';
import 'package:ausales_application/view/widgets/layouts/header.dart';
import 'package:ausales_application/view/widgets/screen_widgets/old_metal_rate/old_metal_rate_delete_popup.dart';
import 'package:ausales_application/view/widgets/screen_widgets/old_metal_rate/old_metal_rate_form.dart';
import 'package:ausales_application/view/widgets/screen_widgets/old_metal_rate/old_metal_rate_table_header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class OldMetalRateListScreen extends StatefulWidget {
  const OldMetalRateListScreen({super.key});

  @override
  State<OldMetalRateListScreen> createState() => _OldMetalRateListScreenState();
}

class _OldMetalRateListScreenState extends State<OldMetalRateListScreen> {
  final OldMetalRateListController _oldMetalRateListController =
      Get.put(OldMetalRateListController());

  @override
  void initState() {
    super.initState();
    _oldMetalRateListController.getOldMetalRateList(context);
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return ShorcutKeyboardHandler(
      scaffoldKey: _oldMetalRateListController.scaffoldKey,
      onRefresh: () {
        _oldMetalRateListController.getOldMetalRateList(context);
      },
      child: Scaffold(
        key: _oldMetalRateListController.scaffoldKey,
        backgroundColor: ColorPalete.appBgColor,
        appBar: const PreferredSize(
          preferredSize: Size.fromHeight(100.0),
          child: HeaderWidget(),
        ),
        bottomNavigationBar: const Footer(),
        endDrawer: const EndMenuDrawerWidget(),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 15.h,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 15.w),
                child: Row(
                  children: [
                    Text(
                      "Old Metal Rate",
                      style: TextPalette.screenTitle,
                    ),
                    SizedBox(
                      width: 10.w,
                    ),
                    IconButton(
                        onPressed: () {
                          _oldMetalRateListController
                              .getOldMetalRateList(context);
                        },
                        icon: const Icon(Icons.refresh))
                  ],
                ),
              ),
              const OldMetalRateForm(),
              const OldMetalRateTableHeader(),
              Container(
                height: 550.h,
                decoration: const BoxDecoration(
                  color: Colors.white,
                ),
                margin: EdgeInsets.symmetric(horizontal: 15.w),
                child: Stack(
                  children: [
                    Obx(() => _oldMetalRateListController.isTableLoading.value
                        ? Padding(
                            padding: EdgeInsets.symmetric(horizontal: 7.w),
                            child: const LinearProgressIndicator(),
                          )
                        : ListView(
                            children: [
                              Obx(() => PaginatedDataTable(
                                showEmptyRows: false,
                                    rowsPerPage: _oldMetalRateListController
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
                                        'Metal Name',
                                        style: TextPalette.tableHeaderTextStyle,
                                      )),
                                      DataColumn(
                                          label: Text(
                                        'Old Rate',
                                        style: TextPalette.tableHeaderTextStyle,
                                      )),
                                      DataColumn(
                                          label: Text(
                                        'Action',
                                        style: TextPalette.tableHeaderTextStyle,
                                      )),
                                    ],
                                    source: _DataSource(
                                        context,
                                        _oldMetalRateListController
                                            .tableData),
                                  )),
                            ],
                          )),
                    Positioned(
                      bottom: 0,
                      left: 0,
                      child: Container(
                        height: 60.h,
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
      child: Row(
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
                value: _oldMetalRateListController.itemsPerPage.value,
                onChanged: (value) {
                  _oldMetalRateListController.itemsPerPage(value);
                  _oldMetalRateListController.getOldMetalRateList(context);
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
    return Obx(() => Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'Page ${_oldMetalRateListController.page.value} of ${_oldMetalRateListController.totalpages.value}',
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
                onPressed: _oldMetalRateListController.page.value > 1
                    ? () {
                        if (_oldMetalRateListController.page.value > 1) {
                          _oldMetalRateListController
                              .page(_oldMetalRateListController.page.value - 1);
                          _oldMetalRateListController
                              .getOldMetalRateList(context);
                        }
                      }
                    : null),
            IconButton(
                icon: Icon(Icons.arrow_forward,
                    size: Responsive.isDesktop(context) ||
                            Responsive.isTablet(context)
                        ? 20.sp
                        : 15.sp),
                onPressed: _oldMetalRateListController.page.value <
                        _oldMetalRateListController.totalpages.value
                    ? () {
                        if (_oldMetalRateListController.page.value <
                            _oldMetalRateListController.totalpages.value) {
                          _oldMetalRateListController
                              .page(_oldMetalRateListController.page.value + 1);
                          _oldMetalRateListController
                              .getOldMetalRateList(context);
                        }
                      }
                    : null),
          ],
        ));
  }
}

class _DataSource extends DataTableSource {
  BuildContext context;
  List<OldMetalRateListData> data;
  _DataSource(this.context, this.data);

  int _selectedCount = 0;

  final OldMetalRateFormController _oldMetalRateFormController =
      Get.put(OldMetalRateFormController());
  final OldMetalRateListController _oldMetalRateListController =
      Get.put(OldMetalRateListController());

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
          row.metalDetailsName.toString(),
          style: TextPalette.tableDataTextStyle,
        )),
        DataCell(Text(
          row.oldRate.toString(),
          style: TextPalette.tableDataTextStyle,
        )),
        DataCell(Row(
          children: [
          Tooltip(
            message: "Edit Old Metal rate",
            child: IconButton(onPressed:  () {
                  _oldMetalRateFormController.oldMetalRateController.text =
                      row.oldRate.toString();
                  _oldMetalRateFormController.selectedMetal(DropdownModel(
                      value: row.metalDetails.toString(),
                      label: row.metalDetailsName.toString()));
                  _oldMetalRateFormController.currentMetal(row);
                  _oldMetalRateFormController.fromMode("update");
                },
          icon: Icon(Icons.edit)),
          ),
            SizedBox(
              width: 10.w,
            ),
            Tooltip(
              message: "Delete Old Metal Rate",
              child: GestureDetector(
                onTap: () async {
                  await Get.dialog(
                      barrierDismissible: false,
                      
                          OldMetalRateDeletePopup(oldMetalRate: row));
                },
                child: const Icon(Icons.delete)),
            ),
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
