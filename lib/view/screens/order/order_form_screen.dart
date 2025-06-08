import 'package:ausales_application/controller/order/order_form_controller.dart';
import 'package:ausales_application/controller/order/order_item_form_controller.dart';
import 'package:ausales_application/core/constants/app_configuration.dart';
import 'package:ausales_application/core/keyboard_listeners/shortcut_keyboard_handler.dart';
import 'package:ausales_application/core/theme/color_palette.dart';
import 'package:ausales_application/core/theme/text_palette.dart';
import 'package:ausales_application/responsive.dart';
import 'package:ausales_application/view/widgets/form_widgets/primary_button.dart';
import 'package:ausales_application/view/widgets/layouts/end_menu_drawer_widget.dart';
import 'package:ausales_application/view/widgets/layouts/footer.dart';
import 'package:ausales_application/view/widgets/layouts/header.dart';
import 'package:ausales_application/view/widgets/screen_widgets/order/order_item_details/delete_item_popup.dart';
import 'package:ausales_application/view/widgets/screen_widgets/order/order_item_details/order_item_details_form.dart';
import 'package:ausales_application/view/widgets/screen_widgets/order/order_item_details/order_item_form.dart';
import 'package:ausales_application/view/widgets/screen_widgets/order/order_make_payment.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:toastification/toastification.dart';

class OrderFormScreen extends StatefulWidget {
  const OrderFormScreen({super.key});

  @override
  State<OrderFormScreen> createState() => _OrderFormScreenState();
}

class _OrderFormScreenState extends State<OrderFormScreen> {
  final OrderFormController _orderFormController =
      Get.put(OrderFormController());

  final OrderItemFormController _orderItemFormController =
      Get.put(OrderItemFormController());

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return ShorcutKeyboardHandler(
      scaffoldKey: _orderFormController.scaffoldKey,
      onRefresh: () {},
      child: Scaffold(
        backgroundColor: ColorPalete.appBgColor,
        appBar: PreferredSize(
          child: HeaderWidget(),
          preferredSize: Size.fromHeight(100.0),
        ),
        bottomNavigationBar: Footer(),
        endDrawer: EndMenuDrawerWidget(),
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 25.h,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 15.w),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                              onPressed: () {
                                Get.back();
                              },
                              icon: Icon(Icons.arrow_back_ios_new)),
                          SizedBox(
                            width: 10.w,
                          ),
                          Text(
                            "Create Order",
                            style: Responsive.isDesktop(context)
                                ? TextPalette.screenTitle
                                : TextPalette.tableHeaderTextStyle,
                          ),
                        ],
                      ),
                    ),
                    Row(
                      children: [
                        SizedBox(
                            width: Responsive.isDesktop(context) ? 150.w : 75.w,
                            child: Obx(() => PrimaryButton(
                                btnHeight: 46.h,
                                isLoading:
                                    _orderFormController.isFormSubmit.value,
                                text: "Create",
                                onPressed: () {
                                  _orderFormController.CreateOrder(context);
                                }))),
                        SizedBox(
                          width: 5,
                        ),
                        SizedBox(
                            width: Responsive.isDesktop(context) ? 150.w : 75.w,
                            child: PrimaryButton(
                                btnHeight: 46.h,
                                isLoading: false,
                                text: "Make Payment",
                                onPressed: () async {
                                  if (_orderFormController
                                          .isValidCustomer.value ==
                                      true) {
                                    await Get.dialog(
                                        barrierDismissible: false,
                                        OrderMakePayment());
                                  } else {
                                    toastification.show(
                                        type: ToastificationType.error,
                                        title: Text('Fill Customer Details'),
                                        autoCloseDuration: notificationDuration,
                                        showProgressBar: false,
                                        pauseOnHover: false);
                                  }
                                })),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 15.h,
              ),
              OrderItemDetailsForm(),
              SizedBox(
                height: 15.h,
              ),
              Obx(() => _orderFormController.selectedGstType.value != null
                  ? OrderItemForm()
                  : SizedBox()),
              SizedBox(
                height: 15.h,
              ),
              itemparticulars(size)
            ],
          ),
        ),
      ),
    );
  }

  Container itemparticulars(Size size) {
    return Container(
      padding: EdgeInsets.all(15.w),
      decoration: BoxDecoration(
        color: Colors.white,
      ),
      width: size.width * 0.98,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: SizedBox(
          width: Responsive.isDesktop(context) ? size.width : null,
          child: Obx(() => DataTable(
                headingRowColor: WidgetStateProperty.resolveWith<Color?>(
                    (Set<WidgetState> states) =>
                        ColorPalete.tableHeaderBgColor),
                columns: [
                   DataColumn(
                    label: SizedBox(
                      width: 125.w,
                      child: Text(
                        'Item Name',
                        style: TextPalette.tableHeaderTextStyle,
                      ),
                    ),
                  ),
                  DataColumn(
                    label: SizedBox(
                      width: 125.w,
                      child: Text(
                        'Sub Item Name',
                        style: TextPalette.tableHeaderTextStyle,
                      ),
                    ),
                  ),
                  DataColumn(
                    label: SizedBox(
                      width: 125.w,
                      child: Text(
                        'Gross Weight',
                        style: TextPalette.tableHeaderTextStyle,
                      ),
                    ),
                  ),
                  DataColumn(
                    label: SizedBox(
                      width: 100.w,
                      child: Text(
                        'Net Weight',
                        style: TextPalette.tableHeaderTextStyle,
                      ),
                    ),
                  ),
                  DataColumn(
                    label: SizedBox(
                      width: 125.w,
                      child: Text(
                        'Pieces',
                        style: TextPalette.tableHeaderTextStyle,
                      ),
                    ),
                  ),
                  DataColumn(
                    label: SizedBox(
                      width: 125.w,
                      child: Text(
                        'Priority',
                        style: TextPalette.tableHeaderTextStyle,
                      ),
                    ),
                  ),
                  DataColumn(
                    label: SizedBox(
                      width: 125.w,
                      child: Text(
                        'gender',
                        style: TextPalette.tableHeaderTextStyle,
                      ),
                    ),
                  ),
                  DataColumn(
                    label: SizedBox(
                      width: 125.w,
                      child: Text(
                        'Action',
                        style: TextPalette.tableHeaderTextStyle,
                      ),
                    ),
                  ),
                ],
                rows: _orderFormController.orderitemdetailsParticularList.value
                    .map((item) {
                  return DataRow(cells: [
                    DataCell(SizedBox(
                        width: 100.w,
                        child: Text(item.itemDetailsName.toString()))),
                    DataCell(SizedBox(
                        width: 100.w,
                        child: Text(item.subItemDetailsName.toString()))),
                    DataCell(SizedBox(
                        width: 100.w,
                        child: Text(item.grossWeight.toString()))),
                    DataCell(SizedBox(
                        width: 100.w, child: Text(item.netWeight.toString()))),
                    DataCell(SizedBox(
                        width: 100.w, child: Text(item.pieces.toString()))),
                    DataCell(SizedBox(
                        width: 100.w, child: Text(item.priority.toString()))),
                    DataCell(SizedBox(
                        width: 100.w, child: Text(item.gender.toString()))),
                    DataCell(Row(
                      children: [
                        GestureDetector(
                            onTap: () {
                              _orderItemFormController.editItem(context, item);
                            },
                            child: Icon(Icons.edit)),
                        SizedBox(
                          width: 10.w,
                        ),
                        GestureDetector(
                            onTap: () async {
                              await Get.dialog(
                                      DeleteItemPopup(itemIndex: item.sNo!));
                            },
                            child: Icon(Icons.delete)),
                      ],
                    )),
                  ]);
                }).toList(),
              )),
        ),
      ),
    );
  }
}
