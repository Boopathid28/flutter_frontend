import 'package:ausales_application/core/theme/text_palette.dart';
import 'package:ausales_application/model/payment/advance_payment_model.dart';
import 'package:ausales_application/view/widgets/billing_widgets/billing_label.dart';
import 'package:ausales_application/view/widgets/form_widgets/custom_label_filter.dart';
import 'package:ausales_application/view/widgets/form_widgets/primary_text_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class SelectedAdvanceList extends StatefulWidget {
  Function() onCompleted;
  List<AdvancePaymentItemModel> advanceItemsList;
  SelectedAdvanceList({super.key, required this.onCompleted, required this.advanceItemsList});

  @override
  State<SelectedAdvanceList> createState() => _SelectedAdvanceListState();
}

class _SelectedAdvanceListState extends State<SelectedAdvanceList> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return AlertDialog.adaptive(
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "Advance Details",
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
            itemCount: widget.advanceItemsList.length,
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
                          CustomLabelFilter(label: widget.advanceItemsList[index].advanceDetailsNo??""),
                          BillingLabel(label: "₹ ${widget.advanceItemsList[index].totalAmount??"0.00"}")
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