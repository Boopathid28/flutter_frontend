import 'dart:async';
import 'dart:developer';

import 'package:ausales_application/core/constants/app_configuration.dart';
import 'package:ausales_application/core/shared_preferences/home_shared_prefs.dart';
import 'package:ausales_application/model/drop_down_model.dart';
import 'package:ausales_application/model/receive_item/receive_item_models.dart';
import 'package:ausales_application/service/dropdown_service.dart';
import 'package:ausales_application/service/receive_item/receive_item_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class ReceiveItemController extends GetxController {
  final receiveItemFormKey = GlobalKey<FormState>();

  RxList<IssuedRepairItemTableList> tableData =
      <IssuedRepairItemTableList>[].obs;

  RxList<RepairItemDetails> receiveItemList = <RepairItemDetails>[].obs;

  RxList<DropdownModel> vendorDropDown = <DropdownModel>[].obs;
  Rx<DropdownModel?> selectedVendor = Rx<DropdownModel?>(null);
  TextEditingController vendorChargesController = TextEditingController();
  TextEditingController customerChargesController = TextEditingController();

  RxInt itemsPerPage = initialRowsPerPage.obs;
  RxInt page = 1.obs;
  RxInt totalpages = 1.obs;
  RxBool isTableLoading = false.obs;
  RxBool isSubmitLoading = false.obs;
  RxString isPrintLoadingIndex = "".obs;
  RxInt id = RxInt(-1);

  @override
  void onInit() {
    super.onInit();

    getVendorList();
  }

  Future getVendorList() async {
    vendorDropDown([]);
    vendorDropDown.add(DropdownModel(value: '0', label: 'All'));
    final List<DesignerDropdownModel> tempList =
        await DropdownService.designerDropDown();
    for (var item in tempList) {
      vendorDropDown.add(
          DropdownModel(label: item.designerName!, value: item.id.toString()));
    }
    selectedVendor(DropdownModel(value: '0', label: 'All'));
  }

  void addOrUpdateReceiveItem(
      {required num id,
      required String cusCharges,
      required dynamic vendorCharges}) {
    logRepaiList();
    if (receiveItemList.value.isEmpty) {
      if (receiveItemFormKey.currentState!.validate()) {
        receiveItemList.value.add(RepairItemDetails(
            customerCharges: num.parse(cusCharges),
            id: id,
            vendorCharges: num.parse(vendorCharges)));
        Get.back();
      }
    } else {
      int index = receiveItemList.value.indexWhere((item) =>
          item.id ==
          RepairItemDetails(
                  customerCharges: num.parse(cusCharges),
                  id: id,
                  vendorCharges: num.parse(vendorCharges))
              .id);

      if (index != -1) {
        receiveItemList.value.removeAt(index);
      } else {
        if (receiveItemFormKey.currentState!.validate()) {
          receiveItemList.value.add(RepairItemDetails(
              customerCharges: num.parse(cusCharges),
              id: id,
              vendorCharges: vendorCharges));
          Get.back();
        }
      }
    }

    receiveItemList.refresh();
    logRepaiList();
  }

  void logRepaiList() {
    for (var i = 0; i < receiveItemList.length; i++) {
      log('{index:$i   duedate: ${receiveItemList.value[i].customerCharges},  id:${receiveItemList.value[i].id},  vendor:${receiveItemList.value[i].vendorCharges}}');
    }
  }

  Future getIssuedRepairItemTableList() async {
    isTableLoading(true);
    final menuId = await HomeSharedPrefs.getCurrentMenu();
    final payload = IssuedRepairItemPayload(
        id: id.value,
        vendor: selectedVendor.value?.value == '0'
            ? null
            : selectedVendor.value?.value,
        menuId: menuId);
    var response =
        await ReceiveItemService.fetchIssuedRepairItemTableList(payload);
    if (response != null) {
      tableData(response['data']);
      totalpages(response['total_pages']);
    } else {
      tableData([]);
      totalpages(1);
    }
    isTableLoading(false);
  }

  Future receiveItem() async {
    final menuId = await HomeSharedPrefs.getCurrentMenu();
    final payload = ReceiveItemPayload(
        menuId: menuId, repairItemDetails: receiveItemList.value);

    var response = await ReceiveItemService.receiveItem(payload);
  }

  void resetVendorFrom() {
    selectedVendor.value = null;
    customerChargesController.text = '0';
    vendorChargesController.text = '0';
  }

  void resetForm() {
    selectedVendor.value = null;
    customerChargesController.text = '0';
    vendorChargesController.text = '0';
    receiveItemList([]);
  }
}
