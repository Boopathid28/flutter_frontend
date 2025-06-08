import 'dart:async';
import 'dart:developer';

import 'package:ausales_application/core/constants/app_configuration.dart';
import 'package:ausales_application/core/shared_preferences/home_shared_prefs.dart';
import 'package:ausales_application/model/drop_down_model.dart';
import 'package:ausales_application/model/order/order_models.dart';
import 'package:ausales_application/model/order/order_receive_item_models.dart';
import 'package:ausales_application/service/dropdown_service.dart';
import 'package:ausales_application/service/order/order_receive_item_service.dart';
import 'package:ausales_application/view/screens/order/order_receive_item__screen/order_receive_item_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class OrderReceiveItemController extends GetxController {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  final orderReceiveItemFormKey = GlobalKey<FormState>();

  Rx<OrderListData?> currentReceiveItemdetails = Rx<OrderListData?>(null);
  TextEditingController vendorSearchController = TextEditingController();
  Rx<DropdownModel?> selectedVendor = Rx<DropdownModel?>(null);

  RxList<DropdownModel> vendorDropDown = <DropdownModel>[].obs;
  RxInt itemsPerPage = initialRowsPerPage.obs;
  RxInt page = 1.obs;
  RxInt totalpages = 1.obs;
  RxBool isDeleteLoading = false.obs;
  RxBool isTableLoading = true.obs;
  RxBool isTable = false.obs;

  RxBool isFormSubmit = false.obs;

  RxList<OrderReceiveItemResponse> tableData = <OrderReceiveItemResponse>[].obs;

  @override
  void onInit() {
    super.onInit();
    getVendorList();
  }

  Future getVendorList() async {
    vendorDropDown([]);
    final List<DesignerDropdownModel> tempList =
        await DropdownService.designerDropDown();
    tempList.forEach((item) {
      vendorDropDown.add(DropdownModel(
          value: item.id.toString(), label: item.designerName.toString()));
    });
  }

  Future submitForm(BuildContext context) async {
    if (orderReceiveItemFormKey.currentState!.validate()) {
      if (!isFormSubmit.value) {
        OrderReceiveItemPayload payload = OrderReceiveItemPayload(
            vendor: selectedVendor.value!.value,
            id: currentReceiveItemdetails.value!.id,
            menuId: await HomeSharedPrefs.getCurrentMenu());

        final Map<String, dynamic>? orderReceivelist =
            await OrderReceiveItemService.fetchOrderReceiveItemList(
                payload: payload);

        if (orderReceivelist != null) {
          tableData(orderReceivelist['data']);
          totalpages(orderReceivelist['total_pages']);
        } else {
          tableData([]);
          totalpages(1);
        }
        Get.back();
        Get.to(() => OrderReceiveItemScreen());
        isTableLoading(false);
        resetreceiveitem(context);
      }
    }
  }

  void resetreceiveitem(BuildContext context) {
    selectedVendor.value = null;
    isFormSubmit(false);
  }
}
