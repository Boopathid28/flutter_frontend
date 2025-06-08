import 'package:ausales_application/controller/estimation_history/estimation_history_list_controller.dart';
import 'package:ausales_application/core/constants/app_configuration.dart';
import 'package:ausales_application/core/keyboard_listeners/shortcut_keyboard_handler.dart';
import 'package:ausales_application/core/theme/color_palette.dart';
import 'package:ausales_application/core/theme/text_palette.dart';
import 'package:ausales_application/model/company/company_modles.dart';
import 'package:ausales_application/model/estimation/estimation_history_models.dart';
import 'package:ausales_application/model/estimation/estimation_print_out_models.dart';
import 'package:ausales_application/responsive.dart';
import 'package:ausales_application/service/company/company_service.dart';
import 'package:ausales_application/service/estimation/estimation_service.dart';
import 'package:ausales_application/utils/date_helper.dart';
import 'package:ausales_application/view/widgets/layouts/end_menu_drawer_widget.dart';
import 'package:ausales_application/view/widgets/layouts/footer.dart';
import 'package:ausales_application/view/widgets/layouts/header.dart';
import 'package:ausales_application/view/widgets/screen_widgets/estimation/estimation_printout.dart';
import 'package:ausales_application/view/widgets/screen_widgets/estimation_history/estimation_history_table_header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class EstimationHistoryScreen extends StatefulWidget {
  @override
  State<EstimationHistoryScreen> createState() => _EstimationHistoryScreenState();
}

class _EstimationHistoryScreenState extends State<EstimationHistoryScreen> {
  final EstimationHistoryListController _estimationHistoryListController =
      Get.put(EstimationHistoryListController());

  @override
  void initState() {
    super.initState();
    _estimationHistoryListController.getEstimationList(context);
  }

  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return ShorcutKeyboardHandler(
      scaffoldKey: _estimationHistoryListController.scaffoldKey,
       onRefresh: () {
        _estimationHistoryListController.getEstimationList(context);
      },
      child: Scaffold(
       key: _estimationHistoryListController.scaffoldKey,
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
                      "Estimation History",
                      style: TextPalette.screenTitle,
                    ),
                    SizedBox(
                      width: 10.w,
                    ),
                    IconButton(
                        onPressed: () {
                          _estimationHistoryListController.getEstimationList(context);
                        },
                        icon: Icon(Icons.refresh))
                  ],
                ),
              ),
              EstimationHistoryTableHeader(),
              Container(
                height: 550.h,
                decoration: BoxDecoration(
                  color: Colors.white,
                ),
                margin: EdgeInsets.symmetric(horizontal: 15.w),
                child: Stack(
                  children: [
                    Obx(() => _estimationHistoryListController.isTableLoading.value
                        ? Padding(
                            padding: EdgeInsets.symmetric(horizontal: 7.w),
                            child: LinearProgressIndicator(),
                          )
                        : ListView(
                            children: [
                              Obx(() => PaginatedDataTable(
                                showEmptyRows: false,
                                    rowsPerPage: _estimationHistoryListController
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
                                        'Estimation No',
                                        style: TextPalette.tableHeaderTextStyle,
                                      )),
                                      DataColumn(
                                          label: Text(
                                        'Estimation Date',
                                        style: TextPalette.tableHeaderTextStyle,
                                      )),
                                      // DataColumn(
                                      //     label: Text(
                                      //   'Branch',
                                      //   style: TextPalette.tableHeaderTextStyle,
                                      // )),
                                      DataColumn(
                                          label: Text(
                                        'Customer',
                                        style: TextPalette.tableHeaderTextStyle,
                                      )),
                                      DataColumn(
                                          label: Text(
                                        'Total Amount',
                                        style: TextPalette.tableHeaderTextStyle,
                                      )),
                                      DataColumn(
                                          label: Text(
                                        'Gst Amount',
                                        style: TextPalette.tableHeaderTextStyle,
                                      )),
                                      DataColumn(
                                          label: Text(
                                        'Payable Amount',
                                        style: TextPalette.tableHeaderTextStyle,
                                      )),
                                      DataColumn(
                                          label: Text(
                                        'Actions',
                                        style: TextPalette.tableHeaderTextStyle,
                                      )),
                                    ],
                                    source: _DataSource(context,
                                        _estimationHistoryListController.tableData.value),
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
                value: _estimationHistoryListController.itemsPerPage.value,
                onChanged: (value) {
                  _estimationHistoryListController.itemsPerPage(value);
                  _estimationHistoryListController.getEstimationList(context);
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
              'Page ${_estimationHistoryListController.page.value} of ${_estimationHistoryListController.totalpages.value}',
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
                onPressed: _estimationHistoryListController.page.value > 1
                    ? () {
                        if (_estimationHistoryListController.page.value > 1) {
                          _estimationHistoryListController
                              .page(_estimationHistoryListController.page.value - 1);
                          _estimationHistoryListController.getEstimationList(context);
                        }
                      }
                    : null),
            IconButton(
                icon: Icon(Icons.arrow_forward,
                    size: Responsive.isDesktop(context) ||
                            Responsive.isTablet(context)
                        ? 20.sp
                        : 15.sp),
                onPressed: _estimationHistoryListController.page.value <
                        _estimationHistoryListController.totalpages.value
                    ? () {
                        if (_estimationHistoryListController.page.value <
                            _estimationHistoryListController.totalpages.value) {
                          _estimationHistoryListController
                              .page(_estimationHistoryListController.page.value + 1);
                          _estimationHistoryListController.getEstimationList(context);
                        }
                      }
                    : null),
          ],
        ));
  }
}

class _DataSource extends DataTableSource {
  BuildContext context;
  List<EstimationHistoryListData> data;
  _DataSource(this.context, this.data);

  int _selectedCount = 0;

  final EstimationHistoryListController _estimationHistoryListController =
      Get.put(EstimationHistoryListController());

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
          row.estimationId.toString(),
          style: TextPalette.tableDataTextStyle,
        )),
        DataCell(Text(
          DateHelper.convertDate(row.estimationDate.toString()),
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
          row.totalAmount.toString(),
          style: TextPalette.tableDataTextStyle,
        )),
        DataCell(Text(
          row.gstAmount.toString(),
          style: TextPalette.tableDataTextStyle,
        )),
        DataCell(Text(
          row.payableAmount.toString(),
          style: TextPalette.tableDataTextStyle,
        )),
        DataCell(Row(
          children: [
            Obx(() => _estimationHistoryListController.isPrintLoadingIndex.value == index.toString() ? SizedBox(width: 20.w, height: 20.w, child: CircularProgressIndicator(),) :
                IconButton(
                    onPressed: () async {
                      _estimationHistoryListController.isPrintLoadingIndex(index.toString());
                      final CompanyDetailsData? data =
                          await CompanyService.retrieveCompany(context: context);
            
                      if (data != null) {
                        final PrintEstimationDetails? estimationDetails =
                            await EstimationService.printRetrieveEstimationDetail(context: context, estimationId: row.id.toString());
            
                        if (estimationDetails != null) {
                          List<PrintParticularDetails> itemsList =
                              <PrintParticularDetails>[
                            ...estimationDetails.particularDetails!
                          ];
 
                          List<PrintExchangeDetails> exchangeDetailsList =
                              <PrintExchangeDetails>[
                            ...estimationDetails.exchangeDetails!
                          ];
                          
                          double totalGrossWeight = 0.0;
                          for (var i in estimationDetails.exchangeDetails!) {
                            totalGrossWeight += i.oldGrossWeight??0.0;
                          }
                          if (estimationDetails.exchangeDetails!.isNotEmpty) {
 
                            exchangeDetailsList.add(PrintExchangeDetails(
                              oldGrossWeight: totalGrossWeight,
                              totalAmount: estimationDetails.exchangeAmount
                            ));
                          }
 
                          List<PrintAdvanceDetails> advanceDetailsList =
                              <PrintAdvanceDetails>[
                            ...estimationDetails.advanceDetails!
                          ];
                          
                          await showDialog(
                              context: context,
                              barrierDismissible: false,
                              builder: (_) => EstimationPrintout(
                                  companyDetailsData: data,
                                  estimationDetails: estimationDetails,
                                  exchangeItems: exchangeDetailsList,
                                  advanceItems: advanceDetailsList,
                                  items: itemsList));
                          _estimationHistoryListController.isPrintLoadingIndex("");
                        }
                      }
                    },
                    icon: Icon(Icons.print))),
                     GestureDetector(
                onTap: () async {
                  _estimationHistoryListController.getestimationDetails(context, row);
                  
                },
                child: Icon(Icons.visibility)),
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
