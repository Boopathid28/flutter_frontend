import 'package:ausales_application/controller/estimation/estimation_controller.dart';
import 'package:ausales_application/core/theme/text_palette.dart';
import 'package:ausales_application/view/widgets/billing_widgets/billing_label.dart';
import 'package:ausales_application/view/widgets/form_widgets/custom_label_filter.dart';
import 'package:ausales_application/view/widgets/form_widgets/primary_text_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class ShowOldPurchaseParticuars extends StatefulWidget {
  const ShowOldPurchaseParticuars({super.key});

  @override
  State<ShowOldPurchaseParticuars> createState() => _ShowOldPurchaseParticuarsState();
}

class _ShowOldPurchaseParticuarsState extends State<ShowOldPurchaseParticuars> {
  final EstimationController _estimationController =
      Get.put(EstimationController());
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
            itemCount: _estimationController.oldPurchaseParticulars.length,
            separatorBuilder:(context, index) => SizedBox(height: 10.h,), 
            itemBuilder: (context, index) {
              return Card(
                elevation: 5,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomLabelFilter(label: _estimationController.oldPurchaseParticulars.value[index].oldGoldBillNo??""),
                      BillingLabel(label: "₹ ${_estimationController.oldPurchaseParticulars.value[index].totalAmount??"0.00"}")
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
        _estimationController.oldPurchaseParticulars([]);
        _estimationController.calculateOldMetals();
        Get.back();
      })
    ],
    );
  }

}


