import 'package:ausales_application/model/home_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EndDrawerController extends GetxController {

  TextEditingController menuSearchController = TextEditingController();

  RxObjectMixin<UserMenuDataList> activeMenuGroup = UserMenuDataList().obs;

  RxBool menuGroupClicked = false.obs;

  Rx<int?> activeMenuIndex = Rx<int?>(null);
}