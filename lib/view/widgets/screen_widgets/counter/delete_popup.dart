import 'package:ausales_application/controller/counter/counter_list_controller.dart';
import 'package:ausales_application/core/shared_preferences/home_shared_prefs.dart';
import 'package:ausales_application/model/counter/counter_models.dart';
import 'package:ausales_application/service/counter/counter_service.dart';
import 'package:ausales_application/view/widgets/form_widgets/cancel_button.dart';
import 'package:ausales_application/view/widgets/form_widgets/primary_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/route_manager.dart';

class CounterDeletePopup extends StatelessWidget {
  CounterListData counter;
  CounterDeletePopup({super.key, required this.counter});

  final CounterListController _counterListController = Get.put(CounterListController());

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Text("Are you sure want to delete the ${counter.counterName}"),
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
                isLoading: _counterListController.isDeleteLoading.value, 
                text: "Yes", 
                onPressed: () async {
                  _counterListController.isDeleteLoading(true);
                  int? menuId = await HomeSharedPrefs.getCurrentMenu();
                  if (menuId != null) {
                    await CounterService.deleteCounter(menuId: menuId.toString(), counterId: counter.id.toString(), context: context);
                  }
                  _counterListController.getcounterList(context);
                  _counterListController.isDeleteLoading(false);
                }
              )),
            )
          ],
        )
      ],
    );
  }
}