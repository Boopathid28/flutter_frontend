import 'package:ausales_application/core/constants/app_configuration.dart';
import 'package:ausales_application/core/shared_preferences/home_shared_prefs.dart';
import 'package:ausales_application/model/drop_down_model.dart';
import 'package:ausales_application/model/payment/suspense_payment_model.dart';
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

class SuspensePaymentController extends GetxController {
  RxBool isSuspenseFetchLoading = false.obs;

  TextEditingController suspenseSearchController = TextEditingController();

  Future getSuspenseDetails(BuildContext context, RxList<SuspenseFetchParticularsDetails> itemsList, Function() onCompleted) async {
    if (suspenseSearchController.text.isNotEmpty) {
          isSuspenseFetchLoading(true);

          bool isValid = true;

          for (var i in itemsList) {
            if (i.suspenseId == suspenseSearchController.text) {
              isValid = false;
              break;
            } else {
              isValid = true;
            }
          }

          if (isValid) {
            final SuspenseRetrieveDetails? data =
                await PaymentService.retrieveSuspenseDetail(
                    context: context, SuspenseId: suspenseSearchController.text);

            suspenseSearchController.clear();

            isSuspenseFetchLoading(false);
            if (data != null) {
              itemsList.add(SuspenseFetchParticularsDetails(id: data.id.toString(), suspenseId: data.suspenseId, totalAmount: data.suspenseAmount!.toStringAsFixed(2)));
              onCompleted();
            }
          } else {
            isSuspenseFetchLoading(false);
            toastification.show(
                context: context, // optional if you use ToastificationWrapper
                type: ToastificationType.info,
                title: Text("${suspenseSearchController.text} is already added!"),
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

  ///////////////////////////// Form

  final suspensePaymentFormKey = GlobalKey<FormState>();

  TextEditingController metalSearchController = TextEditingController();
  TextEditingController itemSearchController = TextEditingController();
  TextEditingController subItemSearchController = TextEditingController();

  TextEditingController metalWeightController = TextEditingController();
  TextEditingController metalAmountController = TextEditingController();
  TextEditingController totalAmountController = TextEditingController();

  Rx<DropdownModel?> selectedMetal = Rx<DropdownModel?>(null);
  Rx<DropdownModel?> selectedItem = Rx<DropdownModel?>(null);
  Rx<DropdownModel?> selectedSubItem = Rx<DropdownModel?>(null);

  RxList<DropdownModel> metalDropDown = <DropdownModel>[].obs;
  RxList<DropdownModel> itemDropDown = <DropdownModel>[].obs;
  RxList<DropdownModel> subItemDropDown = <DropdownModel>[].obs;

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
    itemDropDown([]);
    selectedItem.value = null;
    subItemDropDown([]);
    selectedSubItem.value = null;
    final List<MetalDropdownModel>? data =
        await DropdownService.metalDropDown();

    if (data != null) {
      for (var i in data) {
        metalDropDown.add(DropdownModel(
            value: i.id.toString(), label: i.metalName.toString()));
      }
    }
  }

  Future getItemList(String? metal, DropdownModel? selected) async {
    itemDropDown([]);
    selectedItem.value = null;
    subItemDropDown([]);
    selectedSubItem.value = null;
    final List<ItemDropdownModel>? data =
        await DropdownService.itemDropDown(metal: metal, purity: null);

    if (data != null) {
      for (var i in data) {
        itemDropDown.add(DropdownModel(
            value: i.id.toString(), label: i.itemName.toString()));
      }
      if (selected != null) {
        selectedItem(selected);
      }
    }
  }

  Future getSubItemList(
      String? metal, String? item, DropdownModel? selected) async {
    subItemDropDown([]);
    selectedSubItem.value = null;
    final List<SubItemDropdownModel>? data =
        await DropdownService.subItemDropDown(
            metal: metal, item: item, purity: null);

    if (data != null) {
      for (var i in data) {
        subItemDropDown.add(DropdownModel(
            value: i.id.toString(), label: i.subItemName.toString()));
      }
      if (selected != null) {
        selectedSubItem(selected);
      }
    }
  }

  void addItemInList(
      BuildContext context, RxList<SuspensePaymentItemModel> itemList) {
    if (suspensePaymentFormKey.currentState!.validate()) {
      if (formMode.value == 'create') {
        var id = Uuid();
        SuspensePaymentItemModel item = SuspensePaymentItemModel(
          id: id.v4(),
          metalDetails: selectedMetal.value?.value,
          metalName: selectedMetal.value?.label,
          itemDetails: selectedItem.value?.value,
          itemDetailsName: selectedItem.value?.label,
          subItemDetails: selectedSubItem.value?.value,
          subItemDetailsName: selectedSubItem.value?.label,
          metalAmount: double.parse(metalAmountController.text.isEmpty
              ? "0"
              : metalAmountController.text),
          metalWeight: double.parse(metalWeightController.text.isEmpty
              ? "0"
              : metalWeightController.text),
          totalAmount: double.parse(totalAmountController.text.isEmpty
              ? "0"
              : totalAmountController.text),
        );

        itemList.insert(0, item);
      } else {
        int index = itemList.indexWhere((item) => item.id == updateId.value);
        SuspensePaymentItemModel item = SuspensePaymentItemModel(
          id: updateId.value,
          metalDetails: selectedMetal.value?.value,
          metalName: selectedMetal.value?.label,
          itemDetails: selectedItem.value?.value,
          itemDetailsName: selectedItem.value?.label,
          subItemDetails: selectedSubItem.value?.value,
          subItemDetailsName: selectedSubItem.value?.label,
          metalAmount: double.parse(metalAmountController.text.isEmpty
              ? "0"
              : metalAmountController.text),
          metalWeight: double.parse(metalWeightController.text.isEmpty
              ? "0"
              : metalWeightController.text),
          totalAmount: double.parse(totalAmountController.text.isEmpty
              ? "0"
              : totalAmountController.text),
        );

        itemList[index] = item;
      }
      resetSuspenseItemForm();
    }
  }

  void editItemInList(SuspensePaymentItemModel item) {
    updateId(item.id);
    formMode('update');

    selectedMetal(DropdownModel(
        value: item.metalDetails.toString(), label: item.metalName.toString()));

    getItemList(
        item.metalDetails.toString(),
        DropdownModel(
            value: item.itemDetails.toString(),
            label: item.itemDetailsName.toString()));
    getSubItemList(
        item.metalDetails.toString(),
        item.itemDetails.toString(),
        DropdownModel(
            value: item.subItemDetails.toString(),
            label: item.subItemDetailsName.toString()));

    metalAmountController.text = item.metalAmount!.toStringAsFixed(2);
    metalWeightController.text = item.metalWeight!.toStringAsFixed(2);
    totalAmountController.text = item.totalAmount!.toStringAsFixed(2);
  }

  void deleteItemInList(List<SuspensePaymentItemModel> itemList, String id) {
    itemList.removeWhere((item) => item.id == id);
  }

  void resetSuspenseItemForm() {
    formMode('create');
    updateId("");

    selectedMetal.value = null;
    selectedItem.value = null;
    selectedSubItem.value = null;

    itemDropDown([]);
    subItemDropDown([]);

    metalAmountController.clear();
    metalWeightController.clear();
    totalAmountController.clear();
  }

  Future createSuspense(
      BuildContext context,
      List<SuspensePaymentItemModel> itemsList,
      String branch,
      String customer) async {
    if (itemsList.isNotEmpty) {
      if (!isFormSubmit.value) {
        isFormSubmit(true);

        int? menuId = await HomeSharedPrefs.getCurrentMenu();

        SuspensePaymentCreatePayloadModel payload =
            SuspensePaymentCreatePayloadModel(
                branch: branch,
                customerDetails: customer,
                menuId: menuId,
                itemDetails: itemsList);

        final CreateSuspensePaymentResponse? data =
            await PaymentService.createSuspensePayment(
                payload: payload, context: context);

        if (data != null) {
          Get.back();
          await Get.dialog(
              barrierDismissible: false,
              AlertDialog(
                    content: Text(
                      data.suspenseId.toString(),
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
                            Clipboard.setData(
                                ClipboardData(text: data.suspenseId.toString()));
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
