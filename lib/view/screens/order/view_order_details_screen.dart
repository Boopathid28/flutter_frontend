import 'package:ausales_application/controller/order/view_order_details_controller.dart';
import 'package:ausales_application/core/constants/app_configuration.dart';
import 'package:ausales_application/core/theme/color_palette.dart';
import 'package:ausales_application/core/theme/text_palette.dart';
import 'package:ausales_application/responsive.dart';
import 'package:ausales_application/utils/date_helper.dart';
import 'package:ausales_application/view/widgets/form_widgets/custom_dropdown_search_field.dart';
import 'package:ausales_application/view/widgets/form_widgets/custom_label.dart';
import 'package:ausales_application/view/widgets/form_widgets/custom_text_input.dart';
import 'package:ausales_application/view/widgets/form_widgets/primary_button.dart';
import 'package:ausales_application/view/widgets/layouts/end_menu_drawer_widget.dart';
import 'package:ausales_application/view/widgets/layouts/footer.dart';
import 'package:ausales_application/view/widgets/layouts/header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:toastification/toastification.dart';

class ViewOrderDetailsScreen extends StatefulWidget {
  const ViewOrderDetailsScreen({super.key});

  @override
  State<ViewOrderDetailsScreen> createState() => _ViewOrderDetailsScreenState();
}

class _ViewOrderDetailsScreenState extends State<ViewOrderDetailsScreen> {
  final ViewOrderDetailsController _viewOrderDetailsController =
      Get.put(ViewOrderDetailsController());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    final args = Get.arguments;
    _viewOrderDetailsController.getOrderDetails(context, args.toString());
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Scaffold(
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
              height: 25.h,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 15.w),
              child: Row(
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
                            icon: Icon(Icons.arrow_back_ios_new)),
                        SizedBox(
                          width: 10.w,
                        ),
                        Text(
                          "View Order Details",
                          style: Responsive.isDesktop(context)
                              ? TextPalette.screenTitle
                              : TextPalette.tableHeaderTextStyle,
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            orderDetails(),
            Container(
              margin: EdgeInsets.all(15.w),
              padding: EdgeInsets.all(10.w),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10.r)),
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                      padding: EdgeInsets.symmetric(vertical: 10.h),
                      width: double.infinity,
                      decoration:
                          BoxDecoration(border: Border(bottom: BorderSide())),
                      child: Text(
                        "Payment Details ",
                        style: TextStyle(
                            fontSize: 14.sp, fontWeight: FontWeight.w600),
                      )),
                  SizedBox(
                    height: 10.h,
                  ),
                  Wrap(
                    runSpacing: 10.h,
                    spacing: 10.w,
                    children: [
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            "Total Amount : ",
                            style: TextStyle(
                                fontSize: 14.sp, fontWeight: FontWeight.w600),
                          ),
                          Obx(() => Text(
                                _viewOrderDetailsController
                                    .orderDetails.value.totalAmount
                                    .toString(),
                                style: TextStyle(fontSize: 14.sp),
                              ))
                        ],
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            "GST Amount : ",
                            style: TextStyle(
                                fontSize: 14.sp, fontWeight: FontWeight.w600),
                          ),
                          Obx(() => Text(
                                _viewOrderDetailsController
                                    .orderDetails.value.gstAmount
                                    .toString(),
                                style: TextStyle(fontSize: 14.sp),
                              ))
                        ],
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            "Payable Amount : ",
                            style: TextStyle(
                                fontSize: 14.sp, fontWeight: FontWeight.w600),
                          ),
                          Obx(() => Text(
                                _viewOrderDetailsController
                                    .orderDetails.value.payableAmount
                                    .toString(),
                                style: TextStyle(fontSize: 14.sp),
                              ))
                        ],
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            "Paid Amount : ",
                            style: TextStyle(
                                fontSize: 14.sp, fontWeight: FontWeight.w600),
                          ),
                          Obx(() => Text(
                                _viewOrderDetailsController
                                    .orderDetails.value.paidAmount
                                    .toString(),
                                style: TextStyle(fontSize: 14.sp),
                              ))
                        ],
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            "Balance Amount : ",
                            style: TextStyle(
                                fontSize: 14.sp, fontWeight: FontWeight.w600),
                          ),
                          Obx(() => Text(
                                _viewOrderDetailsController
                                    .orderDetails.value.balanceAmount
                                    .toString(),
                                style: TextStyle(fontSize: 14.sp),
                              ))
                        ],
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 15.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Not Issued Items',
                    style: TextPalette.screenTitle,
                  ),
                  Obx(() => PrimaryButton(
                      onPressed: _viewOrderDetailsController
                            .notissuedItemDetails.isEmpty ? null : () async {
                        bool isValid = true;
                        for (var i in _viewOrderDetailsController
                            .notissuedItemDetails) {
                          if (i.isCheck ?? false) {
                            isValid = true;
                            break;
                          } else {
                            isValid = false;
                          }
                        }
                        if (isValid) {
                          await Get.dialog(
                              barrierDismissible: false,
                              assignVendorForm());
                        } else {
                          toastification.show(
                              context: context,
                              type: ToastificationType.error,
                              title: Text("select atleast one item"),
                              autoCloseDuration: notificationDuration,
                              showProgressBar: false,
                              pauseOnHover: false);
                        }
                      },
                      btnWidth: 150.w,
                      isLoading: false,
                      text: "Assign Items"))
                ],
              ),
            ),
            notAssignItemDetails(context, size),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 15.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Issued Items',
                    style: TextPalette.screenTitle,
                  ),
                  Obx(() => PrimaryButton(
                      onPressed: _viewOrderDetailsController
                            .issuedItemDetails.isEmpty ? null : () {
                        _viewOrderDetailsController.recievedOrderItems(context);
                      },
                      btnWidth: 150.w,
                      isLoading:
                          _viewOrderDetailsController.isRecievedLoading.value,
                      text: "Recieve Items"))
                ],
              ),
            ),
            assignedItemDetails(context, size),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 15.w),
              child: Text(
                'Recieved Items',
                style: TextPalette.screenTitle,
              ),
            ),
            recievedItemDetails(context, size)
          ],
        ),
      ),
    );
  }

  AlertDialog assignVendorForm() {
    return AlertDialog(
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Assign Vendor',
            style: TextPalette.screenTitle,
          ),
          IconButton(
              onPressed: () {
                _viewOrderDetailsController.resetVendorAssign();
                Get.back();
              },
              icon: Icon(Icons.close))
        ],
      ),
      content: Container(
        width: 300.w,
        child: Wrap(
          spacing: 15.w,
          runSpacing: 15.h,
          children: [vendor(), dueDate()],
        ),
      ),
      actions: [
        Obx(() => PrimaryButton(
            onPressed: () async {
              _viewOrderDetailsController.assignOrderItems(context);
            },
            btnWidth: 150.w,
            isLoading: _viewOrderDetailsController.isAssignLoading.value,
            text: "Assign Items"))
      ],
    );
  }

  SizedBox dueDate() {
    return SizedBox(
      width: 300.w,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomLabel(label: "Due Date"),
          SizedBox(height: 7.h),
          CustomTextInput(
            readOnly: true,
            onTap: () async {
              final today = DateTime.now();
              final endYear = today.year + 1;
              DateTime? pickedDate = await showDatePicker(
                  context: context,
                  initialDate: today,
                  firstDate: DateTime(1900),
                  lastDate: DateTime(endYear));
              if (pickedDate != null) {
                _viewOrderDetailsController.dueDateController.text =
                    pickedDate.toString().substring(0, 10);
              } else {
                _viewOrderDetailsController.dueDateController.clear();
              }
            },
            controller: _viewOrderDetailsController.dueDateController,
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.text,
            validator: "default",
            hintText: "Due Date",
          ),
        ],
      ),
    );
  }

  SizedBox vendor() {
    return SizedBox(
      width: 300.w,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomLabel(label: "Vendor"),
          SizedBox(
            height: 7.w,
          ),
          Obx(() => CustomDropdownSearchField(
                controller: _viewOrderDetailsController.vendorSearchController,
                selectedValue: _viewOrderDetailsController.selectedVendor.value,
                options: _viewOrderDetailsController.vendorDropDown.value,
                onChanged: (value) {
                  _viewOrderDetailsController.selectedVendor(value);
                },
                hintText: "Vendor",
              ))
        ],
      ),
    );
  }

  Container recievedItemDetails(BuildContext context, Size size) {
    return Container(
      margin: EdgeInsets.all(15.w),
      padding: EdgeInsets.all(10.w),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(10.r)),
      width: double.infinity,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: SizedBox(
          width: Responsive.isDesktop(context) ? size.width : null,
          child: Obx(() => _viewOrderDetailsController
                  .isRecievedTableLoading.value
              ? Padding(
                  padding: EdgeInsets.symmetric(horizontal: 0),
                  child: Center(child: CircularProgressIndicator()),
                )
              : DataTable(
                  headingRowColor: WidgetStateProperty.resolveWith<Color?>(
                      (Set<WidgetState> states) =>
                          ColorPalete.tableHeaderBgColor),
                  columns: [
                    DataColumn(
                      label: SizedBox(
                        width: 125.w,
                        child: Text(
                          'Item Name',
                          style: TextPalette.tableHeaderTextStyle,
                        ),
                      ),
                    ),
                    DataColumn(
                      label: SizedBox(
                        width: 125.w,
                        child: Text(
                          'Gross Weight',
                          style: TextPalette.tableHeaderTextStyle,
                        ),
                      ),
                    ),
                    DataColumn(
                      label: SizedBox(
                        width: 100.w,
                        child: Text(
                          'Net Weight',
                          style: TextPalette.tableHeaderTextStyle,
                        ),
                      ),
                    ),
                    DataColumn(
                      label: SizedBox(
                        width: 125.w,
                        child: Text(
                          'Pieces',
                          style: TextPalette.tableHeaderTextStyle,
                        ),
                      ),
                    ),
                    DataColumn(
                      label: SizedBox(
                        width: 125.w,
                        child: Text(
                          'Priority',
                          style: TextPalette.tableHeaderTextStyle,
                        ),
                      ),
                    ),
                    DataColumn(
                      label: SizedBox(
                        width: 125.w,
                        child: Text(
                          'Vendor',
                          style: TextPalette.tableHeaderTextStyle,
                        ),
                      ),
                    ),
                    DataColumn(
                      label: SizedBox(
                        width: 125.w,
                        child: Text(
                          'Due Date',
                          style: TextPalette.tableHeaderTextStyle,
                        ),
                      ),
                    ),
                    DataColumn(
                      label: SizedBox(
                        width: 125.w,
                        child: Text(
                          'gender',
                          style: TextPalette.tableHeaderTextStyle,
                        ),
                      ),
                    ),
                    DataColumn(
                      label: SizedBox(
                        width: 125.w,
                        child: Text(
                          'Images',
                          style: TextPalette.tableHeaderTextStyle,
                        ),
                      ),
                    ),
                  ],
                  rows: _viewOrderDetailsController.receivedItemDetails.value
                      .map((item) {
                    return DataRow(cells: [
                      DataCell(SizedBox(
                          width: 100.w,
                          child: Text(item.itemDetailsName.toString()))),
                      DataCell(SizedBox(
                          width: 100.w,
                          child: Text(item.grossWeight.toString()))),
                      DataCell(SizedBox(
                          width: 100.w,
                          child: Text(item.netWeight.toString()))),
                      DataCell(SizedBox(
                          width: 100.w, child: Text(item.pieces.toString()))),
                      DataCell(SizedBox(
                          width: 100.w, child: Text(item.priority.toString()))),
                      DataCell(SizedBox(
                          width: 100.w, child: Text(item.vendorName.toString()))),
                      DataCell(SizedBox(
                          width: 100.w, child: Text(DateHelper.convertDate(item.dueDate.toString())))),
                      DataCell(SizedBox(
                          width: 100.w, child: Text(item.gender.toString()))),
                      DataCell(GestureDetector(
                        onTap: () async {
                          await Get.dialog(
                              AlertDialog(
                                    title: Text("Order Images"),
                                    content: Container(
                                      height: 400.h,
                                      width: 300.w,
                                      child: item.imagePath!.length > 0
                                          ? ListView.separated(
                                              itemCount: item.imagePath!.length,
                                              separatorBuilder:
                                                  (context, index) => SizedBox(
                                                height: 5.h,
                                              ),
                                              itemBuilder: (context, index) {
                                                return Card(
                                                  child: Image(
                                                    image: NetworkImage(
                                                        "${baseUrl}/${item.imagePath![index].imagePath}"),
                                                    width: 200.w,
                                                    height: 200.w,
                                                  ),
                                                );
                                              },
                                            )
                                          : Center(child: Text("No images")),
                                    ),
                                  ));
                        },
                        child:
                            SizedBox(width: 100.w, child: Text("Show Images")),
                      )),
                    ]);
                  }).toList(),
                )),
        ),
      ),
    );
  }

  Container assignedItemDetails(BuildContext context, Size size) {
    return Container(
      margin: EdgeInsets.all(15.w),
      padding: EdgeInsets.all(10.w),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(10.r)),
      width: double.infinity,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: SizedBox(
          width: Responsive.isDesktop(context) ? size.width : null,
          child: Obx(() => _viewOrderDetailsController
                  .isAssignTableLoading.value
              ? Padding(
                  padding: EdgeInsets.symmetric(horizontal: 0),
                  child: Center(child: CircularProgressIndicator()),
                )
              : DataTable(
                  headingRowColor: WidgetStateProperty.resolveWith<Color?>(
                      (Set<WidgetState> states) =>
                          ColorPalete.tableHeaderBgColor),
                  columns: [
                    DataColumn(
                      label: SizedBox(
                        width: 50.w,
                        child: Checkbox(
                            value:
                                _viewOrderDetailsController.isRecievedAll.value,
                            onChanged: (bool? value) {
                              _viewOrderDetailsController
                                  .checkAllForRecieved(value!);
                            }),
                      ),
                    ),
                    DataColumn(
                      label: SizedBox(
                        width: 125.w,
                        child: Text(
                          'Item Name',
                          style: TextPalette.tableHeaderTextStyle,
                        ),
                      ),
                    ),
                    DataColumn(
                      label: SizedBox(
                        width: 125.w,
                        child: Text(
                          'Gross Weight',
                          style: TextPalette.tableHeaderTextStyle,
                        ),
                      ),
                    ),
                    DataColumn(
                      label: SizedBox(
                        width: 100.w,
                        child: Text(
                          'Net Weight',
                          style: TextPalette.tableHeaderTextStyle,
                        ),
                      ),
                    ),
                    DataColumn(
                      label: SizedBox(
                        width: 125.w,
                        child: Text(
                          'Pieces',
                          style: TextPalette.tableHeaderTextStyle,
                        ),
                      ),
                    ),
                    DataColumn(
                      label: SizedBox(
                        width: 125.w,
                        child: Text(
                          'Priority',
                          style: TextPalette.tableHeaderTextStyle,
                        ),
                      ),
                    ),
                    DataColumn(
                      label: SizedBox(
                        width: 125.w,
                        child: Text(
                          'Vendor',
                          style: TextPalette.tableHeaderTextStyle,
                        ),
                      ),
                    ),
                    DataColumn(
                      label: SizedBox(
                        width: 125.w,
                        child: Text(
                          'Due Date',
                          style: TextPalette.tableHeaderTextStyle,
                        ),
                      ),
                    ),
                    DataColumn(
                      label: SizedBox(
                        width: 125.w,
                        child: Text(
                          'gender',
                          style: TextPalette.tableHeaderTextStyle,
                        ),
                      ),
                    ),
                    DataColumn(
                      label: SizedBox(
                        width: 125.w,
                        child: Text(
                          'Images',
                          style: TextPalette.tableHeaderTextStyle,
                        ),
                      ),
                    ),
                  ],
                  rows: _viewOrderDetailsController.issuedItemDetails.value
                      .map((item) {
                    return DataRow(cells: [
                      DataCell(SizedBox(
                        width: 50.w,
                        child: Checkbox(
                            value: item.isCheck ?? false,
                            onChanged: (bool? value) {
                              _viewOrderDetailsController.onRecievedChecked(
                                  value!, item.id!, context);
                            }),
                      )),
                      DataCell(SizedBox(
                          width: 100.w,
                          child: Text(item.itemDetailsName.toString()))),
                      DataCell(SizedBox(
                          width: 100.w,
                          child: Text(item.grossWeight.toString()))),
                      DataCell(SizedBox(
                          width: 100.w,
                          child: Text(item.netWeight.toString()))),
                      DataCell(SizedBox(
                          width: 100.w, child: Text(item.pieces.toString()))),
                      DataCell(SizedBox(
                          width: 100.w, child: Text(item.priority.toString()))),
                      DataCell(SizedBox(
                          width: 100.w, child: Text(item.vendorName??"-"))),
                      DataCell(SizedBox(
                          width: 100.w, child: Text(DateHelper.convertDate(item.dueDate.toString())))),
                      DataCell(SizedBox(
                          width: 100.w, child: Text(item.gender.toString()))),
                      DataCell(GestureDetector(
                        onTap: () async {
                          await Get.dialog(
                              AlertDialog(
                                    title: Text("Order Images"),
                                    content: Container(
                                      height: 400.h,
                                      width: 300.w,
                                      child: item.imagePath!.length > 0
                                          ? ListView.separated(
                                              itemCount: item.imagePath!.length,
                                              separatorBuilder:
                                                  (context, index) => SizedBox(
                                                height: 5.h,
                                              ),
                                              itemBuilder: (context, index) {
                                                return Card(
                                                  child: Image(
                                                    image: NetworkImage(
                                                        "${baseUrl}/${item.imagePath![index].imagePath}"),
                                                    width: 200.w,
                                                    height: 200.w,
                                                  ),
                                                );
                                              },
                                            )
                                          : Center(child: Text("No images")),
                                    ),
                                  ));
                        },
                        child:
                            SizedBox(width: 100.w, child: Text("Show Images")),
                      )),
                    ]);
                  }).toList(),
                )),
        ),
      ),
    );
  }

  Container notAssignItemDetails(BuildContext context, Size size) {
    return Container(
      margin: EdgeInsets.all(15.w),
      padding: EdgeInsets.all(10.w),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(10.r)),
      width: double.infinity,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: SizedBox(
          width: Responsive.isDesktop(context) ? size.width : null,
          child: Obx(() => _viewOrderDetailsController
                  .isNotAssignTableLoading.value
              ? Padding(
                  padding: EdgeInsets.symmetric(horizontal: 0),
                  child: Center(child: CircularProgressIndicator()),
                )
              : DataTable(
                  headingRowColor: WidgetStateProperty.resolveWith<Color?>(
                      (Set<WidgetState> states) =>
                          ColorPalete.tableHeaderBgColor),
                  columns: [
                    DataColumn(
                      label: SizedBox(
                        width: 50.w,
                        child: Checkbox(
                            value:
                                _viewOrderDetailsController.isAssignAll.value,
                            onChanged: (bool? value) {
                              _viewOrderDetailsController
                                  .checkAllForAssign(value!);
                            }),
                      ),
                    ),
                    DataColumn(
                      label: SizedBox(
                        width: 125.w,
                        child: Text(
                          'Item Name',
                          style: TextPalette.tableHeaderTextStyle,
                        ),
                      ),
                    ),
                    DataColumn(
                      label: SizedBox(
                        width: 125.w,
                        child: Text(
                          'Gross Weight',
                          style: TextPalette.tableHeaderTextStyle,
                        ),
                      ),
                    ),
                    DataColumn(
                      label: SizedBox(
                        width: 100.w,
                        child: Text(
                          'Net Weight',
                          style: TextPalette.tableHeaderTextStyle,
                        ),
                      ),
                    ),
                    DataColumn(
                      label: SizedBox(
                        width: 125.w,
                        child: Text(
                          'Pieces',
                          style: TextPalette.tableHeaderTextStyle,
                        ),
                      ),
                    ),
                    DataColumn(
                      label: SizedBox(
                        width: 125.w,
                        child: Text(
                          'Priority',
                          style: TextPalette.tableHeaderTextStyle,
                        ),
                      ),
                    ),
                    DataColumn(
                      label: SizedBox(
                        width: 125.w,
                        child: Text(
                          'Vendor',
                          style: TextPalette.tableHeaderTextStyle,
                        ),
                      ),
                    ),
                    DataColumn(
                      label: SizedBox(
                        width: 125.w,
                        child: Text(
                          'Due Date',
                          style: TextPalette.tableHeaderTextStyle,
                        ),
                      ),
                    ),
                    DataColumn(
                      label: SizedBox(
                        width: 125.w,
                        child: Text(
                          'gender',
                          style: TextPalette.tableHeaderTextStyle,
                        ),
                      ),
                    ),
                    DataColumn(
                      label: SizedBox(
                        width: 125.w,
                        child: Text(
                          'Images',
                          style: TextPalette.tableHeaderTextStyle,
                        ),
                      ),
                    ),
                  ],
                  rows: _viewOrderDetailsController.notissuedItemDetails.value
                      .map((item) {
                    return DataRow(cells: [
                      DataCell(SizedBox(
                        width: 50.w,
                        child: Checkbox(
                            value: item.isCheck ?? false,
                            onChanged: (bool? value) {
                              _viewOrderDetailsController.onAssignChecked(
                                  value!, item.id!, context);
                            }),
                      )),
                      DataCell(SizedBox(
                          width: 100.w,
                          child: Text(item.itemDetailsName.toString()))),
                      DataCell(SizedBox(
                          width: 100.w,
                          child: Text(item.grossWeight.toString()))),
                      DataCell(SizedBox(
                          width: 100.w,
                          child: Text(item.netWeight.toString()))),
                      DataCell(SizedBox(
                          width: 100.w, child: Text(item.pieces.toString()))),
                      DataCell(SizedBox(
                          width: 100.w, child: Text(item.priority.toString()))),
                      DataCell(SizedBox(
                          width: 100.w, child: Text(item.vendorName??"-"))),
                      DataCell(SizedBox(
                          width: 100.w, child: Text(DateHelper.convertDate(item.dueDate.toString())))),
                      DataCell(SizedBox(
                          width: 100.w, child: Text(item.gender.toString()))),
                      DataCell(GestureDetector(
                        onTap: () async {
                          await Get.dialog(
                              AlertDialog(
                                    title: Text("Order Images"),
                                    content: Container(
                                      height: 400.h,
                                      width: 300.w,
                                      child: item.imagePath!.length > 0
                                          ? ListView.separated(
                                              itemCount: item.imagePath!.length,
                                              separatorBuilder:
                                                  (context, index) => SizedBox(
                                                height: 5.h,
                                              ),
                                              itemBuilder: (context, index) {
                                                return Card(
                                                  child: Image(
                                                    image: NetworkImage(
                                                        "${baseUrl}/${item.imagePath![index].imagePath}"),
                                                    width: 200.w,
                                                    height: 200.w,
                                                  ),
                                                );
                                              },
                                            )
                                          : Center(child: Text("No images")),
                                    ),
                                  ));
                        },
                        child:
                            SizedBox(width: 100.w, child: Text("Show Images")),
                      )),
                    ]);
                  }).toList(),
                )),
        ),
      ),
    );
  }

  Container orderDetails() {
    return Container(
      margin: EdgeInsets.all(15.w),
      padding: EdgeInsets.all(10.w),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(10.r)),
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
              padding: EdgeInsets.symmetric(vertical: 10.h),
              width: double.infinity,
              decoration: BoxDecoration(border: Border(bottom: BorderSide())),
              child: Text(
                "Order Details ",
                style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w600),
              )),
          SizedBox(
            height: 10.h,
          ),
          Wrap(
            runSpacing: 10.h,
            spacing: 10.w,
            children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "Order No : ",
                    style:
                        TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w600),
                  ),
                  Obx(() => Text(
                        _viewOrderDetailsController.orderDetails.value.orderId
                            .toString(),
                        style: TextStyle(fontSize: 14.sp),
                      ))
                ],
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "Customer Name : ",
                    style:
                        TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w600),
                  ),
                  Obx(() => Text(
                        _viewOrderDetailsController
                            .orderDetails.value.customerName
                            .toString(),
                        style: TextStyle(fontSize: 14.sp),
                      ))
                ],
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "Customer Address : ",
                    style:
                        TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w600),
                  ),
                  Obx(() => Text(
                        _viewOrderDetailsController
                            .orderDetails.value.customerAddress
                            .toString(),
                        style: TextStyle(fontSize: 14.sp),
                      ))
                ],
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "Customer Mobile : ",
                    style:
                        TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w600),
                  ),
                  Obx(() => Text(
                        _viewOrderDetailsController
                            .orderDetails.value.customerPhone
                            .toString(),
                        style: TextStyle(fontSize: 14.sp),
                      ))
                ],
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "Due Date : ",
                    style:
                        TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w600),
                  ),
                  Obx(() => Text(
                        DateHelper.convertDate(_viewOrderDetailsController
                                .orderDetails.value.dueDate ??
                            ""),
                        style: TextStyle(fontSize: 14.sp),
                      ))
                ],
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "Fixed Rate : ",
                    style:
                        TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w600),
                  ),
                  Obx(() => Text(
                        "${_viewOrderDetailsController.orderDetails.value.isFixed ?? false ? "Yes" : "No"}",
                        style: TextStyle(fontSize: 14.sp),
                      ))
                ],
              ),
            ],
          ),
          SizedBox(
            height: 10.h,
          ),
        ],
      ),
    );
  }
}
