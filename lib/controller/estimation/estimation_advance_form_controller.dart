import 'dart:math';

import 'package:ausales_application/controller/estimation/estimation_controller.dart';
import 'package:ausales_application/controller/layout/header_controller.dart';
import 'package:ausales_application/core/constants/app_configuration.dart';
import 'package:ausales_application/core/shared_preferences/home_shared_prefs.dart';
import 'package:ausales_application/model/advance/advance_models.dart';
import 'package:ausales_application/model/drop_down_model.dart';
import 'package:ausales_application/service/advance/advance_service.dart';
import 'package:ausales_application/service/dropdown_service.dart';
import 'package:ausales_application/view/widgets/form_widgets/primary_button.dart';
import 'package:ausales_application/view/widgets/form_widgets/secondary_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class EstimationAdvanceFormController extends HeaderController {

  final EstimationController _estimationController = Get.put(EstimationController());

  @override
  // TODO: implement isBranchuser
  RxBool get isBranchuser => super.isBranchuser;

  final estimationAdvanceFormKey = GlobalKey<FormState>();

  TextEditingController searchVendorDesignerController =
      TextEditingController();
  TextEditingController searchadvancepurposecontroller =
      TextEditingController();
  TextEditingController customerSearchController = TextEditingController();
  TextEditingController advanceamountController = TextEditingController();
  TextEditingController advanceweightcontroller = TextEditingController();
  TextEditingController advancepurposecontroller = TextEditingController();
  TextEditingController searchpuritycontroller = TextEditingController();
  TextEditingController remarkcontroller = TextEditingController();

  RxList<DropdownModel> customerDropDown = <DropdownModel>[].obs;
  RxList<DropdownModel> puritydropdown = <DropdownModel>[].obs;
  Rx<DropdownModel?> selectedCustomer = Rx<DropdownModel?>(null);
  Rx<DropdownModel?> selectedPurity = Rx<DropdownModel?>(null);

  RxList<DropdownModel> advancedropdown = <DropdownModel>[].obs;

  Rx<DropdownModel?> selectedAdvancePurpose = Rx<DropdownModel?>(null);

  RxBool totalweight = false.obs;

  RxBool isFormSubmit = false.obs;

  @override
  void onInit() {
    super.onInit();
    getPurityList();
    getAdvancePurposeList();
  }

  Future getAdvancePurposeList() async {
    advancedropdown([]);
    final List<AdvancePurposeDropdownmodel> tempList =
        await DropdownService.advancePurposeDropDown();
    tempList.forEach((item) {
      advancedropdown
          .add(DropdownModel(label: item.lable!, value: item.value.toString()));
    });
  }

  Future getPurityList() async {
    puritydropdown([]);
    final List<PurityDropdownModel> tempList =
        await DropdownService.purityDropDown(null);
    tempList.forEach((item) {
      puritydropdown.add(
          DropdownModel(label: item.purityName!, value: item.id.toString()));
    });
  }

  Future CreateAdvance(BuildContext context) async {
    if (estimationAdvanceFormKey.currentState!.validate()) {
      if (!isFormSubmit.value) {
        isFormSubmit(true);
        CreateAdvancePayload payload = CreateAdvancePayload(
            advanceWeightPurity: selectedPurity.value?.value,
            branch: _estimationController.selectedBranch.value?.value,
            customerDetails: _estimationController.customerDetails.value.id.toString(),
            totalAdvanceAmount: advanceamountController.text.isEmpty
                ? "0"
                : advanceamountController.text,
            totalAdvanceWeight: advanceweightcontroller.text.isEmpty
                ? "0"
                : advanceweightcontroller.text,
            advancePurpose: selectedAdvancePurpose.value!.value,
            remark: remarkcontroller.text,
            menuId: await HomeSharedPrefs.getCurrentMenu());

        final AdvanceCreateResponse? data = await AdvanceService.createAdvance(
            payload: payload, context: context);

        if (data != null) {
          await Get.dialog(
              barrierDismissible: false,
              AlertDialog(
                    content: Text(data.advanceId.toString(), style: TextStyle(
                      fontSize: 20.sp,
                      fontWeight: FontWeight.w600,
                      color: Colors.blue
                    ),),
                    actions: [
                      PrimaryButton(
                          isLoading: false,
                          text: 'Copy',
                          onPressed: () {
                            Clipboard.setData(
                                ClipboardData(text: data.advanceId.toString()));
                            
                            Get.back();
                          }),
                      SecondaryButton(
                          isLoading: false,
                          text: 'Close',
                          onPressed: () {
                            Get.back();
                          })
                    ],
                  ));
        }
        resetForm();
        isFormSubmit(false);
        Get.back();
      }
    }
  }

  resetForm() {
    selectedCustomer.value = null;
    selectedPurity.value = null;
    remarkcontroller.clear();
    advanceamountController.clear();
    advancepurposecontroller.clear();
    advancepurposecontroller.clear();
    advanceweightcontroller.clear();
  }
}
