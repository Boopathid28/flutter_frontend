import 'package:ausales_application/controller/metal_rate_master/metal_rate_master_list_controller.dart';
import 'package:ausales_application/core/constants/app_configuration.dart';
import 'package:ausales_application/core/keyboard_listeners/shortcut_keyboard_handler.dart';
import 'package:ausales_application/core/theme/color_palette.dart';
import 'package:ausales_application/core/theme/shadow_palette.dart';
import 'package:ausales_application/core/theme/text_palette.dart';
import 'package:ausales_application/responsive.dart';
import 'package:ausales_application/view/widgets/layouts/end_menu_drawer_widget.dart';
import 'package:ausales_application/view/widgets/layouts/footer.dart';
import 'package:ausales_application/view/widgets/layouts/header.dart';
import 'package:ausales_application/view/widgets/screen_widgets/metal_rates_master/metal_rate_form.dart';
import 'package:ausales_application/view/widgets/screen_widgets/metal_rates_master/metal_rate_header.dart';
import 'package:ausales_application/view/widgets/screen_widgets/metal_rates_master/metal_rate_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class MetalRatesScreen extends StatefulWidget {
  @override
  State<MetalRatesScreen> createState() => _MetalRatesScreenState();
}

class _MetalRatesScreenState extends State<MetalRatesScreen> {
  final MetalRateMasterListController _metalRateMasterListController = Get.put(MetalRateMasterListController());

  @override
  void initState() {
    super.initState();
    _metalRateMasterListController.getMetalRateMasterList(context);
  }


  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return ShorcutKeyboardHandler(
      scaffoldKey: _metalRateMasterListController.scaffoldKey,
      onRefresh: () {
        _metalRateMasterListController.getMetalRateMasterList(context);
      },
      child: Scaffold(
         key: _metalRateMasterListController.scaffoldKey,
        backgroundColor: ColorPalete.appBgColor,
        appBar: PreferredSize(
          child: HeaderWidget(),
          preferredSize: Size.fromHeight(100.0),
        ),
        bottomNavigationBar: Footer(),
        endDrawer: EndMenuDrawerWidget(),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 15.h,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 15.w,),
                child: Row(
                  children: [
                    Text(
                      "Metal Rates",
                      style: TextPalette.screenTitle,
                    ),
                    SizedBox(width: 10.w,),
                    IconButton(
                      onPressed: () {
                        _metalRateMasterListController.getMetalRateMasterList(context);
                      }, 
                      icon: Icon(Icons.refresh)
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 15.h,
              ),
              MetalRateForm(),
              MetalRateHeader(),
              Container(
                height: 470.h,
                decoration: BoxDecoration(
                    color: Colors.white,),
                margin: EdgeInsets.symmetric(horizontal: 15.w),
                child: Stack(
                  children: [
                    Obx(() => _metalRateMasterListController.isTableLoading.value ? Padding(
                      padding: EdgeInsets.symmetric(horizontal: 7.w),
                      child: LinearProgressIndicator(),
                    ) :
                    MetalRateList()
                    ),
                    Positioned(
                      bottom: 0,
                      left: 0,
                      child: Container(
                        height: 60.h,
                        width: size.width - 38,
                        padding: EdgeInsets.all(16.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.vertical(
                              bottom: Radius.circular(15.r)),
                          color: Colors.white,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            itemsPerPageChange(context),
                            SizedBox(width: 5.w,),
                            changePage(context),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: defaultBottombarHeight,
              )
            ],
          ),
        ),
      ),
    );
  }

  SizedBox itemsPerPageChange(BuildContext context) {
    return SizedBox(
      child: Row(
        children: [
          Text(
            'Rows per page:',
            style: TextStyle(
                fontSize: Responsive.isDesktop(context) || Responsive.isTablet(context) ? 12.sp : 10.sp),
          ),
          SizedBox(
            width: 15.w,
          ),
          Obx(() => DropdownButton<int>(
                value: _metalRateMasterListController.itemsPerPage.value,
                onChanged: (value) {
                  _metalRateMasterListController.itemsPerPage(value);
                  _metalRateMasterListController.getMetalRateMasterList(context);
                },
                items: [12, 24, 36, 48, 60]
                    .map((value) => DropdownMenuItem<int>(
                          value: value,
                          child: Text('$value'),
                        ))
                    .toList(),
              )),
        ],
      ),
    );
  }

  Obx changePage(BuildContext context) {
    return Obx(() => Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'Page ${_metalRateMasterListController.page.value} of ${_metalRateMasterListController.totalpages.value}',
              style: TextStyle(
                  fontSize: Responsive.isDesktop(context) || Responsive.isTablet(context) ? 12.sp : 10.sp),
            ),
            IconButton(
                icon: Icon(Icons.arrow_back, size: Responsive.isDesktop(context) || Responsive.isTablet(context) ? 20.sp : 15.sp),
                onPressed: _metalRateMasterListController.page.value > 1
                    ? () {
                        if (_metalRateMasterListController.page.value > 1) {
                          _metalRateMasterListController
                              .page(_metalRateMasterListController.page.value - 1);
                          _metalRateMasterListController.getMetalRateMasterList(context);
                        }
                      }
                    : null),
            IconButton(
                icon: Icon(Icons.arrow_forward, size: Responsive.isDesktop(context) || Responsive.isTablet(context) ? 20.sp : 15.sp),
                onPressed: _metalRateMasterListController.page.value <
                        _metalRateMasterListController.totalpages.value
                    ? () {
                        if (_metalRateMasterListController.page.value <
                            _metalRateMasterListController.totalpages.value) {
                          _metalRateMasterListController
                              .page(_metalRateMasterListController.page.value + 1);
                          _metalRateMasterListController.getMetalRateMasterList(context);
                        }
                      }
                    : null),
          ],
        ));
  }
}
