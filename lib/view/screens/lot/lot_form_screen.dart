import 'package:ausales_application/controller/lot/lot_form_controller.dart';
import 'package:ausales_application/core/keyboard_listeners/shortcut_keyboard_handler.dart';
import 'package:ausales_application/core/theme/color_palette.dart';
import 'package:ausales_application/core/theme/text_palette.dart';
import 'package:ausales_application/responsive.dart';
import 'package:ausales_application/view/widgets/form_widgets/primary_button.dart';
import 'package:ausales_application/view/widgets/form_widgets/secondary_button.dart';
import 'package:ausales_application/view/widgets/layouts/end_menu_drawer_widget.dart';
import 'package:ausales_application/view/widgets/layouts/footer.dart';
import 'package:ausales_application/view/widgets/layouts/header.dart';
import 'package:ausales_application/view/widgets/screen_widgets/lot/lot_form/lot_detail_form.dart';
import 'package:ausales_application/view/widgets/screen_widgets/lot/lot_form/lot_item_form.dart';
import 'package:ausales_application/view/widgets/screen_widgets/lot/lot_form/lot_item_table.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class LotFormScreen extends StatefulWidget {
  const LotFormScreen({super.key});

  @override
  State<LotFormScreen> createState() => _LotFormScreenState();
}

class _LotFormScreenState extends State<LotFormScreen> {
  final LotFormController _lotFormController = Get.put(LotFormController());
  

  @override
  Widget build(BuildContext context) {
    return ShorcutKeyboardHandler(
      scaffoldKey: _lotFormController.scaffoldKey,
      onRefresh: () {},
      child: Scaffold(
        key: _lotFormController.scaffoldKey,
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
                height: 15.h,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 15.w),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      child: Row(
                        children: [
                          IconButton(
                              onPressed: () {
                                _lotFormController.goBack();
                              },
                              icon: Icon(Icons.arrow_back_ios_new)),
                          SizedBox(
                            width: 10.w,
                          ),
                          Text(
                            "${_lotFormController.fromMode.value.capitalize} Lot",
                            style: TextPalette.screenTitle,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                        width: 200.w,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SecondaryButton(
                              btnHeight: 46.h,
                                btnWidth: 90.w,
                                isLoading: false, text: 'Clear', onPressed: () {
                              _lotFormController.resetForm();
                            }),
                            Obx(() => PrimaryButton(
                                btnHeight: 46.h,
                                btnWidth: 90.w,
                                isLoading: _lotFormController.isFormSubmit.value,
                                text: _lotFormController.fromMode.value,
                                onPressed: () async {
                                  _lotFormController.submitLotFormDetails(context);
                                })),
                          ],
                        )),
                  ],
                ),
              ),
              Container(
                  margin: EdgeInsets.all(15.w),
                  child: Responsive.isDesktop(context) ?  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [LotDetailForm(), LotItemForm(), LotItemTable()],
                  ) : Column(
                    children: [LotDetailForm(), SizedBox(height: 15.h,), LotItemForm(), SizedBox(height: 15.h,), LotItemTable()],
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
