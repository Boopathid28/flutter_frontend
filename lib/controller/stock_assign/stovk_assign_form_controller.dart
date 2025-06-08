import 'package:ausales_application/controller/stock_assign/stock_assign_list_controller.dart';
import 'package:ausales_application/model/drop_down_model.dart';
import 'package:ausales_application/model/item_tag_details/item_tag_details_model.dart';
import 'package:ausales_application/service/dropdown_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class StockAssignFormController extends GetxController {
  final StockAssignListController _stockAssignListController = Get.put(StockAssignListController());


  TextEditingController boxSearchController = TextEditingController();
    TextEditingController tagnumberController = TextEditingController();
  TextEditingController tagnumberSearchController = TextEditingController();
    
  RxList<DropdownModel> selectedTagnumber = RxList<DropdownModel>([]);

  Rx<DropdownModel?> selectedbox = Rx<DropdownModel?>(null);
  RxString selectedTagDisplayValue = "".obs;
  RxList<DropdownModel> catalogDeopDown = <DropdownModel>[].obs;
  RxList<DropdownModel> tagnumberDropDown = <DropdownModel>[].obs;

    RxObjectMixin<ItemTagdetailsList> tableData = ItemTagdetailsList().obs;

  RxBool isFormSubmit = false.obs;

  RxString fromMode = "create".obs;


  @override
  void onInit() async{
    super.onInit();
    getCatalogList();
  }

  Future getCatalogList() async {
    catalogDeopDown([]);
    final List<CatalogDropdownModel> tempList =
        await DropdownService.catalogDropDown();
    tempList.forEach((item) {
      catalogDeopDown.add(
          DropdownModel(label: item.catalogNumber!, value: item.id.toString()));
    });
  }

  resetForm() {
    isFormSubmit.value = false;
    fromMode("create");
  }
}
