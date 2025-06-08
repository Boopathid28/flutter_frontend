import 'package:ausales_application/core/theme/text_palette.dart';
import 'package:ausales_application/model/payment/suspense_payment_model.dart';
import 'package:ausales_application/view/widgets/billing_widgets/billing_label.dart';
import 'package:ausales_application/view/widgets/form_widgets/custom_label_filter.dart';
import 'package:ausales_application/view/widgets/form_widgets/primary_text_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class SelectedSuspenseList extends StatefulWidget {
  Function() onCompleted;
  List<SuspenseFetchParticularsDetails> suspenseItemsList;
  SelectedSuspenseList({super.key, required this.onCompleted, required this.suspenseItemsList});

  @override
  State<SelectedSuspenseList> createState() => _SelectedSuspenseListState();
}

class _SelectedSuspenseListState extends State<SelectedSuspenseList> {
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
            itemCount: widget.suspenseItemsList.length,
            separatorBuilder:(context, index) => SizedBox(height: 10.h,), 
            itemBuilder: (context, index) {
              return Card(
                elevation: 5,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CustomLabelFilter(label: widget.suspenseItemsList[index].suspenseId??""),
                          BillingLabel(label: "₹ ${widget.suspenseItemsList[index].totalAmount??"0.00"}")
                        ],
                      ),
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
        widget.onCompleted();
        Get.back();
      })
    ],
    );
  }
}