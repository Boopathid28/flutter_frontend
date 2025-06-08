import 'package:ausales_application/controller/invoice/invoice_controller.dart';
import 'package:ausales_application/core/theme/text_palette.dart';
import 'package:ausales_application/view/widgets/billing_widgets/billing_label.dart';
import 'package:ausales_application/view/widgets/form_widgets/custom_label_filter.dart';
import 'package:ausales_application/view/widgets/form_widgets/primary_text_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class ShowSuspenseParticuars extends StatefulWidget {
  const ShowSuspenseParticuars({super.key});

  @override
  State<ShowSuspenseParticuars> createState() => _ShowSuspenseParticuarsState();
}

class _ShowSuspenseParticuarsState extends State<ShowSuspenseParticuars> {
  final InvoiceController _invoiceController =
      Get.put(InvoiceController());
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return AlertDialog.adaptive(
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "Suspense Details",
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
            itemCount: _invoiceController.fetchSuspenseParticulars.length,
            separatorBuilder:(context, index) => SizedBox(height: 10.h,), 
            itemBuilder: (context, index) {
              return Card(
                elevation: 5,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomLabelFilter(label: _invoiceController.fetchSuspenseParticulars.value[index].suspenseId??""),
                      BillingLabel(label: "₹ ${_invoiceController.fetchSuspenseParticulars.value[index].totalAmount??"0.00"}")
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
        _invoiceController.fetchSuspenseParticulars([]);
        _invoiceController.calculateSuspense();
        Get.back();
      })
    ],
    );
  }

}


