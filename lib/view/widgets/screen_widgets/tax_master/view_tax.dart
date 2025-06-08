import 'package:ausales_application/controller/tax_master/tax_form_controller.dart';
import 'package:ausales_application/model/tax/tax_models.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class TaxViewpopup extends StatefulWidget {
  TaxListData tax;
  TaxViewpopup({super.key, required this.tax});

  @override
  State<TaxViewpopup> createState() => _TaxViewpopupState();
}

class _TaxViewpopupState extends State<TaxViewpopup> {
  final TaxFormController _taxFormController = Get.put(TaxFormController());

  @override
  void initState() {
    super.initState();
    _taxFormController.getCustomerList(context, widget.tax.id!);
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Text(
                "View Tax",
                style: TextStyle(fontSize: 18.sp),
              ),
            ],
          ),
          closeicon()
        ],
      ),
      actions: [
        SizedBox(
          width: 500.w,
          height: 300.h,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Tax Name", style: TextStyle(fontSize: 12.sp)),
                        SizedBox(
                          height: 10.h,
                        ),
                        Obx(() => Text(
                              _taxFormController.taxDetails.value.taxName.toString(),
                              style: TextStyle(fontSize: 14.sp, color: Colors.blue),
                            )),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Tax Code", style: TextStyle(fontSize: 12.sp)),
                        SizedBox(
                          height: 10.h,
                        ),
                        Obx(() => Text(
                              _taxFormController.taxDetails.value.taxCode.toString(),
                              style: TextStyle(fontSize: 14.sp, color: Colors.blue),
                            ))
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Metal Name", style: TextStyle(fontSize: 12.sp)),
                        SizedBox(
                          height: 10.h,
                        ),
                        Obx(() => Text(
                              _taxFormController.taxDetails.value.metalName.toString(),
                              style: TextStyle(fontSize: 14.sp, color: Colors.blue),
                            ))
                      ],
                    ),
                      Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Modified By", style: TextStyle(fontSize: 12.sp)),
                        SizedBox(
                          height: 10.h,
                        ),
                        Obx(() => Text(
                              _taxFormController.taxDetails.value.modifiedBy.toString(),
                              style: TextStyle(fontSize: 14.sp, color: Colors.blue),
                            ))
                      ],
                    ),
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Purchase Igst", style: TextStyle(fontSize: 12.sp)),
                        SizedBox(
                          height: 10.h,
                        ),
                        Obx(() => Text(
                              _taxFormController.taxDetails.value.purchaseIgst.toString(),
                              style: TextStyle(fontSize: 14.sp, color: Colors.blue),
                            ))
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Purchase Cgst", style: TextStyle(fontSize: 12.sp)),
                        SizedBox(
                          height: 10.h,
                        ),
                        Obx(() => Text(
                              _taxFormController.taxDetails.value.purchaseCgst.toString(),
                              style: TextStyle(fontSize: 14.sp, color: Colors.blue),
                            ))
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Purchase Sgst", style: TextStyle(fontSize: 12.sp)),
                        SizedBox(
                          height: 10.h,
                        ),
                        Obx(() => Text(
                              _taxFormController.taxDetails.value.purchaseIgst.toString(),
                              style: TextStyle(fontSize: 14.sp, color: Colors.blue),
                            ))
                      ],
                    ),
                     Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Created By", style: TextStyle(fontSize: 12.sp)),
                        SizedBox(
                          height: 10.h,
                        ),
                        Obx(() => Text(
                              _taxFormController.taxDetails.value.createdBy.toString(),
                              style: TextStyle(fontSize: 14.sp, color: Colors.blue),
                            ))
                      ],
                    ),
                    
                  ],
                ),
                Column(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Sales Sgst", style: TextStyle(fontSize: 12.sp)),
                        SizedBox(
                          height: 10.h,
                        ),
                        Obx(() => Text(
                             _taxFormController.taxDetails.value.salesSgst.toString(),
                              style: TextStyle(fontSize: 14.sp, color: Colors.blue),
                            ))
                      ],
                    ),
                    SizedBox(
                      height:30.h,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Sales Cgst", style: TextStyle(fontSize: 12.sp)),
                        SizedBox(
                          height: 10.h,
                        ),
                        Obx(() => Text(
                            _taxFormController.taxDetails.value.salesCgst.toString(),
                              style: TextStyle(fontSize: 14.sp, color: Colors.blue),
                            ))
                      ],
                    ),
                    SizedBox(
                      height: 30.h,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Sales Igst", style: TextStyle(fontSize: 12.sp)),
                        SizedBox(
                          height: 10.h,
                        ),
                        Obx(() => Text(
                              _taxFormController.taxDetails.value.salesIgst.toString(),
                              style: TextStyle(fontSize: 14.sp, color: Colors.blue),
                            ))
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        )
      ],
    );
  }

  IconButton closeicon() {
    return IconButton(
        onPressed: () {
          Get.back();
        },
        icon: Icon(Icons.close));
  }
}
