import 'dart:async';
import 'dart:math';
import 'package:ausales_application/controller/invoice/invoice_controller.dart';
import 'package:ausales_application/core/constants/app_configuration.dart';
import 'package:ausales_application/core/shared_preferences/home_shared_prefs.dart';
import 'package:ausales_application/model/drop_down_model.dart';
import 'package:ausales_application/model/estimation/estimation_model.dart';
import 'package:ausales_application/model/invoice/invoice_models.dart';
import 'package:ausales_application/service/dropdown_service.dart';
import 'package:ausales_application/service/invoice/invoice_service.dart';
import 'package:ausales_application/view/widgets/form_widgets/primary_button.dart';
import 'package:ausales_application/view/widgets/form_widgets/secondary_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:toastification/toastification.dart';
import 'package:uuid/uuid.dart';

class InvoiceOldItemFormController extends GetxController {

  final InvoiceController _invoiceController = Get.put(InvoiceController());

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  final invoiceOldPurchaseItemFormDetailsFormKey = GlobalKey<FormState>();

  TextEditingController touchWeightController = TextEditingController();
  TextEditingController reduceWeightController = TextEditingController();
  TextEditingController grossWeightController = TextEditingController();
  TextEditingController metalRateController = TextEditingController();
  TextEditingController dustWeightController = TextEditingController();
  TextEditingController netWeightController = TextEditingController();
  TextEditingController oldAmountController = TextEditingController();
  TextEditingController gstAmountController = TextEditingController();
  TextEditingController totalAmountController = TextEditingController();
  TextEditingController itemnameController = TextEditingController();

  TextEditingController metalSearchController = TextEditingController();

  Rx<DropdownModel?> selectedMetal = Rx<DropdownModel?>(null);

  RxList<DropdownModel> metalDropDown = <DropdownModel>[].obs;

  RxList<OldMetalDropdownModel> metalList = <OldMetalDropdownModel>[].obs;

  RxBool isDeleteLoading = false.obs;

  RxString updatingItem = "".obs;
  RxString itemFormMode = "create".obs;

  @override
  void onInit() {
    super.onInit();
    getMetalList();
  }

  Future getMetalList() async {
    metalDropDown([]);
    final List<OldMetalDropdownModel> tempList =
        await DropdownService.oldMetalDropDown();
    metalList(tempList);
    tempList.forEach((item) {
      metalDropDown.add(DropdownModel(
          label: item.metalDetailsName!, value: item.id.toString()));
    });
  }

  void onMetalChange(DropdownModel metal) {
    selectedMetal(metal);
    metalRateController.clear();
    for (var i in metalList) {
      if (i.id.toString() == metal.value) {
        metalRateController.text = i.oldRate.toString();
        break;
      }
    }
    // if (_invoiceController.selectedGstType.value != null) {
      calculateTotalAmount(
        touch: touchWeightController.text.isEmpty ? "0" : touchWeightController.text,
        reduceWeight: reduceWeightController.text.isEmpty
            ? "0.0"
            : reduceWeightController.text,
        metal: metal.value,
        // gstType: _invoiceController.selectedGstType.value!.value,
        oldRate:
            oldAmountController.text.isEmpty ? "0" : oldAmountController.text,
        metalRate:
            metalRateController.text.isEmpty ? "0" : metalRateController.text,
        metalWeight: grossWeightController.text.isEmpty
            ? "0"
            : grossWeightController.text,
      );
    // }
  }

  void calculateTotalAmount({
    required String oldRate,
    required String metalRate,
    required String metalWeight,
    // required String gstType,
    required String metal,
    required String reduceWeight,
    required String touch,
  }) {
    final double oldMetalRate = double.parse(oldRate.isEmpty ? "0.0" : oldRate);
    final double oldMetalAmount =
        double.parse(metalRate.isEmpty ? "0.0" : metalRate);
    final double grossWeight =
        double.parse(metalWeight.isEmpty ? "0.0" : metalWeight);
    final double reduceweight =
        double.parse(reduceWeight.isEmpty ? "0.0" : reduceWeight);
          final double Touch =
        double.parse(touch.isEmpty ? "0.0" : touch);


    final reduced_weight = grossWeight - reduceweight;


  
    final netWeight = reduced_weight * Touch/100;
    
    final dustWeight = reduced_weight - netWeight;
    final predictTotal = oldMetalAmount * netWeight;

    // var gstAmount;
    // if (gstType == interGstType) {
    //   for (var i in metalList) {
    //     if (i.id.toString() == metal) {
    //       gstAmount = predictTotal * (double.parse(i.interGst ?? "0") / 100);
    //       log(gstAmount);
    //       break;
    //     }
    //   }
    // } else if (gstType == intraGstType) {
    //   for (var i in metalList) {
    //     if (i.id.toString() == metal) {
    //       gstAmount = predictTotal * (double.parse(i.intraGst ?? "0") / 100);
    //       break;
    //     }
    //   }
    // }

    // gstAmountController.text = gstAmount.toStringAsFixed(3);
    totalAmountController.text = predictTotal.toStringAsFixed(2);
    dustWeightController.text =
        dustWeight.isNaN ? "0" : dustWeight.toStringAsFixed(3);
    netWeightController.text =
        netWeight.isNaN ? "0" : netWeight.toStringAsFixed(3);
  }

  editItem(InvoiceOldItemDetails item) {
    itemFormMode("update");
    selectedMetal(DropdownModel(
        value: item.oldMetal.toString(), label: item.oldMetalName!));
    updatingItem(item.id);
    itemnameController.text = item.oldItemName.toString();
    grossWeightController.text = item.grossWeight!.toStringAsFixed(3);
    reduceWeightController.text = item.reduceWeight!.toStringAsFixed(3);
    touchWeightController.text = item.touch!.toStringAsFixed(3);
    metalRateController.text = item.oldRate!.toStringAsFixed(2);
    dustWeightController.text = item.oldDustWeight!.toStringAsFixed(3);
    // gstAmountController.text = item.gstAmount!.toStringAsFixed(3);
    netWeightController.text = item.oldNetWeight!.toStringAsFixed(3);
    totalAmountController.text = item.totalAmount!.toStringAsFixed(2);
  }

  deleteItem(InvoiceOldItemDetails oldItem) {
    _invoiceController.oldParticulars.removeWhere((item) => item.id == oldItem.id);
  }

  Future submitForm(BuildContext context) async {
    if (invoiceOldPurchaseItemFormDetailsFormKey.currentState!.validate()) {
      if (itemFormMode.value == "create") {
        var uuid = Uuid();
        InvoiceOldItemDetails oldItemDetails = InvoiceOldItemDetails(
          id: uuid.v4(),
          oldMetal: selectedMetal.value?.value,
          oldItemName: itemnameController.text,
          oldMetalName: selectedMetal.value?.label,
          grossWeight: double.parse(grossWeightController.text),
          oldRate: double.parse(metalRateController.text),
          oldDustWeight: double.parse(dustWeightController.text),
          oldNetWeight: double.parse(netWeightController.text),
          reduceWeight: double.parse(reduceWeightController.text),
          touch: double.parse(touchWeightController.text),
          gstAmount: 0.0,
          totalAmount: double.parse(totalAmountController.text),
        );
        _invoiceController.oldParticulars.insert(0, oldItemDetails);
      } else {
        int index =
            _invoiceController.oldParticulars.indexWhere((item) => item.id == updatingItem.value);

        InvoiceOldItemDetails oldItemDetails = InvoiceOldItemDetails(
          id: updatingItem.value,
          oldMetal: selectedMetal.value?.value,
          oldMetalName: selectedMetal.value?.label,
           oldItemName: itemnameController.text,
          grossWeight: double.parse(grossWeightController.text),
          oldRate: double.parse(metalRateController.text),
          oldDustWeight: double.parse(dustWeightController.text),
          oldNetWeight: double.parse(netWeightController.text),
          reduceWeight: double.parse(reduceWeightController.text),
          touch: double.parse(touchWeightController.text),
          gstAmount: 0.0,
          totalAmount: double.parse(totalAmountController.text),
        );
        _invoiceController.oldParticulars[index] = oldItemDetails;
      }

      resetForm(context);
    }
  }

  Future resetForm(BuildContext context) async {
    grossWeightController.clear();
    metalRateController.clear();
    dustWeightController.clear();
    netWeightController.clear();
    oldAmountController.clear();
    gstAmountController.clear();
    itemnameController.clear();
    totalAmountController.clear();
    touchWeightController.clear();
    reduceWeightController.clear();
    selectedMetal.value = null;
    itemFormMode('create');
  }

  Future createOldMetal(BuildContext context) async {
    if (!_invoiceController.isOldMetalSubmitLoading.value) {
      _invoiceController.isOldMetalSubmitLoading(true);
      if (_invoiceController.oldParticulars.isNotEmpty) {
        InvoiceOldPurchasePayload payload = InvoiceOldPurchasePayload(
          menuId: await HomeSharedPrefs.getCurrentMenu(),
          customerDetails: _invoiceController.customerDetails.value.id,
          branch: _invoiceController.selectedBranch.value?.value,
          oldItemDetails: _invoiceController.oldParticulars.value
        );

        final InvoiceOldPurchaseCreateResponse? data = await InvoiceService.createOldPurchase(context: context, payload: payload);

        if (data != null) {
          await Get.dialog(
            barrierDismissible: false,
            AlertDialog(
                  content: Text(
                    data.oldGoldBillNumber.toString(),
                    style: TextStyle(
                        fontSize: 20.sp,
                        fontWeight: FontWeight.w600,
                        color: Colors.blue),
                  ),
                  actions: [
                    PrimaryButton(
                        isLoading: false,
                        text: 'Copy',
                        onPressed: () {
                          Clipboard.setData(ClipboardData(
                              text: data.oldGoldBillNumber.toString()));
                          toastification.show(
                              context:
                                  context, // optional if you use ToastificationWrapper
                              type: ToastificationType.info,
                              title: Text("Copied"),
                              autoCloseDuration: notificationDuration,
                              showProgressBar: false,
                              pauseOnHover: false);
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
          Get.back();
        }
      } else {
        toastification.show(
          context: context, // optional if you use ToastificationWrapper
          type: ToastificationType.info,
          title: Text("Add at least one item"),
          autoCloseDuration: notificationDuration,
          showProgressBar: false,
          pauseOnHover: false
        );
      }
      _invoiceController.isOldMetalSubmitLoading(false);
    }
  }
}
