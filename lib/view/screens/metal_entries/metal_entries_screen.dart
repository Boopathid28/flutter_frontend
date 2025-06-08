import 'package:ausales_application/controller/metal_entries/metal_entries_list_controller.dart';
import 'package:ausales_application/controller/purity_master/purity_master_form_controller.dart';
import 'package:ausales_application/controller/purity_master/purity_master_list_controller.dart';
import 'package:ausales_application/core/constants/app_configuration.dart';
import 'package:ausales_application/core/keyboard_listeners/shortcut_keyboard_handler.dart';
import 'package:ausales_application/core/shared_preferences/home_shared_prefs.dart';
import 'package:ausales_application/core/theme/color_palette.dart';
import 'package:ausales_application/core/theme/text_palette.dart';
import 'package:ausales_application/model/drop_down_model.dart';
import 'package:ausales_application/model/metal_entries/metal_entries_model.dart';
import 'package:ausales_application/model/purity_master/purity_master_model.dart';
import 'package:ausales_application/responsive.dart';
import 'package:ausales_application/service/purity_master/purity_master_service.dart';
import 'package:ausales_application/utils/date_helper.dart';
import 'package:ausales_application/view/widgets/form_widgets/custom_switch.dart';
import 'package:ausales_application/view/widgets/layouts/end_menu_drawer_widget.dart';
import 'package:ausales_application/view/widgets/layouts/footer.dart';
import 'package:ausales_application/view/widgets/layouts/header.dart';
import 'package:ausales_application/view/widgets/screen_widgets/metal_entries/metal_entries_form.dart';
import 'package:ausales_application/view/widgets/screen_widgets/metal_entries/metal_entries_table_header.dart';
import 'package:ausales_application/view/widgets/screen_widgets/purity_master/purity_master_delete_popup.dart';
import 'package:ausales_application/view/widgets/screen_widgets/purity_master/purity_master_form.dart';
import 'package:ausales_application/view/widgets/screen_widgets/purity_master/purity_master_table_header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class MetalEntriesScreen extends StatefulWidget {
  @override
  State<MetalEntriesScreen> createState() => _MetalEntriesScreenState();
}

class _MetalEntriesScreenState extends State<MetalEntriesScreen> {
  final MetalEntriesListController _metalEntriesListController = Get.put(MetalEntriesListController());

  @override
  void initState() {
    super.initState();
    _metalEntriesListController.getMetalEntriesList(context);
  }

  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return ShorcutKeyboardHandler(
      scaffoldKey: _metalEntriesListController.scaffoldKey,
      onRefresh: () {
        _metalEntriesListController.getMetalEntriesList(context);
      },
      child: Scaffold(
          key: _metalEntriesListController.scaffoldKey,
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
                      "Metal Entries",
                      style: TextPalette.screenTitle,
                    ),
                    SizedBox(width: 10.w,),
                    IconButton(
                      onPressed: () {
                        _metalEntriesListController.getMetalEntriesList(context);
                      }, 
                      icon: Icon(Icons.refresh)
                    )
                  ],
                ),
              ),
              MetalEntriesForm(),
              MetalEntriesTableHeader(),
              Container(
                height: 550.h,
                decoration: BoxDecoration(
                    color: Colors.white,),
                margin: EdgeInsets.symmetric(horizontal: 15.w),
                child: Stack(
                  children: [
                    Obx(() => _metalEntriesListController.isTableLoading.value ? Padding(
                      padding: EdgeInsets.symmetric(horizontal: 7.w),
                      child: LinearProgressIndicator(),
                    ) :
                    ListView(
                      children: [
                        Obx(() => PaginatedDataTable(
                          showEmptyRows: false,
                              rowsPerPage: _metalEntriesListController.itemsPerPage.value,
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
                                  'Entry Id',
                                  style: TextPalette.tableHeaderTextStyle,
                                )),
                                DataColumn(
                                    label: Text(
                                  'Metal',
                                  style: TextPalette.tableHeaderTextStyle,
                                )),
                                DataColumn(
                                    label: Text(
                                  'Touch',
                                  style: TextPalette.tableHeaderTextStyle,
                                )),
                                DataColumn(
                                    label: Text(
                                  'Weight',
                                  style: TextPalette.tableHeaderTextStyle,
                                )),
                                DataColumn(
                                    label: Text(
                                  'Created At',
                                  style: TextPalette.tableHeaderTextStyle,
                                )),
                              ],
                              source: _DataSource(
                                  context, _metalEntriesListController.tableData.value),
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
                value: _metalEntriesListController.itemsPerPage.value,
                onChanged: (value) {
                  _metalEntriesListController.itemsPerPage(value);
                  _metalEntriesListController.getMetalEntriesList(context);
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
              'Page ${_metalEntriesListController.page.value} of ${_metalEntriesListController.totalpages.value}',
              style: TextStyle(
                  fontSize: Responsive.isDesktop(context) || Responsive.isTablet(context) ? 12.sp : 10.sp),
            ),
            IconButton(
                icon: Icon(Icons.arrow_back, size: Responsive.isDesktop(context) || Responsive.isTablet(context) ? 20.sp : 15.sp),
                onPressed: _metalEntriesListController.page.value > 1
                    ? () {
                        if (_metalEntriesListController.page.value > 1) {
                          _metalEntriesListController
                              .page(_metalEntriesListController.page.value - 1);
                          _metalEntriesListController.getMetalEntriesList(context);
                        }
                      }
                    : null),
            IconButton(
                icon: Icon(Icons.arrow_forward, size: Responsive.isDesktop(context) || Responsive.isTablet(context) ? 20.sp : 15.sp),
                onPressed: _metalEntriesListController.page.value <
                        _metalEntriesListController.totalpages.value
                    ? () {
                        if (_metalEntriesListController.page.value <
                            _metalEntriesListController.totalpages.value) {
                          _metalEntriesListController
                              .page(_metalEntriesListController.page.value + 1);
                          _metalEntriesListController.getMetalEntriesList(context);
                        }
                      }
                    : null),
          ],
        ));
  }
}

class _DataSource extends DataTableSource {
  BuildContext context;
  List<MetalEntriesListData> data;
  _DataSource(this.context, this.data);

  int _selectedCount = 0;

  final PurityMasterListController _metalEntriesListController = Get.put(PurityMasterListController());

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
          row.entryId.toString(),
          style: TextPalette.tableDataTextStyle,
        )),
        DataCell(Text(
          row.metalDetailsName.toString(),
          style: TextPalette.tableDataTextStyle,
        )),
        DataCell(Text(
          row.touch.toString(),
          style: TextPalette.tableDataTextStyle,
        )),
        DataCell(Text(
          row.weight.toString(),
          style: TextPalette.tableDataTextStyle,
        )),
        DataCell(Text(
          DateHelper.convertDate(row.createdAt.toString()),
          style: TextPalette.tableDataTextStyle,
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
