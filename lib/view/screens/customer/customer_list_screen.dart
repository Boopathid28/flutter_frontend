import 'package:ausales_application/controller/customer/customer_form_controller.dart';
import 'package:ausales_application/controller/customer/customer_list_controller.dart';
import 'package:ausales_application/core/constants/app_configuration.dart';
import 'package:ausales_application/core/keyboard_listeners/shortcut_keyboard_handler.dart';
import 'package:ausales_application/core/shared_preferences/home_shared_prefs.dart';
import 'package:ausales_application/core/theme/color_palette.dart';
import 'package:ausales_application/core/theme/text_palette.dart';
import 'package:ausales_application/model/customer/customer_models.dart';
import 'package:ausales_application/model/drop_down_model.dart';
import 'package:ausales_application/responsive.dart';
import 'package:ausales_application/service/customer/customer_service.dart';
import 'package:ausales_application/view/widgets/form_widgets/custom_switch.dart';
import 'package:ausales_application/view/widgets/form_widgets/primary_button.dart';
import 'package:ausales_application/view/widgets/layouts/end_menu_drawer_widget.dart';
import 'package:ausales_application/view/widgets/layouts/footer.dart';
import 'package:ausales_application/view/widgets/layouts/header.dart';
import 'package:ausales_application/view/widgets/screen_widgets/customer/customer_form.dart';
import 'package:ausales_application/view/widgets/screen_widgets/customer/customer_table_header.dart';
import 'package:ausales_application/view/widgets/screen_widgets/customer/delete_popup.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class CustomerListScreen extends StatefulWidget {
  @override
  State<CustomerListScreen> createState() => _CustomerListScreenState();
}

class _CustomerListScreenState extends State<CustomerListScreen> {
  final CustomerListController _customerListController =
      Get.put(CustomerListController());
  final CustomerFormController _customerFormController =
      Get.put(CustomerFormController());

  @override
  void initState() {
    super.initState();
    _customerListController.getcustomerlist(context);
  }

  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return ShorcutKeyboardHandler(
      scaffoldKey: _customerListController.scaffoldKey,
       onRefresh: () {
        _customerListController.getcustomerlist(context);
      },
      child: Scaffold(
        key: _customerListController.scaffoldKey,
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
                          "Customer",
                          style: TextPalette.screenTitle,
                        ),
                        SizedBox(
                          width: 10.w,
                        ),
                        IconButton(
                            onPressed: () {
                              _customerListController.getcustomerlist(context);
                            },
                            icon: Icon(Icons.refresh))
                      ],
                    ),
                    SizedBox(
                        width: 100.w,
                        child: PrimaryButton(
                            btnHeight: 46.h,
                            isLoading:
                                false,
                            text: "ADD+",
                            onPressed: () async {
                              await Get.dialog(
                                  barrierDismissible: false,
                                  CustomerFormPopup());
                            })),
                  ],
                ),
              ),
              CustomerTableHeader(),
              Container(
                height: 550.h,
                decoration: BoxDecoration(
                  color: Colors.white,
                ),
                margin: EdgeInsets.symmetric(horizontal: 15.w),
                child: Stack(
                  children: [
                    Obx(() => _customerListController.isTableLoading.value
                        ? Padding(
                            padding: EdgeInsets.symmetric(horizontal: 7.w),
                            child: LinearProgressIndicator(),
                          )
                        : ListView(
                            children: [
                              Obx(() => PaginatedDataTable(
                                showEmptyRows: false,
                                    rowsPerPage: _customerListController
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
                                        'Customer Name',
                                        style: TextPalette.tableHeaderTextStyle,
                                      )),
                                      DataColumn(
                                          label: Text(
                                        'Email',
                                        style: TextPalette.tableHeaderTextStyle,
                                      )),
                                      DataColumn(
                                          label: Text(
                                        'Mobile Number',
                                        style: TextPalette.tableHeaderTextStyle,
                                      )),
                                      DataColumn(
                                          label: Text(
                                        'Active',
                                        style: TextPalette.tableHeaderTextStyle,
                                      )),
                                      DataColumn(
                                          label: Text(
                                        'Created By',
                                        style: TextPalette.tableHeaderTextStyle,
                                      )),
                                      DataColumn(
                                          label: Text(
                                        'Customergroup Name',
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
                                        _customerListController
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
                value: _customerListController.itemsPerPage.value,
                onChanged: (value) {
                  _customerListController.itemsPerPage(value);
                  _customerListController.getcustomerlist(context);
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
              'Page ${_customerListController.page.value} of ${_customerListController.totalpages.value}',
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
                onPressed: _customerListController.page.value > 1
                    ? () {
                        if (_customerListController.page.value > 1) {
                          _customerListController
                              .page(_customerListController.page.value - 1);
                          _customerListController.getcustomerlist(context);
                        }
                      }
                    : null),
            IconButton(
                icon: Icon(Icons.arrow_forward,
                    size: Responsive.isDesktop(context) ||
                            Responsive.isTablet(context)
                        ? 20.sp
                        : 15.sp),
                onPressed: _customerListController.page.value <
                        _customerListController.totalpages.value
                    ? () {
                        if (_customerListController.page.value <
                            _customerListController.totalpages.value) {
                          _customerListController
                              .page(_customerListController.page.value + 1);
                          _customerListController.getcustomerlist(context);
                        }
                      }
                    : null),
          ],
        ));
  }
}

class _DataSource extends DataTableSource {
  BuildContext context;
  List<CustomerListData> data;
  _DataSource(this.context, this.data);

  int _selectedCount = 0;

  final CustomerFormController _customerFormController =
      Get.put(CustomerFormController());
  final CustomerListController _customerListController =
      Get.put(CustomerListController());

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
          row.customerName.toString(),
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
        DataCell(
          Tooltip(
            message: "Update Customer Status",
            child: CustomSwitch(value: row.isActive, onChanged: (index) async {
              int? menuId = await HomeSharedPrefs.getCurrentMenu();
              if (menuId != null) {
                await CustomerService.updateCustomerStatus(
                    menuId: menuId.toString(),
                    customerId: row.id.toString(),
                    context: context);
              }
              _customerListController.getcustomerlist(context);
            }),
          )
        ),
        DataCell(Text(
          row.createdBy.toString(),
          style: TextPalette.tableDataTextStyle,
        )),
        DataCell(Text(
          row.customerGroupName.toString(),
          style: TextPalette.tableDataTextStyle,
        )),
        DataCell(Row(
          children: [
            Tooltip(
              message: "Edit Customer",
              child: IconButton(onPressed:() async {
                  _customerFormController.customerNamecontroller.text =
                      row.customerName ?? "";
                  _customerFormController.pannumbercontroller.text =
                      row.panNumber ?? "" ;
                  _customerFormController.addresscontroller.text = row.address ?? "";
                  _customerFormController.aadharnumbercontroller.text =
                      row.aadharNumber ?? "";
                  _customerFormController.gstnumbercontroller.text =
                      row.gstNumber ?? "";
                  _customerFormController.mobilenumbercontroller.text =
                      row.mobileNumber ?? "";
                  _customerFormController.selectedCustomergroup(DropdownModel(
                      value: row.customerGroup.toString(),
                      label: row.customerGroupName!));
                  _customerFormController.dobcontroller.text = row.dob ?? "";
                  _customerFormController.emailcontroller.text = row.email ?? "";
                  _customerFormController.upiidcontroller.text = row.upiId ?? "";
                 _customerFormController.selectedMarriageStatus(DropdownModel(
                      value: row.maritalStatus.toString(),
                      label: row.maritalStatus!));
                  _customerFormController.currentCustomer(row);
                  _customerFormController.fromMode("update");
                  await Get.dialog(
                    barrierDismissible: false,
                    CustomerFormPopup(),
                  );
                },
            icon: Icon(Icons.edit)),
            ),
            SizedBox(
              width: 10.w,
            ),
            Tooltip(
              message: "Delete Customer",
              child: GestureDetector(
                onTap: () async {
                  await Get.dialog(
                      barrierDismissible: false,
                      CustomerDeletePopup(customer: row));
                },
                child: Icon(Icons.delete)),
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
