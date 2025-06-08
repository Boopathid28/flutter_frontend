import 'dart:developer';
import 'package:ausales_application/controller/itemtag/create_itemtag_branch_form_controller.dart';
import 'package:ausales_application/core/constants/app_configuration.dart';
import 'package:ausales_application/core/shared_preferences/home_shared_prefs.dart';
import 'package:ausales_application/service/itemtag/itemtag_form_service.dart';
import 'package:ausales_application/view/screens/itemtag/itemtag_form/itemtag_form_screen.dart';
import 'package:ausales_application/view/widgets/form_widgets/custom_dropdown_search_field.dart';
import 'package:ausales_application/view/widgets/form_widgets/custom_label.dart';
import 'package:ausales_application/view/widgets/form_widgets/primary_button.dart';
import 'package:ausales_application/view/widgets/form_widgets/secondary_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:toastification/toastification.dart';

class CreateItemtagBranchForm extends StatefulWidget {
  const CreateItemtagBranchForm({super.key});

  @override
  State<CreateItemtagBranchForm> createState() =>
      _CreateItemtagBranchFormState();
}

class _CreateItemtagBranchFormState extends State<CreateItemtagBranchForm> {

  final CreateItemtagBranchFormController _createItemtagBranchFormController = Get.put(CreateItemtagBranchFormController());

  @override
  Widget build(BuildContext context) {
    return AlertDialog.adaptive(
      content: Container(
        width: 300.w,
          child: Form(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Obx(() => _createItemtagBranchFormController.isBranchuser.value ? branch() : SizedBox()),
                SizedBox(height: 10.h,),
                lot(),
              ],
            ),
          ),
      ),
      actions: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            SizedBox(
              width: 125.w,
              child: SecondaryButton(
                isLoading: false, 
                text: "Back", 
                onPressed: () {
                  _createItemtagBranchFormController.selectedBranch(null);
                  _createItemtagBranchFormController.selectedLot(null);
                  Get.back();
                }
              ),
            ),
            SizedBox(width: 15.w,),
            SizedBox(
              width: 125.w,
              child: Obx(() => PrimaryButton(
                isLoading: _createItemtagBranchFormController.isContinueLoading.value, 
                text: "Continue", 
                onPressed: () async {

                  if (_createItemtagBranchFormController.isBranchuser.value) {
                    if (_createItemtagBranchFormController.selectedLot.value != null && _createItemtagBranchFormController.selectedBranch.value != null) {
                      if (!_createItemtagBranchFormController.isContinueLoading.value) {
                        _createItemtagBranchFormController.isContinueLoading(true);
                        await HomeSharedPrefs.setBranchId(_createItemtagBranchFormController.selectedBranch.value!.value.toString());
                        var tagEntryId = await ItemtagFormService.createTagEntry(lotId: _createItemtagBranchFormController.selectedLot.value!.value, branch: _createItemtagBranchFormController.selectedBranch.value!.value.toString(), context: context);
                        if (tagEntryId != null) {
                          Get.back();
                          Get.to(() => ItemtagFormScreen(), arguments: {
                            "lotNo": _createItemtagBranchFormController.selectedLot.value!.label,
                            "branch": _createItemtagBranchFormController.selectedBranch.value!.value.toString(),
                            "tagEntryId": tagEntryId
                          });
                        }
                        _createItemtagBranchFormController.resetform();
                        _createItemtagBranchFormController.isContinueLoading(false);
                      }
                    } else {
                      toastification.show(
                        context: context, // optional if you use ToastificationWrapper
                        type: ToastificationType.info,
                        title: Text("Fill all the fields"),
                        autoCloseDuration: notificationDuration,
                        showProgressBar: false,
                        pauseOnHover: false);
                    }
                  } else {
                    if (_createItemtagBranchFormController.selectedLot.value != null) {
                      if (!_createItemtagBranchFormController.isContinueLoading.value) {
                        _createItemtagBranchFormController.isContinueLoading(true);
                        var tagEntryId = await ItemtagFormService.createTagEntry(lotId: _createItemtagBranchFormController.selectedLot.value!.value, branch: null, context: context);
                        if (tagEntryId != null) {
                          Get.back();
                          Get.to(() => ItemtagFormScreen(), arguments: {
                            "lotNo": _createItemtagBranchFormController.selectedLot.value!.label,
                            "tagEntryId": tagEntryId
                          });
                        }
                        _createItemtagBranchFormController.resetform();
                        _createItemtagBranchFormController.isContinueLoading(false);
                      }
                    } else {
                      toastification.show(
                        context: context, // optional if you use ToastificationWrapper
                        type: ToastificationType.info,
                        title: Text("Fill all the fields"),
                        autoCloseDuration: notificationDuration,
                        showProgressBar: false,
                        pauseOnHover: false);
                    }
                  }

                }
              )),
            )
          ],
        )
      ],
    );
  }

  SizedBox lot() {
    return SizedBox(
      width: 300.w,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomLabel(label: "Lot Number"),
          SizedBox(height: 7.h,),
          Obx(() => CustomDropdownSearchField(
            filled: true,
                controller: _createItemtagBranchFormController.lotNoSearchController,
                selectedValue: _createItemtagBranchFormController.selectedLot.value,
                options: _createItemtagBranchFormController.lotDropDown.value,
                onChanged: (value) {
                  _createItemtagBranchFormController.selectedLot(value);
                },
                hintText: "Lot Number",
              )),
        ],
      ),
    );
  }

  SizedBox branch() {
    return SizedBox(
      width: 300.w,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomLabel(label: "Branch"),
          SizedBox(height: 7.h,),
          Obx(() => CustomDropdownSearchField(
            filled: true,
                controller: _createItemtagBranchFormController.branchSearchController,
                selectedValue: _createItemtagBranchFormController.selectedBranch.value,
                options: _createItemtagBranchFormController.branchDropDown.value,
                onChanged: (value) {
                  _createItemtagBranchFormController.selectedBranch(value);
                  
                  _createItemtagBranchFormController.getLotList(value!.value);
                },
                hintText: "Branch",
              )),
        ],
      ),
    );
  }
  
}
