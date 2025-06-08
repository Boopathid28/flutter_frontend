import 'package:ausales_application/controller/layout/header_controller.dart';
import 'package:ausales_application/core/constants/app_configuration.dart';
import 'package:ausales_application/core/shared_preferences/home_shared_prefs.dart';
import 'package:ausales_application/model/drop_down_model.dart';
import 'package:ausales_application/model/metal_ledger/metal_ledger_models.dart';
import 'package:ausales_application/service/dropdown_service.dart';
import 'package:ausales_application/service/metal_ledger/metal_ledger_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MetalLedgerListController extends HeaderController {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  // TODO: implement isBranchuser
  RxBool get isBranchuser => super.isBranchuser;

  TextEditingController searchController = TextEditingController();
  TextEditingController searchbranchController = TextEditingController();
  TextEditingController searchvendorController = TextEditingController();
  TextEditingController datarangefilterController = TextEditingController();
  TextEditingController searcholdledgerentrytypeController =
      TextEditingController();
  TextEditingController searchmetalController = TextEditingController();
  TextEditingController searchtouchController = TextEditingController();

  Rx<DropdownModel?> selectedbranch = Rx<DropdownModel?>(null);
  Rx<DropdownModel?> selectedvendor = Rx<DropdownModel?>(null);
  Rx<DropdownModel?> selectedoldledgerentrytype = Rx<DropdownModel?>(null);
  Rx<DropdownModel?> selectedmetal = Rx<DropdownModel?>(null);
  Rx<DropdownModel?> selectedtouch = Rx<DropdownModel?>(null);
  RxObjectMixin<DropdownModel?> selectedCancelledStatus =
      DropdownModel(value: 'Active/Cancelled', label: 'Active/Cancelled').obs;

  RxList<DropdownModel> branchFilterList = <DropdownModel>[].obs;
  RxList<DropdownModel> vendorFilterList = <DropdownModel>[].obs;
  RxList<DropdownModel> oldledgerentrytypeFilterList = <DropdownModel>[].obs;
  RxList<DropdownModel> metalFilterList = <DropdownModel>[].obs;
  RxList<DropdownModel> touchFilterList = <DropdownModel>[].obs;

  RxList<DropdownModel> CancelledFilterList = [
    DropdownModel(value: 'Active/Cancelled', label: 'Active/Cancelled'),
    DropdownModel(value: 'Active', label: 'Active'),
    DropdownModel(value: 'Cancelled', label: 'Cancelled')
  ].obs;

  RxInt itemsPerPage = initialRowsPerPage.obs;
  RxInt page = 1.obs;
  RxInt totalpages = 1.obs;
  RxString totalPieces = "0".obs;
 RxDouble totalicweight = 0.0.obs;
  RxDouble totaloutWeight = 0.0.obs;
  RxDouble totalremainingWeight = 0.0.obs;

  RxBool isTableLoading = true.obs;

  RxList<MetalLedgerListResponse> tableData = <MetalLedgerListResponse>[].obs;

  @override
  Future<void> onInit() async {
    final bool branch = await getIsBranchUser();
    if (branch == true) {
      getBranchList();
    }
    getmetalList();
    getvendorList();
    gettouchList();
    getoldledgerentrytypeList();
  }

  Future getBranchList() async {
    branchFilterList([]);
    final List<BranchDropDownModel> templist =
        await DropdownService.branchDropDown(isFilter: isFilter.toString());
    branchFilterList.add(DropdownModel(value: "0", label: "All"));
    templist.forEach((item) {
      branchFilterList.add(DropdownModel(
          value: item.id.toString(), label: item.branchName.toString()));
    });
    selectedbranch(DropdownModel(value: "0", label: "All"));
  }

  Future getmetalList() async {
    metalFilterList([]);
    final List<MetalDropdownModel> templist =
        await DropdownService.metalDropDown();
    metalFilterList.add(DropdownModel(value: "0", label: "All"));
    templist.forEach((item) {
      metalFilterList.add(DropdownModel(
          value: item.id.toString(), label: item.metalName.toString()));
    });
    selectedmetal(DropdownModel(value: "0", label: "All"));
  }

  Future getvendorList() async {
    vendorFilterList([]);
    final List<DesignerDropdownModel> templist =
        await DropdownService.designerDropDown();
    vendorFilterList.add(DropdownModel(value: "0", label: "All"));
    templist.forEach((item) {
      vendorFilterList.add(DropdownModel(
          value: item.id.toString(), label: item.designerName.toString()));
    });
    selectedvendor(DropdownModel(value: "0", label: "All"));
  }

  Future gettouchList() async {
    touchFilterList([]);
    final List<TouchDropdownModel> templist =
        await DropdownService.touchDropDown();
    touchFilterList.add(DropdownModel(value: "0", label: "All"));
    templist.forEach((item) {
      touchFilterList.add(DropdownModel(
          value: item.touch.toString(), label: item.touch.toString()));
    });
    selectedtouch(DropdownModel(value: "0", label: "All"));
  }

  Future getoldledgerentrytypeList() async {
    oldledgerentrytypeFilterList([]);
    final List<oldledgerentrytypeDropDownModel> templist =
        await DropdownService.oldLedgerEntryTypeDropDown();
    oldledgerentrytypeFilterList.add(DropdownModel(value: "0", label: "All"));
    templist.forEach((item) {
      oldledgerentrytypeFilterList.add(DropdownModel(
          value: item.value.toString(), label: item.lable.toString()));
    });
    selectedoldledgerentrytype(DropdownModel(value: "0", label: "All"));
  }

  Future getmetalledgerList(BuildContext context) async {
    isTableLoading(true);

    bool? isCancelledFilter;
    String? branchFilter;
    String? vendorFilter;
    String? oldledgerentrytypeFilter;
    String? touchFilter;
    String? fromDate;
    String? toDate;

    if (selectedbranch.value != null && selectedbranch.value?.value != "0") {
      branchFilter = selectedbranch.value?.value.toString();
    } else {
      branchFilter = null;
    }

    if (selectedvendor.value != null && selectedvendor.value?.value != "0") {
      vendorFilter = selectedvendor.value?.value.toString();
    } else {
      vendorFilter = null;
    }

    if (selectedtouch.value != null && selectedtouch.value?.value != "0") {
      touchFilter = selectedtouch.value?.value.toString();
    } else {
      touchFilter = null;
    }

    if (selectedoldledgerentrytype.value != null &&
        selectedoldledgerentrytype.value?.value != "0") {
      oldledgerentrytypeFilter =
          selectedoldledgerentrytype.value?.value.toString();
    } else {
      oldledgerentrytypeFilter = null;
    }

    if (selectedCancelledStatus.value!.value == "Active") {
      isCancelledFilter = false;
    } else if (selectedCancelledStatus.value!.value == "Cancelled") {
      isCancelledFilter = true;
    } else {
      isCancelledFilter = null;
    }

    if (datarangefilterController.text.isNotEmpty) {
      fromDate = datarangefilterController.text.split(' to ')[0];
      toDate = datarangefilterController.text.split(' to ')[1];
    } else {
      fromDate = null;
      toDate = null;
    }

    FetchMetalLedgerListPayload payload = FetchMetalLedgerListPayload(
        page: page.value,
        fromDate: fromDate,
        toDate: toDate,
        vendor: vendorFilter,
        oldLedgerEntryType: oldledgerentrytypeFilter,
        search: searchController.text,
        itemsPerPage: itemsPerPage.value,
        branch: branchFilter,
        touch: touchFilter,
        cancelStatus: isCancelledFilter,
        menuId: await HomeSharedPrefs.getCurrentMenu());

    final Map<String, dynamic>? metalledgerList =
        await MetalLedgerService.fetchMetalLedgerList(payload: payload);

    if (metalledgerList != null) {
      tableData(metalledgerList['list']);
      totalpages(metalledgerList['data']['total_pages']);
       totalicweight(metalledgerList['data']['total_ic_weight']);
      totaloutWeight(metalledgerList['data']['total_out_weight']);
      totalremainingWeight(metalledgerList['data']['total_remaining_weight']);
    } else {
      tableData([]);
      totalpages(1);
       totalicweight(0.0);
      totaloutWeight(0.0);
      totalremainingWeight(0.0);
    }

    isTableLoading(false);
  }
}
