import 'dart:developer';
 
import 'package:ausales_application/core/constants/app_configuration.dart';
import 'package:ausales_application/core/shared_preferences/home_shared_prefs.dart';
import 'package:ausales_application/model/drop_down_model.dart';
import 'package:ausales_application/model/order/order_view_details_models.dart';
import 'package:ausales_application/service/dropdown_service.dart';
import 'package:ausales_application/service/order/order_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:toastification/toastification.dart';
 
class ViewOrderDetailsController extends GetxController {
 
 
  RxObjectMixin<RetrieveOrderDetails> orderDetails = RetrieveOrderDetails().obs;
  RxList<ItemDetails> orderItemsList = <ItemDetails>[].obs;
  RxList<NotissuedItemDetails> notissuedItemDetails = <NotissuedItemDetails>[].obs;
  RxList<IssuedItemDetails> issuedItemDetails = <IssuedItemDetails>[].obs;
  RxList<ReceivedItemDetails> receivedItemDetails = <ReceivedItemDetails>[].obs;
 
 
  RxBool isNotAssignTableLoading = true.obs;
  RxBool isAssignTableLoading = true.obs;
  RxBool isRecievedTableLoading = true.obs;
 
  RxBool isAssignLoading = false.obs;
  RxBool isRecievedLoading = false.obs;
 
  RxBool isAssignAll = false.obs;
  RxBool isRecievedAll = false.obs;
 
  RxString currentOrderId = "".obs;
 
 
  // Assign Vendor Form Variables
  TextEditingController dueDateController = TextEditingController();
  TextEditingController vendorSearchController = TextEditingController();
 
  Rx<DropdownModel?> selectedVendor = Rx<DropdownModel?>(null);
 
  RxList<DropdownModel> vendorDropDown = <DropdownModel>[].obs;
 
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
 
  Future getOrderDetails(BuildContext context, String id) async {
 
    RetrieveOrderDetails? data = await OrderService.retrieveOrderDetails(
        context: context, orderId: id);
    if (data != null) {
      currentOrderId(id);
      orderItemsList(data.itemDetails??[]);
      notissuedItemDetails(data.notissuedItemDetails??[]);
      issuedItemDetails(data.issuedItemDetails??[]);
      receivedItemDetails(data.receivedItemDetails??[]);
      orderDetails(RetrieveOrderDetails.fromJson(data.toJson()));
    }
 
    isNotAssignTableLoading(false);
    isAssignTableLoading(false);
    isRecievedTableLoading(false);
  }
 
  void onAssignChecked(bool check, int id, BuildContext context) {
    int index = notissuedItemDetails.indexWhere((item) => item.id == id);
    if (index != -1) {
      NotissuedItemDetails orderItem = notissuedItemDetails[index];
      var orderItemJson = orderItem.toJson();
      orderItemJson['is_check'] = check;
      notissuedItemDetails[index] = NotissuedItemDetails.fromJson(orderItemJson);
    } else {
      toastification.show(
        context: context,
        type: ToastificationType.error,
        title: Text("Item not exists"),
        autoCloseDuration: notificationDuration,
        showProgressBar: false,
        pauseOnHover: false);
    }
  }
 
  void checkAllForAssign(bool check) {
    List<NotissuedItemDetails> dataList = [];
    for (var i in notissuedItemDetails) {
      var orderItemJson = i.toJson();
      orderItemJson['is_check'] = check;
      dataList.add(NotissuedItemDetails.fromJson(orderItemJson));
    }
    notissuedItemDetails(dataList);
    isAssignAll(check);
  }
 
  Future assignOrderItems(BuildContext context) async {
    if (!isAssignLoading.value) {
      isAssignLoading(true);
      
 
      List<OrderItemDetails> items = [];
      for (var i in notissuedItemDetails.value) {
        if (i.isCheck??false) {
          items.add(OrderItemDetails(
            id: i.id,
            vendorDetails: selectedVendor.value?.value,
            dueDate: dueDateController.text
          ));
        }
      }
 
      AssignOrderItems payload = AssignOrderItems(
        menuId: await HomeSharedPrefs.getCurrentMenu(),
        orderItemDetails: items
      );
      
      final String? data = await OrderService.assignVendorOrderItems(context: context, payload: payload);
 
      if(data != null) {
        resetVendorAssign();
        isNotAssignTableLoading(true);
        isAssignTableLoading(true);
        getOrderDetails(context, currentOrderId.value);
        Get.back();
      }
      isAssignLoading(false);
    }
  }
 
  resetVendorAssign() {
    dueDateController.clear();
    selectedVendor.value = null;
    isAssignAll(false);
  }
 
  void onRecievedChecked(bool check, int id, BuildContext context) {
    int index = issuedItemDetails.indexWhere((item) => item.id == id);
    if (index != -1) {
      IssuedItemDetails orderItem = issuedItemDetails[index];
      var orderItemJson = orderItem.toJson();
      orderItemJson['is_check'] = check;
      issuedItemDetails[index] = IssuedItemDetails.fromJson(orderItemJson);
    } else {
      toastification.show(
        context: context,
        type: ToastificationType.error,
        title: Text("Item not exists"),
        autoCloseDuration: notificationDuration,
        showProgressBar: false,
        pauseOnHover: false);
    }
  }
 
  void checkAllForRecieved(bool check) {
    List<IssuedItemDetails> dataList = [];
    for (var i in issuedItemDetails) {
      var orderItemJson = i.toJson();
      orderItemJson['is_check'] = check;
      dataList.add(IssuedItemDetails.fromJson(orderItemJson));
    }
    issuedItemDetails(dataList);
    isRecievedAll(check);
  }
 
  Future recievedOrderItems(BuildContext context) async {
    if (!isRecievedLoading.value) {
      isRecievedLoading(true);
      
 
      List<RecieveOrderItemDetails> items = [];
      for (var i in issuedItemDetails.value) {
        if (i.isCheck??false) {
          items.add(RecieveOrderItemDetails(
            id: i.id,
          ));
        }
      }
 
      RecieveOrderItems payload = RecieveOrderItems(
        menuId: await HomeSharedPrefs.getCurrentMenu(),
        orderItemDetails: items
      );
      
      final String? data = await OrderService.recievedOrderItems(context: context, payload: payload);
 
      if(data != null) {       
        isAssignTableLoading(true);
        isRecievedTableLoading(true);
        getOrderDetails(context, currentOrderId.value);
        isRecievedAll(false);
      }
      isRecievedLoading(false);
    }
  }
}