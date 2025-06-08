import 'dart:developer';

import 'package:ausales_application/model/repair_creation/repair_creation_models.dart';
import 'package:ausales_application/service/repair_creation/repair_creation_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ViewRepairDetailsController extends GetxController {


  RxObjectMixin<RepairGetbyData> repairdetails = RepairGetbyData().obs;
  RxList<ItemDetails> repairItemsList = <ItemDetails>[].obs;

  Future getRepairDetails(BuildContext context) async {
    final args = Get.arguments;
    RepairGetbyData? data = await RepairCreationService.getRepairGetData(
        context: context, repairId: args.toString());
    if (data != null) {
     
      repairItemsList(data.itemDetails??[]);
      repairdetails(RepairGetbyData.fromJson(data.toJson()));
    }
  }
}