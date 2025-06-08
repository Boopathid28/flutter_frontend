import 'package:ausales_application/controller/repair_type/repair_type_controller.dart';
import 'package:ausales_application/core/shared_preferences/home_shared_prefs.dart';
import 'package:ausales_application/model/repair_type/repair_type_models.dart';
import 'package:ausales_application/responsive.dart';
import 'package:ausales_application/view/widgets/form_widgets/cancel_button.dart';
import 'package:ausales_application/view/widgets/form_widgets/primary_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class RepairTypeDeletePopup extends StatelessWidget {
  final GetAllRepairTypes item;
  RepairTypeDeletePopup({super.key, required this.item});

  final RepairTypeController _repairTypeController = Get.put(RepairTypeController());

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      insetPadding: EdgeInsets.all(Responsive.isMobile(context)?8.w:0),
      content: Text("Are you sure want to delete the ${item.repairType}"),
      actions: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width:Responsive.isMobile(context)?100.w: 200.w,
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
              width:Responsive.isMobile(context)?100.w: 200.w,
              child: Obx(() => PrimaryButton(
                isLoading: _repairTypeController.isDeleteLoading.value, 
                text: "Yes", 
                onPressed: () async {
                  _repairTypeController.isDeleteLoading(true);
                  int? menuId = await HomeSharedPrefs.getCurrentMenu();
                  if (menuId != null) {
                    _repairTypeController.fromMode('delete');
                    await _repairTypeController.submitRepairType(context,item.id);
                  }
                  _repairTypeController.getAllRepairTypes();
                  _repairTypeController.isDeleteLoading(false);
                  _repairTypeController.resetForm();
                  
                }
              )),
            )
          ],
        )
      ],
    );
  }
}