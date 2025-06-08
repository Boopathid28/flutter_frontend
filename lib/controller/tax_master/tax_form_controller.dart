import 'package:ausales_application/controller/tax_master/tax_list_controller.dart';
import 'package:ausales_application/core/shared_preferences/home_shared_prefs.dart';
import 'package:ausales_application/model/drop_down_model.dart';
import 'package:ausales_application/model/tax/tax_models.dart';
import 'package:ausales_application/service/dropdown_service.dart';
import 'package:ausales_application/service/tax_master/tax_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TaxFormController extends GetxController {
  final TaxListController _taxListController = Get.put(TaxListController());

  final taxFormKey = GlobalKey<FormState>();

  Rx<TaxListData?> currentTax = Rx<TaxListData?>(null);

  TextEditingController taxNameController = TextEditingController();
  TextEditingController taxCodeController = TextEditingController();
  TextEditingController purchaseigstController = TextEditingController();
  TextEditingController purchasecgstController = TextEditingController();
  TextEditingController purchasesgstController = TextEditingController();
  TextEditingController salesigstController = TextEditingController();
  TextEditingController salescgstController = TextEditingController();
  TextEditingController salessgstController = TextEditingController();

  RxObjectMixin<TaxDetailModel> taxDetails = TaxDetailModel().obs;


  TextEditingController searchtaxController = TextEditingController();

  Rx<DropdownModel?> selectedMetal = Rx<DropdownModel?>(null);

  RxBool isFormSubmit = false.obs;

  RxString fromMode = "create".obs;

  RxList<DropdownModel> metalDropDown = <DropdownModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    getMetalNameList();
  }


  Future getMetalNameList() async {
    metalDropDown([]);
    final List<MetalDropdownModel> tempList =
        await DropdownService.metalDropDown();
    tempList.forEach((item) {
      metalDropDown
          .add(DropdownModel(label: item.metalName!, value: item.id.toString()));
    });

  }

    Future getCustomerList(BuildContext context , int id) async {
    int? menuId = await HomeSharedPrefs.getCurrentMenu();
    final response = await TaxService.getTaxdetails(
        menuId: menuId.toString(),
        taxId: id.toString(),
        context: context);


        taxDetails(TaxDetailModel.fromJson(response['data']));

  }

  Future submitTaxForm(BuildContext context) async {
    if (taxFormKey.currentState!.validate()) {

      if (!isFormSubmit.value) {
        isFormSubmit.value = true;
        if (fromMode.value == "create") {
          final CreateTaxPayload payload = CreateTaxPayload(
              menuId: await HomeSharedPrefs.getCurrentMenu(),
              taxName: taxNameController.text,
              taxCode: taxCodeController.text,
              purchaseIgst: double.parse(purchaseigstController.text),
              purchaseCgst: double.parse(purchasecgstController.text),
              purchaseSgst: double.parse(purchasesgstController.text),
              salesCgst: double.parse(salescgstController.text),
              salesIgst: double.parse(salesigstController.text),
              salesSgst: double.parse(salessgstController.text),
              metal:  int.parse(selectedMetal.value!.value));

          await TaxService.createTax(context: context, payload: payload);
          _taxListController.getTaxList(context);
        } else {
          final UpdateTaxPayload payload = UpdateTaxPayload(
            menuId: await HomeSharedPrefs.getCurrentMenu(),
            id: currentTax.value?.id,
              taxName: taxNameController.text,
              taxCode: taxCodeController.text,
              purchaseIgst: double.parse(purchaseigstController.text),
              purchaseCgst: double.parse(purchasecgstController.text),
              purchaseSgst: double.parse(purchasesgstController.text),
              salesCgst: double.parse(salescgstController.text),
              salesIgst: double.parse(salesigstController.text),
              salesSgst: double.parse(salessgstController.text),
              metal:  int.parse(selectedMetal.value!.value)
          );

          await TaxService.updateTax(context: context, payload: payload);
          _taxListController.getTaxList(context);
        }
          resetForm();
          Get.back();
      }
        
    }
  }

  resetForm() {
    isFormSubmit.value = false;
    taxFormKey.currentState!.reset();
    taxNameController.clear();
    taxCodeController.clear();
    purchasecgstController.clear();
    purchaseigstController.clear();
    purchasesgstController.clear();
    salescgstController.clear();
    salesigstController.clear();
    salessgstController.clear();
    selectedMetal.value = null;
    currentTax.value = null;
    fromMode("create");
  }
}
