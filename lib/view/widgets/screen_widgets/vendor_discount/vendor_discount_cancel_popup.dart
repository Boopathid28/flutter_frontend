import 'package:ausales_application/controller/vendor_discount/vendor_discount_list_controller.dart';
import 'package:ausales_application/controller/vendor_payment/vendor_payment_list_controller.dart';
import 'package:ausales_application/core/shared_preferences/home_shared_prefs.dart';
import 'package:ausales_application/model/vendor_discount/vendor_discount_model.dart';
import 'package:ausales_application/service/vendor_discount/vendor_discount_service.dart';
import 'package:ausales_application/service/vendor_payment/vendor_payment_service.dart';
import 'package:ausales_application/view/widgets/form_widgets/cancel_button.dart';
import 'package:ausales_application/view/widgets/form_widgets/primary_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class VendorDiscountCancelPopup extends StatelessWidget {
  VendorDiscountListData vendorDiscountItem;
  VendorDiscountCancelPopup({super.key, required this.vendorDiscountItem});

  final VendorDiscountListController _vendorDiscountListController =
      Get.put(VendorDiscountListController());

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content:
          Text("Are you sure want to cancel the ${vendorDiscountItem.discountId}"),
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
                  isLoading: _vendorDiscountListController.isDeleteLoading.value,
                  text: "Yes",
                  onPressed: () async {
                    _vendorDiscountListController.isDeleteLoading(true);
                    int? menuId = await HomeSharedPrefs.getCurrentMenu();
                    if (menuId != null) {
                      await VendorDiscountService.cancelVendorDiscount(
                          menuId: menuId.toString(),
                          vendorDiscountId: vendorDiscountItem.id.toString(),
                          context: context);
                    }
                    _vendorDiscountListController.getVendorDiscountList(context);
                    _vendorDiscountListController.isDeleteLoading(false);
                  })),
            )
          ],
        )
      ],
    );
  }
}
