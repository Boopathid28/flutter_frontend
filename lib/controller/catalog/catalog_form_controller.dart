import 'package:ausales_application/controller/catalog/catalog_list_controller.dart';
import 'package:ausales_application/core/shared_preferences/home_shared_prefs.dart';
import 'package:ausales_application/model/catalog/catalog_models.dart';
import 'package:ausales_application/model/drop_down_model.dart';
import 'package:ausales_application/service/catalog/catalog_service.dart';
import 'package:ausales_application/service/dropdown_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CatalogFormController extends GetxController {
  final CatalogListController _catalogListController = Get.put(CatalogListController());

  final catalogFormKey = GlobalKey<FormState>();

  Rx<CatalogListData?> currentCatalog = Rx<CatalogListData?>(null);

  TextEditingController catalogweightController = TextEditingController();
  TextEditingController catalognumberController = TextEditingController();

  TextEditingController searchCounterController = TextEditingController();

  Rx<DropdownModel?> selectedCounter = Rx<DropdownModel?>(null);
  Rx<DropdownModel?> selectedCatalogType = Rx<DropdownModel?>(null);

  RxBool isFormSubmit = false.obs;

  RxString fromMode = "create".obs;

  RxList<DropdownModel> counterDropDown = <DropdownModel>[].obs;
  RxList<DropdownModel> catalogTypeDropDown = <DropdownModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    getCounterList();
    getCatalogTypeList();
  }

  Future getCounterList() async {
    counterDropDown([]);
    final List<CounterDropdownModel> tempList =
        await DropdownService.counterDropDown();
    tempList.forEach((item) {
      counterDropDown.add(
          DropdownModel(label: item.counterName!, value: item.id.toString()));
    });
  }

  Future getCatalogTypeList() async {
    catalogTypeDropDown([]);
    final List<CatalogTypeDropdownModel> tempList =
        await DropdownService.catalogTypeDropDown();
    tempList.forEach((item) {
      catalogTypeDropDown.add(
          DropdownModel(label: item.lable!, value: item.value.toString()));
    });
  }

  Future submitCatalogForm(BuildContext context) async {
    if (catalogFormKey.currentState!.validate()) {
      if (!isFormSubmit.value) {
        isFormSubmit.value = true;
        if (fromMode.value == "create") {
          final CreateCatalogPayload payload = CreateCatalogPayload(
              menuId: await HomeSharedPrefs.getCurrentMenu(),
              counterDetails: selectedCounter.value!.value,
              catalogNumber: catalognumberController.text,
              catalogType: selectedCatalogType.value?.value,
              catalogWeight: catalogweightController.text);

          await CatalogService.createCatalog(context: context, payload: payload);
          _catalogListController.getCatalogList(context);
        } else {
          final UpdateCatalogPayload payload = UpdateCatalogPayload(
            menuId: await HomeSharedPrefs.getCurrentMenu(),
            counterDetails: selectedCounter.value!.value,
            catalogNumber: catalognumberController.text,
            catalogType: selectedCatalogType.value?.value,
            catalogWeight: catalogweightController.text,
            id: currentCatalog.value?.id,
          );

          await CatalogService.updateCatalog(
              context: context, payload: payload);
          _catalogListController.getCatalogList(context);
        }
        resetForm();
      }
    }
  }

  resetForm() {
    isFormSubmit.value = false;
    catalogFormKey.currentState!.reset();
    currentCatalog.value = null;
    catalogweightController.clear();
    catalognumberController.clear();
    selectedCounter.value =null;
    fromMode("create");
  }
}
