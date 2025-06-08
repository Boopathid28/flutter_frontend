import 'package:ausales_application/controller/suspense/suspense_payment/suspense_payment_controller.dart';
import 'package:ausales_application/controller/suspense/suspense_payment/suspense_payment_form_controller.dart';
import 'package:ausales_application/core/theme/color_palette.dart';
import 'package:ausales_application/core/theme/text_palette.dart';
import 'package:ausales_application/responsive.dart';
import 'package:ausales_application/view/widgets/form_widgets/custom_dropdown_search_field.dart';
import 'package:ausales_application/view/widgets/form_widgets/custom_label.dart';
import 'package:ausales_application/view/widgets/form_widgets/primary_button.dart';
import 'package:ausales_application/view/widgets/screen_widgets/suspense/payment/delete_payment_popup.dart';
import 'package:ausales_application/view/widgets/screen_widgets/suspense/payment/payment_details_form.dart';
import 'package:ausales_application/view/widgets/screen_widgets/suspense/payment/payment_form.dart';
import 'package:ausales_application/view/widgets/screen_widgets/suspense/payment/payment_view_details.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class PaymentDetailPopup extends StatefulWidget {
  const PaymentDetailPopup({super.key});

  @override
  State<PaymentDetailPopup> createState() => _PaymentDetailPopupState();
}

class _PaymentDetailPopupState extends State<PaymentDetailPopup> {
  final SuspensePaymentFormController _suspensePaymentFormController =
      Get.put(SuspensePaymentFormController());

  final SuspensePaymentController _suspensePaymentController =
      Get.put(SuspensePaymentController());

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return AlertDialog.adaptive(
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "Payment",
            style: TextPalette.screenTitle,
          ),
          IconButton(onPressed: () {
            _suspensePaymentFormController.resetPayment(context);
            _suspensePaymentController.denominationDetailsParticulars([]);
            Get.back();
          }, icon: Icon(Icons.close))
        ],
      ),
      content: Container(
        width: size.width,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              PaymentViewDetails(),
              SizedBox(height: 10.h,),
              PaymentDetailsForm(),
              SizedBox(height: 10.h,),
              PaymentForm(),
              SizedBox(
                height: 15.h,
              ),
              Flexible(
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: SizedBox(
                    width: Responsive.isDesktop(context) ? size.width : null,
                    child: Obx(() => DataTable(
                          headingRowColor:
                              WidgetStateProperty.resolveWith<Color?>(
                                  (Set<WidgetState> states) =>
                                      ColorPalete.tableHeaderBgColor),
                          columns: [
                            DataColumn(
                              label: SizedBox(
                                width: 150.w,
                                child: Text(
                                  'Payment Methoad',
                                  style: TextPalette.tableHeaderTextStyle,
                                ),
                              ),
                            ),
                            DataColumn(
                              label: SizedBox(
                                width: 150.w,
                                child: Text(
                                  'Payment Provider',
                                  style: TextPalette.tableHeaderTextStyle,
                                ),
                              ),
                            ),
                            DataColumn(
                              label: SizedBox(
                                width: 100.w,
                                child: Text(
                                  'Paid Amount',
                                  style: TextPalette.tableHeaderTextStyle,
                                ),
                              ),
                            ),
                           
                            DataColumn(
                              label: SizedBox(
                                width: 150.w,
                                child: Text(
                                  'Action',
                                  style: TextPalette.tableHeaderTextStyle,
                                ),
                              ),
                            ),
                          ],
                          rows: _suspensePaymentController
                              .denominationDetailsParticulars.value
                              .map((item) {
                            return DataRow(cells: [
                              DataCell(Text(item.paymentMethod.toString())), 
                              DataCell(Text(item.paymentProvider.toString())), 
                              DataCell(Text(item.paidAmount.toString())),
                              DataCell(Row(
                                children: [
                                  GestureDetector(
                                      onTap: () {
                                        _suspensePaymentFormController.editPayment(context, item);
                                      }, child: Icon(Icons.edit)),
                                  SizedBox(
                                    width: 10.w,
                                  ),
                                  GestureDetector(
                                      onTap: () async {
                                        await showDialog(
                                          context: context, 
                                          builder: (_) => DeletePaymentPopup(itemIndex: item.sNo)
                                        );
                                        
                                      },
                                      child: Icon(Icons.delete)),
                                ],
                              )),
                            ]);
                          }).toList(),
                        )),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
      actions: [actions(context)],
    );
  }

  SizedBox actions(BuildContext context) {
    return SizedBox(
      width: 145.w,
      height: 73.h,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          // SizedBox(
          //     width: 145.w,
          //     child: SecondaryButton(
          //         btnHeight: 46.h,
          //         isLoading: false,
          //         text: "Cancel",
          //         onPressed: () {})),
          // SizedBox(
          //   width: 10.w,
          // ),
          SizedBox(
              width: 145.w,
              child: PrimaryButton(
                  btnHeight: 46.h,
                  isLoading: false,
                  text: "Create",
                  onPressed: () {
                    _suspensePaymentController.CreatePayment(context);
                  })),
        ],
      ),
    );
  }


  SizedBox branch() {
    return SizedBox(
      width: 275.w,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomLabel(label: "Branch"),
          SizedBox(
            height: 7.w,
          ),
          Obx(() => CustomDropdownSearchField(
                controller: _suspensePaymentController.branchSearchController,
                selectedValue: _suspensePaymentController.selectedBranch.value,
                options: _suspensePaymentController.branchDropDown.value,
                onChanged: (value) {
                  _suspensePaymentController.selectedBranch(value);
                },
                hintText: "Branch",
              ))
        ],
      ),
    );
  }
}
