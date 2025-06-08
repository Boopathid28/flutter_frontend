import 'package:ausales_application/controller/branchtransfer/branch_transfer_list_controller.dart';
import 'package:ausales_application/controller/counter/counter_form_controller.dart';
import 'package:ausales_application/controller/counter/counter_list_controller.dart';
import 'package:ausales_application/core/constants/app_configuration.dart';
import 'package:ausales_application/core/keyboard_listeners/shortcut_keyboard_handler.dart';
import 'package:ausales_application/core/shared_preferences/home_shared_prefs.dart';
import 'package:ausales_application/core/theme/color_palette.dart';
import 'package:ausales_application/core/theme/text_palette.dart';
import 'package:ausales_application/model/branch_transfer/branch_transfer_models.dart';
import 'package:ausales_application/model/counter/counter_models.dart';
import 'package:ausales_application/responsive.dart';
import 'package:ausales_application/service/counter/counter_service.dart';
import 'package:ausales_application/view/widgets/form_widgets/custom_switch.dart';
import 'package:ausales_application/view/widgets/form_widgets/primary_button.dart';
import 'package:ausales_application/view/widgets/layouts/end_menu_drawer_widget.dart';
import 'package:ausales_application/view/widgets/layouts/footer.dart';
import 'package:ausales_application/view/widgets/layouts/header.dart';
import 'package:ausales_application/view/widgets/screen_widgets/branchtransfer/branch_transfer_form.dart';
import 'package:ausales_application/view/widgets/screen_widgets/counter/counter_form.dart';
import 'package:ausales_application/view/widgets/screen_widgets/counter/counter_table_header.dart';
import 'package:ausales_application/view/widgets/screen_widgets/counter/delete_popup.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:toggle_switch/toggle_switch.dart';

class BranchTransferListScreen extends StatefulWidget {
  @override
  State<BranchTransferListScreen> createState() =>
      _BranchTransferListScreenState();
}

class _BranchTransferListScreenState extends State<BranchTransferListScreen> {
  final BranchTransferListController _branchTransferListController =
      Get.put(BranchTransferListController());

  @override
  void initState() {
    super.initState();
    _branchTransferListController.getbranchTransferList(context);
  }

  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return ShorcutKeyboardHandler(
      scaffoldKey: _branchTransferListController.scaffoldKey,
      onRefresh: () {
        _branchTransferListController.getbranchTransferList(context);
      },
      child: Scaffold(
        key: _branchTransferListController.scaffoldKey,
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
                padding: EdgeInsets.symmetric(horizontal: 15.w , vertical: 15.h),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Text(
                          "Branch Transfer",
                          style: TextPalette.screenTitle,
                        ),
                        SizedBox(
                          width: 10.w,
                        ),
                        IconButton(
                            onPressed: () {
                              _branchTransferListController
                                  .getbranchTransferList(context);
                            },
                            icon: Icon(Icons.refresh))
                      ],
                    ),
                    SizedBox(
                          width: 150.w,
                          child: PrimaryButton(
                              btnHeight: 46.h,
                              isLoading: false,
                              text: "Branch Transfer",
                              onPressed:  () async {
                      await Get.dialog(
                        BranchTransferFormPopup(),
                        barrierDismissible: false,
                      );
                    })),
                  ],
                ),
              ),
              Container(
                height: 550.h,
                decoration: BoxDecoration(
                  color: Colors.white,
                ),
                margin: EdgeInsets.symmetric(horizontal: 15.w),
                child: Stack(
                  children: [
                    Obx(() => _branchTransferListController.isTableLoading.value
                        ? Padding(
                            padding: EdgeInsets.symmetric(horizontal: 7.w),
                            child: LinearProgressIndicator(),
                          )
                        : ListView(
                            children: [
                              Obx(() => PaginatedDataTable(
                                    showEmptyRows: false,
                                    rowsPerPage: _branchTransferListController
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
                                        'Tag Count',
                                        style: TextPalette.tableHeaderTextStyle,
                                      )),
                                      DataColumn(
                                          label: Text(
                                        'From Branch',
                                        style: TextPalette.tableHeaderTextStyle,
                                      )),
                                      DataColumn(
                                          label: Text(
                                        'To Branch',
                                        style: TextPalette.tableHeaderTextStyle,
                                      )),
                                      DataColumn(
                                          label: Text(
                                        'Created By',
                                        style: TextPalette.tableHeaderTextStyle,
                                      )),
                                    ],
                                    source: _DataSource(
                                        context,
                                        _branchTransferListController
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
                value: _branchTransferListController.itemsPerPage.value,
                onChanged: (value) {
                  _branchTransferListController.itemsPerPage(value);
                  _branchTransferListController.getbranchTransferList(context);
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
              'Page ${_branchTransferListController.page.value} of ${_branchTransferListController.totalpages.value}',
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
                onPressed: _branchTransferListController.page.value > 1
                    ? () {
                        if (_branchTransferListController.page.value > 1) {
                          _branchTransferListController.page(
                              _branchTransferListController.page.value - 1);
                          _branchTransferListController
                              .getbranchTransferList(context);
                        }
                      }
                    : null),
            IconButton(
                icon: Icon(Icons.arrow_forward,
                    size: Responsive.isDesktop(context) ||
                            Responsive.isTablet(context)
                        ? 20.sp
                        : 15.sp),
                onPressed: _branchTransferListController.page.value <
                        _branchTransferListController.totalpages.value
                    ? () {
                        if (_branchTransferListController.page.value <
                            _branchTransferListController.totalpages.value) {
                          _branchTransferListController.page(
                              _branchTransferListController.page.value + 1);
                          _branchTransferListController
                              .getbranchTransferList(context);
                        }
                      }
                    : null),
          ],
        ));
  }
}

class _DataSource extends DataTableSource {
  BuildContext context;
  List<BranchTransferListData> data;
  _DataSource(this.context, this.data);

  int _selectedCount = 0;

  final CounterFormController _counterFormController =
      Get.put(CounterFormController());
  final CounterListController _branchTransferListController =
      Get.put(CounterListController());

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
          row.id.toString(),
          style: TextPalette.tableDataTextStyle,
        )),
        DataCell(Text(
          row.tagCount.toString(),
          style: TextPalette.tableDataTextStyle,
        )),
        DataCell(Text(
          row.fromBranch.toString(),
          style: TextPalette.tableDataTextStyle,
        )),
        DataCell(Text(
          row.toBranch.toString(),
          style: TextPalette.tableDataTextStyle,
        )),
        DataCell(Text(
          row.createdBy.toString(),
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
