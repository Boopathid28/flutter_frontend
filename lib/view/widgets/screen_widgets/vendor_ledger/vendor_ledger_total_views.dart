import 'package:ausales_application/controller/vendor_ledger/vendor_ledger_list_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class VendorLedgerTotalViews extends StatefulWidget {
  const VendorLedgerTotalViews({super.key});

  @override
  State<VendorLedgerTotalViews> createState() => _VendorLedgerTotalViewsState();
}

class _VendorLedgerTotalViewsState extends State<VendorLedgerTotalViews> {
  final VendorLedgerListController _vendorLedgerListController =
      Get.put(VendorLedgerListController());
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(15.w),
      child: Container(
        width: double.infinity,
        child: Wrap(
          spacing: 10.w,
          runSpacing: 15.h,
          children: [
            totalAmount(),
            totalWeight(),
            discWeight(),
            discAmount(),
            paidweight(),
            paidamount(),
            balanceweight(),
            balanceAmount(),
          ],
        ),
      ),
    );
  }

  Row totalAmount() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
            Text(
              "Total Amount",
              style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w700),
            ),
            SizedBox(
              width: 10.w,
            ),
            Obx(() =>
                Text(_vendorLedgerListController.totalAmount.toString()))
          ]);
  }

 
  Row totalWeight() {
    return  Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          "Total Weight",
          style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w700),
        ),
        SizedBox(
          width: 10.w,
        ),
        Obx(() => Text(_vendorLedgerListController.totalWeight.toString()))
      ]);
  }

  Row discWeight() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          "Disc Weight",
          style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w700),
        ),
        SizedBox(
          width: 10.w,
        ),
        Obx(() => Text(_vendorLedgerListController.discWeight.toString()))
      ]);
  }

  Row discAmount() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          "Disc Amount",
          style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w700),
        ),
        SizedBox(
          width: 10.w,
        ),
        Obx(() => Text(_vendorLedgerListController.discAmount.toString()))
      ]);
  }

 
  Row paidweight() {
    return  Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          "Paid Weight",
          style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w700),
        ),
        SizedBox(
          width: 10.w,
        ),
        Obx(() => Text(_vendorLedgerListController.paidWeight.toString()))
      ]);
  }

 
  Row paidamount() {
    return  Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          "Paid Amount",
          style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w700),
        ),
        SizedBox(
          width: 10.w,
        ),
        Obx(() => Text(_vendorLedgerListController.paidAmount.toString()))
      ]);
  }

 
  Row balanceAmount() {
    return  Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          "Balance Amount",
          style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w700),
        ),
        SizedBox(
          width: 10.w,
        ),
        Obx(() => Text(_vendorLedgerListController.balanceAmount.toString()))
      ]);
  }

  Row balanceweight() {
    return  Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          "Balance Weight",
          style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w700),
        ),
        SizedBox(
          width: 10.w,
        ),
        Obx(() => Text(_vendorLedgerListController.balanceWeight.toString()))
      ]);
  }
}
