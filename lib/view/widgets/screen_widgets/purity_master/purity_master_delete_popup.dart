import 'package:ausales_application/controller/purity_master/purity_master_list_controller.dart';
import 'package:ausales_application/core/shared_preferences/home_shared_prefs.dart';
import 'package:ausales_application/model/purity_master/purity_master_model.dart';
import 'package:ausales_application/service/purity_master/purity_master_service.dart';
import 'package:ausales_application/view/widgets/form_widgets/cancel_button.dart';
import 'package:ausales_application/view/widgets/form_widgets/primary_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class PurityMasterDeletePopup extends StatelessWidget {
  PurityMasterListData item;
  PurityMasterDeletePopup({super.key, required this.item});

  final PurityMasterListController _purityMasterListController = Get.put(PurityMasterListController());

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Text("Are you sure want to delete the ${item.purityName}"),
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
                isLoading: _purityMasterListController.isDeleteLoading.value, 
                text: "Yes", 
                onPressed: () async {
                  _purityMasterListController.isDeleteLoading(true);
                  int? menuId = await HomeSharedPrefs.getCurrentMenu();
                  if (menuId != null) {
                    await PurityMasterService.deletePurityMaster(menuId: menuId.toString(), purityId: item.id.toString(), context: context);
                  }
                  _purityMasterListController.getPurityMasterList(context);
                  _purityMasterListController.isDeleteLoading(false);
                }
              )),
            )
          ],
        )
      ],
    );
  }
}