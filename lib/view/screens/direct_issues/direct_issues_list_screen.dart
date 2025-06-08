import 'package:ausales_application/controller/approval_issues/approval_issues_list_controller.dart';
import 'package:ausales_application/controller/approval_issues/approval_issues_receipt/approval_issues_receipt_controller.dart';
import 'package:ausales_application/controller/counter/counter_form_controller.dart';
import 'package:ausales_application/controller/direct_issues/direct_issues_list_controller.dart';
import 'package:ausales_application/core/constants/app_configuration.dart';
import 'package:ausales_application/core/keyboard_listeners/shortcut_keyboard_handler.dart';
import 'package:ausales_application/core/theme/color_palette.dart';
import 'package:ausales_application/core/theme/text_palette.dart';
import 'package:ausales_application/model/approval_issues/approval_issues_models.dart';
import 'package:ausales_application/model/direct_issues/direct_issues_models.dart';
import 'package:ausales_application/responsive.dart';
import 'package:ausales_application/utils/date_helper.dart';
import 'package:ausales_application/view/widgets/layouts/end_menu_drawer_widget.dart';
import 'package:ausales_application/view/widgets/layouts/footer.dart';
import 'package:ausales_application/view/widgets/layouts/header.dart';
import 'package:ausales_application/view/widgets/screen_widgets/approval_issues/approval_issues_form.dart';
import 'package:ausales_application/view/widgets/screen_widgets/approval_issues/approval_issues_table_header.dart';
import 'package:ausales_application/view/widgets/screen_widgets/direct_issues/direct_issues_form.dart';
import 'package:ausales_application/view/widgets/screen_widgets/direct_issues/direct_issues_table_header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class DirectIssuesListScreen extends StatefulWidget {
  @override
  State<DirectIssuesListScreen> createState() => _DirectIssuesListScreenState();
}

class _DirectIssuesListScreenState extends State<DirectIssuesListScreen> {
  final DirectIssuesListController _directIssuesListController =
      Get.put(DirectIssuesListController());

  @override
  void initState() {
    super.initState();
    _directIssuesListController.getdirectissuesList(context);
  }

  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return ShorcutKeyboardHandler(
      scaffoldKey: _directIssuesListController.scaffoldKey,
      onRefresh: () {
        _directIssuesListController.getdirectissuesList(context);
      },
      child: Scaffold(
        key: _directIssuesListController.scaffoldKey,
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
                      "Direct Issues",
                      style: TextPalette.screenTitle,
                    ),
                    SizedBox(
                      width: 10.w,
                    ),
                    IconButton(
                        onPressed: () {
                          _directIssuesListController.getdirectissuesList(context);
                        },
                        icon: Icon(Icons.refresh))
                  ],
                ),
              ),
              DirectIssuesForm(),
              DirectIssuesTableHeader(),
              Container(
                height: 550.h,
                decoration: BoxDecoration(
                  color: Colors.white,
                ),
                margin: EdgeInsets.symmetric(horizontal: 15.w),
                child: Stack(
                  children: [
                    Obx(() => _directIssuesListController.isTableLoading.value
                        ? Padding(
                            padding: EdgeInsets.symmetric(horizontal: 7.w),
                            child: LinearProgressIndicator(),
                          )
                        : ListView(
                            children: [
                              Obx(() => PaginatedDataTable(
                                showEmptyRows: false,
                                    rowsPerPage: _directIssuesListController
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
                                        'Direct issues Id',
                                        style: TextPalette.tableHeaderTextStyle,
                                      )),
                                      DataColumn(
                                          label: Text(
                                        'Designer Name',
                                        style: TextPalette.tableHeaderTextStyle,
                                      )),
                                      DataColumn(
                                          label: Text(
                                        'Issues Date',
                                        style: TextPalette.tableHeaderTextStyle,
                                      )),
                                      DataColumn(
                                          label: Text(
                                        'Remarks',
                                        style: TextPalette.tableHeaderTextStyle,
                                      )),
                                      DataColumn(
                                          label: Text(
                                        'Action',
                                        style: TextPalette.tableHeaderTextStyle,
                                      )),
                                    ],
                                    source: _DataSource(context,
                                        _directIssuesListController.tableData.value),
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
                value: _directIssuesListController.itemsPerPage.value,
                onChanged: (value) {
                  _directIssuesListController.itemsPerPage(value);
                  _directIssuesListController.getdirectissuesList(context);
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
              'Page ${_directIssuesListController.page.value} of ${_directIssuesListController.totalpages.value}',
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
                onPressed: _directIssuesListController.page.value > 1
                    ? () {
                        if (_directIssuesListController.page.value > 1) {
                          _directIssuesListController
                              .page(_directIssuesListController.page.value - 1);
                          _directIssuesListController.getdirectissuesList(context);
                        }
                      }
                    : null),
            IconButton(
                icon: Icon(Icons.arrow_forward,
                    size: Responsive.isDesktop(context) ||
                            Responsive.isTablet(context)
                        ? 20.sp
                        : 15.sp),
                onPressed: _directIssuesListController.page.value <
                        _directIssuesListController.totalpages.value
                    ? () {
                        if (_directIssuesListController.page.value <
                            _directIssuesListController.totalpages.value) {
                          _directIssuesListController
                              .page(_directIssuesListController.page.value + 1);
                          _directIssuesListController.getdirectissuesList(context);
                        }
                      }
                    : null),
          ],
        ));
  }
}

class _DataSource extends DataTableSource {
  BuildContext context;
  List<DirectIssuesListData> data;
  _DataSource(this.context, this.data);

  int _selectedCount = 0;

  final DirectIssuesListController _directIssuesListController =
      Get.put(DirectIssuesListController());

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
          row.directIssueId.toString(),
          style: TextPalette.tableDataTextStyle,
        )),
         DataCell(Text(
          row.designerName.toString(),
          style: TextPalette.tableDataTextStyle,
        )),
        DataCell(Text(
          DateHelper.convertDate(row.issuedDate.toString()),
          style: TextPalette.tableDataTextStyle,
        )),
         DataCell(Text(
          row.remarks.toString(),
          style: TextPalette.tableDataTextStyle,
        )),
        DataCell(Row(
          children: [
           Tooltip(
            message: "View Direct Issues",
            child: GestureDetector(
                onTap: () async {
                  _directIssuesListController.getdirectDetails(context, row);
                  
                },
                child: Icon(Icons.visibility)),
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
