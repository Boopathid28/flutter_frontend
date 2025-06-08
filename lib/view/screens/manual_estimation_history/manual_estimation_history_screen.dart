import 'package:ausales_application/controller/estimation_history/estimation_history_list_controller.dart';
import 'package:ausales_application/controller/manual_estimation_history/manual_estimation_history_list_controller.dart';
import 'package:ausales_application/core/constants/app_configuration.dart';
import 'package:ausales_application/core/keyboard_listeners/shortcut_keyboard_handler.dart';
import 'package:ausales_application/core/theme/color_palette.dart';
import 'package:ausales_application/core/theme/text_palette.dart';
import 'package:ausales_application/model/company/company_modles.dart';
import 'package:ausales_application/model/estimation/estimation_history_models.dart';
import 'package:ausales_application/model/mannual_estimation/mannual_estimation_history_model.dart';
import 'package:ausales_application/responsive.dart';
import 'package:ausales_application/service/company/company_service.dart';
import 'package:ausales_application/utils/date_helper.dart';
import 'package:ausales_application/view/widgets/layouts/end_menu_drawer_widget.dart';
import 'package:ausales_application/view/widgets/layouts/footer.dart';
import 'package:ausales_application/view/widgets/layouts/header.dart';
import 'package:ausales_application/view/widgets/screen_widgets/estimation/estimation_printout.dart';
import 'package:ausales_application/view/widgets/screen_widgets/estimation_history/estimation_history_table_header.dart';
import 'package:ausales_application/view/widgets/screen_widgets/mannual_estimation/mannual_estimation_printout.dart';
import 'package:ausales_application/view/widgets/screen_widgets/manual_estimation_history/manual_estimation_history_table_header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class ManualEstimationHistoryScreen extends StatefulWidget {
  @override
  State<ManualEstimationHistoryScreen> createState() => _ManualEstimationHistoryScreenState();
}

class _ManualEstimationHistoryScreenState extends State<ManualEstimationHistoryScreen> {
  final ManualEstimationHistoryListController _manualEstimationHistoryListController =
      Get.put(ManualEstimationHistoryListController());

  @override
  void initState() {
    super.initState();
    _manualEstimationHistoryListController.getEstimationList(context);
  }

  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return ShorcutKeyboardHandler(
      scaffoldKey: _manualEstimationHistoryListController.scaffoldKey,
       onRefresh: () {
        _manualEstimationHistoryListController.getEstimationList(context);
      },
      child: Scaffold(
       key: _manualEstimationHistoryListController.scaffoldKey,
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
                      "Manual Estimation History",
                      style: TextPalette.screenTitle,
                    ),
                    SizedBox(
                      width: 10.w,
                    ),
                    IconButton(
                        onPressed: () {
                          _manualEstimationHistoryListController.getEstimationList(context);
                        },
                        icon: Icon(Icons.refresh))
                  ],
                ),
              ),
              ManualEstimationHistoryTableHeader(),
              Container(
                height: 550.h,
                decoration: BoxDecoration(
                  color: Colors.white,
                ),
                margin: EdgeInsets.symmetric(horizontal: 15.w),
                child: Stack(
                  children: [
                    Obx(() => _manualEstimationHistoryListController.isTableLoading.value
                        ? Padding(
                            padding: EdgeInsets.symmetric(horizontal: 7.w),
                            child: LinearProgressIndicator(),
                          )
                        : ListView(
                            children: [
                              Obx(() => PaginatedDataTable(
                                showEmptyRows: false,
                                    rowsPerPage: _manualEstimationHistoryListController
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
                                      DataColumn(
                                          label: Text(
                                        'Branch',
                                        style: TextPalette.tableHeaderTextStyle,
                                      )),
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
                                        _manualEstimationHistoryListController.tableData.value),
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
                value: _manualEstimationHistoryListController.itemsPerPage.value,
                onChanged: (value) {
                  _manualEstimationHistoryListController.itemsPerPage(value);
                  _manualEstimationHistoryListController.getEstimationList(context);
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
              'Page ${_manualEstimationHistoryListController.page.value} of ${_manualEstimationHistoryListController.totalpages.value}',
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
                onPressed: _manualEstimationHistoryListController.page.value > 1
                    ? () {
                        if (_manualEstimationHistoryListController.page.value > 1) {
                          _manualEstimationHistoryListController
                              .page(_manualEstimationHistoryListController.page.value - 1);
                          _manualEstimationHistoryListController.getEstimationList(context);
                        }
                      }
                    : null),
            IconButton(
                icon: Icon(Icons.arrow_forward,
                    size: Responsive.isDesktop(context) ||
                            Responsive.isTablet(context)
                        ? 20.sp
                        : 15.sp),
                onPressed: _manualEstimationHistoryListController.page.value <
                        _manualEstimationHistoryListController.totalpages.value
                    ? () {
                        if (_manualEstimationHistoryListController.page.value <
                            _manualEstimationHistoryListController.totalpages.value) {
                          _manualEstimationHistoryListController
                              .page(_manualEstimationHistoryListController.page.value + 1);
                          _manualEstimationHistoryListController.getEstimationList(context);
                        }
                      }
                    : null),
          ],
        ));
  }
}

class _DataSource extends DataTableSource {
  BuildContext context;
  List<ManualEstimationHistoryListData> data;
  _DataSource(this.context, this.data);

  int _selectedCount = 0;

  final ManualEstimationHistoryListController _manualEstimationHistoryListController =
      Get.put(ManualEstimationHistoryListController());

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
        DataCell(Text(
          row.branchName.toString(),
          style: TextPalette.tableDataTextStyle,
        )),
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
            Obx(() => _manualEstimationHistoryListController.isPrintLoadingIndex.value == index.toString() ? SizedBox(width: 20.w, height: 20.w, child: CircularProgressIndicator(),) :
                IconButton(
                    onPressed: () async {
                      _manualEstimationHistoryListController.isPrintLoadingIndex(index.toString());
                      final CompanyDetailsData? data =
                          await CompanyService.retrieveCompany(context: context);
            
                      if (data != null) {
                        final ManualRetrieveEstimationDetails? estimationDetails =
                            await _manualEstimationHistoryListController.getEstimationDetails(
                                context, row.id.toString());
            
                        if (estimationDetails != null) {
                          List<ManualRetrieveParticularDetails> itemsList =
                              <ManualRetrieveParticularDetails>[
                            ...estimationDetails.particularDetails!
                          ];
                          
                          await showDialog(
                              context: context,
                              barrierDismissible: false,
                              builder: (_) => MannualEstimationPrintout(
                                  companyDetailsData: data,
                                  estimationDetails: estimationDetails,
                                  items: itemsList));
                          _manualEstimationHistoryListController.isPrintLoadingIndex("");
                        }
                      }
                    },
                    icon: Icon(Icons.print))),
                     GestureDetector(
                onTap: () async {
                  _manualEstimationHistoryListController.getestimationDetails(context, row);
                  
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
