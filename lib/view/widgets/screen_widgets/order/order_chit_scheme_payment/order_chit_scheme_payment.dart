import 'package:ausales_application/controller/order/order_chit_scheme_payment_controller.dart';
import 'package:ausales_application/core/constants/app_configuration.dart';
import 'package:ausales_application/model/invoice/invoice_history_models.dart';
import 'package:ausales_application/model/order/order_models.dart';
import 'package:ausales_application/model/payment/chit_scheme_payment_model.dart';
import 'package:ausales_application/view/widgets/billing_widgets/billing_text_input.dart';
import 'package:ausales_application/view/widgets/form_widgets/custom_label.dart';
import 'package:ausales_application/view/widgets/form_widgets/primary_button.dart';
import 'package:ausales_application/view/widgets/form_widgets/secondary_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:toastification/toastification.dart';

class OrderChitSchemePayment extends StatefulWidget {
  String mobileNo;
  List<OrderItemDetails> taggedItems;
  List<ChitPaymentDenominationParticulars> chitPaymentList;
  List<OrderItemDetails> selectedTagChitPaymentParticulars;
  List<ChitSchemeListData> selectedChitSchemeList;
  Function() onClear;
  Function() onCompleted;

  OrderChitSchemePayment({super.key, required this.selectedChitSchemeList, required this.mobileNo, required this.onClear, required this.onCompleted, required this.taggedItems, required this.chitPaymentList, required this.selectedTagChitPaymentParticulars});

  @override
  State<OrderChitSchemePayment> createState() => _OrderChitSchemePaymentState();
}

class _OrderChitSchemePaymentState extends State<OrderChitSchemePayment> {

  final OrderChitSchemePaymentController _orderChitSchemePaymentController = Get.put(OrderChitSchemePaymentController());

  @override
  void initState() {
    super.initState();
    _orderChitSchemePaymentController.chitSchemeSearchController.text = widget.mobileNo;
  }
  
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300.w,
      padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 15.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomLabel(label: "Scheme"),
              SizedBox(
                height: 7.w,
              ),
              BillingTextInput(
                width: 300.w,
                height: 45,
                filled: true,
                filledColor: Colors.white,
                controller: _orderChitSchemePaymentController.chitSchemeSearchController,
                textInputAction: TextInputAction.done,
                keyboardType: TextInputType.text,
                validator: 'no_validation',
                onChanged: (value) {},
              ),
            ],
          ),
          SizedBox(
            height: 7.w,
          ),
          Obx(() => PrimaryButton(
              btnWidth: 300.w,
              isLoading: _orderChitSchemePaymentController.isCitSchemeFetchLoading.value,
              text: 'Fetch Details',
              onPressed: _orderChitSchemePaymentController.isCitSchemeFetchLoading.value ? null : () async {
                if (widget.selectedTagChitPaymentParticulars.isNotEmpty) {
                  toastification.show(
                    context: context, // optional if you use ToastificationWrapper
                    type: ToastificationType.info,
                    title: Text("Clear schemes and add new scheme payemnts"),
                    autoCloseDuration: notificationDuration,
                    showProgressBar: false,
                    pauseOnHover: false);
                } else {
                  List<OrderItemDetails> orderDataList = widget.taggedItems;
                  orderDataList.sort((a, b) =>
                            b.wastagePercent!.compareTo(a.wastagePercent!));
                  _orderChitSchemePaymentController.getChitSchemeDetails(context, widget.selectedChitSchemeList, widget.chitPaymentList, orderDataList, widget.onCompleted, widget.selectedTagChitPaymentParticulars);
                }
              })),
          SizedBox(
            height: 7.w,
          ),
          SecondaryButton(isLoading: false, text: "Clear", onPressed: () {
            widget.onClear();
            _orderChitSchemePaymentController.selectedTagItemIdsList([]);
            _orderChitSchemePaymentController.selectedChitSchemeIdsList([]);
          })
        ],
      ),
    );
  }
}