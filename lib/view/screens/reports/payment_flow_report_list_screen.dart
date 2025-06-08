import 'package:ausales_application/controller/reports/bill_repayment_report_controller.dart';
import 'package:ausales_application/controller/reports/cash_purchase_report_list_controller.dart';
import 'package:ausales_application/controller/reports/payment_flow_report_controller.dart';
import 'package:ausales_application/core/constants/app_configuration.dart';
import 'package:ausales_application/core/keyboard_listeners/shortcut_keyboard_handler.dart';
import 'package:ausales_application/core/theme/color_palette.dart';
import 'package:ausales_application/core/theme/text_palette.dart';
import 'package:ausales_application/model/reports/bill_repayment_report_models.dart';
import 'package:ausales_application/model/reports/cash_purchase_report_models..dart';
import 'package:ausales_application/model/reports/payment_flow_report_models.dart';
import 'package:ausales_application/responsive.dart';
import 'package:ausales_application/utils/date_helper.dart';
import 'package:ausales_application/view/widgets/form_widgets/primary_button.dart';
import 'package:ausales_application/view/widgets/layouts/end_menu_drawer_widget.dart';
import 'package:ausales_application/view/widgets/layouts/footer.dart';
import 'package:ausales_application/view/widgets/layouts/header.dart';
import 'package:ausales_application/view/widgets/screen_widgets/reports/bill_repayment_report/bill_repayment_report_header.dart';
import 'package:ausales_application/view/widgets/screen_widgets/reports/bill_repayment_report/bill_repayment_report_summary.dart';
import 'package:ausales_application/view/widgets/screen_widgets/reports/cash_purchase_report/cash_purchase_report_header.dart';
import 'package:ausales_application/view/widgets/screen_widgets/reports/cash_purchase_report/cash_purchase_report_summary.dart';
import 'package:ausales_application/view/widgets/screen_widgets/reports/payment_flow_report/payment_flow_report_header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class PaymentFlowReportListScreen extends StatefulWidget {
  @override
  State<PaymentFlowReportListScreen> createState() => _PaymentFlowReportListScreenState();
}

class _PaymentFlowReportListScreenState extends State<PaymentFlowReportListScreen> {
  final PaymentFlowReportController _paymentFlowReportController =
      Get.put(PaymentFlowReportController());

  @override
  void initState() {
    super.initState();
    _paymentFlowReportController.getPaymentFlowReport();
  }

  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return ShorcutKeyboardHandler(
      scaffoldKey: _paymentFlowReportController.scaffoldKey,
      onRefresh: () {
        // _paymentFlowReportController.getPaymentFlowReport(context);
      },
      child: Scaffold(
        key: _paymentFlowReportController.scaffoldKey,
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
                padding: const EdgeInsets.all(8.0),
                child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Text(
                              "Payment Flow Report",
                              style: Responsive.isMobile(context)
                                  ? TextPalette.tableDataTextStyle
                                  : TextPalette.screenTitle,
                            ),
                        SizedBox(
                          width: 10.w,
                        ),
                        IconButton(
                            onPressed: () {
                              _paymentFlowReportController
                                  .getPaymentFlowReport();
                            },
                            icon: const Icon(Icons.refresh)),
                          ],
                        ),
                        Obx(() =>Row(
                          children: [
                            PrimaryButton(
                              btnWidth: 150.w,
                              isLoading: _paymentFlowReportController.isExportLoading.value,
                              text: 'Export',
                              onPressed: () {   
                                _paymentFlowReportController.exportData(context);
                              }),
                              SizedBox(width: 10.w,),
                              Obx(() =>PrimaryButton(
                          btnWidth: 150.w,
                          isLoading: _paymentFlowReportController.isExportPdfLoading.value,
                          text: 'Print Pdf',
                          onPressed: () {   
                            _paymentFlowReportController.exportDataPdf(context);
                          }))
                          ],
                        )),
                      ],
                    ),
              ),
              PaymentFlowReportHeader(),
              Container(
                height: 550.h,
                decoration: BoxDecoration(
                  color: Colors.white,
                ),
                margin: EdgeInsets.symmetric(horizontal: 15.w),
                child: Stack(
                  children: [
                    Obx(() => _paymentFlowReportController.isTableLoading.value
                        ? Padding(
                            padding: EdgeInsets.symmetric(horizontal: 7.w),
                            child: LinearProgressIndicator(),
                          )
                        : ListView(
                            children: [
                              Obx(() => PaginatedDataTable(
                                showEmptyRows: false,
                                    rowsPerPage: _paymentFlowReportController
                                        .itemsPerPage.value,
                                    headingRowColor:
                                        WidgetStateProperty.resolveWith<Color?>(
                                            (Set<WidgetState> states) =>
                                                ColorPalete.tableHeaderBgColor),
                                    columns: [
                                      DataColumn(
                                          label: Text(
                                        'S No',
                                        style: TextPalette.tableHeaderTextStyle,
                                      )),
                                      DataColumn(
                                          label: Text(
                                        'Type',
                                        style: TextPalette.tableHeaderTextStyle,
                                      )),
                                      DataColumn(
                                          label: Text(
                                        'Open',
                                        style: TextPalette.tableHeaderTextStyle,
                                      )),
                                       DataColumn(
                                          label: Text(
                                        'In',
                                        style: TextPalette.tableHeaderTextStyle,
                                      )),
                                       DataColumn(
                                          label: Text(
                                        'Out',
                                        style: TextPalette.tableHeaderTextStyle,
                                      )),
                                       DataColumn(
                                          label: Text(
                                        'Close',
                                        style: TextPalette.tableHeaderTextStyle,
                                      )),
                                    ],
                                    source: _DataSource(context,
                                        _paymentFlowReportController.tableData.value),
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
                value: _paymentFlowReportController.itemsPerPage.value,
                onChanged: (value) {
                  _paymentFlowReportController.itemsPerPage(value);
                  // _paymentFlowReportController.getPaymentFlowReport(context);
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
              'Page ${_paymentFlowReportController.page.value} of ${_paymentFlowReportController.totalpages.value}',
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
                onPressed: _paymentFlowReportController.page.value > 1
                    ? () {
                        if (_paymentFlowReportController.page.value > 1) {
                          _paymentFlowReportController
                              .page(_paymentFlowReportController.page.value - 1);
                          // _paymentFlowReportController.getPaymentFlowReport(context);
                        }
                      }
                    : null),
            IconButton(
                icon: Icon(Icons.arrow_forward,
                    size: Responsive.isDesktop(context) ||
                            Responsive.isTablet(context)
                        ? 20.sp
                        : 15.sp),
                onPressed: _paymentFlowReportController.page.value <
                        _paymentFlowReportController.totalpages.value
                    ? () {
                        if (_paymentFlowReportController.page.value <
                            _paymentFlowReportController.totalpages.value) {
                          _paymentFlowReportController
                              .page(_paymentFlowReportController.page.value + 1);
                          // _paymentFlowReportController.getPaymentFlowReport(context);
                        }
                      }
                    : null),
          ],
        ));
  }
}

class _DataSource extends DataTableSource {
  BuildContext context;
  List<PaymentFlowReportListData> data;
  _DataSource(this.context, this.data);

  int _selectedCount = 0;

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
          row.type.toString(),
          style: TextPalette.tableDataTextStyle,
        )),
         DataCell(Text(
          row.open.toString(),
          style: TextPalette.tableDataTextStyle,
        )),
         DataCell(Text(
          row.In.toString(),
          style: TextPalette.tableDataTextStyle,
        )),
          DataCell(Text(
          row.out.toString(),
          style: TextPalette.tableDataTextStyle,
        )),
          DataCell(Text(
          row.close.toString(),
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
