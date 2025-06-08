import 'package:ausales_application/controller/repair_creation/assign_vendor_list_controller.dart';
import 'package:ausales_application/controller/repair_creation/receive_item_controller.dart';
import 'package:ausales_application/controller/repair_creation/repair_creation_table_list_controller.dart';
import 'package:ausales_application/core/constants/app_configuration.dart';
import 'package:ausales_application/core/constants/nav_controller.dart';
import 'package:ausales_application/core/shared_preferences/home_shared_prefs.dart';
import 'package:ausales_application/core/theme/color_palette.dart';
import 'package:ausales_application/core/theme/text_palette.dart';
import 'package:ausales_application/model/company/company_modles.dart';
import 'package:ausales_application/model/repair_creation/repair_creation_models.dart';
import 'package:ausales_application/responsive.dart';
import 'package:ausales_application/service/company/company_service.dart';
import 'package:ausales_application/service/repair_creation/repair_creation_service.dart';
import 'package:ausales_application/view/screens/repair_creation/assign_vendor_screen.dart';
import 'package:ausales_application/view/screens/repair_creation/receive_item_screen.dart';
import 'package:ausales_application/view/screens/repair_creation/repair_creation_form_screen.dart';
import 'package:ausales_application/view/screens/repair_creation/view_repair_details_screen.dart';
import 'package:ausales_application/view/widgets/form_widgets/primary_button.dart';
import 'package:ausales_application/view/widgets/layouts/footer.dart';
import 'package:ausales_application/view/widgets/layouts/header.dart';
import 'package:ausales_application/view/widgets/screen_widgets/repair_creation/repair_creation_delete_popup.dart';
import 'package:ausales_application/view/widgets/screen_widgets/repair_creation/repair_creation_table_header.dart';
import 'package:ausales_application/view/widgets/screen_widgets/repair_creation/repair_make_payment.dart';
import 'package:ausales_application/view/widgets/screen_widgets/repair_creation/repair_printout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:toastification/toastification.dart';

class RepairCreationScreen extends StatefulWidget {
  const RepairCreationScreen({super.key});

  @override
  State<RepairCreationScreen> createState() => _RepairCreationScreenState();
}

class _RepairCreationScreenState extends State<RepairCreationScreen> {
  final RepairCreationTableListController _repairCreationTableListController =
      Get.put(RepairCreationTableListController());

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.sizeOf(context);
    return Scaffold(
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(100.0),
        child: HeaderWidget(),
      ),
      body: SingleChildScrollView(
        child: Form(
            child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 15.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 15.h,
                  ),
                  Responsive.isMobile(context)
                      ? Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Row(
                              children: [
                                Text(
                                  "Repair Creation",
                                  style: Responsive.isMobile(context)
                                      ? TextPalette.tableDataTextStyle
                                      : TextPalette.screenTitle,
                                ),
                                SizedBox(
                                  height: 10.w,
                                ),
                                IconButton(
                                    onPressed: () {
                                      _repairCreationTableListController
                                          .getRepairCreationTableList();
                                    },
                                    icon: const Icon(Icons.refresh)),
                              ],
                            ),
                            Align(
                                alignment: Alignment.bottomRight,
                                child: addRepairButton(context))
                          ],
                        )
                      : Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Row(
                              children: [
                                Text(
                                  "Repair Creation",
                                  style: Responsive.isMobile(context)
                                      ? TextPalette.tableDataTextStyle
                                      : TextPalette.screenTitle,
                                ),
                                SizedBox(
                                  width: 10.w,
                                ),
                                IconButton(
                                    onPressed: () {
                                      _repairCreationTableListController
                                          .getRepairCreationTableList();
                                    },
                                    icon: const Icon(Icons.refresh)),
                              ],
                            ),
                            const Spacer(),
                            addRepairButton(context)
                          ],
                        ),
                  SizedBox(
                    height: 16.h,
                  ),
                  const RepairCreationTableHeader(),
                  SizedBox(
                    height: 16.h,
                  ),
                ],
              ),
            ),
            Container(
              height: 550.h,
              decoration: const BoxDecoration(
                color: Colors.white,
              ),
              margin: EdgeInsets.symmetric(horizontal: 15.w),
              child: Stack(
                children: [
                  Obx(() => _repairCreationTableListController
                          .isTableLoading.value
                      ? Padding(
                          padding: EdgeInsets.symmetric(horizontal: 7.w),
                          child: const LinearProgressIndicator(),
                        )
                      : ListView(
                          children: [
                            Obx(() => PaginatedDataTable(
                                  showEmptyRows: false,
                                  rowsPerPage:
                                      _repairCreationTableListController
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
                                      'Repair ID',
                                      style: TextPalette.tableHeaderTextStyle,
                                    )),
                                    DataColumn(
                                        label: Text(
                                      'Created Date',
                                      style: TextPalette.tableHeaderTextStyle,
                                    )),
                                    DataColumn(
                                        label: Text(
                                      'Created By',
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
                                      'Is Cancelled',
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
                                      _repairCreationTableListController
                                          .tableData.value),
                                )),
                          ],
                        )),
                  Positioned(
                    bottom: 0,
                    left: 0,
                    child: Container(
                      height: Responsive.isMobile(context) ? 118.h : 60.h,
                      width: size.width - 38,
                      padding: const EdgeInsets.all(16.0),
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
          ],
        )),
      ),
      bottomNavigationBar: const Footer(),
    );
  }

  SizedBox addRepairButton(BuildContext context) {
    return SizedBox(
      width: !Responsive.isMobile(context) ? 145.w : 70.w,
      height: Responsive.isMobile(context) ? 35.h : 46.h,
      child: PrimaryButton(
        isLoading: false,
        text: 'Add +',
        onPressed: () => Get.to(() => const RepairCreationFormScreen()),
      ),
    );
  }

  SizedBox itemsPerPageChange(BuildContext context) {
    return SizedBox(
      child: Responsive.isMobile(context)
          ? Column(
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
                      value:
                          _repairCreationTableListController.itemsPerPage.value,
                      onChanged: (value) {
                        _repairCreationTableListController.itemsPerPage(value);
                        _repairCreationTableListController
                            .getRepairCreationTableList();
                      },
                      items: [1, 5, 10, 20, 50]
                          .map((value) => DropdownMenuItem<int>(
                                value: value,
                                child: Text('$value'),
                              ))
                          .toList(),
                    )),
              ],
            )
          : Row(
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
                      value:
                          _repairCreationTableListController.itemsPerPage.value,
                      onChanged: (value) {
                        _repairCreationTableListController.itemsPerPage(value);
                        _repairCreationTableListController
                            .getRepairCreationTableList();
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
    return Obx(() => Responsive.isMobile(context)
        ? Column(
            children: [
              Text(
                'Page ${_repairCreationTableListController.page.value} of ${_repairCreationTableListController.totalpages.value}',
                style: TextStyle(
                    fontSize: Responsive.isDesktop(context) ||
                            Responsive.isTablet(context)
                        ? 12.sp
                        : 10.sp),
              ),
              Row(
                children: [
                  IconButton(
                      icon: Icon(Icons.arrow_back,
                          size: Responsive.isDesktop(context) ||
                                  Responsive.isTablet(context)
                              ? 20.sp
                              : 15.sp),
                      onPressed:
                          _repairCreationTableListController.page.value > 1
                              ? () {
                                  if (_repairCreationTableListController
                                          .page.value >
                                      1) {
                                    _repairCreationTableListController.page(
                                        _repairCreationTableListController
                                                .page.value -
                                            1);
                                    _repairCreationTableListController
                                        .getRepairCreationTableList();
                                  }
                                }
                              : null),
                  IconButton(
                      icon: Icon(Icons.arrow_forward,
                          size: Responsive.isDesktop(context) ||
                                  Responsive.isTablet(context)
                              ? 20.sp
                              : 15.sp),
                      onPressed: _repairCreationTableListController.page.value <
                              _repairCreationTableListController
                                  .totalpages.value
                          ? () {
                              if (_repairCreationTableListController
                                      .page.value <
                                  _repairCreationTableListController
                                      .totalpages.value) {
                                _repairCreationTableListController.page(
                                    _repairCreationTableListController
                                            .page.value +
                                        1);
                                _repairCreationTableListController
                                    .getRepairCreationTableList();
                              }
                            }
                          : null),
                ],
              ),
            ],
          )
        : Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'Page ${_repairCreationTableListController.page.value} of ${_repairCreationTableListController.totalpages.value}',
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
                  onPressed: _repairCreationTableListController.page.value > 1
                      ? () {
                          if (_repairCreationTableListController.page.value >
                              1) {
                            _repairCreationTableListController.page(
                                _repairCreationTableListController.page.value -
                                    1);
                            _repairCreationTableListController
                                .getRepairCreationTableList();
                          }
                        }
                      : null),
              IconButton(
                  icon: Icon(Icons.arrow_forward,
                      size: Responsive.isDesktop(context) ||
                              Responsive.isTablet(context)
                          ? 20.sp
                          : 15.sp),
                  onPressed: _repairCreationTableListController.page.value <
                          _repairCreationTableListController.totalpages.value
                      ? () {
                          if (_repairCreationTableListController.page.value <
                              _repairCreationTableListController
                                  .totalpages.value) {
                            _repairCreationTableListController.page(
                                _repairCreationTableListController.page.value +
                                    1);
                            _repairCreationTableListController
                                .getRepairCreationTableList();
                          }
                        }
                      : null),
            ],
          ));
  }
}

class _DataSource extends DataTableSource {
  BuildContext context;
  List<RepairTableList> data;
  _DataSource(this.context, this.data);

  int _selectedCount = 0;

  final AssignVendorListController _assignVendorListController =
      Get.put(AssignVendorListController());
  final ReceiveItemController _receiveItemController =
      Get.put(ReceiveItemController());

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
          row.repairId.toString(),
          style: TextPalette.tableDataTextStyle,
        )),
        DataCell(Text(
          row.createdAt!.split('T')[0].toString(),
          style: TextPalette.tableDataTextStyle,
        )),
        DataCell(Text(
          row.createdBy.toString(),
          style: TextPalette.tableDataTextStyle,
        )),
        // DataCell(Text(
        //   row.branchName.toString(),
        //   style: TextPalette.tableDataTextStyle,
        // )),
        DataCell(Text(
          row.customerName.toString(),
          style: TextPalette.tableDataTextStyle,
        )),
        DataCell(Text(
          row.isCanceled! ? "Cancelled" : "Active",
          style: TextStyle(color: !row.isCanceled! ? Colors.green : Colors.red),
        )),
        DataCell(Row(
          children: [
            Obx(() => _receiveItemController.isPrintLoadingIndex.value ==
                    index.toString()
                ? SizedBox(
                    width: 20, height: 20, child: CircularProgressIndicator())
                : GestureDetector(
                    onTap: () async {
                      _receiveItemController
                          .isPrintLoadingIndex(index.toString());
                      final CompanyDetailsData? data =
                          await CompanyService.retrieveCompany(
                              context: context);

                      if (data != null) {
                         var menuId = await HomeSharedPrefs.getCurrentMenu();
                        final RepairGetbyData? repairGetbyData =
                            await RepairCreationService.getRepairGetData(repairId:row.id.toString() , context: context);
                        if (repairGetbyData != null) {
                          List<ItemDetails> itemsList = <ItemDetails>[
                            ...repairGetbyData.itemDetails!
                          ];
                          int totalPieces = 0;
                          double totalGrossWeight = 0.0;
                          for (var i in repairGetbyData.itemDetails!) {
                            totalPieces += i.pieces ?? 0;
                            totalGrossWeight += i.grossWeight ?? 0.0;
                          }
                          // itemsList.add(ItemDetails(
                          //     pieces: totalPieces,
                          //     grossWeight: totalGrossWeight,
                          //     netWeight: totalNetWeight,
                          //     gstAmount: repairGetbyData.gstAmount,
                          //     payableAmount: repairGetbyData.payableAmount,));
                          await showDialog(
                              context: context,
                              barrierDismissible: false,
                              builder: (context) => RepairPrintOut(
                                    companyDetailsData: data,
                                    repairgetbydata: repairGetbyData,
                                    items: itemsList,
                                  ));
                        }
                      } else {
                        navCompanyList();
                      }
                      _receiveItemController.isPrintLoadingIndex("");
                    },
                    child: Icon(Icons.print))),
            SizedBox(
              width: 10.w,
            ),
            IconButton(onPressed: () 
            async{
              await showDialog(context: context, barrierDismissible: false, builder: (_) => RepairMakePayment(
                branch: row.branch.toString(),
                customer: row.customerDetails.toString(),
                repairId: row.id.toString(),
                totalPayment: row.totalPayment,
                totalAmount: row.totalAmount,
                balanceAmount: row.balanceAmount,
              )
              );
            }, icon: Icon(Icons.payment)),
            SizedBox(
              width: 5.w,
            ),
            IconButton(
                onPressed: () async {
                  if (!row.isCanceled!) {
                    showDialog(
                        context: context,
                        barrierDismissible: false,
                        builder: (context) =>
                            RepairCreationDeletePopup(item: row));
                  } else {
                    toastification.show(
                        context: context,
                        type: ToastificationType.info,
                        title: const Text('This repair is already cancelled'),
                        autoCloseDuration: notificationDuration,
                        showProgressBar: false,
                        pauseOnHover: false);
                  }
                },
                icon: Icon(Icons.cancel)),
            SizedBox(
              width: 5.w,
            ),
            IconButton(
                onPressed: () {
                  _assignVendorListController.id(row.id);
                  _assignVendorListController
                      .getNotIssuedRepairCreationTableList();
                  Get.to(() => const AssignVendorScreen());
                },
                icon: Icon(Icons.assignment)),
            SizedBox(
              width: 5.w,
            ),
            IconButton(
                onPressed: () {
                  _receiveItemController.id(row.id);
                  _receiveItemController.getIssuedRepairItemTableList();
                  Get.to(() => ReceiveItemScreen());
                },
                icon: Icon(Icons.recommend_rounded)),
                SizedBox(
              width: 10.w,
            ),
            GestureDetector(
                onTap: () async {
                  Get.to(() => ViewRepairDetailsScreen(), arguments: row.id.toString());
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
