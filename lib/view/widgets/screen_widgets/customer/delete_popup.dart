import 'package:ausales_application/controller/customer/customer_list_controller.dart';
import 'package:ausales_application/controller/user/user_list_controller.dart';
import 'package:ausales_application/core/shared_preferences/home_shared_prefs.dart';
import 'package:ausales_application/model/customer/customer_models.dart';
import 'package:ausales_application/model/user/user_model.dart';
import 'package:ausales_application/service/customer/customer_service.dart';
import 'package:ausales_application/service/user/user_service.dart';
import 'package:ausales_application/view/widgets/form_widgets/cancel_button.dart';
import 'package:ausales_application/view/widgets/form_widgets/primary_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/route_manager.dart';

class CustomerDeletePopup extends StatelessWidget {
  CustomerListData customer;
  CustomerDeletePopup({super.key, required this.customer});

  final CustomerListController _customerListController = Get.put(CustomerListController());

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Text("Are you sure want to delete the ${customer.customerName}"),
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
                isLoading: _customerListController.isDeleteLoading.value, 
                text: "Yes", 
                onPressed: () async {
                  _customerListController.isDeleteLoading(true);
                  int? menuId = await HomeSharedPrefs.getCurrentMenu();
                  if (menuId != null) {
                    await CustomerService.deleteCustomer(menuId: menuId.toString(), customerId: customer.id.toString(), context: context);
                  }
                  _customerListController.getcustomerlist(context);
                  _customerListController.isDeleteLoading(false);
                }
              )),
            )
          ],
        )
      ],
    );
  }
}