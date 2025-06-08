import 'package:ausales_application/controller/vendor_payment/vendor_payment_list_controller.dart';
import 'package:ausales_application/core/shared_preferences/home_shared_prefs.dart';
import 'package:ausales_application/model/vendor_payment/vendor_payment_models.dart';
import 'package:ausales_application/service/vendor_payment/vendor_payment_service.dart';
import 'package:ausales_application/view/widgets/form_widgets/cancel_button.dart';
import 'package:ausales_application/view/widgets/form_widgets/primary_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class VendorPaymentCancelPopup extends StatelessWidget {
  VendorPaymentListData vendorPaymentItem;
  VendorPaymentCancelPopup({super.key, required this.vendorPaymentItem});

  final VendorPaymentListController _vendorPaymentListController =
      Get.put(VendorPaymentListController());

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content:
          Text("Are you sure want to cancel the ${vendorPaymentItem.paymentId}"),
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
                  }),
            ),
            SizedBox(
              width: 15.w,
            ),
            SizedBox(
              width: 200.w,
              child: Obx(() => PrimaryButton(
                  isLoading: _vendorPaymentListController.isDeleteLoading.value,
                  text: "Yes",
                  onPressed: () async {
                    _vendorPaymentListController.isDeleteLoading(true);
                    int? menuId = await HomeSharedPrefs.getCurrentMenu();
                    if (menuId != null) {
                      await VendorPaymentService.cancelVendorPayment(
                          menuId: menuId.toString(),
                          vendorPaymentId: vendorPaymentItem.id.toString(),
                          context: context);
                    }
                    _vendorPaymentListController.getVendorPaymentList(context);
                    _vendorPaymentListController.isDeleteLoading(false);
                  })),
            )
          ],
        )
      ],
    );
  }
}
