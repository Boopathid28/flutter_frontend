import 'package:ausales_application/controller/old_purchase/old_purchase_list_controller.dart';
import 'package:ausales_application/core/constants/app_configuration.dart';
import 'package:ausales_application/core/constants/nav_controller.dart';
import 'package:ausales_application/core/keyboard_listeners/shortcut_keyboard_handler.dart';
import 'package:ausales_application/core/theme/color_palette.dart';
import 'package:ausales_application/core/theme/text_palette.dart';
import 'package:ausales_application/model/company/company_modles.dart';
import 'package:ausales_application/model/old_purchase/old_purchase_model.dart';
import 'package:ausales_application/responsive.dart';
import 'package:ausales_application/service/company/company_service.dart';
import 'package:ausales_application/service/old_purchase/old_purchase_service.dart';
import 'package:ausales_application/view/screens/old_purchase/old_purchase_form_screen.dart';
import 'package:ausales_application/view/widgets/form_widgets/primary_button.dart';
import 'package:ausales_application/view/widgets/layouts/end_menu_drawer_widget.dart';
import 'package:ausales_application/view/widgets/layouts/footer.dart';
import 'package:ausales_application/view/widgets/layouts/header.dart';
import 'package:ausales_application/view/widgets/screen_widgets/old_purchase/old_purchase_cancel_popup.dart';
import 'package:ausales_application/view/widgets/screen_widgets/old_purchase/old_purchase_printout.dart';
import 'package:ausales_application/view/widgets/screen_widgets/old_purchase/old_purchase_table_header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class OldPurchaseListScreen extends StatefulWidget {
  const OldPurchaseListScreen({super.key});

  @override
  State<OldPurchaseListScreen> createState() => _OldPurchaseListScreenState();
}

class _OldPurchaseListScreenState extends State<OldPurchaseListScreen> {
  final OldPurchaseListController _oldPurchaseListController =
      Get.put(OldPurchaseListController());

  @override
  void initState() {
    super.initState();
    _oldPurchaseListController.getOldPurchaseList(context);
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return ShorcutKeyboardHandler(
      scaffoldKey: _oldPurchaseListController.scaffoldKey,
      onRefresh: () {
        _oldPurchaseListController.getOldPurchaseList(context);
      },
      child: Scaffold(
        key: _oldPurchaseListController.scaffoldKey,
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
                            "Old Purchase",
                            style: TextPalette.screenTitle,
                          ),
                          SizedBox(
                            width: 10.w,
                          ),
                          IconButton(
                              onPressed: () {
                                _oldPurchaseListController
                                    .getOldPurchaseList(context);
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
                              Get.to(() => OldPurchaseFormScreen());
                            })),
                  ],
                ),
              ),
              OldPurchaseTableHeader(),
              Container(
                height: 550.h,
                decoration: BoxDecoration(color: Colors.white),
                margin: EdgeInsets.symmetric(horizontal: 15.w),
                child: Stack(
                  children: [
                    Obx(() => _oldPurchaseListController.isTableLoading.value
                        ? Padding(
                            padding: EdgeInsets.symmetric(horizontal: 7.w),
                            child: LinearProgressIndicator(),
                          )
                        : ListView(
                            children: [
                              Obx(() => PaginatedDataTable(
                                    showEmptyRows: false,
                                    rowsPerPage: _oldPurchaseListController
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
                                        'Old Metal Bill No',
                                        style: TextPalette.tableHeaderTextStyle,
                                      )),
                                      // DataColumn(
                                      //     label: Text(
                                      //   'Branch',
                                      //   style: TextPalette.tableHeaderTextStyle,
                                      // )),
                                      DataColumn(
                                          label: Text(
                                        'Customer Name',
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
                                    source: _DataSource(
                                        context,
                                        _oldPurchaseListController
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
                value: _oldPurchaseListController.itemsPerPage.value,
                onChanged: (value) {
                  _oldPurchaseListController.itemsPerPage(value);
                  _oldPurchaseListController.getOldPurchaseList(context);
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
              'Page ${_oldPurchaseListController.page.value} of ${_oldPurchaseListController.totalpages.value}',
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
                onPressed: _oldPurchaseListController.page.value > 1
                    ? () {
                        if (_oldPurchaseListController.page.value > 1) {
                          _oldPurchaseListController
                              .page(_oldPurchaseListController.page.value - 1);
                          _oldPurchaseListController
                              .getOldPurchaseList(context);
                        }
                      }
                    : null),
            IconButton(
                icon: Icon(Icons.arrow_forward,
                    size: Responsive.isDesktop(context) ||
                            Responsive.isTablet(context)
                        ? 20.sp
                        : 15.sp),
                onPressed: _oldPurchaseListController.page.value <
                        _oldPurchaseListController.totalpages.value
                    ? () {
                        if (_oldPurchaseListController.page.value <
                            _oldPurchaseListController.totalpages.value) {
                          _oldPurchaseListController
                              .page(_oldPurchaseListController.page.value + 1);
                          _oldPurchaseListController
                              .getOldPurchaseList(context);
                        }
                      }
                    : null),
          ],
        ));
  }
}

class _DataSource extends DataTableSource {
  BuildContext context;
  List<FetchOldPurchaseListResponse> data;
  _DataSource(this.context, this.data);

  int _selectedCount = 0;

  final OldPurchaseListController _oldPurchaseListController =
      Get.put(OldPurchaseListController());

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
          row.oldGoldBillNumber.toString(),
          style: TextPalette.tableDataTextStyle,
        )),
        // DataCell(Text(
        //   row.branchName.toString(),
        //   style: TextPalette.tableDataTextStyle,
        // )),
        DataCell(Text(
          row.customerDetailsName.toString(),
          style: TextPalette.tableDataTextStyle,
        )),
        DataCell(Text(
          row.oldGoldWeight.toString(),
          style: TextPalette.tableDataTextStyle,
        )),
        DataCell(Text(
          row.oldGoldPieces.toString(),
          style: TextPalette.tableDataTextStyle,
        )),
        DataCell(Text(
          row.oldGoldAmount.toString(),
          style: TextPalette.tableDataTextStyle,
        )),
        DataCell(Text(
          row.isCanceled! ? "Canceled" : "Active",
          style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 15,
              color: !row.isCanceled! ? Colors.green : Colors.red),
        )),
        DataCell(Row(
          children: [
            Obx(() => _oldPurchaseListController.isPrintLoadingIndex.value ==
                    index.toString()
                ? SizedBox(width: 20, height: 20, child: CircularProgressIndicator())
                : Tooltip(message: "Print",
                child: GestureDetector(
                    onTap: () async {
                      _oldPurchaseListController
                          .isPrintLoadingIndex(index.toString());
                      final CompanyDetailsData? data =
                          await CompanyService.retrieveCompany(
                              context: context);

                      if (data != null) {
                        final OldPurchaseRetrieveResponse? oldPurchaseData =
                            await OldPurchaseService.retrieveOldPurchase(
                                context: context,
                                oldPurdchaseId: row.id.toString());
                        _oldPurchaseListController.isPrintLoadingIndex("");
                        if (oldPurchaseData != null) {
                          await Get.dialog(
                              barrierDismissible: false,
                              OldPurchasePrintout(
                                  companyDetailsData: data,
                                  oldPurchaseDetails: oldPurchaseData));
                        }
                      } else {
                        navCompanyList();
                      }
                    },
                    child: Icon(Icons.print)),)),
            SizedBox(
              width: 10.w,
            ),
            Tooltip(
              message: "Cancel Old Purchase",
              child: GestureDetector(
                onTap: () async {
                  await Get.dialog(
                      barrierDismissible: false,
                          OldPurchaseCancelPopup(oldItem: row));
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
