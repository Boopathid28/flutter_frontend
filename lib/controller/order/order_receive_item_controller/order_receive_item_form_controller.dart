import 'dart:developer';

import 'package:ausales_application/controller/order/order_form_controller.dart';
import 'package:ausales_application/controller/order/order_item_form_controller.dart';
import 'package:ausales_application/core/constants/app_configuration.dart';
import 'package:ausales_application/core/constants/nav_controller.dart';
import 'package:ausales_application/core/shared_preferences/home_shared_prefs.dart';
import 'package:ausales_application/model/order/order_receive_item_models.dart';
import 'package:ausales_application/service/order/order_receive_item_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:toastification/toastification.dart';

class OrderReceiveItemFormController extends GetxController {
  final OrderItemFormController _orderItemFormController =
      Get.put(OrderItemFormController());
  final OrderFormController _orderFormController =
      Get.put(OrderFormController());


  Rx<OrderReceiveItemResponse?> currentOrderReceiveItemdetails =
      Rx<OrderReceiveItemResponse?>(null);

  RxList<OrderItemDetails> orderItem = <OrderItemDetails>[].obs;
  RxString vendorassignFormMode = "create".obs;
  RxString vendorFormUpdateId = "".obs;

  RxList id = [].obs;

  RxBool isFormSubmit = false.obs;
  RxBool isForm = false.obs;
  RxBool isIcon = false.obs;

  @override
  void onInit() {
    super.onInit();
  }

 

  Future submitReceiveItem(BuildContext context) async {
        id.add(currentOrderReceiveItemdetails.value?.id);
        final OrderItemDetails orderItemDetails = OrderItemDetails(
            id: currentOrderReceiveItemdetails.value?.id,);

        orderItem.insert(0, orderItemDetails);
  }



    void deleteReceive(BuildContext context, String index) {
    orderItem.removeWhere((item) => item.id.toString() == index);
    id.removeWhere((item) => item.toString() == index);
    Get.back();
  }

  Future ReceiveItem(BuildContext context) async {
    if (!isForm.value) {
      isForm.value = true;
      if (orderItem.isNotEmpty) {
        ReceiveOrderItemPaylaod payload = ReceiveOrderItemPaylaod(
            orderItemDetails: orderItem,
            menuId: await HomeSharedPrefs.getCurrentMenu());

        final ReceiveOrderItemResponse? data =
            await OrderReceiveItemService.createreceiveItem(
                payload: payload, context: context);
        if (data != null) {
          orderItem([]);
          id([]);
          navOrderList();
        }
      } else {
        toastification.show(
            context: context, // optional if you use ToastificationWrapper
            type: ToastificationType.info,
            title: Text("Add at least one Receive Item"),
            autoCloseDuration: notificationDuration,
            showProgressBar: false,
            pauseOnHover: false);

        isForm.value = false;
      }
    }
  }

  // void stoneAddCompleted(BuildContext context) {
  //   int pieces = 0;

  //   for (var i in _orderFormController.stonedetailsParticulars) {
  //     pieces = int.parse((pieces + int.parse(i.stonePieces ?? "0")).toString());
  //   }

  //   _orderItemFormController.totalstonepiecesController.text =
  //       pieces.toString();

  //   Get.back();
  // }
}
