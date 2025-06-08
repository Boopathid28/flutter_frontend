import 'package:ausales_application/controller/expense_account/expense_account_form_controller.dart';
import 'package:ausales_application/controller/expense_account/expense_account_list_controller.dart';
import 'package:ausales_application/core/constants/app_configuration.dart';
import 'package:ausales_application/core/keyboard_listeners/shortcut_keyboard_handler.dart';
import 'package:ausales_application/core/shared_preferences/home_shared_prefs.dart';
import 'package:ausales_application/core/theme/color_palette.dart';
import 'package:ausales_application/core/theme/text_palette.dart';
import 'package:ausales_application/model/expense/expense_models.dart';
import 'package:ausales_application/responsive.dart';
import 'package:ausales_application/service/expense_account/expense_account_service.dart';
import 'package:ausales_application/view/widgets/form_widgets/custom_switch.dart';
import 'package:ausales_application/view/widgets/layouts/end_menu_drawer_widget.dart';
import 'package:ausales_application/view/widgets/layouts/footer.dart';
import 'package:ausales_application/view/widgets/layouts/header.dart';
import 'package:ausales_application/view/widgets/screen_widgets/expense/delete_popup.dart';
import 'package:ausales_application/view/widgets/screen_widgets/expense/expense_account_form.dart';
import 'package:ausales_application/view/widgets/screen_widgets/expense/expense_account_table_header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class ExpenseListScreen extends StatefulWidget {
  @override
  State<ExpenseListScreen> createState() => _ExpenseListScreenState();
}

class _ExpenseListScreenState extends State<ExpenseListScreen> {
  final ExpenseAccountListController _expenseAccountListController = Get.put(ExpenseAccountListController());

  @override
  void initState() {
    super.initState();
    _expenseAccountListController.getExpenseAccountList(context);
  }

  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return ShorcutKeyboardHandler(
      scaffoldKey: _expenseAccountListController.scaffoldKey,
      onRefresh: () {
        _expenseAccountListController.getExpenseAccountList(context);
      },
      child: Scaffold(
         key: _expenseAccountListController.scaffoldKey,
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
                        "Expense Account",
                        style: TextPalette.screenTitle,
                      ),
                      SizedBox(width: 10.w,),
                      IconButton(
                        onPressed: () {
                          _expenseAccountListController.getExpenseAccountList(context);
                        },
                        icon: Icon(Icons.refresh)
                      )
                    ],
                  ),
                ),
              ExpenseAccountForm(),
              ExpenseAccountTableHeader(),
              Container(
                height: 550.h,
                decoration: BoxDecoration(
                    color: Colors.white,),
                margin: EdgeInsets.symmetric(horizontal: 15.w),
                child: Stack(
                  children: [
                    Obx(() => _expenseAccountListController.isTableLoading.value ? Padding(
                        padding: EdgeInsets.symmetric(horizontal: 7.w),
                        child: LinearProgressIndicator(),
                      ) :
                    ListView(
                      children: [
                        Obx(() => PaginatedDataTable(
                          showEmptyRows: false,
                              rowsPerPage: _expenseAccountListController.itemsPerPage.value,
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
                                  'Expense name',
                                  style: TextPalette.tableHeaderTextStyle,
                                )),
                                DataColumn(
                                    label: Text(
                                  'Created By',
                                  style: TextPalette.tableHeaderTextStyle,
                                )),
                                DataColumn(
                                    label: Text(
                                  'Active',
                                  style: TextPalette.tableHeaderTextStyle,
                                )),
                                DataColumn(
                                    label: Text(
                                  'Action',
                                  style: TextPalette.tableHeaderTextStyle,
                                )),
                              ],
                              source: _DataSource(
                                  context, _expenseAccountListController.tableData.value),
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
                            SizedBox(width: 5.w,),
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
                fontSize: Responsive.isDesktop(context) || Responsive.isTablet(context) ? 12.sp : 10.sp),
          ),
          SizedBox(
            width: 15.w,
          ),
          Obx(() => DropdownButton<int>(
                value: _expenseAccountListController.itemsPerPage.value,
                onChanged: (value) {
                  _expenseAccountListController.itemsPerPage(value);
                  _expenseAccountListController.getExpenseAccountList(context);
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
              'Page ${_expenseAccountListController.page.value} of ${_expenseAccountListController.totalpages.value}',
              style: TextStyle(
                  fontSize: Responsive.isDesktop(context) || Responsive.isTablet(context) ? 12.sp : 10.sp),
            ),
            IconButton(
                icon: Icon(Icons.arrow_back, size: Responsive.isDesktop(context) || Responsive.isTablet(context) ? 20.sp : 15.sp),
                onPressed: _expenseAccountListController.page.value > 1
                    ? () {
                        if (_expenseAccountListController.page.value > 1) {
                          _expenseAccountListController
                              .page(_expenseAccountListController.page.value - 1);
                          _expenseAccountListController.getExpenseAccountList(context);
                        }
                      }
                    : null),
            IconButton(
                icon: Icon(Icons.arrow_forward, size: Responsive.isDesktop(context) || Responsive.isTablet(context) ? 20.sp : 15.sp),
                onPressed: _expenseAccountListController.page.value <
                        _expenseAccountListController.totalpages.value
                    ? () {
                        if (_expenseAccountListController.page.value <
                            _expenseAccountListController.totalpages.value) {
                          _expenseAccountListController
                              .page(_expenseAccountListController.page.value + 1);
                          _expenseAccountListController.getExpenseAccountList(context);
                        }
                      }
                    : null),
          ],
        ));
  }
}

class _DataSource extends DataTableSource {
  BuildContext context;
  List<ExpenseAccoutListData> data;
  _DataSource(this.context, this.data);

  int _selectedCount = 0;

  final ExpenseAccountFormController _expenseAccountFormController = Get.put(ExpenseAccountFormController());
  final ExpenseAccountListController _expenseAccountListController = Get.put(ExpenseAccountListController());

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
          row.expensesName.toString(),
          style: TextPalette.tableDataTextStyle,
        )),
        DataCell(Text(
          row.createdBy.toString(),
          style: TextPalette.tableDataTextStyle,
        )),
        DataCell(
          CustomSwitch(value: row.isActive, onChanged: (index) async {
              int? menuId = await HomeSharedPrefs.getCurrentMenu();
              if (menuId != null) {
                await ExpenseAccountService.updateExpenseaccountStatus(
                  menuId: menuId.toString(),
                    expenseId: row.id.toString(),
                    context: context);
              }
              _expenseAccountListController.getExpenseAccountList(context);
            })
        ),
        DataCell(Row(
          children: [
            IconButton(onPressed: () {
               _expenseAccountFormController.expenseNameController.text = row.expensesName!;
                _expenseAccountFormController.currentExpense(row);
                  _expenseAccountFormController.fromMode("update");
                },
            icon: Icon(Icons.edit)),
            SizedBox(
              width: 10.w,
            ),
            GestureDetector(
                onTap: () async {
                  await Get.dialog(
                      barrierDismissible: false,
                      ExpenseDeletePopup(expense: row));
                },
                child: Icon(Icons.delete)),
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
