import 'package:ausales_application/controller/transfer_creation/transfer_creation_list_controller.dart';
import 'package:ausales_application/core/shared_preferences/home_shared_prefs.dart';
import 'package:ausales_application/model/transfer_creation/transfer_creation_models.dart';
import 'package:ausales_application/service/transfer_creation/transfer_creation_service.dart';
import 'package:ausales_application/view/widgets/form_widgets/cancel_button.dart';
import 'package:ausales_application/view/widgets/form_widgets/primary_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/route_manager.dart';

class TransferCreationDeletePopup extends StatelessWidget {
  TransferCreationListData transfercreation;
  TransferCreationDeletePopup({super.key, required this.transfercreation});

  final TransferCreationListController _transferCreationListController = Get.put(TransferCreationListController());

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Text("Are you sure want to delete the ${transfercreation.bagNumber}"),
      actions: [
        Row(
          children: [
            SizedBox(
              width: 200.w,
              child: CancelButton(
                isLoading: false, 
                text: "No", 
                onPressed: () {
                  Get.back();
                }
              ),
            ),
            SizedBox(width: 15.w,),
            SizedBox(
              width: 200.w,
              child: Obx(() => PrimaryButton(
                isLoading: _transferCreationListController.isDeleteLoading.value, 
                text: "Yes", 
                onPressed: () async {
                  _transferCreationListController.isDeleteLoading(true);
                  int? menuId = await HomeSharedPrefs.getCurrentMenu();
                  if (menuId != null) {
                    await TransfercreationService.deleteTransferCreation(menuId: menuId.toString(), transferId: transfercreation.id.toString(), context: context);
                  }
                  _transferCreationListController.gettransfercreationList(context);
                  _transferCreationListController.isDeleteLoading(false);
                }
              )),
            )
          ],
        )
      ],
    );
  }
}