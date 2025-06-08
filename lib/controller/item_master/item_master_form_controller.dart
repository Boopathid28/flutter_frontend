import 'package:ausales_application/controller/item_master/item_master_list_controller.dart';
import 'package:ausales_application/core/shared_preferences/home_shared_prefs.dart';
import 'package:ausales_application/model/drop_down_model.dart';
import 'package:ausales_application/model/item_master/item_master_models.dart';
import 'package:ausales_application/service/dropdown_service.dart';
import 'package:ausales_application/service/item_master/item_master_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ItemMasterFormController extends GetxController {
  final ItemMasterListController _itemMasterListController = Get.put(ItemMasterListController());

  final itemFormKey = GlobalKey<FormState>();

  Rx<ItemListData?> currentItem = Rx<ItemListData?>(null);

  TextEditingController itemNameController = TextEditingController();
  TextEditingController itemCodeController = TextEditingController();
  TextEditingController huidChargeController = TextEditingController();

  TextEditingController searchPurityController = TextEditingController();

  Rx<DropdownModel?> selectedPurity = Rx<DropdownModel?>(null);

  RxBool isFormSubmit = false.obs;

  RxString fromMode = "create".obs;

  RxList<DropdownModel> purityDropDown = <DropdownModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    getPurityList();
  }

  Future getPurityList() async {
    purityDropDown([]);
    final List<PurityDropdownModel> tempList =
        await DropdownService.purityDropDown(null);
    tempList.forEach((item) {
      purityDropDown
          .add(DropdownModel(label: item.purityName!, value: item.id.toString()));
    });
  }

  Future submitItemForm(BuildContext context) async {
    if (itemFormKey.currentState!.validate()) {
      if (!isFormSubmit.value) {
        isFormSubmit.value = true;
        if (fromMode.value == "create") {
          final CreateItemPayload payload = CreateItemPayload(
              menuId: await HomeSharedPrefs.getCurrentMenu(),
              purity: int.parse(selectedPurity.value!.value),
              itemName: itemNameController.text,
              itemCode: itemCodeController.text,
              huidCharges: double.parse(huidChargeController.text),
              );

          await ProductItemService.createItem(context: context, payload: payload);
          _itemMasterListController.getItemList(context);
        } else {
          final UpdateItemPayload payload = UpdateItemPayload(
              menuId: await HomeSharedPrefs.getCurrentMenu(),
              itemName: itemNameController.text,
              itemCode: itemCodeController.text,
              huidCharges: double.parse(huidChargeController.text),
              id: currentItem.value!.id,
              purity: int.parse(selectedPurity.value!.value)
              );

          await ProductItemService.updateItem(context: context, payload: payload);
          _itemMasterListController.getItemList(context);
        }
        resetForm();
      }
    }
  }

  resetForm() {
    isFormSubmit.value = false;
    itemFormKey.currentState!.reset();
    selectedPurity.value = null;
    currentItem.value = null;
    fromMode("create");
  }
}
