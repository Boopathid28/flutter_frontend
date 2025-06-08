import 'dart:async';
import 'dart:developer';

import 'package:ausales_application/core/constants/app_configuration.dart';
import 'package:ausales_application/core/constants/nav_controller.dart';
import 'package:ausales_application/core/shared_preferences/home_shared_prefs.dart';
import 'package:ausales_application/model/approval_issues/approval_issues_models.dart';
import 'package:ausales_application/model/order/order_models.dart';
import 'package:ausales_application/service/approval_issues/approval_issues_services.dart';
import 'package:ausales_application/view/screens/approval_issues/approval_issues_receipt_item_screen/approval_issues_receipt_item_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:toastification/toastification.dart';

class ApprovalIssuesReceiptController extends GetxController {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  final approvalreceiptformkey = GlobalKey<FormState>();

  Rx<OrderListData?> currentReceiveItem = Rx<OrderListData?>(null);

  RxInt itemsPerPage = initialRowsPerPage.obs;
  RxInt page = 1.obs;
  RxInt totalpages = 1.obs;
  RxBool isDeleteLoading = false.obs;
  RxBool isTableLoading = true.obs;
  RxBool isTable = false.obs;

  RxBool isFormSubmit = false.obs;
  RxBool isForm = false.obs;





  RxString issuesId = "".obs;
  RxString issuedBy = "".obs;
  RxString designerName = "".obs;
  RxString createdBy = "".obs;
  

  Rx<ApprovalIssuesReciptResponse?> tableData =
      Rx<ApprovalIssuesReciptResponse?>(null);

  RxList<ApprovalItemDetails> approvalParticularList =
      <ApprovalItemDetails>[].obs;

  @override
  void onInit() {
    super.onInit();
  }

  void onReceiveChange(String value, String id) {
    int itemIndex =
        approvalParticularList.indexWhere((item) => item.id.toString() == id);
    var dataList = [...approvalParticularList.value];
    ApprovalItemDetails item = dataList[itemIndex];
    var jsonObjectItem = item.toJson();
    jsonObjectItem['received_by'] = value;
    ApprovalItemDetails updatedItem =
        ApprovalItemDetails.fromJson(jsonObjectItem);

    approvalParticularList[itemIndex] = updatedItem;
  }

  Future getReceiveItemList(BuildContext context, String? id) async {

    final ApprovalIssuesReciptResponse approvalReceivelist =
        await ApprovalIssuesServices.retrieveReceiveItem(
            receiveId: id, context: context);

    if (approvalReceivelist != null) {
      tableData(approvalReceivelist);
      approvalParticularList(approvalReceivelist.itemDetails);
      issuesId(approvalReceivelist.issueId);
      designerName(approvalReceivelist.designerName);
      createdBy(approvalReceivelist.createdBy);
      issuedBy(approvalReceivelist.issuedBy);
    } else {
      tableData();
      totalpages(1);
      issuesId("");
      designerName("");
      createdBy("");
      issuedBy("");
    }
    Get.to(() => ApprovalIssuesReceiptItemScreen());
    isTableLoading(false);
    resetreceiveitem(context);
  }

  void resetreceiveitem(BuildContext context) {
    isFormSubmit(false);
  }

  Future createReceipt(BuildContext context) async {
    if (!isForm.value) {
      isForm.value = true;
      if (approvalParticularList.isNotEmpty) {
        List<ApprovalItemDetail> approvalItemDetailId = <ApprovalItemDetail>[].obs;
        for (var i in approvalParticularList.value) {
          ApprovalItemDetail approvalItemDetail =
              ApprovalItemDetail(id: i.id, receivedBy: i.receivedBy);
              approvalItemDetailId.add(approvalItemDetail);
        }

        CreateApprovalIssuesReciptPayload payload =
            CreateApprovalIssuesReciptPayload(
              approvalItemDetails: approvalItemDetailId,
                menuId: await HomeSharedPrefs.getCurrentMenu());

        final CreateReceiptResponse? data =
            await  ApprovalIssuesServices.createApprovalIssuesReceipt(
                payload: payload, context: context);
        if (data != null) {
          approvalParticularList([]);
          navApprovalIssues();
        }
      } else {
        toastification.show(
            context: context, // optional if you use ToastificationWrapper
            type: ToastificationType.info,
            title: Text("Add at least one Receive Item"),
            autoCloseDuration: notificationDuration,
            showProgressBar: false,
            pauseOnHover: false);

        isForm.value = false;
      }
    }
  }
}
