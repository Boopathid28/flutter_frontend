import 'package:ausales_application/controller/floor/floor_form_controller.dart';
import 'package:ausales_application/controller/floor/floor_list_controller.dart';
import 'package:ausales_application/core/constants/app_configuration.dart';
import 'package:ausales_application/core/keyboard_listeners/shortcut_keyboard_handler.dart';
import 'package:ausales_application/core/shared_preferences/home_shared_prefs.dart';
import 'package:ausales_application/core/theme/color_palette.dart';
import 'package:ausales_application/core/theme/text_palette.dart';
import 'package:ausales_application/model/drop_down_model.dart';
import 'package:ausales_application/model/floor/floor_models.dart';
import 'package:ausales_application/responsive.dart';
import 'package:ausales_application/service/floor/floor_service.dart';
import 'package:ausales_application/view/widgets/form_widgets/custom_switch.dart';
import 'package:ausales_application/view/widgets/layouts/end_menu_drawer_widget.dart';
import 'package:ausales_application/view/widgets/layouts/footer.dart';
import 'package:ausales_application/view/widgets/layouts/header.dart';
import 'package:ausales_application/view/widgets/screen_widgets/floor/delete_popup.dart';
import 'package:ausales_application/view/widgets/screen_widgets/floor/floor_form.dart';
import 'package:ausales_application/view/widgets/screen_widgets/floor/floor_table_header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class FloorListScreen extends StatefulWidget {
  @override
  State<FloorListScreen> createState() => _FloorListScreenState();
}

class _FloorListScreenState extends State<FloorListScreen> {
  final FloorListController _floorListController =
      Get.put(FloorListController());

  @override
  void initState() {
    super.initState();
    _floorListController.getfloorList(context);
  }

  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return ShorcutKeyboardHandler(
      scaffoldKey: _floorListController.scaffoldKey,
      onRefresh: () {
        _floorListController.getfloorList(context);
      },
      child: Scaffold(
        key: _floorListController.scaffoldKey,
        backgroundColor: ColorPalete.appBgColor,
        appBar: PreferredSize(
          child: HeaderWidget(),
          preferredSize: Size.fromHeight(100.0),
        ),
        bottomNavigationBar: Footer(),
        endDrawer: EndMenuDrawerWidget(),
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
                      "Floor",
                      style: TextPalette.screenTitle,
                    ),
                    SizedBox(
                      width: 10.w,
                    ),
                    IconButton(
                        onPressed: () {
                          _floorListController.getfloorList(context);
                        },
                        icon: Icon(Icons.refresh))
                  ],
                ),
              ),
              FloorForm(),
              FloorTableHeader(),
              Container(
                height: 550.h,
                decoration: BoxDecoration(
                  color: Colors.white,
                ),
                margin: EdgeInsets.symmetric(horizontal: 15.w),
                child: Stack(
                  children: [
                    Obx(() => _floorListController.isTableLoading.value
                        ? Padding(
                            padding: EdgeInsets.symmetric(horizontal: 7.w),
                            child: LinearProgressIndicator(),
                          )
                        : ListView(
                            children: [
                              Obx(() => PaginatedDataTable(
                                    showEmptyRows: false,
                                    rowsPerPage:
                                        _floorListController.itemsPerPage.value,
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
                                        'Floor Name',
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
                                        _floorListController.tableData.value),
                                  )),
                            ],
                          )),
                    Positioned(
                      bottom: 0,
                      left: 0,
                      child: Container(
                        height: 60.h,
                        width: size.width - 38,
                        padding: EdgeInsets.all(16.0),
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
                value: _floorListController.itemsPerPage.value,
                onChanged: (value) {
                  _floorListController.itemsPerPage(value);
                  _floorListController.getfloorList(context);
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
              'Page ${_floorListController.page.value} of ${_floorListController.totalpages.value}',
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
                onPressed: _floorListController.page.value > 1
                    ? () {
                        if (_floorListController.page.value > 1) {
                          _floorListController
                              .page(_floorListController.page.value - 1);
                          _floorListController.getfloorList(context);
                        }
                      }
                    : null),
            IconButton(
                icon: Icon(Icons.arrow_forward,
                    size: Responsive.isDesktop(context) ||
                            Responsive.isTablet(context)
                        ? 20.sp
                        : 15.sp),
                onPressed: _floorListController.page.value <
                        _floorListController.totalpages.value
                    ? () {
                        if (_floorListController.page.value <
                            _floorListController.totalpages.value) {
                          _floorListController
                              .page(_floorListController.page.value + 1);
                          _floorListController.getfloorList(context);
                        }
                      }
                    : null),
          ],
        ));
  }
}

class _DataSource extends DataTableSource {
  BuildContext context;
  List<FloorListData> data;
  _DataSource(this.context, this.data);

  int _selectedCount = 0;

  final FloorFormController _floorFormController =
      Get.put(FloorFormController());
  final FloorListController _floorListController =
      Get.put(FloorListController());

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
          row.floorName.toString(),
          style: TextPalette.tableDataTextStyle,
        )),
        DataCell(
          Tooltip(
            message: "Update Floor Status",
            child: CustomSwitch(
            value: row.isActive,
            onChanged: (index) async {
              int? menuId = await HomeSharedPrefs.getCurrentMenu();
              if (menuId != null) {
                await FloorService.updateFloorStatus(
                    menuId: menuId.toString(),
                    floorId: row.id.toString(),
                    context: context);
              }
              _floorListController.getfloorList(context);
            }),
          )
        ),
        DataCell(Row(
          children: [
            Tooltip(
              message: "Edit Floor",
              child: IconButton(
                  onPressed: () {
                    _floorFormController.floornameController.text =
                        row.floorName!;
                    _floorFormController.selectedBranch(DropdownModel(
                        value: row.branch.toString(),
                        label: row.branchName.toString()));
                    _floorFormController.currentFloor(row);
                    _floorFormController.fromMode("update");
                  },
                  icon: Icon(Icons.edit)),
            ),
            SizedBox(
              width: 10.w,
            ),
            Tooltip(
              message: "Delete Floor",
              child: GestureDetector(
                onTap: () async {
                  await Get.dialog(
                      barrierDismissible: false,
                      FloorDeletepopup(floor: row));
                },
                child: Icon(Icons.delete))
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
