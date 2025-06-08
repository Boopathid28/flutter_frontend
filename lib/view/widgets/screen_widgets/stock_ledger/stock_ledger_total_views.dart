import 'package:ausales_application/controller/stock_ledger/stock_ledger_list_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class StockLedgerTotalView extends StatefulWidget {
  const StockLedgerTotalView({super.key});

  @override
  State<StockLedgerTotalView> createState() => _StockLedgerTotalViewState();
}

class _StockLedgerTotalViewState extends State<StockLedgerTotalView> {
  final StockLedgerListController _stockLedgerListController =
      Get.put(StockLedgerListController());
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
            inStockpieces(),
            outStockpieces(),
            inStockgrossweight(),
            outStockgrossweight()
          ],
        ),
      ),
    );
  }

  Row inStockpieces() {
    return Row(mainAxisSize: MainAxisSize.min, children: [
      Text(
        "In Stock Pieces",
        style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w700),
      ),
      SizedBox(
        width: 10.w,
      ),
      Obx(() => Text(_stockLedgerListController.inStockpieces.toString()))
    ]);
  }

  Row outStockpieces() {
    return Row(mainAxisSize: MainAxisSize.min, children: [
      Text(
        "Out Stock Pieces",
        style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w700),
      ),
      SizedBox(
        width: 10.w,
      ),
      Obx(() => Text(_stockLedgerListController.outStockpieces.toString()))
    ]);
  }

  Row inStockgrossweight() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
      Text(
        "In Stock Gross Weight",
        style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w700),
      ),
      SizedBox(
        width: 10.w,
      ),
      Obx(() =>
          Text(_stockLedgerListController.inStockgrossweight.toString()))
    ]);
  }

  Row outStockgrossweight() {
    return Row(
      mainAxisSize: MainAxisSize.min,children: [
      Text(
        "Out Stock Gross Weight",
        style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w700),
      ),
      SizedBox(
        width: 10.w,
      ),
      Obx(() =>
          Text(_stockLedgerListController.outStockgrossweight.toString()))
    ]);
  }
}
