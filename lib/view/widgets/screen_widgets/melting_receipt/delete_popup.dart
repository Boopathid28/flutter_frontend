import 'package:ausales_application/controller/melting_receipt/melting_receipt_list_controller.dart';
import 'package:ausales_application/core/shared_preferences/home_shared_prefs.dart';
import 'package:ausales_application/model/melting_receipt/melting_receipt_models.dart';
import 'package:ausales_application/service/melting_receipt/melting_receipt_service.dart';
import 'package:ausales_application/service/metal_master/metal_service.dart';
import 'package:ausales_application/view/widgets/form_widgets/cancel_button.dart';
import 'package:ausales_application/view/widgets/form_widgets/primary_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/route_manager.dart';

class MeltingReceiptDeletePopup extends StatelessWidget {
  MeltingReceiptListData melting;
  MeltingReceiptDeletePopup({super.key, required this.melting});

  final MeltingReceiptListController _meltingReceiptListController = Get.put(MeltingReceiptListController());

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Text("Are you sure want to delete the ${melting.meltingId}"),
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
                isLoading: _meltingReceiptListController.isDeleteLoading.value, 
                text: "Yes", 
                onPressed: () async {
                  _meltingReceiptListController.isDeleteLoading(true);
                  int? menuId = await HomeSharedPrefs.getCurrentMenu();
                  if (menuId != null) {
                    await MeltingReceiptService.deleteMeltingReceipt(menuId: menuId.toString(), meltingId: melting.id.toString(), context: context);
                  }
                  _meltingReceiptListController.getmeltingReceiptList(context);
                  _meltingReceiptListController.isDeleteLoading(false);
                }
              )),
            )
          ],
        )
      ],
    );
  }
}