import 'package:ausales_application/controller/stone_master/stone_master_form_controller.dart';
import 'package:ausales_application/controller/stone_master/stone_master_list_controller.dart';
import 'package:ausales_application/core/constants/app_configuration.dart';
import 'package:ausales_application/core/keyboard_listeners/shortcut_keyboard_handler.dart';
import 'package:ausales_application/core/shared_preferences/home_shared_prefs.dart';
import 'package:ausales_application/core/theme/color_palette.dart';
import 'package:ausales_application/core/theme/text_palette.dart';
import 'package:ausales_application/model/stone_master/stone_master_model.dart';
import 'package:ausales_application/responsive.dart';
import 'package:ausales_application/service/stone_master/stone_master_service.dart';
import 'package:ausales_application/view/widgets/form_widgets/custom_switch.dart';
import 'package:ausales_application/view/widgets/layouts/end_menu_drawer_widget.dart';
import 'package:ausales_application/view/widgets/layouts/footer.dart';
import 'package:ausales_application/view/widgets/layouts/header.dart';
import 'package:ausales_application/view/widgets/screen_widgets/stone_master/stone_master_delete_popup.dart';
import 'package:ausales_application/view/widgets/screen_widgets/stone_master/stone_master_form.dart';
import 'package:ausales_application/view/widgets/screen_widgets/stone_master/stone_master_table_header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:toggle_switch/toggle_switch.dart';

class StoneMasterScreen extends StatefulWidget {
  @override
  State<StoneMasterScreen> createState() => _StoneMasterScreenState();
}

class _StoneMasterScreenState extends State<StoneMasterScreen> {
  final StoneMasterListController _stoneMasterListController = Get.put(StoneMasterListController());

  @override
  void initState() {
    super.initState();
    _stoneMasterListController.getStoneMasterList(context);
  }

  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return ShorcutKeyboardHandler(
      scaffoldKey: _stoneMasterListController.scaffoldKey,
      onRefresh: () {
        _stoneMasterListController.getStoneMasterList(context);
      },
      child: Scaffold(
          key: _stoneMasterListController.scaffoldKey,
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
                      "Stone",
                      style: TextPalette.screenTitle,
                    ),
                    SizedBox(width: 10.w,),
                    IconButton(
                      onPressed: () {
                        _stoneMasterListController.getStoneMasterList(context);
                      }, 
                      icon: Icon(Icons.refresh)
                    )
                  ],
                ),
              ),
              StoneMasterForm(),
              StoneMasterTableHeader(),
              Container(
                height: 550.h,
                decoration: BoxDecoration(
                    color: Colors.white,),
                margin: EdgeInsets.symmetric(horizontal: 15.w),
                child: Stack(
                  children: [
                    Obx(() => _stoneMasterListController.isTableLoading.value ? Padding(
                      padding: EdgeInsets.symmetric(horizontal: 7.w),
                      child: LinearProgressIndicator(),
                    ) :
                    ListView(
                      children: [
                        Obx(() => PaginatedDataTable(
                          showEmptyRows: false,
                              rowsPerPage: _stoneMasterListController.itemsPerPage.value,
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
                                  'Stone Name',
                                  style: TextPalette.tableHeaderTextStyle,
                                )),
                                DataColumn(
                                    label: Text(
                                  'Stone Code',
                                  style: TextPalette.tableHeaderTextStyle,
                                )),
                                DataColumn(
                                    label: Text(
                                  'Stone Rate',
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
                                  context, _stoneMasterListController.tableData.value),
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
                            SizedBox(width: 5.w,),
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
                fontSize: Responsive.isDesktop(context) || Responsive.isTablet(context) ? 12.sp : 10.sp),
          ),
          SizedBox(
            width: 15.w,
          ),
          Obx(() => DropdownButton<int>(
                value: _stoneMasterListController.itemsPerPage.value,
                onChanged: (value) {
                  _stoneMasterListController.itemsPerPage(value);
                  _stoneMasterListController.getStoneMasterList(context);
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
              'Page ${_stoneMasterListController.page.value} of ${_stoneMasterListController.totalpages.value}',
              style: TextStyle(
                  fontSize: Responsive.isDesktop(context) || Responsive.isTablet(context) ? 12.sp : 10.sp),
            ),
            IconButton(
                icon: Icon(Icons.arrow_back, size: Responsive.isDesktop(context) || Responsive.isTablet(context) ? 20.sp : 15.sp),
                onPressed: _stoneMasterListController.page.value > 1
                    ? () {
                        if (_stoneMasterListController.page.value > 1) {
                          _stoneMasterListController
                              .page(_stoneMasterListController.page.value - 1);
                          _stoneMasterListController.getStoneMasterList(context);
                        }
                      }
                    : null),
            IconButton(
                icon: Icon(Icons.arrow_forward, size: Responsive.isDesktop(context) || Responsive.isTablet(context) ? 20.sp : 15.sp),
                onPressed: _stoneMasterListController.page.value <
                        _stoneMasterListController.totalpages.value
                    ? () {
                        if (_stoneMasterListController.page.value <
                            _stoneMasterListController.totalpages.value) {
                          _stoneMasterListController
                              .page(_stoneMasterListController.page.value + 1);
                          _stoneMasterListController.getStoneMasterList(context);
                        }
                      }
                    : null),
          ],
        ));
  }
}

class _DataSource extends DataTableSource {
  BuildContext context;
  List<StoneMasterListData> data;
  _DataSource(this.context, this.data);

  int _selectedCount = 0;

  final StoneMasterFormController _stoneMasterFormController = Get.put(StoneMasterFormController());
  final StoneMasterListController _stoneMasterListController = Get.put(StoneMasterListController());

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
          row.stoneName.toString(),
          style: TextPalette.tableDataTextStyle,
        )),
        DataCell(Text(
          row.stoneCode.toString(),
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
         DataCell(
          Tooltip(
            message: "update stone reduce status",
            child: CustomSwitch(value: row.reduceWeight, onChanged:(index) async {
                int? menuId = await HomeSharedPrefs.getCurrentMenu();
                if (menuId != null) {
                  await StoneMasterService.updateStoneMasterReduceWeightStatus(
                      menuId: menuId.toString(),
                      stoneId: row.id.toString(),
                      context: context);
                }
                _stoneMasterListController.getStoneMasterList(context);
              }),
          )
        ),
         DataCell(
          Tooltip(
            message: "update stone status",
            child: CustomSwitch(value: row.isActive, onChanged:(index) async {
                int? menuId = await HomeSharedPrefs.getCurrentMenu();
                if (menuId != null) {
                  await StoneMasterService.updateStoneMasterStatus(
                      menuId: menuId.toString(),
                      stoneId: row.id.toString(),
                      context: context);
                }
                _stoneMasterListController.getStoneMasterList(context);
              }),
          )
        ),
        DataCell(Row(
          children: [
            Tooltip(
              message: "edit stone",
              child: IconButton(onPressed: () {
                    _stoneMasterFormController.stoneNameController.text = row.stoneName!;
                    _stoneMasterFormController.stoneCodeController.text = row.stoneCode!;
                    _stoneMasterFormController.stoneRateController.text = row.rate!.toStringAsFixed(2);
                    _stoneMasterFormController.stoneCertificateRateController.text = row.certificateAmount!.toStringAsFixed(2);
                    _stoneMasterFormController.selectedReduceWeight(row.reduceWeight ? _stoneMasterFormController.reduceWeightDropDown.value[0] : _stoneMasterFormController.reduceWeightDropDown.value[1]);
                    _stoneMasterFormController.currentStone(row);
                    _stoneMasterFormController.fromMode("update");
                  },
              icon: Icon(Icons.edit)),
            ),
            SizedBox(
              width: 10.w,
            ),
            Tooltip(
              message: "delete stone",
              child: GestureDetector(
                  onTap: () async {
                    await showDialog(
                        context: context,
                        barrierDismissible: false,
                        builder: (context) => StoneMasterDeletePopup(item: row));
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
