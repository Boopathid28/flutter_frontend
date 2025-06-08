import 'package:ausales_application/controller/reports/order_vendor_wise_report_list_controller.dart';
import 'package:ausales_application/controller/reports/purchase_wise_vendor_report_controller.dart';
import 'package:ausales_application/core/constants/app_configuration.dart';
import 'package:ausales_application/core/keyboard_listeners/shortcut_keyboard_handler.dart';
import 'package:ausales_application/core/theme/color_palette.dart';
import 'package:ausales_application/core/theme/text_palette.dart';
import 'package:ausales_application/model/reports/order_vendor_wise_report_models.dart';
import 'package:ausales_application/model/reports/purchase_wise_vendor_report_model.dart';
import 'package:ausales_application/responsive.dart';
import 'package:ausales_application/utils/date_helper.dart';
import 'package:ausales_application/view/widgets/form_widgets/primary_button.dart';
import 'package:ausales_application/view/widgets/layouts/end_menu_drawer_widget.dart';
import 'package:ausales_application/view/widgets/layouts/footer.dart';
import 'package:ausales_application/view/widgets/layouts/header.dart';
import 'package:ausales_application/view/widgets/screen_widgets/reports/order_vendor_wise_report/order_vendor_wise_report_header.dart';
import 'package:ausales_application/view/widgets/screen_widgets/reports/order_vendor_wise_report/order_vendor_wise_report_total_views.dart';
import 'package:ausales_application/view/widgets/screen_widgets/reports/purchase_wise_vendor_report/purchase_vendor_wise_report_header.dart';
import 'package:ausales_application/view/widgets/screen_widgets/reports/purchase_wise_vendor_report/purchase_vendor_wise_report_total_views.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class PurchaseWiseVendorReportScreen extends StatefulWidget {
  @override
  State<PurchaseWiseVendorReportScreen> createState() => _PurchaseWiseVendorReportListScreenState();
}

class _PurchaseWiseVendorReportListScreenState extends State<PurchaseWiseVendorReportScreen> {
  final PurchaseWiseVendorReportController _purchaseWiseVendorReportController =
      Get.put(PurchaseWiseVendorReportController());

  @override
  void initState() {
    super.initState();
    _purchaseWiseVendorReportController.getpurchasevendorwisereport(context);
  }

  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return ShorcutKeyboardHandler(
      scaffoldKey: _purchaseWiseVendorReportController.scaffoldKey,
      onRefresh: () {
        _purchaseWiseVendorReportController.getpurchasevendorwisereport(context);
      },
      child: Scaffold(
        key: _purchaseWiseVendorReportController.scaffoldKey,
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
                              "Purchase Vendor Wise Report",
                              style: Responsive.isMobile(context)
                                  ? TextPalette.tableDataTextStyle
                                  : TextPalette.screenTitle,
                            ),
                        SizedBox(
                          width: 10.w,
                        ),
                        IconButton(
                            onPressed: () {
                              _purchaseWiseVendorReportController
                                  .getpurchasevendorwisereport(context);
                            },
                            icon: const Icon(Icons.refresh)),
                          ],
                        ),
                        Obx(() =>PrimaryButton(
                          btnWidth: 150.w,
                          isLoading: _purchaseWiseVendorReportController.isExportLoading.value,
                          text: 'Export',
                          onPressed: () {
                            _purchaseWiseVendorReportController.exportData(context);
                          }))
                      ],
                    ),
              ),
              PurchaseVendorWiseReportTotalViews(),
              PurchaseVendorWiseReportHeader(), 
              
              Container(
                height: 550.h,
                decoration: BoxDecoration(
                  color: Colors.white,
                ),
                margin: EdgeInsets.symmetric(horizontal: 15.w),
                child: Stack(
                  children: [
                    Obx(() => _purchaseWiseVendorReportController.isTableLoading.value
                        ? Padding(
                            padding: EdgeInsets.symmetric(horizontal: 7.w),
                            child: LinearProgressIndicator(),
                          )
                        : ListView(
                            children: [
                              Obx(() => PaginatedDataTable(
                                showEmptyRows: false,
                                    rowsPerPage: _purchaseWiseVendorReportController
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
                                        'Designer Name',
                                        style: TextPalette.tableHeaderTextStyle,
                                      )),
                                      DataColumn(
                                          label: Text(
                                        'Designer Code',
                                        style: TextPalette.tableHeaderTextStyle,
                                      )),
                                      DataColumn(
                                          label: Text(
                                        'Email',
                                        style: TextPalette.tableHeaderTextStyle,
                                      )),
                                        DataColumn(
                                          label: Text(
                                        'Mobile',
                                        style: TextPalette.tableHeaderTextStyle,
                                      )),
                                        DataColumn(
                                          label: Text(
                                        'Land Line Number',
                                        style: TextPalette.tableHeaderTextStyle,
                                      )),
                                       DataColumn(
                                          label: Text(
                                        'Branch',
                                        style: TextPalette.tableHeaderTextStyle,
                                      )),
                                        DataColumn(
                                          label: Text(
                                        'Gst Number',
                                        style: TextPalette.tableHeaderTextStyle,
                                      )),
                                        DataColumn(
                                          label: Text(
                                        'Pan Number',
                                        style: TextPalette.tableHeaderTextStyle,
                                      )),
                                      DataColumn(
                                          label: Text(
                                        'Gross Weight',
                                        style: TextPalette.tableHeaderTextStyle,
                                      )),
                                       DataColumn(
                                          label: Text(
                                        'Net Weight',
                                        style: TextPalette.tableHeaderTextStyle,
                                      )),
                                      DataColumn(
                                          label: Text(
                                        'Pieces',
                                        style: TextPalette.tableHeaderTextStyle,
                                      )),
                                       DataColumn(
                                          label: Text(
                                        'Created At',
                                        style: TextPalette.tableHeaderTextStyle,
                                      )),
                                      DataColumn(
                                          label: Text(
                                        'Created By',
                                        style: TextPalette.tableHeaderTextStyle,
                                      )),
                                    ],
                                    source: _DataSource(context,
                                        _purchaseWiseVendorReportController.tableData.value),
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
                value: _purchaseWiseVendorReportController.itemsPerPage.value,
                onChanged: (value) {
                  _purchaseWiseVendorReportController.itemsPerPage(value);
                  _purchaseWiseVendorReportController.getpurchasevendorwisereport(context);
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
              'Page ${_purchaseWiseVendorReportController.page.value} of ${_purchaseWiseVendorReportController.totalpages.value}',
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
                onPressed: _purchaseWiseVendorReportController.page.value > 1
                    ? () {
                        if (_purchaseWiseVendorReportController.page.value > 1) {
                          _purchaseWiseVendorReportController
                              .page(_purchaseWiseVendorReportController.page.value - 1);
                          _purchaseWiseVendorReportController.getpurchasevendorwisereport(context);
                        }
                      }
                    : null),
            IconButton(
                icon: Icon(Icons.arrow_forward,
                    size: Responsive.isDesktop(context) ||
                            Responsive.isTablet(context)
                        ? 20.sp
                        : 15.sp),
                onPressed: _purchaseWiseVendorReportController.page.value <
                        _purchaseWiseVendorReportController.totalpages.value
                    ? () {
                        if (_purchaseWiseVendorReportController.page.value <
                            _purchaseWiseVendorReportController.totalpages.value) {
                          _purchaseWiseVendorReportController
                              .page(_purchaseWiseVendorReportController.page.value + 1);
                          _purchaseWiseVendorReportController.getpurchasevendorwisereport(context);
                        }
                      }
                    : null),
          ],
        ));
  }
}

class _DataSource extends DataTableSource {
  BuildContext context;
  List<PurchasewiseVendorReportListData> data;
  _DataSource(this.context, this.data);

  int _selectedCount = 0;

  final PurchaseWiseVendorReportController _purchaseWiseVendorReportController =
      Get.put(PurchaseWiseVendorReportController());

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
          row.designerName.toString(),
          style: TextPalette.tableDataTextStyle,
        )),
        DataCell(Text(
          row.designerCode.toString(),
          style: TextPalette.tableDataTextStyle,
        )),
          DataCell(Text(
          row.email.toString(),
          style: TextPalette.tableDataTextStyle,
        )),
         DataCell(Text(
          row.mobileNumber.toString(),
          style: TextPalette.tableDataTextStyle,
        )),
         DataCell(Text(
         row.landlineNumber.toString(),
          style: TextPalette.tableDataTextStyle,
        )),
         DataCell(Text(
          row.branchName.toString(),
          style: TextPalette.tableDataTextStyle,
        )),
         DataCell(Text(
          row.gstNumber.toString(),
          style: TextPalette.tableDataTextStyle,
        )),
         DataCell(Text(
        row.panNumber.toString(),
          style: TextPalette.tableDataTextStyle,
        )),
        DataCell(Text(
          row.totalGrossWeight.toString(),
          style: TextPalette.tableDataTextStyle,
        )),
          DataCell(Text(
          row.totalNetWeight.toString(),
          style: TextPalette.tableDataTextStyle,
        )),
          DataCell(Text(
          row.totalPieces.toString(),
          style: TextPalette.tableDataTextStyle,
        )),
          DataCell(Text(
            DateHelper.convertDate(row.createdAt.toString(),),
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
