import 'package:ausales_application/model/home_model.dart';
import 'package:ausales_application/service/home_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  
  RxList<UserMenuDataList> userMenuPermissionList = <UserMenuDataList>[].obs;

  RxBool modulePermit = false.obs;
  RxBool viewPermit = false.obs;
  RxBool addPermit = false.obs;
  RxBool editPermit = false.obs;
  RxBool deletePermit = false.obs;

  Future getUserPermission() async {
    userMenuPermissionList([]);
    final List<UserMenuDataList> userMenuDataList =
        await HomeService.getUserMenuPermission();
    userMenuPermissionList(userMenuDataList);
  }
}
