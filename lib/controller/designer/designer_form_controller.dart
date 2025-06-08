import 'package:ausales_application/controller/designer/designer_list_controller.dart';
import 'package:ausales_application/core/shared_preferences/home_shared_prefs.dart';
import 'package:ausales_application/model/designer/designer_model.dart';
import 'package:ausales_application/service/designer/designer_service.dart';
import 'package:ausales_application/view/widgets/screen_widgets/designer/designer_form.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DesignerFormController extends GetxController {
  final DesignerListController _designerListController =
      Get.put(DesignerListController());

  final designerFormKey = GlobalKey<FormState>();

  Rx<DesignerDetailsData?> currentDesigner = Rx<DesignerDetailsData?>(null);

  TextEditingController designerNameController = TextEditingController();
  TextEditingController designerCodeController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController mobileNumberController = TextEditingController();
  TextEditingController websiteController = TextEditingController();
  TextEditingController landlineController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController gstController = TextEditingController();
  TextEditingController panController = TextEditingController();
  TextEditingController accountNoController = TextEditingController();
  TextEditingController accountNameController = TextEditingController();
  TextEditingController ifscCodeController = TextEditingController();
  TextEditingController bankNameController = TextEditingController();
  TextEditingController branchNameController = TextEditingController();
  TextEditingController remarksController = TextEditingController();
  TextEditingController upiIdController = TextEditingController();

  RxBool isFormSubmit = false.obs;

  RxString fromMode = "create".obs;


  Future submitDesignerForm(BuildContext context) async {
    if (designerFormKey.currentState!.validate()) {
      if (!isFormSubmit.value) {
        isFormSubmit.value = true;
        if (fromMode.value == "create") {
          final CreateDesignerPayload payload = CreateDesignerPayload(
              menuId: await HomeSharedPrefs.getCurrentMenu(),
              designerName: designerNameController.text,
              designerCode: designerCodeController.text,
              mobileNumber: mobileNumberController.text,
              email: emailController.text,
              website: websiteController.text,
              landlineNumber: landlineController.text,
              address: addressController.text,
              gstNumber: gstController.text,
              remarks : remarksController.text,
              panNumber: panController.text,
              accountNumber: accountNoController.text,
              accountName: accountNameController.text,
              ifscCode: ifscCodeController.text,
              bankName: bankNameController.text,
              branchName: branchNameController.text,
              upiId: upiIdController.text,);


          await DesignerService.createDesigner(
              context: context, payload: payload);
          _designerListController.getDesignerlist(context);
        } else {
          final UpdateDesignerPayload payload = UpdateDesignerPayload(
            menuId: await HomeSharedPrefs.getCurrentMenu(),
              designerName: designerNameController.text,
              designerCode: designerCodeController.text,
              mobileNumber: mobileNumberController.text,
              email: emailController.text,
              remarks: remarksController.text,
              website: websiteController.text,
              landlineNumber: landlineController.text,
              address: addressController.text,
              gstNumber: gstController.text,
              panNumber: panController.text,
              accountNumber: accountNoController.text,
              accountName: accountNameController.text,
              ifscCode: ifscCodeController.text,
              bankName: bankNameController.text,
              branchName: branchNameController.text,
              upiId: upiIdController.text,
            id: currentDesigner.value?.id,
          );
          await DesignerService.updateDesigner(context: context, payload: payload);
          _designerListController.getDesignerlist(context);
        }
        resetForm();
        Get.back();
      }
    }
  }

  resetForm() {
    Get.back();
    isFormSubmit.value = false;
    designerFormKey.currentState!.reset();
    currentDesigner.value = null;
    designerNameController.clear();
    designerCodeController.clear();
    emailController.clear();
    mobileNumberController.clear();
    websiteController.clear();
    landlineController.clear();
    addressController.clear();
    gstController.clear();
    panController.clear();
    accountNoController.clear();
    accountNameController.clear();
    remarksController.clear();
    ifscCodeController.clear();
    bankNameController.clear();
    branchNameController.clear();
    upiIdController.clear();
    fromMode("create");
  }

  Future getDesignerDetails(BuildContext context, DesignerListData item) async {
    DesignerDetailsData? data = await DesignerService.retrieveDesigner(context: context, designerId: item.id.toString());

    if (data != null) {
      currentDesigner(data);
      designerNameController.text = data.designerName.toString();
      designerCodeController.text = data.designerCode.toString();
      emailController.text = data.email.toString();
      mobileNumberController.text = data.mobileNumber.toString();
      websiteController.text = data.website.toString();
      landlineController.text = data.landlineNumber.toString();
      addressController.text = data.address.toString();
      gstController.text = data.gstNumber.toString();
      panController.text = data.panNumber.toString();
      remarksController.text = data.remarks.toString();
      accountNoController.text = data.accountNumber.toString();
      accountNameController.text = data.accountName.toString();
      ifscCodeController.text = data.ifscCode.toString();
      bankNameController.text = data.bankName.toString();
      branchNameController.text = data.branchName.toString();
      upiIdController.text = data.upiId.toString();

      fromMode("update");

      await Get.dialog(
        barrierDismissible: false,
        DesignerForm()
      );
    } else {
      resetForm();
    }
  }
}
