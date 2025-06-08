import 'dart:developer';

import 'package:ausales_application/core/constants/app_configuration.dart';
import 'package:ausales_application/core/shared_preferences/home_shared_prefs.dart';
import 'package:ausales_application/model/assign_vendor/assign_vendor_models.dart';
import 'package:ausales_application/model/drop_down_model.dart';
import 'package:ausales_application/service/assign_vendor/assign_vendor_service.dart';
import 'package:ausales_application/service/dropdown_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AssignVendorListController extends GetxController {
  RxList<NotIssuesRepairItemTableList> tableData =
      <NotIssuesRepairItemTableList>[].obs;

  final assignEachVendorFormKey = GlobalKey<FormState>();

  RxList<DropdownModel> vendorDropDown = <DropdownModel>[].obs;
  Rx<DropdownModel?> selectedVendor = Rx<DropdownModel?>(null);
  RxList<Map<String, dynamic>> status = <Map<String, dynamic>>[].obs;
  // RxList<DropdownModel?> selectedVendors = <DropdownModel>[].obs;
  RxList<RepairItemDetails> repairItemList = <RepairItemDetails>[].obs;
  TextEditingController dueDateController = TextEditingController();
  // RxList<TextEditingController> dueDateControllers =
  //     <TextEditingController>[].obs;
  final repairFormMode = 'create'.obs;

  RxInt itemsPerPage = initialRowsPerPage.obs;
  RxInt page = 1.obs;
  RxInt totalpages = 1.obs;
  RxBool isTableLoading = false.obs;
  RxBool isSubmitLoading = false.obs;
  RxInt id = RxInt(-1);

  @override
  void onInit() {
    super.onInit();

    getVendorList();
  }

  Future getVendorList() async {
    vendorDropDown([]);
    vendorDropDown.add(DropdownModel(value: '0', label: 'No Vendor'));
    final List<DesignerDropdownModel> tempList =
        await DropdownService.designerDropDown();
    for (var item in tempList) {
      vendorDropDown.add(
          DropdownModel(label: item.designerName!, value: item.id.toString()));
    }
    selectedVendor(DropdownModel(value: '0', label: 'No Vendor'));
  }

  void addOrUpdateRepairItem(
      {required num id,
      required String dueDate,
      required dynamic vendorDetails}) {
    if (repairItemList.isEmpty) {
      if (assignEachVendorFormKey.currentState!.validate()) {
        repairItemList.value.add(RepairItemDetails(
            dueDate: dueDate, id: id, vendorDetails: vendorDetails));
        Get.back();
      }
    } else {
      int index = repairItemList.value.indexWhere((item) =>
          item.id ==
          RepairItemDetails(
                  dueDate: dueDate, id: id, vendorDetails: vendorDetails)
              .id);

      if (index != -1) {
        repairItemList.value.removeAt(index);
      } else {
        if (assignEachVendorFormKey.currentState!.validate()) {
          repairItemList.value.add(RepairItemDetails(
              dueDate: dueDate, id: id, vendorDetails: vendorDetails));
          Get.back();
        }
      }
    }

    repairItemList.refresh();
    logRepaiList();
  }

  void logRepaiList() {
    for (var i = 0; i < repairItemList.length; i++) {
      log('{index:$i   duedate: ${repairItemList.value[i].dueDate},  id:${repairItemList.value[i].id},  vendor:${repairItemList.value[i].vendorDetails}}');
    }
  }

  Future assignVendor() async {
    final menuId = await HomeSharedPrefs.getCurrentMenu();
    final payload = AssignVendorPayload(
        menuId: menuId, repairItemDetails: repairItemList.value);

    var response = await AssignVendorService.assignVendor(payload);
  }

  Future getNotIssuedRepairCreationTableList() async {
    isTableLoading(true);
    final menuId = await HomeSharedPrefs.getCurrentMenu();
    final payload =
        NotIssuesRepairItemTableListPayload(id: id.value, menuId: menuId);
    var response = await AssignVendorService.fetchNotIssuedTableList(payload);
    if (response != null) {
      tableData(response['data']);
      totalpages(response['total_pages']);
      status(List.generate(
        tableData.length,
        (index) => {'status': 'Assign', 'id': tableData[index].id}.obs,
      ));
    } else {
      tableData([]);
      totalpages(1);
    }
    isTableLoading(false);
  }

  void resetVendorFrom() {
    selectedVendor.value = null;
    dueDateController.clear();
    repairFormMode('create');
  }

  void resetForm() {
    selectedVendor.value = null;
    dueDateController.clear();
    repairFormMode('create');
    repairItemList.value = [];
  }
}
