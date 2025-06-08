import 'package:ausales_application/controller/value_addition_customer/value_addition_customer_list_controller.dart';
import 'package:ausales_application/core/shared_preferences/home_shared_prefs.dart';
import 'package:ausales_application/model/value_addition_customer/value_addition_customer_models.dart';
import 'package:ausales_application/service/value_addition_customer/value_addition_customer_service.dart';
import 'package:ausales_application/view/widgets/form_widgets/cancel_button.dart';
import 'package:ausales_application/view/widgets/form_widgets/primary_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class ValueAdditionCustomerDeletePopup extends StatelessWidget {
  ValueAdditionCustomerData item;
  ValueAdditionCustomerDeletePopup({super.key, required this.item});

  final ValueAdditionCustomerListController _valueAdditionCustomerListController = Get.put(ValueAdditionCustomerListController());

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Text("Are you sure want to delete the ${item.subItemName}"),
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
                isLoading: _valueAdditionCustomerListController.isDeleteLoading.value, 
                text: "Yes", 
                onPressed: () async {
                  _valueAdditionCustomerListController.isDeleteLoading(true);
                  int? menuId = await HomeSharedPrefs.getCurrentMenu();
                  if (menuId != null) {
                    await ValueAdditionCustomerService.deleteValueAdditionCustomer(menuId: menuId.toString(), valueadditioncustomerId: item.id.toString(), context: context);
                  }
                  _valueAdditionCustomerListController.getValueAdditionCustomerlist(context);
                  _valueAdditionCustomerListController.isDeleteLoading(false);
                }
              )),
            )
          ],
        )
      ],
    );
  }
}