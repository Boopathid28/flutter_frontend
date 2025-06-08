import 'package:ausales_application/controller/estimation/estimation_controller.dart';
import 'package:ausales_application/controller/mannual_estimation/mannual_estimation_controller.dart';
import 'package:ausales_application/core/theme/text_palette.dart';
import 'package:ausales_application/view/widgets/billing_widgets/billing_label.dart';
import 'package:ausales_application/view/widgets/form_widgets/custom_label_filter.dart';
import 'package:ausales_application/view/widgets/form_widgets/primary_text_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class MannualShowOldPurchaseParticuars extends StatefulWidget {
  const MannualShowOldPurchaseParticuars({super.key});

  @override
  State<MannualShowOldPurchaseParticuars> createState() => _MannualShowOldPurchaseParticuarsState();
}

class _MannualShowOldPurchaseParticuarsState extends State<MannualShowOldPurchaseParticuars> {
  final MannualEstimationController _mannualEstimationController =
      Get.put(MannualEstimationController());
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return AlertDialog.adaptive(
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "Old Metal Details",
            style: TextPalette.screenTitle,
          ),
          IconButton(
              onPressed: () {
                Get.back();
              },
              icon: Icon(Icons.close))
        ],
      ),
      content: SingleChildScrollView(
        child: Container(
          width: 300.w,
          child: Obx(() => ListView.separated(
            shrinkWrap: true,
            itemCount: _mannualEstimationController.oldPurchaseParticulars.length,
            separatorBuilder:(context, index) => SizedBox(height: 10.h,), 
            itemBuilder: (context, index) {
              return Card(
                elevation: 5,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomLabelFilter(label: _mannualEstimationController.oldPurchaseParticulars.value[index].oldGoldBillNo??""),
                      BillingLabel(label: "₹ ${_mannualEstimationController.oldPurchaseParticulars.value[index].totalAmount??"0.00"}")
                    ],
                  ),
                ),
              );
            }, 
            )),
        ),
      ),
    actions: [
      PrimaryTextButton(text: 'Clear All', onPressed: () {
        _mannualEstimationController.oldPurchaseParticulars([]);
        _mannualEstimationController.calculateOldMetals();
        Get.back();
      })
    ],
    );
  }

}


