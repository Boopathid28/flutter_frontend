import 'dart:async';
import 'dart:developer';

import 'package:ausales_application/core/shared_preferences/auth_shared_prefs.dart';
import 'package:ausales_application/model/layout_model.dart';
import 'package:ausales_application/service/metal_rate_master/metal_rate_master_service.dart';
import 'package:get/get.dart';

class HeaderController extends GetxController {

  RxBool isBranchuser = false.obs;

  RxList<DisplayMetalRateModel> displayRates = <DisplayMetalRateModel>[].obs;
  RxList<DisplayMetalRateModel> minDisplayRates = <DisplayMetalRateModel>[].obs;

  RxString metalDisplayRate = "".obs;

  Future getIsBranchUser() async {
    isBranchuser(await AuthSharedPrefs.getBranch());
    return await AuthSharedPrefs.getBranch();
  }

  Future getMetalRates() async {

    final Map<String, dynamic>? data = await MetalRateMasterService.retrieveDisplayMetalRates();
    displayRates([]);
    if (data != null) {

      List<DisplayMetalRateModel> templist = [];
      String value = "";
      for (var entry in data.entries) {
        templist.add(DisplayMetalRateModel(metalName: entry.key.split('_').join(' '), rate: entry.value));
        value = value + "${entry.key.split('_').join(' ')}: ${entry.value}     ";
      }


      displayRates(templist);
      
      metalDisplayRate(value);

      if (templist.length >= 2) {
        minDisplayRates(templist.sublist(0,2));
      } else {
        minDisplayRates(templist);
      } 
    }    
  }
}