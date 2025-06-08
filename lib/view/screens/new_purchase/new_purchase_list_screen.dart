import 'package:ausales_application/controller/new_purchase/new_purchase_list_controller.dart';
import 'package:ausales_application/controller/new_purchase/new_purchase_to_lot/newpurchase_to_lot_controller.dart';
import 'package:ausales_application/controller/new_purchase/new_purchase_to_lot/newpurchase_to_lot_form_controller.dart';
import 'package:ausales_application/core/constants/app_configuration.dart';
import 'package:ausales_application/core/constants/nav_controller.dart';
import 'package:ausales_application/core/keyboard_listeners/shortcut_keyboard_handler.dart';
import 'package:ausales_application/core/theme/color_palette.dart';
import 'package:ausales_application/core/theme/text_palette.dart';
import 'package:ausales_application/model/company/company_modles.dart';
import 'package:ausales_application/model/new_purchase/new_purchase_model.dart';
import 'package:ausales_application/responsive.dart';
import 'package:ausales_application/service/company/company_service.dart';
import 'package:ausales_application/service/new_purchase/new_purchase_service.dart';
import 'package:ausales_application/view/screens/new_purchase/new_purchase_form_screen.dart';
import 'package:ausales_application/view/widgets/form_widgets/primary_button.dart';
import 'package:ausales_application/view/widgets/layouts/end_menu_drawer_widget.dart';
import 'package:ausales_application/view/widgets/layouts/footer.dart';
import 'package:ausales_application/view/widgets/layouts/header.dart';
import 'package:ausales_application/view/widgets/screen_widgets/new_purchase/new_purchase_cancel_popup.dart';
import 'package:ausales_application/view/widgets/screen_widgets/new_purchase/new_purchase_printout.dart';
import 'package:ausales_application/view/widgets/screen_widgets/new_purchase/new_purchase_table_header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class NewPurchaseListScreen extends StatefulWidget {
  const NewPurchaseListScreen({super.key});

  @override
  State<NewPurchaseListScreen> createState() => _NewPurchaseListScreenState();
}

class _NewPurchaseListScreenState extends State<NewPurchaseListScreen> {
  final NewPurchaseListController _newPurchaseListController = Get.put(NewPurchaseListController());

  @override
  void initState() {
    super.initState();
    _newPurchaseListController.getNewPurchaseList(context);
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return ShorcutKeyboardHandler(
      scaffoldKey: _newPurchaseListController.scaffoldKey,
      onRefresh: () {
        _newPurchaseListController.getNewPurchaseList(context);
      },
      child: Scaffold(
        key: _newPurchaseListController.scaffoldKey,
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
                    SizedBox(
                      child: Row(
                        children: [
                          Text(
                            "New Purchase",
                            style: TextPalette.screenTitle,
                          ),
                          SizedBox(
                      width: 10.w,
                    ),
                    IconButton(
                        onPressed: () {
                          _newPurchaseListController.getNewPurchaseList(context);
                        },
                        icon: Icon(Icons.refresh))
                        ],
                      ),
                    ),
                    SizedBox(
                        width: 100.w,
                        child: PrimaryButton(
                            btnHeight: 46.h,
                            isLoading: false,
                            text: "ADD +",
                            onPressed: () async {
                              Get.to(() => NewPurchaseFormScreen());
                            })),
                    
                  ],
                ),
              ),
              NewPurchaseTableHeader(),
              Container(
                height: 550.h,
                decoration: BoxDecoration(color: Colors.white),
                margin: EdgeInsets.symmetric(horizontal: 15.w),
                child: Stack(
                  children: [
                    Obx(() => _newPurchaseListController.isTableLoading.value
                        ? Padding(
                            padding: EdgeInsets.symmetric(horizontal: 7.w),
                            child: LinearProgressIndicator(),
                          )
                        : ListView(
                            children: [
                              Obx(() => PaginatedDataTable(
                                    showEmptyRows: false,
                                    rowsPerPage:
                                        _newPurchaseListController.itemsPerPage.value,
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
                                        'PO No',
                                        style: TextPalette.tableHeaderTextStyle,
                                      )),
                                      // DataColumn(
                                      //     label: Text(
                                      //   'Branch',
                                      //   style: TextPalette.tableHeaderTextStyle,
                                      // )),
                                      DataColumn(
                                          label: Text(
                                        'Vendor Name',
                                        style: TextPalette.tableHeaderTextStyle,
                                      )),
                                      DataColumn(
                                          label: Text(
                                        'Weight',
                                        style: TextPalette.tableHeaderTextStyle,
                                      )),
                                      DataColumn(
                                          label: Text(
                                        'Pieces',
                                        style: TextPalette.tableHeaderTextStyle,
                                      )),
                                      DataColumn(
                                          label: Text(
                                        'Amount',
                                        style: TextPalette.tableHeaderTextStyle,
                                      )),
                                      DataColumn(
                                          label: Text(
                                        'Canceled',
                                        style: TextPalette.tableHeaderTextStyle,
                                      )),
                                      DataColumn(
                                          label: Text(
                                        'Action',
                                        style: TextPalette.tableHeaderTextStyle,
                                      )),
                                    ],
                                    source: _DataSource(context,
                                        _newPurchaseListController.tableData.value),
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
                value: _newPurchaseListController.itemsPerPage.value,
                onChanged: (value) {
                  _newPurchaseListController.itemsPerPage(value);
                  _newPurchaseListController.getNewPurchaseList(context);
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
              'Page ${_newPurchaseListController.page.value} of ${_newPurchaseListController.totalpages.value}',
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
                onPressed: _newPurchaseListController.page.value > 1
                    ? () {
                        if (_newPurchaseListController.page.value > 1) {
                          _newPurchaseListController
                              .page(_newPurchaseListController.page.value - 1);
                          _newPurchaseListController.getNewPurchaseList(context);
                        }
                      }
                    : null),
            IconButton(
                icon: Icon(Icons.arrow_forward,
                    size: Responsive.isDesktop(context) ||
                            Responsive.isTablet(context)
                        ? 20.sp
                        : 15.sp),
                onPressed: _newPurchaseListController.page.value <
                        _newPurchaseListController.totalpages.value
                    ? () {
                        if (_newPurchaseListController.page.value <
                            _newPurchaseListController.totalpages.value) {
                          _newPurchaseListController
                              .page(_newPurchaseListController.page.value + 1);
                          _newPurchaseListController.getNewPurchaseList(context);
                        }
                      }
                    : null),
          ],
        ));
  }
}

class _DataSource extends DataTableSource {
  BuildContext context;
  List<FetchNewPurchaseListResponse> data;
  _DataSource(this.context, this.data);

  int _selectedCount = 0;

  final NewPurchaseListController _newPurchaseListController = Get.put(NewPurchaseListController());

    final NewpurchaseToLotController _newpurchaseToLotController =
      Get.put(NewpurchaseToLotController());

    final NewpurchaseToLotFormController _newpurchaseToLotFormController =
      Get.put(NewpurchaseToLotFormController());

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
          row.poId.toString(),
          style: TextPalette.tableDataTextStyle,
        )),
        // DataCell(Text(
        //   row.branchName.toString(),
        //   style: TextPalette.tableDataTextStyle,
        // )),
        DataCell(Text(
          row.vendorName.toString(),
          style: TextPalette.tableDataTextStyle,
        )),
        DataCell(Text(
          row.totalGrossWeight.toString(),
          style: TextPalette.tableDataTextStyle,
        )),
        DataCell(Text(
          row.totalPieces.toString(),
          style: TextPalette.tableDataTextStyle,
        )),
        DataCell(Text(
          row.payableAmount!.toStringAsFixed(2),
          style: TextPalette.tableDataTextStyle,
        )),
        DataCell(Text(
          row.isCanceled! ? "Canceled" : "Active",
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 15,
            color: !row.isCanceled! ? Colors.green : Colors.red
          ),
        )),
        DataCell(Row(
          children: [
            Tooltip(
              message: "print",
              child: Obx(() => _newPurchaseListController.isPrintLoadingIndex.value == index.toString() ? SizedBox(width: 20, height: 20, child: CircularProgressIndicator()) : GestureDetector(
                  onTap: () async {
                    _newPurchaseListController.isPrintLoadingIndex(index.toString());
                    final CompanyDetailsData? data = await CompanyService.retrieveCompany(context: context);
                    
                    if (data != null) {
                      final NewPurchaseRetrieveResponse? newPurchaseData = await NewPurchaseService.retrieveNewPurchase(context: context, newPurdchaseId: row.id.toString());
                      _newPurchaseListController.isPrintLoadingIndex("");
                      if (newPurchaseData != null) {
                        await Get.dialog(
                            barrierDismissible: false,
                            NewPurchasePrintout(companyDetailsData: data, newPurchaseDetails: newPurchaseData));
                      }
                    } else {
                      navCompanyList();
                    }
              
                  },
                  child: Icon(Icons.print))),
            ),
            SizedBox(
              width: 10.w,
            ),
            Tooltip(
              message: "cancel purchase",
              child: GestureDetector(
                  onTap: () async {
                    await Get.dialog(
                        barrierDismissible: false,
                        NewPurchaseCancelPopup(newPurchaseItem: row));
                  },
                  child: Icon(Icons.cancel)),
            ),
                 SizedBox(
              width: 10.w,
            ),
            Tooltip(
              message: "convert to lot",
              child: GestureDetector(
                  onTap: () {
                        _newpurchaseToLotFormController.getLotDetails(context, row.id);
                    _newpurchaseToLotController.getnewpurchaseItemList(
                        context, row.id.toString());
                  },
                  child: Icon(Icons.conveyor_belt)),
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
