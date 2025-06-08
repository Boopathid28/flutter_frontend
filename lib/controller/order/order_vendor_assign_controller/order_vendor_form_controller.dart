import 'dart:developer';

import 'package:ausales_application/controller/order/order_form_controller.dart';
import 'package:ausales_application/controller/order/order_item_form_controller.dart';
import 'package:ausales_application/core/constants/app_configuration.dart';
import 'package:ausales_application/core/constants/nav_controller.dart';
import 'package:ausales_application/core/shared_preferences/home_shared_prefs.dart';
import 'package:ausales_application/model/drop_down_model.dart';
import 'package:ausales_application/model/order/order_assign_models.dart';
import 'package:ausales_application/service/dropdown_service.dart';
import 'package:ausales_application/service/order/order_assign_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:toastification/toastification.dart';
import 'package:uuid/uuid.dart';

class OrderVendorFormController extends GetxController {
  final OrderItemFormController _orderItemFormController =
      Get.put(OrderItemFormController());
  final OrderFormController _orderFormController =
      Get.put(OrderFormController());

  final ordervendorDetailsFormKey = GlobalKey<FormState>();

  Rx<OrderItemtableListData?> currentItemdetails =
      Rx<OrderItemtableListData?>(null);

  TextEditingController vendorSearchController = TextEditingController();
  TextEditingController duedateController = TextEditingController();

  Rx<DropdownModel?> selectedVendor = Rx<DropdownModel?>(null);

  RxList<DropdownModel> vendorDropDown = <DropdownModel>[].obs;

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

  Future submitOrderVendorForm(BuildContext context) async {
    if (ordervendorDetailsFormKey.currentState!.validate()) {
      if (!isFormSubmit.value) {
        id.add(currentItemdetails.value?.id);
        var uuid = Uuid();
        final OrderItemDetails orderItemDetails = OrderItemDetails(
            // sNo: uuid.v4(),
            id: currentItemdetails.value?.id,
            vendorDetails: int.parse(selectedVendor.value!.value),
            dueDate: duedateController.text);

        orderItem.insert(0, orderItemDetails);
        resetvendor(context);
        Get.back();
      }
    }
  }


  Future AssignVendor(BuildContext context) async {
    if (!isForm.value) {
      isForm.value = true;
      if (orderItem.isNotEmpty) {
        AssignVendorPayload payload = AssignVendorPayload(
            orderItemDetails: orderItem,
            menuId: await HomeSharedPrefs.getCurrentMenu());

        final AssignVendorResponse? data =
            await OrderAssignService.createVendorAssign(
                payload: payload, context: context);
        if (data != null) {
          orderItem([]);
          navOrderList();
        }
      } else {
        toastification.show(
            context: context, // optional if you use ToastificationWrapper
            type: ToastificationType.info,
            title: Text("Add at least one vendor assign"),
            autoCloseDuration: notificationDuration,
            showProgressBar: false,
            pauseOnHover: false);

        isForm.value = false;
      }
    }
  }

  
    void deleteVendor(BuildContext context, String index) {
    orderItem.removeWhere((item) => item.id.toString() == index);
    id.removeWhere((item) => item.toString() == index);
    Get.back();
  }

  void resetvendor(BuildContext context) {
    selectedVendor.value = null;
    duedateController.clear();
    vendorassignFormMode('create');
    vendorFormUpdateId("");
    isFormSubmit(false);
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
