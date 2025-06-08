
import 'package:ausales_application/controller/lot/lot_item_table_controller.dart';
import 'package:ausales_application/model/drop_down_model.dart';
import 'package:ausales_application/model/lot/lot_model.dart';
import 'package:ausales_application/service/dropdown_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LotItemFormController extends GetxController {

  final LotItemTableController _lotItemTableController = Get.put(LotItemTableController());

  final lotItemFormKey = GlobalKey<FormState>();

  TextEditingController itemDetailSearchController = TextEditingController();

  TextEditingController tagCountController = TextEditingController();
  TextEditingController piecesController = TextEditingController();
  TextEditingController grossWeightController = TextEditingController();
  TextEditingController remarksController = TextEditingController();

  Rx<int?> currentIndex = Rx<int?>(null);
  Rx<int?> currentItemId = Rx<int?>(null);

  Rx<DropdownModel?> selectedItem = Rx<DropdownModel?>(null);

  RxList<DropdownModel> itemDropDown = <DropdownModel>[].obs;

  RxBool isFormSubmit = false.obs;
  RxBool isDeleteLoading = false.obs;
  RxBool isDbValue = false.obs;

  RxString fromMode = "create".obs;

  @override
  void onInit() {
    super.onInit();
    getItemList();
  }

  Future getItemList() async {
    itemDropDown([]);
    final List<ItemDropdownModel> tempList =
        await DropdownService.itemDropDown();
    tempList.forEach((item) {
      itemDropDown.add(DropdownModel(
          value: item.id.toString(), label: item.itemName.toString()));
    });
  }

  editItem(int index, LotFormItemDataModel item) {
    selectedItem(DropdownModel(value: item.itemDetails.toString(), label: item.itemDetailsName!));
    tagCountController.text = item.tagCount??"";
    piecesController.text = item.pieces??"";
    grossWeightController.text = item.grossWeight??"";
    remarksController.text = item.remark??"";
    currentIndex(index);
    isDbValue(item.isDb);
    currentItemId(item.id);
  }

  deleteItem(int index, LotFormItemDataModel item) {
    isDeleteLoading(true);
    _lotItemTableController.tableData.removeAt(index);
    isDeleteLoading(false);
  }

  Future submitLotItemForm(BuildContext context) async {
    if (lotItemFormKey.currentState!.validate()) {

      final LotFormItemDataModel itemData = LotFormItemDataModel(
        id: currentItemId.value,
        itemDetails: int.parse(selectedItem.value!.value),
        itemDetailsName: selectedItem.value!.label,
        tagCount: tagCountController.text,
        pieces: piecesController.text,
        grossWeight: grossWeightController.text,
        remark: remarksController.text,
        isDb: isDbValue.value
      );

      if (fromMode.value == 'create') {
        _lotItemTableController.tableData.add(itemData);
      } else {
        _lotItemTableController.tableData[currentIndex.value!] = itemData;
      }
      
      resetForm();
    }
  }

  resetForm() {
    selectedItem.value = null;
    lotItemFormKey.currentState?.reset();
    fromMode('create');
    isDbValue(false);
  }

}