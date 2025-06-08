import 'package:ausales_application/controller/order/order_form_controller.dart';
import 'package:ausales_application/core/constants/app_configuration.dart';
import 'package:ausales_application/core/shared_preferences/home_shared_prefs.dart';
import 'package:ausales_application/model/drop_down_model.dart';
import 'package:ausales_application/model/order/order_models.dart';
import 'package:ausales_application/model/payment/old_gold_payment_model.dart';
import 'package:ausales_application/service/dropdown_service.dart';
import 'package:ausales_application/service/payment/payment_service.dart';
import 'package:ausales_application/view/widgets/form_widgets/primary_button.dart';
import 'package:ausales_application/view/widgets/form_widgets/secondary_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:toastification/toastification.dart';
import 'package:uuid/uuid.dart';

class OrderOldMetalPaymentController extends GetxController {
  final OrderFormController _orderFormController =
      Get.put(OrderFormController());

  RxBool isOldMetalFetchLoading = false.obs;

  TextEditingController oldMetalSearchController = TextEditingController();

  Future getOldMetalDetails(
      BuildContext context,
      RxList<OrderOldPurchasePaymentParticularsDetails> itemsList,
      Function() onCompleted) async {
    if (oldMetalSearchController.text.isNotEmpty) {
      isOldMetalFetchLoading(true);

      bool isValid = true;

      for (var i in itemsList) {
        if (i.oldGoldBillNo == oldMetalSearchController.text) {
          isValid = false;
          break;
        } else {
          isValid = true;
        }
      }

      if (isValid) {
        final OldPurchasePaymentRetrieveResponse? data =
            await PaymentService.retrieveOldPurchaseByNumber(
                context: context,
                oldPurdchaseNumber: oldMetalSearchController.text);

        oldMetalSearchController.clear();

        isOldMetalFetchLoading(false);
        if (data != null) {
          itemsList.add(OrderOldPurchasePaymentParticularsDetails(
              id: data.id.toString(),
              oldGoldBillNo: data.oldGoldBillNumber,
              totalAmount: data.oldGoldAmount!.toStringAsFixed(2)));
          onCompleted();
        }
      } else {
        isOldMetalFetchLoading(false);
        toastification.show(
            context: context, // optional if you use ToastificationWrapper
            type: ToastificationType.info,
            title: Text("${oldMetalSearchController.text} is already added!"),
            autoCloseDuration: notificationDuration,
            showProgressBar: false,
            pauseOnHover: false);
      }
    } else {
      toastification.show(
          context: context, // optional if you use ToastificationWrapper
          type: ToastificationType.info,
          title: Text("Suspense Search Field is Not Empty"),
          autoCloseDuration: notificationDuration,
          showProgressBar: false,
          pauseOnHover: false);
    }
  }

  ////////////////////////// Form
  final oldMetalPaymentFormKey = GlobalKey<FormState>();

  TextEditingController metalSearchController = TextEditingController();

  TextEditingController touchWeightController = TextEditingController();
  TextEditingController itemController = TextEditingController();
  TextEditingController reduceWeightController = TextEditingController();
  TextEditingController grossWeightController = TextEditingController();
  TextEditingController metalRateController = TextEditingController();
  TextEditingController dustWeightController = TextEditingController();
  TextEditingController netWeightController = TextEditingController();
  TextEditingController oldAmountController = TextEditingController();
  TextEditingController gstAmountController = TextEditingController();
  TextEditingController totalAmountController = TextEditingController();

  Rx<DropdownModel?> selectedMetal = Rx<DropdownModel?>(null);

  RxList<DropdownModel> metalDropDown = <DropdownModel>[].obs;

  RxList<OldMetalDropdownModel> metalList = <OldMetalDropdownModel>[].obs;

  RxBool isFormSubmit = false.obs;

  RxString formMode = 'create'.obs;
  RxString updateId = ''.obs;

  @override
  void onInit() {
    super.onInit();
    getMetalList();
  }

  Future getMetalList() async {
    metalDropDown([]);
    selectedMetal.value = null;
    final List<OldMetalDropdownModel>? data =
        await DropdownService.oldMetalDropDown();

    if (data != null) {
      metalList(data);
      for (var i in data) {
        metalDropDown.add(DropdownModel(
            value: i.id.toString(), label: i.metalDetailsName.toString()));
      }
    }
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
    calculateTotalAmount(
      touch:
          touchWeightController.text.isEmpty ? "0" : touchWeightController.text,
      reduceWeight: reduceWeightController.text.isEmpty
          ? "0.0"
          : reduceWeightController.text,
      metal: metal.value,
      oldRate:
          oldAmountController.text.isEmpty ? "0" : oldAmountController.text,
      metalRate:
          metalRateController.text.isEmpty ? "0" : metalRateController.text,
      metalWeight:
          grossWeightController.text.isEmpty ? "0" : grossWeightController.text,
    );
  }

  void calculateTotalAmount({
    required String oldRate,
    required String metalRate,
    required String metalWeight,
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
    final double Touch = double.parse(touch.isEmpty ? "0.0" : touch);

    final reduced_weight = grossWeight - reduceweight;

    final netWeight = reduced_weight * Touch / 100;

    final dustWeight = reduced_weight - netWeight;
    final predictTotal = oldMetalAmount * netWeight;

    // var gstAmount;
    // if (_orderFormController.selectedGstType.value?.value == interGstType) {
    //   for (var i in metalList) {
    //     if (i.id.toString() == metal) {
    //       gstAmount = predictTotal * (double.parse(i.interGst ?? "0") / 100);
    //       break;
    //     }
    //   }
    // } else if (_orderFormController.selectedGstType.value?.value ==
    //     intraGstType) {
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

  void addItemInList(
      BuildContext context, RxList<OldItemPaymentDetails> itemList) {
    if (oldMetalPaymentFormKey.currentState!.validate()) {
      if (formMode.value == 'create') {
        var uuid = Uuid();
        OldItemPaymentDetails item = OldItemPaymentDetails(
          id: uuid.v4(),
          item: itemController.text,
          oldMetal: selectedMetal.value?.value,
          oldMetalName: selectedMetal.value?.label,
          oldWeight: double.parse(grossWeightController.text),
          oldRate: double.parse(metalRateController.text),
          grossWeight: double.parse(grossWeightController.text),
          reduceWeight: double.parse(reduceWeightController.text),
          touch: double.parse(touchWeightController.text),
          oldDustWeight: double.parse(dustWeightController.text),
          oldNetWeight: double.parse(netWeightController.text),
          gstAmount: 0.0,
          totalAmount: double.parse(totalAmountController.text),
        );

        itemList.insert(0, item);
      } else {
        int index = itemList.indexWhere((item) => item.id == updateId.value);
        OldItemPaymentDetails item = OldItemPaymentDetails(
          id: updateId.value,
          item: itemController.text,
          oldMetal: selectedMetal.value?.value,
          oldMetalName: selectedMetal.value?.label,
          oldWeight: double.parse(grossWeightController.text),
          oldRate: double.parse(metalRateController.text),
          grossWeight: double.parse(grossWeightController.text),
          reduceWeight: double.parse(reduceWeightController.text),
          touch: double.parse(touchWeightController.text),
          oldDustWeight: double.parse(dustWeightController.text),
          oldNetWeight: double.parse(netWeightController.text),
          gstAmount: 0.0,
          totalAmount: double.parse(totalAmountController.text),
        );

        itemList[index] = item;
      }
      resetOldMetalItemForm();
    }
  }

  editItem(OldItemPaymentDetails item) {
    formMode("update");
    selectedMetal(DropdownModel(
        value: item.oldMetal.toString(), label: item.oldMetalName!));
    updateId(item.id);
    itemController.text = item.item!;
    grossWeightController.text = item.grossWeight!.toStringAsFixed(3);
    reduceWeightController.text = item.reduceWeight!.toStringAsFixed(3);
    touchWeightController.text = item.touch!.toStringAsFixed(3);
    metalRateController.text = item.oldRate!.toStringAsFixed(2);
    dustWeightController.text = item.oldDustWeight!.toStringAsFixed(3);
    // gstAmountController.text = item.gstAmount!.toStringAsFixed(3);
    netWeightController.text = item.oldNetWeight!.toStringAsFixed(3);
    totalAmountController.text = item.totalAmount!.toStringAsFixed(2);
  }

  deleteItem(List<OldItemPaymentDetails> itemList, String id) {
    itemList.removeWhere((item) => item.id == id);
  }

  void resetOldMetalItemForm() {
    itemController.clear();
    grossWeightController.clear();
    metalRateController.clear();
    dustWeightController.clear();
    netWeightController.clear();
    oldAmountController.clear();
    gstAmountController.clear();
    totalAmountController.clear();
    touchWeightController.clear();
    reduceWeightController.clear();
    selectedMetal.value = null;
    formMode('create');
    updateId("");
  }

  Future createOldPurchase(
      BuildContext context, List<OldItemPaymentDetails> itemsList) async {
    if (itemsList.isNotEmpty) {
      if (!isFormSubmit.value) {
        isFormSubmit(true);

        OldPurchasePaymentPayload payload = OldPurchasePaymentPayload(
            menuId: await HomeSharedPrefs.getCurrentMenu(),
            customerDetails:
                _orderFormController.customerDetails.value.id.toString(),
            branch: _orderFormController.isBranchuser.value
                ? _orderFormController.selectedBranch.value?.value
                : null,
            oldItemDetails: itemsList);

        final OldPurchasePaymentCreateResponse? data =
            await PaymentService.createOldPurchasePayment(
                payload: payload, context: context);

        if (data != null) {
          Get.back();
          itemsList = [];
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
                            type: ToastificationType.success,
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
        }
        isFormSubmit(false);
      }
    } else {
      toastification.show(
          context: context, // optional if you use ToastificationWrapper
          type: ToastificationType.info,
          title: Text("Atleast one item should be added in the table"),
          autoCloseDuration: notificationDuration,
          showProgressBar: false,
          pauseOnHover: false);
    }
  }
}
