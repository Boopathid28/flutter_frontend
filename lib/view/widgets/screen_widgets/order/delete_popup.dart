import 'package:ausales_application/controller/order/order_list_controller.dart';
import 'package:ausales_application/core/shared_preferences/home_shared_prefs.dart';
import 'package:ausales_application/model/order/order_models.dart';
import 'package:ausales_application/service/order/order_service.dart';
import 'package:ausales_application/view/widgets/form_widgets/cancel_button.dart';
import 'package:ausales_application/view/widgets/form_widgets/primary_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/route_manager.dart';

class DeleteOrderPopup extends StatelessWidget {
  OrderListData order;
  DeleteOrderPopup({super.key, required this.order});

  final OrderListController _orderListController = Get.put(OrderListController());

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Text("Are you sure want to delete ${order.orderId}"),
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
                isLoading: _orderListController.isDeleteLoading.value, 
                text: "Yes", 
                onPressed: () async {
                  _orderListController.isDeleteLoading(true);
                  int? menuId = await HomeSharedPrefs.getCurrentMenu();
                  if (menuId != null) {
                    await OrderService.deleteOrder(menuId: menuId.toString(), orderId: order.id.toString(), context: context);
                  }
                  _orderListController.getorderList(context);
                  _orderListController.isDeleteLoading(false);
                }
              )),
            )
          ],
        )
      ],
    );
  }
}