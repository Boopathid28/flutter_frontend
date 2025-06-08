import 'package:ausales_application/controller/repair_creation/receive_item_controller.dart';
import 'package:ausales_application/core/constants/app_configuration.dart';
import 'package:ausales_application/core/keyboard_listeners/shortcut_keyboard_handler.dart';
import 'package:ausales_application/core/theme/color_palette.dart';
import 'package:ausales_application/core/theme/text_palette.dart';
import 'package:ausales_application/model/receive_item/receive_item_models.dart';
import 'package:ausales_application/responsive.dart';
import 'package:ausales_application/view/widgets/form_widgets/custom_dropdown_field.dart';
import 'package:ausales_application/view/widgets/form_widgets/primary_button.dart';
import 'package:ausales_application/view/widgets/layouts/footer.dart';
import 'package:ausales_application/view/widgets/layouts/header.dart';
import 'package:ausales_application/view/widgets/screen_widgets/repair_creation/receive_item/receive_item_popup.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:toastification/toastification.dart';

class ReceiveItemScreen extends StatefulWidget {
  const ReceiveItemScreen({super.key});

  @override
  State<ReceiveItemScreen> createState() => _ReceiveItemScreenState();
}

class _ReceiveItemScreenState extends State<ReceiveItemScreen> {
  final ReceiveItemController _receiveItemController =
      Get.put(ReceiveItemController());

   @override
  void initState() {
    super.initState();
    _receiveItemController.customerChargesController.text='0';
    _receiveItemController.vendorChargesController.text='0';
    _receiveItemController.receiveItemList([]);
  }   

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.sizeOf(context);
    return ShorcutKeyboardHandler(
      scaffoldKey: null,
      onRefresh: () {},
      child: Scaffold(
        appBar: const PreferredSize(
          preferredSize: Size.fromHeight(100.0),
          child: HeaderWidget(),
        ),
        bottomNavigationBar: const Footer(),
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 25.h,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 15.w),
                child: Responsive.isMobile(context)
                    ? Column(
                        children: [
                          SizedBox(
                            child: Align(
                              alignment: Alignment.topLeft,
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Responsive.isMobile(context)
                                      ? InkWell(
                                          splashColor: Colors.transparent,
                                          highlightColor: Colors.transparent,
                                          onTap: () {
                                            _receiveItemController.resetForm();
                                            Get.back();
                                          },
                                          child: const Icon(
                                              Icons.arrow_back_ios_new),
                                        )
                                      : IconButton(
                                          onPressed: () {
                                            _receiveItemController.resetForm();
                                            Get.back();
                                          },
                                          icon: const Icon(
                                              Icons.arrow_back_ios_new)),
                                  SizedBox(
                                    height: 10.w,
                                  ),
                                  Text(
                                    "Receive Item",
                                    style: Responsive.isDesktop(context)
                                        ? TextPalette.screenTitle
                                        : TextPalette.tableHeaderTextStyle,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      )
                    : Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                IconButton(
                                    onPressed: () {
                                      Get.back();
                                    },
                                    icon: const Icon(Icons.arrow_back_ios_new)),
                                SizedBox(
                                  width: 10.w,
                                ),
                                Text(
                                  "Receive Item",
                                  style: Responsive.isDesktop(context)
                                      ? TextPalette.screenTitle
                                      : TextPalette.tableHeaderTextStyle,
                                ),
                              ],
                            ),
                          ),
                          saveButton(context)
                        ],
                      ),
              ),
              SizedBox(
                height: 25.h,
              ),
              Align(alignment: Alignment.centerLeft, child: vendorDropDown()),
              SizedBox(
                height: 25.h,
              ),
              Container(
                height: 550.h,
                decoration: const BoxDecoration(
                  color: Colors.white,
                ),
                margin: EdgeInsets.symmetric(horizontal: 15.w),
                child: Stack(
                  children: [
                    Obx(() => _receiveItemController.isTableLoading.value
                        ? Padding(
                            padding: EdgeInsets.symmetric(horizontal: 7.w),
                            child: const LinearProgressIndicator(),
                          )
                        : ListView(
                            children: [
                              Obx(() => PaginatedDataTable(
                                    showEmptyRows: false,
                                    rowsPerPage: _receiveItemController
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
                                        'Repair Type',
                                        style: TextPalette.tableHeaderTextStyle,
                                      )),
                                      DataColumn(
                                          label: Text(
                                        'Item',
                                        style: TextPalette.tableHeaderTextStyle,
                                      )),
                                      DataColumn(
                                          label: Text(
                                        'Customer',
                                        style: TextPalette.tableHeaderTextStyle,
                                      )),
                                     
                                      DataColumn(
                                          label: Text(
                                        'Vendor ',
                                        style: TextPalette.tableHeaderTextStyle,
                                      )),
                                     
                                      DataColumn(
                                          label: Text(
                                        'Receive',
                                        style: TextPalette.tableHeaderTextStyle,
                                      )),
                                    ],
                                    source: _DataSource(context,
                                        _receiveItemController.tableData.value),
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
          ),
        ),
      ),
    );
  }

  SizedBox saveButton(BuildContext context) {
    return SizedBox(
      width: !Responsive.isMobile(context) ? 150.w : 150.w,
      child: Obx(
        () => PrimaryButton(
          btnHeight: Responsive.isMobile(context) ? 46.h : 46.h,
          isLoading: _receiveItemController.isSubmitLoading.value,
          text: 'Save',
          onPressed: () {
            _receiveItemController.isSubmitLoading(true);
            if (_receiveItemController.receiveItemList.isNotEmpty) {
              _receiveItemController.receiveItem();
            } else {
              toastification.show(
                  context: context,
                  type: ToastificationType.info,
                  title: const Text('Please add receive data'),
                  autoCloseDuration: notificationDuration,
                  showProgressBar: false,
                  pauseOnHover: false);
            }
            _receiveItemController.isSubmitLoading(false);
          },
        ),
      ),
    );
  }

  Widget vendorDropDown() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 15.w),
      child: SizedBox(
        width: 300.w,
        child: Obx(
          () => CustomDropdownField(
              hintText: 'Select Vendor',
              selectedValue: _receiveItemController.selectedVendor.value,
              onChanged: (value) {
                _receiveItemController.selectedVendor(value);
                _receiveItemController.getIssuedRepairItemTableList();
              },
              options: _receiveItemController.vendorDropDown.value),
        ),
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
                      value: _receiveItemController.itemsPerPage.value,
                      onChanged: (value) {
                        _receiveItemController.itemsPerPage(value);
                        _receiveItemController.getIssuedRepairItemTableList();
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
                      value: _receiveItemController.itemsPerPage.value,
                      onChanged: (value) {
                        _receiveItemController.itemsPerPage(value);
                        _receiveItemController.getIssuedRepairItemTableList();
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
                'Page ${_receiveItemController.page.value} of ${_receiveItemController.totalpages.value}',
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
                      onPressed: _receiveItemController.page.value > 1
                          ? () {
                              if (_receiveItemController.page.value > 1) {
                                _receiveItemController.page(
                                    _receiveItemController.page.value - 1);
                                _receiveItemController
                                    .getIssuedRepairItemTableList();
                              }
                            }
                          : null),
                  IconButton(
                      icon: Icon(Icons.arrow_forward,
                          size: Responsive.isDesktop(context) ||
                                  Responsive.isTablet(context)
                              ? 20.sp
                              : 15.sp),
                      onPressed: _receiveItemController.page.value <
                              _receiveItemController.totalpages.value
                          ? () {
                              if (_receiveItemController.page.value <
                                  _receiveItemController.totalpages.value) {
                                _receiveItemController.page(
                                    _receiveItemController.page.value + 1);
                                _receiveItemController
                                    .getIssuedRepairItemTableList();
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
                'Page ${_receiveItemController.page.value} of ${_receiveItemController.totalpages.value}',
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
                  onPressed: _receiveItemController.page.value > 1
                      ? () {
                          if (_receiveItemController.page.value > 1) {
                            _receiveItemController
                                .page(_receiveItemController.page.value - 1);
                            _receiveItemController
                                .getIssuedRepairItemTableList();
                          }
                        }
                      : null),
              IconButton(
                  icon: Icon(Icons.arrow_forward,
                      size: Responsive.isDesktop(context) ||
                              Responsive.isTablet(context)
                          ? 20.sp
                          : 15.sp),
                  onPressed: _receiveItemController.page.value <
                          _receiveItemController.totalpages.value
                      ? () {
                          if (_receiveItemController.page.value <
                              _receiveItemController.totalpages.value) {
                            _receiveItemController
                                .page(_receiveItemController.page.value + 1);
                            _receiveItemController
                                .getIssuedRepairItemTableList();
                          }
                        }
                      : null),
            ],
          ));
  }
}

class _DataSource extends DataTableSource {
  BuildContext context;
  List<IssuedRepairItemTableList> data;
  _DataSource(this.context, this.data);

  int _selectedCount = 0;

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
          row.repairType!,
          style: TextPalette.tableDataTextStyle,
        )),
        DataCell(Text(
          row.itemDetails.toString(),
          style: TextPalette.tableDataTextStyle,
        )),
        DataCell(Text(
          row.customerName.toString(),
          style: TextPalette.tableDataTextStyle,
        )),
       
        DataCell(Text(
          row.vendorName!,
          style: TextPalette.tableDataTextStyle,
        )),
        
       DataCell(GestureDetector(
          onTap: () {
            bool itemExists = _receiveItemController.receiveItemList.value
                .any((item) => item.id == row.id);
            if (itemExists) {
              _receiveItemController.addOrUpdateReceiveItem(
                  cusCharges: _receiveItemController.customerChargesController.text,
                  id: row.id!,
                  vendorCharges:_receiveItemController.vendorChargesController.text);
            } else {
              Get.dialog(
                barrierDismissible: false,
                ReceiveItemPopup(
                  index: index,
                  id: row.id!,
                ),
              );
            }
          },
          child: Obx(
            () {
              bool isReceived = _receiveItemController.receiveItemList.value
                  .any((item) => item.id == row.id);
              return Text(
                isReceived ? 'Unreceive' : 'Receive',
                style: TextStyle(
                  color: isReceived ? Colors.red : Colors.green,
                ),
              );
            },
          ),
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
