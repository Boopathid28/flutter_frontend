import 'dart:developer';

import 'package:ausales_application/core/shared_preferences/home_shared_prefs.dart';
import 'package:ausales_application/model/item_tag_details/item_tag_details_model.dart';
import 'package:ausales_application/service/item_tag_details/item_tag_details_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TagDetailsFormController extends GetxController {

    final tagdetailsFormKey = GlobalKey<FormState>();

  TextEditingController tagnumberController = TextEditingController();

  RxObjectMixin<ItemTagdetailsList> tableData = ItemTagdetailsList().obs;

  RxBool isFormFind = false.obs;


  @override
  void onInit() async {
    super.onInit();
  }

  Future getTagItemList(String? tagnumber, BuildContext context) async {
    int? menuId = await HomeSharedPrefs.getCurrentMenu();
    final response = await ItemTagDetailsService.getTagItemdetails(
        context: context, tagnumber: tagnumber);

    if (response != null) {
      tableData(ItemTagdetailsList.fromJson(response['data']));
    }
    
  }

  resetForm() {
    isFormFind.value = false;
    tagdetailsFormKey.currentState!.reset();
  }
}
