import 'package:ausales_application/controller/repair_creation/repair_creation_form_controller.dart';
import 'package:ausales_application/controller/repair_creation/repair_creation_table_list_controller.dart';
import 'package:ausales_application/core/shared_preferences/home_shared_prefs.dart';
import 'package:ausales_application/model/repair_creation/repair_creation_models.dart';
import 'package:ausales_application/responsive.dart';
import 'package:ausales_application/view/widgets/form_widgets/cancel_button.dart';
import 'package:ausales_application/view/widgets/form_widgets/primary_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class RepairCreationDeletePopup extends StatelessWidget {
  final RepairTableList item;
  RepairCreationDeletePopup({super.key, required this.item});

  final RepairCreationFormController _repairCreationFormController =
      Get.put(RepairCreationFormController());

  final RepairCreationTableListController _repairCreationTableListController = Get.put(RepairCreationTableListController() );    

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      insetPadding: EdgeInsets.all(Responsive.isMobile(context) ? 8.w : 0),
      content: const Text("Are you sure want to delete this item"),
      actions: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: Responsive.isMobile(context) ? 100.w : 200.w,
              child: CancelButton(
                  isLoading: false,
                  text: "No",
                  onPressed: () {
                    Get.back();
                  }),
            ),
            SizedBox(
              width: 15.w,
            ),
            SizedBox(
              width: Responsive.isMobile(context) ? 100.w : 200.w,
              child: Obx(() => PrimaryButton(
                  isLoading:
                      _repairCreationFormController.isDeleteLoading.value,
                  text: "Yes",
                  onPressed: () async {
                    _repairCreationFormController.formMode('delete');
                    _repairCreationFormController.isDeleteLoading(true);
                    int? menuId = await HomeSharedPrefs.getCurrentMenu();
                    if (menuId != null) {
                      _repairCreationFormController.formMode('delete');
                      await _repairCreationFormController
                          .submitRepairCreation(item.id.toString());
                    }
                  await  _repairCreationTableListController.getRepairCreationTableList();

                    _repairCreationFormController.isDeleteLoading(false);
                    Get.back();
                  })),
            )
          ],
        )
      ],
    );
  }
}
