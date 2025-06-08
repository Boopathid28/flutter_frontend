import 'dart:async';
import 'dart:developer';

import 'package:ausales_application/controller/new_purchase/new_purchase_to_lot/newpurchase_to_lot_item_table_controller.dart';
import 'package:ausales_application/core/constants/app_configuration.dart';
import 'package:ausales_application/core/shared_preferences/home_shared_prefs.dart';
import 'package:ausales_application/model/lot/lot_model.dart';
import 'package:ausales_application/model/new_purchase/new_pharchase_item_list.dart';
import 'package:ausales_application/model/order/order_models.dart';
import 'package:ausales_application/service/new_purchase/new_pharchase_to_lot_service.dart';
import 'package:ausales_application/view/screens/new_purchase/newpurchase_item_screen/newpurchase_item_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class NewpurchaseToLotController extends GetxController {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();


  final NewpurchaseToLotItemTableController _newpurchaseToLotItemTableController = Get.put(NewpurchaseToLotItemTableController());

  Rx<OrderListData?> currentReceiveItemConvertdetails =
      Rx<OrderListData?>(null);

  RxInt itemsPerPage = initialRowsPerPage.obs;
  RxInt page = 1.obs;
  RxInt totalpages = 1.obs;
  RxBool isDeleteLoading = false.obs;
  RxBool isTableLoading = true.obs;
  RxBool isTable = false.obs;
  RxBool isDbValue = false.obs;

  RxBool isFormSubmit = false.obs;

  RxList<NewPurchaseItemListData> tableData = <NewPurchaseItemListData>[].obs;

  @override
  void onInit() {
    super.onInit();
  }

  Future getnewpurchaseItemList(BuildContext context, String? id) async {
    NewPurchaseItemListPaylaod payload = NewPurchaseItemListPaylaod(
        page: page.value,
        itemsPerPage: itemsPerPage.value,
        id: id,
        menuId: await HomeSharedPrefs.getCurrentMenu());

    final Map<String, dynamic>? newpurchaseitemlist =
        await NewPharchaseToLotService.fetchConvertLotItemList(
            payload: payload);

    if (newpurchaseitemlist != null) {
      tableData(newpurchaseitemlist['data']);
      totalpages(newpurchaseitemlist['total_pages']);
      _newpurchaseToLotItemTableController.lotitemParticularList([]);
      for (var i in newpurchaseitemlist['data']) {
        final LotFormItemDataModel lotFormItemDataModel = LotFormItemDataModel(
            id: i.id,
            purchaseItemId: i.id.toString(),
            itemDetails: i.itemDetails,
            itemDetailsName: i.itemDetailsName,
            pieces: i.pieces.toString(),
            grossWeight: i.grossWeight.toString(),
            isDb: isDbValue.value);
      // _newpurchaseToLotItemTableController.lotitemParticularList.add(lotFormItemDataModel);
       _newpurchaseToLotItemTableController.lotitemParticularList.add(lotFormItemDataModel);
      }
     
    } else {
      tableData([]);
      totalpages(1);
    }
    Get.to(() => NewpurchaseItemScreen());
    isTableLoading(false);
    resetreceiveitem(context);
  }

  void resetreceiveitem(BuildContext context) {
    isFormSubmit(false);
  }
}
