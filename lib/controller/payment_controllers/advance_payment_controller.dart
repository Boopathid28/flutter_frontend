import 'package:ausales_application/core/constants/app_configuration.dart';
import 'package:ausales_application/core/shared_preferences/home_shared_prefs.dart';
import 'package:ausales_application/model/advance/advance_models.dart';
import 'package:ausales_application/model/drop_down_model.dart';
import 'package:ausales_application/model/payment/advance_payment_model.dart';
import 'package:ausales_application/service/advance/advance_service.dart';
import 'package:ausales_application/service/dropdown_service.dart';
import 'package:ausales_application/view/widgets/form_widgets/primary_button.dart';
import 'package:ausales_application/view/widgets/form_widgets/secondary_button.dart';
import 'package:ausales_application/view/widgets/payment_widgets/advance_payment/advance_details_retrieve_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:toastification/toastification.dart';

class AdvancePaymentController extends GetxController {
  RxBool isAdvanceFetchLoading = false.obs;

  TextEditingController advanceSearchController = TextEditingController();

  TextEditingController advanceMetalRateController = TextEditingController();
  TextEditingController advanceRedeemWeightController = TextEditingController();
  TextEditingController advanceRedeemAmountController = TextEditingController();

  RxDouble totalAdvanceAmount = 0.0.obs;
  RxDouble totalAdvanceMetalValue = 0.0.obs;

  Future getAdvanceDetails(BuildContext context,
      List<AdvancePaymentItemModel> itemsList, Function() onCompleted) async {
    if (advanceSearchController.text.isNotEmpty) {
      isAdvanceFetchLoading(true);

      bool isValid = true;

      for (var i in itemsList) {
        if (i.advanceDetailsNo == advanceSearchController.text) {
          isValid = false;
          break;
        } else {
          isValid = true;
        }
      }

      if (isValid) {
        final AdvanceRetrieveData? data =
            await AdvanceService.retrieveAdvanceByNumber(
                context: context, advanceNumber: advanceSearchController.text);

        advanceSearchController.clear();

        isAdvanceFetchLoading(false);
        if (data != null) {
          if (data.metalRate != "null") {
            advanceMetalRateController.text = data.metalRate!;
          }
          await Get.dialog(
              barrierDismissible: false,
              AdvanceDetailsRetrieveForm(
                  data: data,
                  onCompleted: onCompleted,
                  advanceItemsList: itemsList));
        }
      } else {
        isAdvanceFetchLoading(false);
        toastification.show(
            context: context, // optional if you use ToastificationWrapper
            type: ToastificationType.info,
            title: Text("${advanceSearchController.text} is already added!"),
            autoCloseDuration: notificationDuration,
            showProgressBar: false,
            pauseOnHover: false);
      }
    } else {
      toastification.show(
          context: context, // optional if you use ToastificationWrapper
          type: ToastificationType.info,
          title: Text("Advance Search Field is Not Empty"),
          autoCloseDuration: notificationDuration,
          showProgressBar: false,
          pauseOnHover: false);
    }
  }

  void applyAdvanceDetails(
      BuildContext context,
      AdvanceRetrieveData advanceData,
      Function() onCompleted,
      List<AdvancePaymentItemModel> itemsList) {
    if ((advanceRedeemAmountController.text.isNotEmpty &&
            advanceMetalRateController.text.isNotEmpty) ||
        advanceRedeemAmountController.text.isNotEmpty) {
      AdvancePaymentItemModel advanceDetails = AdvancePaymentItemModel(
          advanceDetails: advanceData.id,
          advanceDetailsNo: advanceData.advanceId,
          redeemWeight: double.parse(advanceRedeemWeightController.text.isEmpty
              ? "0"
              : advanceRedeemWeightController.text),
          redeemAmount: double.parse(advanceRedeemAmountController.text.isEmpty
              ? "0"
              : advanceRedeemAmountController.text),
          redeemMetalRate: double.parse(advanceMetalRateController.text.isEmpty
              ? "0"
              : advanceMetalRateController.text),
          redeemMetalValue: totalAdvanceMetalValue.value,
          totalAmount: totalAdvanceAmount.value);

      itemsList.add(advanceDetails);
      onCompleted();
      advanceRedeemWeightController.clear();
      advanceMetalRateController.clear();
      advanceRedeemAmountController.clear();
      totalAdvanceMetalValue(0.0);
      totalAdvanceAmount(0.0);
      Get.back();
    } else {
      toastification.show(
          context: context, // optional if you use ToastificationWrapper
          type: ToastificationType.info,
          title: Text("Advance Amount or Advance Weight Field is Required"),
          autoCloseDuration: notificationDuration,
          showProgressBar: false,
          pauseOnHover: false);
    }
  }

  ///////////////////////////// Form

  final advancePaymentFormKey = GlobalKey<FormState>();

  TextEditingController advanceAmountController = TextEditingController();
  TextEditingController advanceWeightController = TextEditingController();
  TextEditingController remarksController = TextEditingController();

  Rx<DropdownModel?> selectedPurity = Rx<DropdownModel?>(null);
  Rx<DropdownModel?> selectedAdvancePurpose = Rx<DropdownModel?>(null);

  RxList<DropdownModel> purityDropDown = <DropdownModel>[].obs;
  RxList<DropdownModel> advancePurposeDropDown = <DropdownModel>[].obs;

  RxList<DenominationDetails> paymentParticulars = <DenominationDetails>[].obs;

  RxBool validatePurity = false.obs;

  RxBool isFormSubmit = false.obs;

  @override
  void onInit() {
    super.onInit();
    getPurityList();
    getAdvancePurposeList();
  }

  Future getPurityList() async {
    purityDropDown([]);
    selectedPurity.value = null;
    final List<PurityDropdownModel>? data =
        await DropdownService.purityDropDown(null);

    if (data != null) {
      for (var i in data) {
        purityDropDown.add(DropdownModel(
            value: i.id.toString(), label: i.purityName.toString()));
      }
    }
  }

  Future getAdvancePurposeList() async {
    advancePurposeDropDown([]);
    selectedAdvancePurpose.value = null;
    final List<AdvancePurposeDropdownmodel>? data =
        await DropdownService.advancePurposeDropDown();

    if (data != null) {
      for (var i in data) {
        advancePurposeDropDown.add(DropdownModel(
            value: i.value.toString(), label: i.lable.toString()));
      }
    }
  }

  void resetAdvancePaymentForm() {
    selectedAdvancePurpose.value = null;
    advanceAmountController.clear();
    advanceWeightController.clear();
    selectedPurity.value = null;
    remarksController.clear();
    paymentParticulars([]);
  }

  Future createAdvance(
      BuildContext context, String branch, String customer) async {
    if (advancePaymentFormKey.currentState!.validate()) {
      if (paymentParticulars.isNotEmpty) {
        if (!isFormSubmit.value) {
          isFormSubmit(true);
          CreateAdvancePayload payload = CreateAdvancePayload(
              advanceWeightPurity: selectedPurity.value?.value,
              branch: branch,
              customerDetails: customer,
              totalAdvanceAmount: advanceAmountController.text.isEmpty
                  ? "0"
                  : advanceAmountController.text,
              totalAdvanceWeight: advanceWeightController.text.isEmpty
                  ? "0"
                  : advanceWeightController.text,
              advancePurpose: selectedAdvancePurpose.value!.value,
              denominationDetails: paymentParticulars,
              remark: remarksController.text,
              menuId: await HomeSharedPrefs.getCurrentMenu());

          final AdvanceCreateResponse? data =
              await AdvanceService.createAdvance(
                  payload: payload, context: context);

          if (data != null) {
            Get.back();
            await Get.dialog(
                barrierDismissible: false,
                AlertDialog(
                      content: Text(
                        data.advanceId.toString(),
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
                                  text: data.advanceId.toString()));
                              toastification.show(
                                  context:
                                      context, // optional if you use ToastificationWrapper
                                  type: ToastificationType.error,
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
          resetAdvancePaymentForm();
          isFormSubmit(false);
        }
      }else {
        toastification.show(
          type: ToastificationType.error,
          title: Text('Atleast Add One Payment'),
          autoCloseDuration: notificationDuration,
          showProgressBar: false,
          pauseOnHover: false);
      }
    }
  }
}
