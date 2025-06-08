import 'package:ausales_application/controller/diamond_master/diamond_master_form_controller.dart';
import 'package:ausales_application/controller/diamond_master/diamond_master_list_controller.dart';
import 'package:ausales_application/core/constants/app_configuration.dart';
import 'package:ausales_application/core/keyboard_listeners/shortcut_keyboard_handler.dart';
import 'package:ausales_application/core/shared_preferences/home_shared_prefs.dart';
import 'package:ausales_application/core/theme/color_palette.dart';
import 'package:ausales_application/core/theme/text_palette.dart';
import 'package:ausales_application/model/diamond_master/diamond_master_model.dart';
import 'package:ausales_application/responsive.dart';
import 'package:ausales_application/service/diamond_master/diamond_master_service.dart';
import 'package:ausales_application/view/widgets/form_widgets/custom_switch.dart';
import 'package:ausales_application/view/widgets/layouts/end_menu_drawer_widget.dart';
import 'package:ausales_application/view/widgets/layouts/footer.dart';
import 'package:ausales_application/view/widgets/layouts/header.dart';
import 'package:ausales_application/view/widgets/screen_widgets/diamond_master/diamond_master_delete_popup.dart';
import 'package:ausales_application/view/widgets/screen_widgets/diamond_master/diamond_master_form.dart';
import 'package:ausales_application/view/widgets/screen_widgets/diamond_master/diamond_master_table_header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:toggle_switch/toggle_switch.dart';

class DiamondMasterScreen extends StatefulWidget {
  @override
  State<DiamondMasterScreen> createState() => _DiamondMasterScreenState();
}

class _DiamondMasterScreenState extends State<DiamondMasterScreen> {
  final DiamondMasterListController _diamondMasterListController =
      Get.put(DiamondMasterListController());

  @override
  void initState() {
    super.initState();
    _diamondMasterListController.getDiamondMasterList(context);
  }

  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return ShorcutKeyboardHandler(
      scaffoldKey: _diamondMasterListController.scaffoldKey,
      onRefresh: () {
        _diamondMasterListController.getDiamondMasterList(context);
      },
      child: Scaffold(
        key: _diamondMasterListController.scaffoldKey,
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
                      "Diamond",
                      style: TextPalette.screenTitle,
                    ),
                    SizedBox(
                      width: 10.w,
                    ),
                    IconButton(
                        onPressed: () {
                          _diamondMasterListController
                              .getDiamondMasterList(context);
                        },
                        icon: Icon(Icons.refresh))
                  ],
                ),
              ),
              DiamondMasterForm(),
              DiamondMasterTableHeader(),
              Container(
                height: 550.h,
                decoration: BoxDecoration(
                  color: Colors.white,
                ),
                margin: EdgeInsets.symmetric(horizontal: 15.w),
                child: Stack(
                  children: [
                    Obx(() => _diamondMasterListController.isTableLoading.value
                        ? Padding(
                            padding: EdgeInsets.symmetric(horizontal: 7.w),
                            child: LinearProgressIndicator(),
                          )
                        : ListView(
                            children: [
                              Obx(() => PaginatedDataTable(
                                showEmptyRows: false,
                                    rowsPerPage: _diamondMasterListController
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
                                        'Diamond Name',
                                        style: TextPalette.tableHeaderTextStyle,
                                      )),
                                      DataColumn(
                                          label: Text(
                                        'Diamond Code',
                                        style: TextPalette.tableHeaderTextStyle,
                                      )),
                                      DataColumn(
                                          label: Text(
                                        'Diamond Rate',
                                        style: TextPalette.tableHeaderTextStyle,
                                      )),
                                      DataColumn(
                                          label: Text(
                                        'Certificate Amount',
                                        style: TextPalette.tableHeaderTextStyle,
                                      )),
                                      DataColumn(
                                          label: Text(
                                        'Reduce Weight',
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
                                    source: _DataSource(
                                        context,
                                        _diamondMasterListController
                                            .tableData.value),
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
                value: _diamondMasterListController.itemsPerPage.value,
                onChanged: (value) {
                  _diamondMasterListController.itemsPerPage(value);
                  _diamondMasterListController.getDiamondMasterList(context);
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
              'Page ${_diamondMasterListController.page.value} of ${_diamondMasterListController.totalpages.value}',
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
                onPressed: _diamondMasterListController.page.value > 1
                    ? () {
                        if (_diamondMasterListController.page.value > 1) {
                          _diamondMasterListController.page(
                              _diamondMasterListController.page.value - 1);
                          _diamondMasterListController
                              .getDiamondMasterList(context);
                        }
                      }
                    : null),
            IconButton(
                icon: Icon(Icons.arrow_forward,
                    size: Responsive.isDesktop(context) ||
                            Responsive.isTablet(context)
                        ? 20.sp
                        : 15.sp),
                onPressed: _diamondMasterListController.page.value <
                        _diamondMasterListController.totalpages.value
                    ? () {
                        if (_diamondMasterListController.page.value <
                            _diamondMasterListController.totalpages.value) {
                          _diamondMasterListController.page(
                              _diamondMasterListController.page.value + 1);
                          _diamondMasterListController
                              .getDiamondMasterList(context);
                        }
                      }
                    : null),
          ],
        ));
  }
}

class _DataSource extends DataTableSource {
  BuildContext context;
  List<DiamondMasterListData> data;
  _DataSource(this.context, this.data);

  int _selectedCount = 0;

  final DiamondMasterFormController _diamondMasterFormController =
      Get.put(DiamondMasterFormController());
  final DiamondMasterListController _diamondMasterListController =
      Get.put(DiamondMasterListController());

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
          row.diamondName.toString(),
          style: TextPalette.tableDataTextStyle,
        )),
        DataCell(Text(
          row.diamondCode.toString(),
          style: TextPalette.tableDataTextStyle,
        )),
        DataCell(Text(
          row.rate!.toStringAsFixed(2),
          style: TextPalette.tableDataTextStyle,
        )),
        DataCell(Text(
          row.certificateAmount!.toStringAsFixed(2),
          style: TextPalette.tableDataTextStyle,
        )),
        DataCell(Tooltip(
          message: "update diamond reduce status",
          child: CustomSwitch(
              value: row.reduceWeight,
              onChanged: (index) async {
                int? menuId = await HomeSharedPrefs.getCurrentMenu();
                if (menuId != null) {
                  await DiamondMasterService
                      .updateDiamondMasterReduceWeightStatus(
                          menuId: menuId.toString(),
                          diamondId: row.id.toString(),
                          context: context);
                }
                _diamondMasterListController.getDiamondMasterList(context);
              }),
        )),
        DataCell(Tooltip(
          message: "update diamond status",
          child: CustomSwitch(
              value: row.isActive,
              onChanged: (index) async {
                int? menuId = await HomeSharedPrefs.getCurrentMenu();
                if (menuId != null) {
                  await DiamondMasterService.updateDiamondMasterStatus(
                      menuId: menuId.toString(),
                      diamondId: row.id.toString(),
                      context: context);
                }
                _diamondMasterListController.getDiamondMasterList(context);
              }),
        )),
        DataCell(Row(
          children: [
            Tooltip(
              message: "edit diamond",
              child: IconButton(
                  onPressed: () {
                    _diamondMasterFormController.diamondNameController.text =
                        row.diamondName!;
                    _diamondMasterFormController.diamondCodeController.text =
                        row.diamondCode!;
                    _diamondMasterFormController.diamondRateController.text =
                        row.rate!.toStringAsFixed(2);
                    _diamondMasterFormController.diamondCertificateRateController.text =
                      row.certificateAmount!.toStringAsFixed(2);
                    _diamondMasterFormController.selectedReduceWeight(
                        row.reduceWeight
                            ? _diamondMasterFormController
                                .reduceWeightDropDown.value[0]
                            : _diamondMasterFormController
                                .reduceWeightDropDown.value[1]);
                    _diamondMasterFormController.currentDiamond(row);
                    _diamondMasterFormController.fromMode("update");
                  },
                  icon: Icon(Icons.edit)),
            ),
            SizedBox(
              width: 10.w,
            ),
            Tooltip(
              message: "delete diamond",
              child: GestureDetector(
                  onTap: () async {
                    await Get.dialog(
                        barrierDismissible: false,
                            DiamondMasterDeletePopup(item: row));
                  },
                  child: Icon(Icons.delete)),
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
