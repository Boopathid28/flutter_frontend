import 'package:ausales_application/controller/reports/customer_cr_dr_report_list_controller.dart';
import 'package:ausales_application/core/constants/app_configuration.dart';
import 'package:ausales_application/core/keyboard_listeners/shortcut_keyboard_handler.dart';
import 'package:ausales_application/core/theme/color_palette.dart';
import 'package:ausales_application/core/theme/text_palette.dart';
import 'package:ausales_application/model/reports/customer_cr_dr_report_models.dart';
import 'package:ausales_application/responsive.dart';
import 'package:ausales_application/view/widgets/form_widgets/primary_button.dart';
import 'package:ausales_application/view/widgets/layouts/end_menu_drawer_widget.dart';
import 'package:ausales_application/view/widgets/layouts/footer.dart';
import 'package:ausales_application/view/widgets/layouts/header.dart';
import 'package:ausales_application/view/widgets/screen_widgets/reports/customer_cr_dr_report/customer_cr_dr_report_data.dart';
import 'package:ausales_application/view/widgets/screen_widgets/reports/customer_cr_dr_report/customer_cr_dr_report_table_header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class CustomerCrDrReportListScreen extends StatefulWidget {
  @override
  State<CustomerCrDrReportListScreen> createState() => _CustomerCrDrReportListScreenState();
}

class _CustomerCrDrReportListScreenState extends State<CustomerCrDrReportListScreen> {
  final CustomerCrDrReportListController _customerCrDrReportListController =
      Get.put(CustomerCrDrReportListController());

  @override
  void initState() {
    super.initState();
    _customerCrDrReportListController.getCustomerCRDRReport();
  }

  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return ShorcutKeyboardHandler(
      scaffoldKey: _customerCrDrReportListController.scaffoldKey,
      onRefresh: () {
        _customerCrDrReportListController.getCustomerCRDRReport();
      },
      child: Scaffold(
        key: _customerCrDrReportListController.scaffoldKey,
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
                              "Customer CR DR Report",
                              style: Responsive.isMobile(context)
                                  ? TextPalette.tableDataTextStyle
                                  : TextPalette.screenTitle,
                            ),
                        SizedBox(
                          width: 10.w,
                        ),
                        IconButton(
                            onPressed: () {
                              _customerCrDrReportListController
                                  .getCustomerCRDRReport();
                            },
                            icon: const Icon(Icons.refresh)),
                          ],
                        ),
                        Row(
                          children: [
                            Obx(() =>PrimaryButton(
                              btnWidth: 150.w,
                              isLoading: _customerCrDrReportListController.isExportLoading.value,
                              text: 'Export',
                              onPressed: () {
                                _customerCrDrReportListController.exportData(context);
                              })),
                              SizedBox(width: 10,),
                              Obx(() =>PrimaryButton(
                              btnWidth: 150.w,
                              isLoading: _customerCrDrReportListController.isExportPdfLoading.value,
                              text: 'Print Pdf',
                              onPressed: () {
                                _customerCrDrReportListController.exportDataPdf(context);
                              })),
                          ],
                        )
                      ],
                    ),
              ),
              CustomerCrDrReportData(),
              CustomerCrDrReportTableHeader(),
              Container(
                height: 550.h,
                decoration: BoxDecoration(
                  color: Colors.white,
                ),
                margin: EdgeInsets.symmetric(horizontal: 15.w),
                child: Stack(
                  children: [
                    Obx(() => _customerCrDrReportListController.isTableLoading.value
                        ? Padding(
                            padding: EdgeInsets.symmetric(horizontal: 7.w),
                            child: LinearProgressIndicator(),
                          )
                        : ListView(
                            children: [
                              Obx(() => PaginatedDataTable(
                                showEmptyRows: false,
                                    rowsPerPage: _customerCrDrReportListController
                                        .itemsPerPage.value,
                                    headingRowColor:
                                        WidgetStateProperty.resolveWith<Color?>(
                                            (Set<WidgetState> states) =>
                                                ColorPalete.tableHeaderBgColor),
                                    columns: [
                                      DataColumn(
                                          label: Text(
                                        'Customer Name',
                                        style: TextPalette.tableHeaderTextStyle,
                                      )),
                                      DataColumn(
                                          label: Text(
                                        'Mobile Number',
                                        style: TextPalette.tableHeaderTextStyle,
                                      )),
                                      DataColumn(
                                          label: Text(
                                        'CR',
                                        style: TextPalette.tableHeaderTextStyle,
                                      )),
                                      DataColumn(
                                          label: Text(
                                        'DR',
                                        style: TextPalette.tableHeaderTextStyle,
                                      )),
                                       
                                    ],
                                    source: _DataSource(context,
                                        _customerCrDrReportListController.tableData.value),
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
                value: _customerCrDrReportListController.itemsPerPage.value,
                onChanged: (value) {
                  _customerCrDrReportListController.itemsPerPage(value);
                  _customerCrDrReportListController.getCustomerCRDRReport();
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
              'Page ${_customerCrDrReportListController.page.value} of ${_customerCrDrReportListController.totalpages.value}',
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
                onPressed: _customerCrDrReportListController.page.value > 1
                    ? () {
                        if (_customerCrDrReportListController.page.value > 1) {
                          _customerCrDrReportListController
                              .page(_customerCrDrReportListController.page.value - 1);
                          _customerCrDrReportListController.getCustomerCRDRReport();
                        }
                      }
                    : null),
            IconButton(
                icon: Icon(Icons.arrow_forward,
                    size: Responsive.isDesktop(context) ||
                            Responsive.isTablet(context)
                        ? 20.sp
                        : 15.sp),
                onPressed: _customerCrDrReportListController.page.value <
                        _customerCrDrReportListController.totalpages.value
                    ? () {
                        if (_customerCrDrReportListController.page.value <
                            _customerCrDrReportListController.totalpages.value) {
                          _customerCrDrReportListController
                              .page(_customerCrDrReportListController.page.value + 1);
                          _customerCrDrReportListController.getCustomerCRDRReport();
                        }
                      }
                    : null),
          ],
        ));
  }
}

class _DataSource extends DataTableSource {
  BuildContext context;
  List<CustomerCRDRListData> data;
  _DataSource(this.context, this.data);

  int _selectedCount = 0;

  final CustomerCrDrReportListController _customerCrDrReportListController =
      Get.put(CustomerCrDrReportListController());

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
          row.customer.toString(),
          style: TextPalette.tableDataTextStyle,
        )),
        DataCell(Text(
          row.mobile.toString(),
          style: TextPalette.tableDataTextStyle,
        )),
        DataCell(Text(
          row.cr.toString(),
          style: TextPalette.tableDataTextStyle,
        )),
        DataCell(Text(
          row.dr.toString(),
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
