import 'package:ausales_application/controller/reports/order_vendor_wise_report_list_controller.dart';
import 'package:ausales_application/controller/reports/purchase_and_billing_vendor_wise_report_list_controller.dart';
import 'package:ausales_application/core/constants/app_configuration.dart';
import 'package:ausales_application/core/keyboard_listeners/shortcut_keyboard_handler.dart';
import 'package:ausales_application/core/theme/color_palette.dart';
import 'package:ausales_application/core/theme/text_palette.dart';
import 'package:ausales_application/model/reports/order_vendor_wise_report_models.dart';
import 'package:ausales_application/model/reports/purchase_and_billing_vendor_report_models.dart';
import 'package:ausales_application/responsive.dart';
import 'package:ausales_application/utils/date_helper.dart';
import 'package:ausales_application/view/widgets/form_widgets/primary_button.dart';
import 'package:ausales_application/view/widgets/layouts/end_menu_drawer_widget.dart';
import 'package:ausales_application/view/widgets/layouts/footer.dart';
import 'package:ausales_application/view/widgets/layouts/header.dart';
import 'package:ausales_application/view/widgets/screen_widgets/reports/order_vendor_wise_report/order_vendor_wise_report_header.dart';
import 'package:ausales_application/view/widgets/screen_widgets/reports/order_vendor_wise_report/order_vendor_wise_report_total_views.dart';
import 'package:ausales_application/view/widgets/screen_widgets/reports/purchase_and_billing_vendor_wise_report/purchase_and_billing_vendor_wise_report_header.dart';
import 'package:ausales_application/view/widgets/screen_widgets/reports/purchase_and_billing_vendor_wise_report/purchase_and_billing_vendor_wise_report_total_views.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class PurchaseAndBillingVendorWiseReportListScreen extends StatefulWidget {
  @override
  State<PurchaseAndBillingVendorWiseReportListScreen> createState() => _PurchaseAndBillingVendorWiseReportListScreenState();
}

class _PurchaseAndBillingVendorWiseReportListScreenState extends State<PurchaseAndBillingVendorWiseReportListScreen> {
  final PurchaseAndBillingVendorWiseReportListController _purchaseAndBillingVendorWiseReportListController =
      Get.put(PurchaseAndBillingVendorWiseReportListController());

  @override
  void initState() {
    super.initState();
    _purchaseAndBillingVendorWiseReportListController.getpurchaseandbillingvendordesignerwisereport(context);
  }

  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return ShorcutKeyboardHandler(
      scaffoldKey: _purchaseAndBillingVendorWiseReportListController.scaffoldKey,
      onRefresh: () {
        _purchaseAndBillingVendorWiseReportListController.getpurchaseandbillingvendordesignerwisereport(context);
      },
      child: Scaffold(
        key: _purchaseAndBillingVendorWiseReportListController.scaffoldKey,
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
                              "Purchase And Billing Vendor Wise Report",
                              style: Responsive.isMobile(context)
                                  ? TextPalette.tableDataTextStyle
                                  : TextPalette.screenTitle,
                            ),
                        SizedBox(
                          width: 10.w,
                        ),
                        IconButton(
                            onPressed: () {
                              _purchaseAndBillingVendorWiseReportListController
                                  .getpurchaseandbillingvendordesignerwisereport(context);
                            },
                            icon: const Icon(Icons.refresh)),
                          ],
                        ),
                        Obx(() =>PrimaryButton(
                          btnWidth: 150.w,
                          isLoading: _purchaseAndBillingVendorWiseReportListController.isExportLoading.value,
                          text: 'Export',
                          onPressed: () {
                            _purchaseAndBillingVendorWiseReportListController.exportData(context);
                          }))
                      ],
                    ),
              ),
              PurchaseAndBillingVendorWiseReportTotalViews(),
              PurchaseAndBillingVendorWiseReportHeader(),
              Container(
                height: 550.h,
                decoration: BoxDecoration(
                  color: Colors.white,
                ),
                margin: EdgeInsets.symmetric(horizontal: 15.w),
                child: Stack(
                  children: [
                    Obx(() => _purchaseAndBillingVendorWiseReportListController.isTableLoading.value
                        ? Padding(
                            padding: EdgeInsets.symmetric(horizontal: 7.w),
                            child: LinearProgressIndicator(),
                          )
                        : ListView(
                            children: [
                              Obx(() => PaginatedDataTable(
                                showEmptyRows: false,
                                    rowsPerPage: _purchaseAndBillingVendorWiseReportListController
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
                                        _purchaseAndBillingVendorWiseReportListController.tableData.value),
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
                value: _purchaseAndBillingVendorWiseReportListController.itemsPerPage.value,
                onChanged: (value) {
                  _purchaseAndBillingVendorWiseReportListController.itemsPerPage(value);
                  _purchaseAndBillingVendorWiseReportListController.getpurchaseandbillingvendordesignerwisereport(context);
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
              'Page ${_purchaseAndBillingVendorWiseReportListController.page.value} of ${_purchaseAndBillingVendorWiseReportListController.totalpages.value}',
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
                onPressed: _purchaseAndBillingVendorWiseReportListController.page.value > 1
                    ? () {
                        if (_purchaseAndBillingVendorWiseReportListController.page.value > 1) {
                          _purchaseAndBillingVendorWiseReportListController
                              .page(_purchaseAndBillingVendorWiseReportListController.page.value - 1);
                          _purchaseAndBillingVendorWiseReportListController.getpurchaseandbillingvendordesignerwisereport(context);
                        }
                      }
                    : null),
            IconButton(
                icon: Icon(Icons.arrow_forward,
                    size: Responsive.isDesktop(context) ||
                            Responsive.isTablet(context)
                        ? 20.sp
                        : 15.sp),
                onPressed: _purchaseAndBillingVendorWiseReportListController.page.value <
                        _purchaseAndBillingVendorWiseReportListController.totalpages.value
                    ? () {
                        if (_purchaseAndBillingVendorWiseReportListController.page.value <
                            _purchaseAndBillingVendorWiseReportListController.totalpages.value) {
                          _purchaseAndBillingVendorWiseReportListController
                              .page(_purchaseAndBillingVendorWiseReportListController.page.value + 1);
                          _purchaseAndBillingVendorWiseReportListController.getpurchaseandbillingvendordesignerwisereport(context);
                        }
                      }
                    : null),
          ],
        ));
  }
}

class _DataSource extends DataTableSource {
  BuildContext context;
  List<PurchaseandbillingVendorReportResponse> data;
  _DataSource(this.context, this.data);

  int _selectedCount = 0;

  final OrderVendorWiseReportListController _purchaseAndBillingVendorWiseReportListController =
      Get.put(OrderVendorWiseReportListController());

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
         row.email != null   && row.email!.isNotEmpty  ? row.email.toString() : "-",
          style: TextPalette.tableDataTextStyle,
        )),
         DataCell(Text(
         row.mobileNumber != null  &&  row.mobileNumber!.isNotEmpty  ? row.mobileNumber.toString() : "-",
          style: TextPalette.tableDataTextStyle,
        )),
         DataCell(Text(
        row.landlineNumber != null  &&  row.landlineNumber!.isNotEmpty   ? row.landlineNumber.toString() : "-",
          style: TextPalette.tableDataTextStyle,
        )),
         DataCell(Text(
          row.branchName != null   && row.branchName!.isNotEmpty  ? row.branchName.toString() : "-",
          style: TextPalette.tableDataTextStyle,
        )),
         DataCell(Text(
        row.gstNumber != null  &&   row.gstNumber!.isNotEmpty  ? row.gstNumber.toString() : "-",
          style: TextPalette.tableDataTextStyle,
        )),
         DataCell(Text(
       row.panNumber != null  &&  row.panNumber!.isNotEmpty  ? row.panNumber.toString() : "-",
          style: TextPalette.tableDataTextStyle,
        )),
        DataCell(Text(
          row.totalPurchaseGrossWeight.toString(),
          style: TextPalette.tableDataTextStyle,
        )),
          DataCell(Text(
          row.totalSaleAmount.toString(),
          style: TextPalette.tableDataTextStyle,
        )),
          DataCell(Text(
          row.totalPurchasePieces.toString(),
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
