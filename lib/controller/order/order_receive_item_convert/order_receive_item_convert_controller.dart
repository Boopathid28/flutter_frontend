import 'dart:async';
import 'dart:developer';

import 'package:ausales_application/core/constants/app_configuration.dart';
import 'package:ausales_application/core/shared_preferences/home_shared_prefs.dart';
import 'package:ausales_application/model/order/order_models.dart';
import 'package:ausales_application/model/order/order_receive_item_convert_models.dart';
import 'package:ausales_application/service/order/order_convert_receive_item_service.dart';
import 'package:ausales_application/view/screens/order/order_convert_receive_item_screen/order_convert_receive_item_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OrderConvertReceiveItemController extends GetxController {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  final orderReceiveItemConvertFormKey = GlobalKey<FormState>();

  Rx<OrderListData?> currentReceiveItemConvertdetails = Rx<OrderListData?>(null);

  RxInt itemsPerPage = initialRowsPerPage.obs;
  RxInt page = 1.obs;
  RxInt totalpages = 1.obs;
  RxBool isDeleteLoading = false.obs;
  RxBool isTableLoading = true.obs;
  RxBool isTable = false.obs;

  RxBool isFormSubmit = false.obs;

  RxList<OrderConvertReceiveItemResponse> tableData = <OrderConvertReceiveItemResponse>[].obs;

  @override
  void onInit() {
    super.onInit();
  }

  Future getCovertReceiveItemList(BuildContext context , String? id) async {
        OrderConvertReceiveItemPayload payload = OrderConvertReceiveItemPayload(
            id: id,
            menuId: await HomeSharedPrefs.getCurrentMenu());

        final Map<String, dynamic>? orderConvertReceivelist =
            await OrderConvertReceiveItemService.fetchConvertOrderReceiveItemList(
                payload: payload);

        if (orderConvertReceivelist != null) {
          tableData(orderConvertReceivelist['data']);
          totalpages(orderConvertReceivelist['total_pages']);
        } else {
          tableData([]);
          totalpages(1);
        }
        Get.to(() => OrderConvertReceiveItemScreen());
        isTableLoading(false);
        resetreceiveitem(context);
  }

  void resetreceiveitem(BuildContext context) {
    isFormSubmit(false);
  }
}
