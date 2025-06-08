import 'package:ausales_application/controller/item_master/item_master_form_controller.dart';
import 'package:ausales_application/controller/vendor_payment/vendor_payment_list_controller.dart';
import 'package:ausales_application/core/constants/app_configuration.dart';
import 'package:ausales_application/core/keyboard_listeners/shortcut_keyboard_handler.dart';
import 'package:ausales_application/core/shared_preferences/home_shared_prefs.dart';
import 'package:ausales_application/core/theme/color_palette.dart';
import 'package:ausales_application/core/theme/text_palette.dart';
import 'package:ausales_application/model/vendor_payment/vendor_payment_models.dart';
import 'package:ausales_application/model/vendor_payment/vendor_payment_view_models.dart';
import 'package:ausales_application/responsive.dart';
import 'package:ausales_application/service/vendor_payment/vendor_payment_service.dart';
import 'package:ausales_application/utils/date_helper.dart';
import 'package:ausales_application/view/screens/vendor_payment/vendor_payment_vendor_selection_form.dart';
import 'package:ausales_application/view/screens/vendor_payment/vendor_payment_view_screen.dart';
import 'package:ausales_application/view/widgets/form_widgets/primary_button.dart';
import 'package:ausales_application/view/widgets/layouts/end_menu_drawer_widget.dart';
import 'package:ausales_application/view/widgets/layouts/footer.dart';
import 'package:ausales_application/view/widgets/layouts/header.dart';
import 'package:ausales_application/view/widgets/screen_widgets/vendor_payment/vendor_payment_cancel_popup.dart';
import 'package:ausales_application/view/widgets/screen_widgets/vendor_payment/vendor_payment_printout.dart';
import 'package:ausales_application/view/widgets/screen_widgets/vendor_payment/vendor_payment_table_header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class VendorPaymentListScreen extends StatefulWidget {
  @override
  State<VendorPaymentListScreen> createState() =>
      _VendorPaymentListScreenState();
}

class _VendorPaymentListScreenState extends State<VendorPaymentListScreen> {
  final VendorPaymentListController _vendorPaymentListController =
      Get.put(VendorPaymentListController());

  @override
  void initState() {
    super.initState();
    _vendorPaymentListController.getVendorPaymentList(context);
  }

  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return ShorcutKeyboardHandler(
      scaffoldKey: _vendorPaymentListController.scaffoldKey,
      onRefresh: () {
        _vendorPaymentListController.getVendorPaymentList(context);
      },
      child: Scaffold(
        key: _vendorPaymentListController.scaffoldKey,
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
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          "Vendor Payment",
                          style: TextPalette.screenTitle,
                        ),
                        SizedBox(
                          width: 10.w,
                        ),
                        IconButton(
                            onPressed: () {
                              _vendorPaymentListController
                                  .getVendorPaymentList(context);
                            },
                            icon: Icon(Icons.refresh))
                      ],
                    ),
                    SizedBox(
                        width: 150.w,
                        child: PrimaryButton(
                            btnHeight: 46.h,
                            isLoading: false,
                            text: "Make Payment",
                            onPressed: () async {
                              await Get.dialog(
                                  VendorPaymentVendorSelectionForm());
                            })),
                  ],
                ),
              ),
              VendorPaymentTableHeader(),
              Container(
                height: 550.h,
                decoration: BoxDecoration(
                  color: Colors.white,
                ),
                margin: EdgeInsets.symmetric(horizontal: 15.w),
                child: Stack(
                  children: [
                    Obx(() => _vendorPaymentListController.isTableLoading.value
                        ? Padding(
                            padding: EdgeInsets.symmetric(horizontal: 7.w),
                            child: LinearProgressIndicator(),
                          )
                        : ListView(
                            children: [
                              Obx(() => PaginatedDataTable(
                                    showEmptyRows: false,
                                    rowsPerPage: _vendorPaymentListController
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
                                        'Payment Id',
                                        style: TextPalette.tableHeaderTextStyle,
                                      )),
                                      DataColumn(
                                          label: Text(
                                        'Vendor Name',
                                        style: TextPalette.tableHeaderTextStyle,
                                      )),
                                      //  DataColumn(
                                      //     label: Text(
                                      //   'Branch',
                                      //   style: TextPalette.tableHeaderTextStyle,
                                      // )),
                                      DataColumn(
                                          label: Text(
                                        'Payment Date',
                                        style: TextPalette.tableHeaderTextStyle,
                                      )),
                                      DataColumn(
                                          label: Text(
                                        'Payment Weight',
                                        style: TextPalette.tableHeaderTextStyle,
                                      )),
                                      DataColumn(
                                          label: Text(
                                        'Payment Amount',
                                        style: TextPalette.tableHeaderTextStyle,
                                      )),
                                      DataColumn(
                                          label: Text(
                                        'Cancelled',
                                        style: TextPalette.tableHeaderTextStyle,
                                      )),
                                      DataColumn(
                                          label: Text(
                                        'Action',
                                        style: TextPalette.tableHeaderTextStyle,
                                      )),
                                    ],
                                    source: _DataSource(
                                        context,
                                        _vendorPaymentListController
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
                value: _vendorPaymentListController.itemsPerPage.value,
                onChanged: (value) {
                  _vendorPaymentListController.itemsPerPage(value);
                  _vendorPaymentListController.getVendorPaymentList(context);
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
              'Page ${_vendorPaymentListController.page.value} of ${_vendorPaymentListController.totalpages.value}',
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
                onPressed: _vendorPaymentListController.page.value > 1
                    ? () {
                        if (_vendorPaymentListController.page.value > 1) {
                          _vendorPaymentListController.page(
                              _vendorPaymentListController.page.value - 1);
                          _vendorPaymentListController
                              .getVendorPaymentList(context);
                        }
                      }
                    : null),
            IconButton(
                icon: Icon(Icons.arrow_forward,
                    size: Responsive.isDesktop(context) ||
                            Responsive.isTablet(context)
                        ? 20.sp
                        : 15.sp),
                onPressed: _vendorPaymentListController.page.value <
                        _vendorPaymentListController.totalpages.value
                    ? () {
                        if (_vendorPaymentListController.page.value <
                            _vendorPaymentListController.totalpages.value) {
                          _vendorPaymentListController.page(
                              _vendorPaymentListController.page.value + 1);
                          _vendorPaymentListController
                              .getVendorPaymentList(context);
                        }
                      }
                    : null),
          ],
        ));
  }
}

class _DataSource extends DataTableSource {
  BuildContext context;
  List<VendorPaymentListData> data;
  _DataSource(this.context, this.data);

  int _selectedCount = 0;

  final ItemMasterFormController _itemMasterFormController =
      Get.put(ItemMasterFormController());
  final VendorPaymentListController _vendorPaymentListController =
      Get.put(VendorPaymentListController());

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
          row.paymentId.toString(),
          style: TextPalette.tableDataTextStyle,
        )),
        DataCell(Text(
          row.vendorDetailsName.toString(),
          style: TextPalette.tableDataTextStyle,
        )),
        // DataCell(Text(
        //   row.branchName.toString(),
        //   style: TextPalette.tableDataTextStyle,
        // )),
        DataCell(Text(
          DateHelper.convertDate(row.paymentDate.toString()),
          style: TextPalette.tableDataTextStyle,
        )),
        DataCell(Text(
          row.paymentWeight.toString(),
          style: TextPalette.tableDataTextStyle,
        )),
        DataCell(Text(
          row.paymentAmount.toString(),
          style: TextPalette.tableDataTextStyle,
        )),
        DataCell(Text(
          row.isCanceled! ? "Cancelled" : "No",
          style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 15.sp,
              color: row.isCanceled! ? Colors.red : Colors.green),
        )),
        DataCell(Row(
          children: [
            Tooltip(
              message: "print",
              child: GestureDetector(onTap: () async {
                int? menuId = await HomeSharedPrefs.getCurrentMenu();

                final VendorPaymentListDataDetailsResponse? data = await VendorPaymentService.retrieveVendorPayment(menuId: menuId.toString(), id: row.id.toString(), context: context);

                if (data != null) {
                  await Get.dialog( barrierDismissible: false,VendorPaymentPrintout(vendorPaymentDetails: data,));
                }
              }, child: Icon(Icons.print)),
            ),
            SizedBox(width: 10.w,),
            Tooltip(
              message: "view details",
              child: GestureDetector(onTap: () {
                Get.to(() => VendorPaymentViewScreen(), arguments:row.id);
              }, child: Icon(Icons.visibility)),
            ),
            SizedBox(width: 10.w,),
            Tooltip(
              message: "cancel payment",
              child: GestureDetector(
                  onTap: () async {
                    await Get.dialog(
                        barrierDismissible: false,
                            VendorPaymentCancelPopup(vendorPaymentItem: row));
                  },
                  child: Icon(Icons.cancel)),
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
