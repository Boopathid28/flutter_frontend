import 'dart:async';

import 'package:ausales_application/core/constants/app_configuration.dart';
import 'package:ausales_application/core/shared_preferences/home_shared_prefs.dart';
import 'package:ausales_application/model/order/order_assign_models.dart';
import 'package:ausales_application/service/order/order_assign_service.dart';
import 'package:ausales_application/view/screens/order/order_assign_screen/order_assign_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class OrderVendorAssignController extends GetxController {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  RxInt itemsPerPage = initialRowsPerPage.obs;
  RxInt page = 1.obs;
  RxInt totalpages = 1.obs;
  RxBool isDeleteLoading = false.obs;
  RxBool isTableLoading = true.obs;
  RxBool isTable = false.obs;

  RxList<OrderItemtableListData> tableData = <OrderItemtableListData>[].obs;

  @override
  void onInit() {
    super.onInit();
  }

  Future getorderAssignList(BuildContext context, String? Id) async {
    isTableLoading(true);

    OrderItemtableList payload = OrderItemtableList(
        id: int.parse(Id!), menuId: await HomeSharedPrefs.getCurrentMenu());

    final Map<String, dynamic>? orderAssignlist =
        await OrderAssignService.fetchOrderAssignList(payload: payload);

    if (orderAssignlist != null) {
      tableData(orderAssignlist['data']);
      totalpages(orderAssignlist['total_pages']);
    } else {
      tableData([]);
      totalpages(1);
    }
      Get.to(()=> OrderAssignListScreen());
    isTableLoading(false);
  }
}
