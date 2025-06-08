import 'package:ausales_application/controller/order/view_order_details_controller.dart';
import 'package:ausales_application/controller/repair_creation/view_repair_details_controller.dart';
import 'package:ausales_application/core/theme/color_palette.dart';
import 'package:ausales_application/core/theme/text_palette.dart';
import 'package:ausales_application/responsive.dart';
import 'package:ausales_application/utils/date_helper.dart';
import 'package:ausales_application/view/widgets/layouts/end_menu_drawer_widget.dart';
import 'package:ausales_application/view/widgets/layouts/footer.dart';
import 'package:ausales_application/view/widgets/layouts/header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class ViewRepairDetailsScreen extends StatefulWidget {
  const ViewRepairDetailsScreen({super.key});

  @override
  State<ViewRepairDetailsScreen> createState() => _ViewRepairDetailsScreenState();
}

class _ViewRepairDetailsScreenState extends State<ViewRepairDetailsScreen> {
  final ViewRepairDetailsController _viewRepairDetailsController =
      Get.put(ViewRepairDetailsController());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _viewRepairDetailsController.getRepairDetails(context);
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
                          "View Repair Details",
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
            repairdetails(),
            Container(
              margin: EdgeInsets.all(15.w),
              padding: EdgeInsets.all(10.w),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10.r)
              ),
              width: double.infinity,
              child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: EdgeInsets.symmetric(vertical: 10.h),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    border: Border(bottom: BorderSide())
                  ),
                  child: Text("Payment Details ", style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w600),)),
                SizedBox(height: 10.h,),
                Wrap(
                  runSpacing: 10.h,
                  spacing: 10.w,
                  children: [
                    Row(mainAxisSize: MainAxisSize.min, children: [
                      Text("Total Customer Amount : ", style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w600),),
                      Obx(() => Text(_viewRepairDetailsController.repairdetails.value.totalCustomerCharges.toString(), style: TextStyle(fontSize: 14.sp),))
                    ],),
                    Row(mainAxisSize: MainAxisSize.min, children: [
                      Text("Advance Amount : ", style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w600),),
                      Obx(() => Text(_viewRepairDetailsController.repairdetails.value.totalAdvanceAmount.toString(), style: TextStyle(fontSize: 14.sp),))
                    ],),
                    Row(mainAxisSize: MainAxisSize.min, children: [
                      Text("Balance Amount : ", style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w600),),
                      Obx(() => Text(_viewRepairDetailsController.repairdetails.value.balanceAmount.toString(), style: TextStyle(fontSize: 14.sp),))
                    ],),
                  ],
                ),
                SizedBox(height: 10.h,),
              ],
            ),
            ),

            itemDetails(context, size)
          ],
        ),
      ),
    );
  }

  Container itemDetails(BuildContext context, Size size) {
    return Container(
            margin: EdgeInsets.all(15.w),
            padding: EdgeInsets.all(10.w),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10.r)
            ),
            width: double.infinity,
            child: SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: SizedBox(
        width: Responsive.isDesktop(context) ? size.width : null,
        child: Obx(() => DataTable(
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
                      'Metal',
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
                    width: 125.w,
                    child: Text(
                      'Repair Type',
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
                      'Remarks',
                      style: TextPalette.tableHeaderTextStyle,
                    ),
                  ),
                ),
              ],
              rows: _viewRepairDetailsController.repairItemsList.value
                  .map((item) {
                return DataRow(cells: [
                  DataCell(SizedBox(
                      width: 100.w,
                      child: Text(item.itemDetailsName.toString()))),
                      DataCell(SizedBox(
                      width: 100.w,
                      child: Text(item.metalName.toString()))),
                  DataCell(SizedBox(
                      width: 100.w,
                      child: Text(item.grossWeight.toString()))),
                  DataCell(SizedBox(
                      width: 100.w, child: Text(item.repairType.toString()))),
                  DataCell(SizedBox(
                      width: 100.w, child: Text(item.pieces.toString()))),
                  DataCell(SizedBox(
                      width: 100.w, child: Text(item.remarks.toString()))),
                ]);
              }).toList(),
            )),
      ),
    ),
          );
  }

  Container repairdetails() {
    return Container(
            margin: EdgeInsets.all(15.w),
            padding: EdgeInsets.all(10.w),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10.r)
            ),
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: EdgeInsets.symmetric(vertical: 10.h),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    border: Border(bottom: BorderSide())
                  ),
                  child: Text("Repair Details ", style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w600),)),
                SizedBox(height: 10.h,),
                Wrap(
                  runSpacing: 10.h,
                  spacing: 10.w,
                  children: [
                    Row(mainAxisSize: MainAxisSize.min, children: [
                      Text("Repair No : ", style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w600),),
                      Obx(() => Text(_viewRepairDetailsController.repairdetails.value.repairId.toString(), style: TextStyle(fontSize: 14.sp),))
                    ],),
                    Row(mainAxisSize: MainAxisSize.min, children: [
                      Text("Customer Name : ", style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w600),),
                      Obx(() => Text(_viewRepairDetailsController.repairdetails.value.customerName.toString(), style: TextStyle(fontSize: 14.sp),))
                    ],),
                    Row(mainAxisSize: MainAxisSize.min, children: [
                      Text("Customer Address : ", style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w600),),
                      Obx(() => Text(_viewRepairDetailsController.repairdetails.value.customerAddress.toString(), style: TextStyle(fontSize: 14.sp),))
                    ],),
                    Row(mainAxisSize: MainAxisSize.min, children: [
                      Text("Customer Mobile : ", style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w600),),
                      Obx(() => Text(_viewRepairDetailsController.repairdetails.value.customerPhone.toString(), style: TextStyle(fontSize: 14.sp),))
                    ],),
                    Row(mainAxisSize: MainAxisSize.min, children: [
                      Text("Date : ", style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w600),),
                      Obx(() => Text(DateHelper.convertDate(_viewRepairDetailsController.repairdetails.value.createdAt.toString()), style: TextStyle(fontSize: 14.sp),))
                    ],),
                  ],
                ),
                SizedBox(height: 10.h,),
              ],
            ),
          );
  }
}
