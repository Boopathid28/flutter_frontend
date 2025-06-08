import 'dart:developer';

import 'package:ausales_application/controller/order/order_list_controller.dart';
import 'package:ausales_application/controller/order/order_receive_item_controller/order_receive_item_controller.dart';
import 'package:ausales_application/controller/order/order_receive_item_convert/order_receive_item_convert_controller.dart';
import 'package:ausales_application/controller/order/order_vendor_assign_controller/order_vendor_assign_controller.dart';
import 'package:ausales_application/core/constants/app_configuration.dart';
import 'package:ausales_application/core/constants/nav_controller.dart';
import 'package:ausales_application/core/keyboard_listeners/shortcut_keyboard_handler.dart';
import 'package:ausales_application/core/theme/color_palette.dart';
import 'package:ausales_application/core/theme/text_palette.dart';
import 'package:ausales_application/model/company/company_modles.dart';
import 'package:ausales_application/model/order/order_models.dart';
import 'package:ausales_application/model/order/order_view_details_models.dart';
import 'package:ausales_application/responsive.dart';
import 'package:ausales_application/service/company/company_service.dart';
import 'package:ausales_application/service/order/order_service.dart';
import 'package:ausales_application/utils/date_helper.dart';
import 'package:ausales_application/view/screens/order/order_form_screen.dart';
import 'package:ausales_application/view/screens/order/view_order_details_screen.dart';
import 'package:ausales_application/view/widgets/form_widgets/primary_button.dart';
import 'package:ausales_application/view/widgets/layouts/end_menu_drawer_widget.dart';
import 'package:ausales_application/view/widgets/layouts/footer.dart';
import 'package:ausales_application/view/widgets/layouts/header.dart';
import 'package:ausales_application/view/widgets/screen_widgets/order/delete_popup.dart';
import 'package:ausales_application/view/widgets/screen_widgets/order/order_printout.dart';
import 'package:ausales_application/view/widgets/screen_widgets/order/order_table_header.dart';
import 'package:ausales_application/view/widgets/screen_widgets/order/receive_item/receive_item_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class OrderListScreen extends StatefulWidget {
  @override
  State<OrderListScreen> createState() => _OrderListScreenState();
}

class _OrderListScreenState extends State<OrderListScreen> {
  final OrderListController _orderListController =
      Get.put(OrderListController());

  @override
  void initState() {
    super.initState();
    _orderListController.getorderList(context);
  }

  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return ShorcutKeyboardHandler(
      scaffoldKey: _orderListController.scaffoldKey,
      onRefresh: () {
        _orderListController.getorderList(context);
      },
      child: Scaffold(
        key: _orderListController.scaffoldKey,
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
                          "Order",
                          style: TextPalette.screenTitle,
                        ),
                        SizedBox(
                          width: 10.w,
                        ),
                        IconButton(
                            onPressed: () {
                              _orderListController.getorderList(context);
                            },
                            icon: Icon(Icons.refresh))
                      ],
                    ),
                    SizedBox(
                        width: 100.w,
                        child: PrimaryButton(
                            btnHeight: 46.h,
                            isLoading: false,
                            text: "ADD +",
                            onPressed: () async {
                              Get.to(() => OrderFormScreen());
                            })),
                  ],
                ),
              ),
              OrderTableHeader(),
              Container(
                height: 550.h,
                decoration: BoxDecoration(
                  color: Colors.white,
                ),
                margin: EdgeInsets.symmetric(horizontal: 15.w),
                child: Stack(
                  children: [
                    Obx(() => _orderListController.isTableLoading.value
                        ? Padding(
                            padding: EdgeInsets.symmetric(horizontal: 7.w),
                            child: LinearProgressIndicator(),
                          )
                        : ListView(
                            children: [
                              Obx(() => PaginatedDataTable(
                                    rowsPerPage:
                                        _orderListController.itemsPerPage.value,
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
                                        'Order Id',
                                        style: TextPalette.tableHeaderTextStyle,
                                      )),
                                      DataColumn(
                                          label: Text(
                                        'Customer Name',
                                        style: TextPalette.tableHeaderTextStyle,
                                      )),
                                      // DataColumn(
                                      //     label: Text(
                                      //   'Branch',
                                      //   style: TextPalette.tableHeaderTextStyle,
                                      // )),
                                      DataColumn(
                                          label: Text(
                                        'Due Date',
                                        style: TextPalette.tableHeaderTextStyle,
                                      )),
                                      DataColumn(
                                          label: Text(
                                        'Order Status',
                                        style: TextPalette.tableHeaderTextStyle,
                                      )),
                                      DataColumn(
                                          label: Text(
                                        'Is Cancelled',
                                        style: TextPalette.tableHeaderTextStyle,
                                      )),
                                      DataColumn(
                                          label: Text(
                                        'Created By',
                                        style: TextPalette.tableHeaderTextStyle,
                                      )),
                                      DataColumn(
                                          label: Text(
                                        'Action',
                                        style: TextPalette.tableHeaderTextStyle,
                                      )),
                                    ],
                                    source: _DataSource(context,
                                        _orderListController.tableData.value),
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
                value: _orderListController.itemsPerPage.value,
                onChanged: (value) {
                  _orderListController.itemsPerPage(value);
                  _orderListController.getorderList(context);
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
              'Page ${_orderListController.page.value} of ${_orderListController.totalpages.value}',
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
                onPressed: _orderListController.page.value > 1
                    ? () {
                        if (_orderListController.page.value > 1) {
                          _orderListController
                              .page(_orderListController.page.value - 1);
                          _orderListController.getorderList(context);
                        }
                      }
                    : null),
            IconButton(
                icon: Icon(Icons.arrow_forward,
                    size: Responsive.isDesktop(context) ||
                            Responsive.isTablet(context)
                        ? 20.sp
                        : 15.sp),
                onPressed: _orderListController.page.value <
                        _orderListController.totalpages.value
                    ? () {
                        if (_orderListController.page.value <
                            _orderListController.totalpages.value) {
                          _orderListController
                              .page(_orderListController.page.value + 1);
                          _orderListController.getorderList(context);
                        }
                      }
                    : null),
          ],
        ));
  }
}

class _DataSource extends DataTableSource {
  BuildContext context;
  List<OrderListData> data;
  _DataSource(this.context, this.data);

  int _selectedCount = 0;

  final OrderListController _orderListController =
      Get.put(OrderListController());

  final OrderVendorAssignController _orderVendorAssignController =
      Get.put(OrderVendorAssignController());

  final OrderReceiveItemController _orderReceiveItemController =
      Get.put(OrderReceiveItemController());

  final OrderConvertReceiveItemController _orderConvertReceiveItemController =
      Get.put(OrderConvertReceiveItemController());

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
          row.orderId.toString(),
          style: TextPalette.tableDataTextStyle,
        )),
        DataCell(Text(
          row.customerName.toString(),
          style: TextPalette.tableDataTextStyle,
        )),
        // DataCell(Text(
        //   row.branchName.toString(),
        //   style: TextPalette.tableDataTextStyle,
        // )),
        DataCell(Text(
          DateHelper.convertDate(row.dueDate.toString()),
          style: TextPalette.tableDataTextStyle,
        )),
DataCell(Text(
          row.orderStatus.toString(),
          style: TextPalette.tableDataTextStyle,
        )),
        DataCell(Text(
          row.isCanceled! ? "Cancelled" : "Active",
          style: TextStyle(
              color: row.isCanceled! ? Colors.green : Colors.red,
              fontSize: 16.sp),
        )),
        DataCell(Text(
          row.createdBy.toString(),
          style: TextPalette.tableDataTextStyle,
        )),
        DataCell(Row(
          children: [
            Obx(
              () => _orderListController.isPrintLoadingIndex.value ==
                      index.toString()
                  ? SizedBox(
                      width: 20, height: 20, child: CircularProgressIndicator())
                  : Tooltip(
                      message: "Order Print",
                      child: GestureDetector(
                          onTap: () async {
                            _orderListController
                                .isPrintLoadingIndex(index.toString());
                            final CompanyDetailsData? data =
                                await CompanyService.retrieveCompany(
                                    context: context);

                            if (data != null) {
                              final RetrieveOrderDetails? orderGetResponse =
                                  await OrderService.retrieveOrderDetails(
                                      context: context,
                                      orderId: row.id.toString());
                              if (orderGetResponse != null) {
                                List<ItemDetails> itemsList = <ItemDetails>[
                                  ...orderGetResponse.itemDetails!
                                ];
                                int totalPieces = 0;
                                double totalNetWeight = 0.0;
                                double totalGrossWeight = 0.0;
                                for (var i in orderGetResponse.itemDetails!) {
                                  totalPieces += i.pieces ?? 0;
                                  totalGrossWeight += i.grossWeight ?? 0.0;
                                  totalNetWeight += i.netWeight ?? 0.0;
                                }
                                itemsList.add(ItemDetails(
                                  pieces: totalPieces,
                                  grossWeight: totalGrossWeight,
                                  netWeight: totalNetWeight,
                                  gstAmount: orderGetResponse.gstAmount,
                                  totalAmount: orderGetResponse.totalAmount,
                                ));
                                await Get.dialog(
                                    barrierDismissible: false,
                                    OrderPrintout(
                                          companyDetailsData: data,
                                          orderDetails: orderGetResponse,
                                          items: itemsList,
                                        ));
                              }
                            } else {
                              navCompanyList();
                            }
                            _orderListController.isPrintLoadingIndex("");
                          },
                          child: Icon(Icons.print))),
            ),
            SizedBox(
              width: 10.w,
            ),
            Tooltip(
              message: "Convert To Purchase",
              child: GestureDetector(
                onTap: () {
                  _orderConvertReceiveItemController.getCovertReceiveItemList(
                      context, row.id.toString());
                },
                child: Icon(Icons.conveyor_belt),
              ),
            ),
            SizedBox(
              width: 10.w,
            ),
            // Tooltip(
            //     message: "Receive Items",
            //     child: GestureDetector(
            //         onTap: () async {
            //           _orderReceiveItemController
            //               .currentReceiveItemdetails(row);
            //           await showDialog(
            //               context: context,
            //               barrierDismissible: false,
            //               builder: (context) => ReceiveItemForm());
            //         },
            //         child: Icon(Icons.call_received))),
            // SizedBox(
            //   width: 10.w,
            // ),
            // Tooltip(
            //     message: "Vendor Assign",
            //     child: GestureDetector(
            //         onTap: () {
            //           _orderVendorAssignController.getorderAssignList(
            //               context, row.id.toString());
            //         },
            //         child: Icon(Icons.assignment))),
            // SizedBox(
            //   width: 10.w,
            // ),
            Tooltip(
              message: "Cancel Order",
              child: GestureDetector(
                  onTap: () async {
                    await Get.dialog(
                        barrierDismissible: false,
                        DeleteOrderPopup(order: row));
                  },
                  child: Icon(Icons.cancel)),
            ),
            SizedBox(
              width: 10.w,
            ),
            Tooltip(
              message: "View Order",
              child: GestureDetector(
                  onTap: () async {
                    Get.to(() => ViewOrderDetailsScreen(),
                        arguments: row.id.toString());
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
