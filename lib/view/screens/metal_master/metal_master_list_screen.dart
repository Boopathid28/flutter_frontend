import 'package:ausales_application/controller/metal_master/metal_form_controller.dart';
import 'package:ausales_application/controller/metal_master/metal_list_controller.dart';
import 'package:ausales_application/core/constants/app_configuration.dart';
import 'package:ausales_application/core/keyboard_listeners/shortcut_keyboard_handler.dart';
import 'package:ausales_application/core/shared_preferences/home_shared_prefs.dart';
import 'package:ausales_application/core/theme/color_palette.dart';
import 'package:ausales_application/core/theme/shadow_palette.dart';
import 'package:ausales_application/core/theme/text_palette.dart';
import 'package:ausales_application/model/metal_master/metal_models.dart';
import 'package:ausales_application/responsive.dart';
import 'package:ausales_application/service/metal_master/metal_service.dart';
import 'package:ausales_application/view/widgets/form_widgets/custom_switch.dart';
import 'package:ausales_application/view/widgets/layouts/end_menu_drawer_widget.dart';
import 'package:ausales_application/view/widgets/layouts/footer.dart';
import 'package:ausales_application/view/widgets/layouts/header.dart';
import 'package:ausales_application/view/widgets/screen_widgets/metal_master/delete_popup.dart';
import 'package:ausales_application/view/widgets/screen_widgets/metal_master/metal_form.dart';
import 'package:ausales_application/view/widgets/screen_widgets/metal_master/metal_table_header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:toggle_switch/toggle_switch.dart';

class MetalListScreen extends StatefulWidget {
  @override
  State<MetalListScreen> createState() => _metalListScreenState();
}

class _metalListScreenState extends State<MetalListScreen> {
  final MetalListController _metalListController = Get.put(MetalListController());

  @override
  void initState() {
    super.initState();
    _metalListController.getMetalList(context);
  }

  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return ShorcutKeyboardHandler(
      scaffoldKey: _metalListController.scaffoldKey,
      onRefresh: () {
        _metalListController.getMetalList(context);
      },
      child: Scaffold(
         key: _metalListController.scaffoldKey,
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
                        "Metal",
                        style: TextPalette.screenTitle,
                      ),
                      SizedBox(width: 10.w,),
                      IconButton(
                        onPressed: () {
                          _metalListController.getMetalList(context);
                        },
                        icon: Icon(Icons.refresh)
                      )
                    ],
                  ),
                ),
              MetalForm(),
              MetalTableHeader(),
              Container(
                height: 550.h,
                decoration: BoxDecoration(
                    color: Colors.white,),
                margin: EdgeInsets.symmetric(horizontal: 15.w),
                child: Stack(
                  children: [
                    Obx(() => _metalListController.isTableLoading.value ? Padding(
                        padding: EdgeInsets.symmetric(horizontal: 7.w),
                        child: LinearProgressIndicator(),
                      ) :
                    ListView(
                      children: [
                        Obx(() => PaginatedDataTable(
                          showEmptyRows: false,
                              rowsPerPage: _metalListController.itemsPerPage.value,
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
                                  'Metalname',
                                  style: TextPalette.tableHeaderTextStyle,
                                )),
                                DataColumn(
                                    label: Text(
                                  'Metalcode',
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
                                  context, _metalListController.tableData.value),
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
                value: _metalListController.itemsPerPage.value,
                onChanged: (value) {
                  _metalListController.itemsPerPage(value);
                  _metalListController.getMetalList(context);
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
              'Page ${_metalListController.page.value} of ${_metalListController.totalpages.value}',
              style: TextStyle(
                  fontSize: Responsive.isDesktop(context) || Responsive.isTablet(context) ? 12.sp : 10.sp),
            ),
            IconButton(
                icon: Icon(Icons.arrow_back, size: Responsive.isDesktop(context) || Responsive.isTablet(context) ? 20.sp : 15.sp),
                onPressed: _metalListController.page.value > 1
                    ? () {
                        if (_metalListController.page.value > 1) {
                          _metalListController
                              .page(_metalListController.page.value - 1);
                          _metalListController.getMetalList(context);
                        }
                      }
                    : null),
            IconButton(
                icon: Icon(Icons.arrow_forward, size: Responsive.isDesktop(context) || Responsive.isTablet(context) ? 20.sp : 15.sp),
                onPressed: _metalListController.page.value <
                        _metalListController.totalpages.value
                    ? () {
                        if (_metalListController.page.value <
                            _metalListController.totalpages.value) {
                          _metalListController
                              .page(_metalListController.page.value + 1);
                          _metalListController.getMetalList(context);
                        }
                      }
                    : null),
          ],
        ));
  }
}

class _DataSource extends DataTableSource {
  BuildContext context;
  List<MetalListData> data;
  _DataSource(this.context, this.data);

  int _selectedCount = 0;

  final MetalFormController _metalFormController = Get.put(MetalFormController());
  final MetalListController _metalListController = Get.put(MetalListController());

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
          row.metalName.toString(),
          style: TextPalette.tableDataTextStyle,
        )),
        DataCell(Text(
          row.metalCode.toString(),
          style: TextPalette.tableDataTextStyle,
        )),
        DataCell(
          Tooltip(
            message: "update metal status",
            child: CustomSwitch(value: row.isActive, onChanged: (index) async {
                int? menuId = await HomeSharedPrefs.getCurrentMenu();
                if (menuId != null) {
                  await MetalService.updateMetalStatus(
                      menuId: menuId.toString(),
                      metalId: row.id.toString(),
                      context: context);
                }
                _metalListController.getMetalList(context);
              }),
          )
        ),
        DataCell(Row(
          children: [
            Tooltip(
              message: "update metal",
              child: IconButton(onPressed: () {
                 _metalFormController.metalNameController.text = row.metalName!;
                 _metalFormController.metalCodeController.text = row.metalCode!;
                  _metalFormController.currentMetal(row);
                    _metalFormController.fromMode("update");
                  },
              icon: Icon(Icons.edit)),
            ),
            SizedBox(
              width: 10.w,
            ),
            Tooltip(
              message: "delete metal",
              child: GestureDetector(
                  onTap: () async {
                    await Get.dialog(
                        barrierDismissible: false,
                        MetalDeletePopup(metal: row));
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
