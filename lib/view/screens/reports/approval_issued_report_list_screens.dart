import 'package:ausales_application/controller/reports/approval_issued_report_controller.dart';
import 'package:ausales_application/controller/reports/approval_pending_report_controller.dart';
import 'package:ausales_application/controller/reports/order_metal_wise_report_list_controller.dart';
import 'package:ausales_application/core/constants/app_configuration.dart';
import 'package:ausales_application/core/keyboard_listeners/shortcut_keyboard_handler.dart';
import 'package:ausales_application/core/theme/color_palette.dart';
import 'package:ausales_application/core/theme/text_palette.dart';
import 'package:ausales_application/model/reports/approval_issue_report_models.dart';
import 'package:ausales_application/model/reports/approval_pending_report_models.dart';
import 'package:ausales_application/model/reports/order_metal_wise_report_models.dart';
import 'package:ausales_application/responsive.dart';
import 'package:ausales_application/utils/date_helper.dart';
import 'package:ausales_application/view/widgets/form_widgets/primary_button.dart';
import 'package:ausales_application/view/widgets/layouts/end_menu_drawer_widget.dart';
import 'package:ausales_application/view/widgets/layouts/footer.dart';
import 'package:ausales_application/view/widgets/layouts/header.dart';
import 'package:ausales_application/view/widgets/screen_widgets/reports/approval_issued_report/approval_issued_report_header.dart';
import 'package:ausales_application/view/widgets/screen_widgets/reports/approval_issued_report/approval_issued_report_total_views.dart';
import 'package:ausales_application/view/widgets/screen_widgets/reports/approval_pending_report/approval_pending_report_header.dart';
import 'package:ausales_application/view/widgets/screen_widgets/reports/approval_pending_report/approval_pending_report_total_views.dart';
import 'package:ausales_application/view/widgets/screen_widgets/reports/order_metal_wise_report/order_metal_wise_report_header.dart';
import 'package:ausales_application/view/widgets/screen_widgets/reports/order_metal_wise_report/order_metal_wise_report_total_views.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class ApprovalIssuedReportListScreens extends StatefulWidget {
  @override
  State<ApprovalIssuedReportListScreens> createState() => _ApprovalIssuedReportListScreensState();
}

class _ApprovalIssuedReportListScreensState extends State<ApprovalIssuedReportListScreens> {
  final ApprovalIssuedReportController _approvalIssuedReportController =
      Get.put(ApprovalIssuedReportController());

  @override
  void initState() {
    super.initState();
    _approvalIssuedReportController.getApprovalIssuedreport(context);
  }

  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return ShorcutKeyboardHandler(
      scaffoldKey: _approvalIssuedReportController.scaffoldKey,
      onRefresh: () {
        _approvalIssuedReportController.getApprovalIssuedreport(context);
      },
      child: Scaffold(
        key: _approvalIssuedReportController.scaffoldKey,
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
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Text(
                              "Approval Issued Report",
                              style: Responsive.isMobile(context)
                                  ? TextPalette.tableDataTextStyle
                                  : TextPalette.screenTitle,
                            ),
                        SizedBox(
                          width: 10.w,
                        ),
                        IconButton(
                            onPressed: () {
                              _approvalIssuedReportController
                                  .getApprovalIssuedreport(context);
                            },
                            icon: const Icon(Icons.refresh)),
                          ],
                        ),
                        Row(
                          children: [
                            Obx(() =>PrimaryButton(
                              btnWidth: 150.w,
                              isLoading: _approvalIssuedReportController.isExportLoading.value,
                              text: 'Export to Excel',
                              onPressed: () {
                                _approvalIssuedReportController.exportData(context);
                              })),
                              SizedBox(width: 10,),
                            Obx(() =>PrimaryButton(
                              btnWidth: 150.w,
                              isLoading: _approvalIssuedReportController.isExportPdfLoading.value,
                              text: 'Export to Pdf',
                              onPressed: () {
                                _approvalIssuedReportController.exportPdfData(context);
                              })),
                          ],
                        )
                      ],
                    ),
              ),
              ApprovalIssuedReportTotalViews(),
              ApprovalIssuedReportHeader(),
              Container(
                height: 550.h,
                decoration: BoxDecoration(
                  color: Colors.white,
                ),
                margin: EdgeInsets.symmetric(horizontal: 15.w),
                child: Stack(
                  children: [
                    Obx(() => _approvalIssuedReportController.isTableLoading.value
                        ? Padding(
                            padding: EdgeInsets.symmetric(horizontal: 7.w),
                            child: LinearProgressIndicator(),
                          )
                        : ListView(
                            children: [
                              Obx(() => PaginatedDataTable(
                                showEmptyRows: false,
                                    rowsPerPage: _approvalIssuedReportController
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
                                        'Tag No',
                                        style: TextPalette.tableHeaderTextStyle,
                                      )),
                                     
                                       DataColumn(
                                          label: Text(
                                        'Item Name',
                                        style: TextPalette.tableHeaderTextStyle,
                                      )),
                                      DataColumn(
                                          label: Text(
                                        'Pieces',
                                        style: TextPalette.tableHeaderTextStyle,
                                      )),
                                       DataColumn(
                                          label: Text(
                                        'Weight',
                                        style: TextPalette.tableHeaderTextStyle,
                                      )),
                                     
                                    ],
                                    source: _DataSource(context,
                                        _approvalIssuedReportController.tableData.value),
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
                value: _approvalIssuedReportController.itemsPerPage.value,
                onChanged: (value) {
                  _approvalIssuedReportController.itemsPerPage(value);
                  _approvalIssuedReportController.getApprovalIssuedreport(context);
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
              'Page ${_approvalIssuedReportController.page.value} of ${_approvalIssuedReportController.totalpages.value}',
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
                onPressed: _approvalIssuedReportController.page.value > 1
                    ? () {
                        if (_approvalIssuedReportController.page.value > 1) {
                          _approvalIssuedReportController
                              .page(_approvalIssuedReportController.page.value - 1);
                          _approvalIssuedReportController.getApprovalIssuedreport(context);
                        }
                      }
                    : null),
            IconButton(
                icon: Icon(Icons.arrow_forward,
                    size: Responsive.isDesktop(context) ||
                            Responsive.isTablet(context)
                        ? 20.sp
                        : 15.sp),
                onPressed: _approvalIssuedReportController.page.value <
                        _approvalIssuedReportController.totalpages.value
                    ? () {
                        if (_approvalIssuedReportController.page.value <
                            _approvalIssuedReportController.totalpages.value) {
                          _approvalIssuedReportController
                              .page(_approvalIssuedReportController.page.value + 1);
                          _approvalIssuedReportController.getApprovalIssuedreport(context);
                        }
                      }
                    : null),
          ],
        ));
  }
}

class _DataSource extends DataTableSource {
  BuildContext context;
  List<ApprovalIssueReportListData> data;
  _DataSource(this.context, this.data);

  int _selectedCount = 0;

  final ApprovalIssuedReportController _approvalIssuedReportController =
      Get.put(ApprovalIssuedReportController());

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
          row.tagNo.toString(),
          style: TextPalette.tableDataTextStyle,
        )),
        
        DataCell(Text(
          row.itemName.toString(),
          style: TextPalette.tableDataTextStyle,
        )),
          DataCell(Text(
          row.pieces.toString(),
          style: TextPalette.tableDataTextStyle,
        )),
          DataCell(Text(
          row.weight.toString(),
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
