import 'package:ausales_application/controller/customer_group/customer_group_list_controller.dart';
import 'package:ausales_application/core/shared_preferences/home_shared_prefs.dart';
import 'package:ausales_application/model/customer_group/customer_group_models.dart';
import 'package:ausales_application/service/customer_group/customer_group_service.dart';
import 'package:ausales_application/view/widgets/form_widgets/cancel_button.dart';
import 'package:ausales_application/view/widgets/form_widgets/primary_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/route_manager.dart';

class CustomerGroupDeletePopup extends StatelessWidget {
  CustomergroupListData customergroup;
  CustomerGroupDeletePopup({super.key, required this.customergroup});

  final CustomerGroupListController _customerGroupListController = Get.put(CustomerGroupListController());

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Text("Are you sure want to delete the ${customergroup.customerGroupName}"),
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
                isLoading: _customerGroupListController.isDeleteLoading.value, 
                text: "Yes", 
                onPressed: () async {
                  _customerGroupListController.isDeleteLoading(true);
                  int? menuId = await HomeSharedPrefs.getCurrentMenu();
                  if (menuId != null) {
                    await CustomerGroupService.deleteCustomerGroup(menuId: menuId.toString(), customergroupId: customergroup.id.toString(), context: context);
                  }
                  _customerGroupListController.getcustomergrouplist(context);
                  _customerGroupListController.isDeleteLoading(false);
                }
              )),
            )
          ],
        )
      ],
    );
  }
}