import 'package:ausales_application/controller/purity_master/purity_master_form_controller.dart';
import 'package:ausales_application/controller/purity_master/purity_master_list_controller.dart';
import 'package:ausales_application/core/constants/app_configuration.dart';
import 'package:ausales_application/core/keyboard_listeners/shortcut_keyboard_handler.dart';
import 'package:ausales_application/core/shared_preferences/home_shared_prefs.dart';
import 'package:ausales_application/core/theme/color_palette.dart';
import 'package:ausales_application/core/theme/shadow_palette.dart';
import 'package:ausales_application/core/theme/text_palette.dart';
import 'package:ausales_application/model/drop_down_model.dart';
import 'package:ausales_application/model/purity_master/purity_master_model.dart';
import 'package:ausales_application/responsive.dart';
import 'package:ausales_application/service/purity_master/purity_master_service.dart';
import 'package:ausales_application/view/widgets/form_widgets/custom_switch.dart';
import 'package:ausales_application/view/widgets/layouts/end_menu_drawer_widget.dart';
import 'package:ausales_application/view/widgets/layouts/footer.dart';
import 'package:ausales_application/view/widgets/layouts/header.dart';
import 'package:ausales_application/view/widgets/screen_widgets/purity_master/purity_master_delete_popup.dart';
import 'package:ausales_application/view/widgets/screen_widgets/purity_master/purity_master_form.dart';
import 'package:ausales_application/view/widgets/screen_widgets/purity_master/purity_master_table_header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:toggle_switch/toggle_switch.dart';

class PurityMasterScreen extends StatefulWidget {
  @override
  State<PurityMasterScreen> createState() => _PurityMasterScreenState();
}

class _PurityMasterScreenState extends State<PurityMasterScreen> {
  final PurityMasterListController _purityMasterListController = Get.put(PurityMasterListController());

  @override
  void initState() {
    super.initState();
    _purityMasterListController.getPurityMasterList(context);
  }

  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return ShorcutKeyboardHandler(
      scaffoldKey: _purityMasterListController.scaffoldKey,
      onRefresh: () {
        _purityMasterListController.getPurityMasterList(context);
      },
      child: Scaffold(
          key: _purityMasterListController.scaffoldKey,
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
                      "Purity",
                      style: TextPalette.screenTitle,
                    ),
                    SizedBox(width: 10.w,),
                    IconButton(
                      onPressed: () {
                        _purityMasterListController.getPurityMasterList(context);
                      }, 
                      icon: Icon(Icons.refresh)
                    )
                  ],
                ),
              ),
              PurityMasterForm(),
              PurityMasterTableHeader(),
              Container(
                height: 550.h,
                decoration: BoxDecoration(
                    color: Colors.white,),
                margin: EdgeInsets.symmetric(horizontal: 15.w),
                child: Stack(
                  children: [
                    Obx(() => _purityMasterListController.isTableLoading.value ? Padding(
                      padding: EdgeInsets.symmetric(horizontal: 7.w),
                      child: LinearProgressIndicator(),
                    ) :
                    ListView(
                      children: [
                        Obx(() => PaginatedDataTable(
                          showEmptyRows: false,
                              rowsPerPage: _purityMasterListController.itemsPerPage.value,
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
                                  'Purity Name',
                                  style: TextPalette.tableHeaderTextStyle,
                                )),
                                DataColumn(
                                    label: Text(
                                  'Metal',
                                  style: TextPalette.tableHeaderTextStyle,
                                )),
                                DataColumn(
                                    label: Text(
                                  'Purity Code',
                                  style: TextPalette.tableHeaderTextStyle,
                                )),
                                DataColumn(
                                    label: Text(
                                  'Purity Percent',
                                  style: TextPalette.tableHeaderTextStyle,
                                )),
                                DataColumn(
                                    label: Text(
                                  'Active',
                                  style: TextPalette.tableHeaderTextStyle,
                                )),
                                DataColumn(
                                    label: Text(
                                  'Visibility',
                                  style: TextPalette.tableHeaderTextStyle,
                                )),
                                
                                DataColumn(
                                    label: Text(
                                  'Action',
                                  style: TextPalette.tableHeaderTextStyle,
                                )),
                              ],
                              source: _DataSource(
                                  context, _purityMasterListController.tableData.value),
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
                value: _purityMasterListController.itemsPerPage.value,
                onChanged: (value) {
                  _purityMasterListController.itemsPerPage(value);
                  _purityMasterListController.getPurityMasterList(context);
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
              'Page ${_purityMasterListController.page.value} of ${_purityMasterListController.totalpages.value}',
              style: TextStyle(
                  fontSize: Responsive.isDesktop(context) || Responsive.isTablet(context) ? 12.sp : 10.sp),
            ),
            IconButton(
                icon: Icon(Icons.arrow_back, size: Responsive.isDesktop(context) || Responsive.isTablet(context) ? 20.sp : 15.sp),
                onPressed: _purityMasterListController.page.value > 1
                    ? () {
                        if (_purityMasterListController.page.value > 1) {
                          _purityMasterListController
                              .page(_purityMasterListController.page.value - 1);
                          _purityMasterListController.getPurityMasterList(context);
                        }
                      }
                    : null),
            IconButton(
                icon: Icon(Icons.arrow_forward, size: Responsive.isDesktop(context) || Responsive.isTablet(context) ? 20.sp : 15.sp),
                onPressed: _purityMasterListController.page.value <
                        _purityMasterListController.totalpages.value
                    ? () {
                        if (_purityMasterListController.page.value <
                            _purityMasterListController.totalpages.value) {
                          _purityMasterListController
                              .page(_purityMasterListController.page.value + 1);
                          _purityMasterListController.getPurityMasterList(context);
                        }
                      }
                    : null),
          ],
        ));
  }
}

class _DataSource extends DataTableSource {
  BuildContext context;
  List<PurityMasterListData> data;
  _DataSource(this.context, this.data);

  int _selectedCount = 0;

  final PurityMasterFormController _purityMasterFormController = Get.put(PurityMasterFormController());
  final PurityMasterListController _purityMasterListController = Get.put(PurityMasterListController());

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
          row.purityName.toString(),
          style: TextPalette.tableDataTextStyle,
        )),
        DataCell(Text(
          row.metalName.toString(),
          style: TextPalette.tableDataTextStyle,
        )),
        DataCell(Text(
          row.purityCode.toString(),
          style: TextPalette.tableDataTextStyle,
        )),
        DataCell(Text(
          row.purityPercent.toString(),
          style: TextPalette.tableDataTextStyle,
        )),
        DataCell(
          Tooltip(
            message: "update purity status",
            child: CustomSwitch(value: row.isActive, onChanged: (index) async {
             int? menuId = await HomeSharedPrefs.getCurrentMenu();
              if (menuId != null) {
                  await PurityMasterService.updatePurityMasterStatus(
                      menuId: menuId.toString(),
                      purityId: row.id.toString(),
                      context: context);
                }
                _purityMasterListController.getPurityMasterList(context);
            }),
          )
        ),
         DataCell(
          Tooltip(
            message: "update purity visibility status",
            child: CustomSwitch(value: row.isVisible, onChanged: (index) async {
                int? menuId = await HomeSharedPrefs.getCurrentMenu();
                if (menuId != null) {
                  await PurityMasterService.updatePurityMasterVisibilityStatus(
                      menuId: menuId.toString(),
                      purityId: row.id.toString(),
                      context: context);
                }
                _purityMasterListController.getPurityMasterList(context);
              }),
          )
        ),
        DataCell(Row(
          children: [
            Tooltip(
              message: "edit purity",
              child: IconButton(onPressed: () {
                    _purityMasterFormController.purityNameController.text = row.purityName!;
                    _purityMasterFormController.purityCodeController.text = row.purityCode!;
                    _purityMasterFormController.purityPercentController.text = row.purityPercent.toString();
                    _purityMasterFormController.selectedMetal(
                        DropdownModel(value: row.metal.toString(), label: row.metalName!));
                    _purityMasterFormController.currentPurity(row);
                    _purityMasterFormController.fromMode("update");
                  },
              icon: Icon(Icons.edit)),
            ),
            SizedBox(
              width: 10.w,
            ),
            Tooltip(
              message: "delete purity",
              child: GestureDetector(
                  onTap: () async {
                    await showDialog(
                        context: context,
                        barrierDismissible: false,
                        builder: (context) => PurityMasterDeletePopup(item: row));
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
