import 'dart:developer';

import 'package:ausales_application/controller/transfer_creation/transfer_creation_form_controller.dart';
import 'package:ausales_application/core/keyboard_listeners/shortcut_keyboard_handler.dart';
import 'package:ausales_application/core/theme/color_palette.dart';
import 'package:ausales_application/core/theme/shadow_palette.dart';
import 'package:ausales_application/core/theme/text_palette.dart';
import 'package:ausales_application/responsive.dart';
import 'package:ausales_application/view/widgets/form_widgets/custom_dropdown_field.dart';
import 'package:ausales_application/view/widgets/form_widgets/custom_label.dart';
import 'package:ausales_application/view/widgets/form_widgets/custom_text_input.dart';
import 'package:ausales_application/view/widgets/form_widgets/primary_button.dart';
import 'package:ausales_application/view/widgets/layouts/end_menu_drawer_widget.dart';
import 'package:ausales_application/view/widgets/layouts/footer.dart';
import 'package:ausales_application/view/widgets/layouts/header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class TransferCreationForm extends StatefulWidget {
  @override
  State<TransferCreationForm> createState() => _TransferCreationFormState();
}

class _TransferCreationFormState extends State<TransferCreationForm> {
  final TransferCreationFormController _transferCreationFormController =
      Get.put(TransferCreationFormController());

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return ShorcutKeyboardHandler(
      scaffoldKey: _transferCreationFormController.scaffoldKey,
      onRefresh: () {},
      child: Scaffold(
        key: _transferCreationFormController.scaffoldKey,
        backgroundColor: ColorPalete.appBgColor,
        appBar: PreferredSize(
          child: HeaderWidget(),
          preferredSize: Size.fromHeight(100.0),
        ),
        bottomNavigationBar: Footer(),
        endDrawer: EndMenuDrawerWidget(),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                  onPressed: () {
                                    Get.back();
                                    _transferCreationFormController.resetForm();
                                  },
                                  icon: Icon(Icons.arrow_back_ios_new)),
                              SizedBox(
                                height: 10.w,
                              ),
                              Text(
                                "Transfer Creation",
                                style: TextPalette.screenTitle,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        boxShadow: ShadowPalette.formElevation,
                        borderRadius: BorderRadius.vertical(
                            bottom: Radius.circular(15.r),
                            top: Radius.circular(15.r)),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Form(
                          key: _transferCreationFormController
                              .transfercreationFormKey,
                          child: Wrap(
                            spacing: 10.w,
                            runSpacing: 10.h,
                            children: [
                              Obx(
                                () => _transferCreationFormController
                                        .isBranchuser.value
                                    ? branch()
                                    : SizedBox(),
                              ),
                              datefilter(context),
                              metal(),
                              SizedBox(
                                child: SizedBox(
                                    width: Responsive.isDesktop(context) ||
                                            Responsive.isTablet(context)
                                        ? 115.w
                                        : double.infinity,
                                    child: Obx(() => PrimaryButton(
                                        btnHeight: 46.h,
                                        isLoading:
                                            _transferCreationFormController
                                                .isFindLoading.value,
                                        text: "Find",
                                        onPressed: () {
                                          _transferCreationFormController
                                              .gettransfercreationList(context);
                                        }))),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10.h,
                ),
                Container(
                  width: size.width,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: ShadowPalette.formElevation,
                    borderRadius:
                        BorderRadius.vertical(bottom: Radius.circular(15.r)),
                  ),
                  child: Obx(() => _transferCreationFormController
                              .transfercreationFormMode.value ==
                          'update'
                      ? Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            SizedBox(
                              width: double.infinity,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  SizedBox(height: 10.h,),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 25),
                                    child: Text("Items",style: TextStyle(fontSize: 18.sp,fontWeight: FontWeight.w700),),
                                  ),
                                  SizedBox(height: 10.h,),
                                  Flexible(
                                    child: SingleChildScrollView(
                                      scrollDirection: Axis.horizontal,
                                      child: SizedBox(
                                        width: Responsive.isDesktop(context)
                                            ? size.width
                                            : null,
                                        child: Obx(() => DataTable(
                                              headingRowColor:
                                                  WidgetStateProperty.resolveWith<
                                                      Color?>((Set<WidgetState>
                                                          states) =>
                                                      ColorPalete
                                                          .tableHeaderBgColor),
                                              columns: [
                                                DataColumn(
                                                  label: SizedBox(
                                                    width: 100.w,
                                                    child: Text(
                                                      '#',
                                                      style: TextPalette
                                                          .tableHeaderTextStyle,
                                                    ),
                                                  ),
                                                ),
                                                DataColumn(
                                                  label: SizedBox(
                                                    width: 100.w,
                                                    child: Text(
                                                      'Metal Name',
                                                      style: TextPalette
                                                          .tableHeaderTextStyle,
                                                    ),
                                                  ),
                                                ),
                                                DataColumn(
                                                  label: SizedBox(
                                                    width: 75.w,
                                                    child: Text(
                                                      'Gross Weight',
                                                      style: TextPalette
                                                          .tableHeaderTextStyle,
                                                    ),
                                                  ),
                                                ),
                                                DataColumn(
                                                  label: SizedBox(
                                                    width: 75.w,
                                                    child: Text(
                                                      'Dust Weight',
                                                      style: TextPalette
                                                          .tableHeaderTextStyle,
                                                    ),
                                                  ),
                                                ),
                                                DataColumn(
                                                  label: SizedBox(
                                                    width: 75.w,
                                                    child: Text(
                                                      'Net Weight',
                                                      style: TextPalette
                                                          .tableHeaderTextStyle,
                                                    ),
                                                  ),
                                                ),
                                                DataColumn(
                                                  label: SizedBox(
                                                    width: 75.w,
                                                    child: Text(
                                                      'Customer Name',
                                                      style: TextPalette
                                                          .tableHeaderTextStyle,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                              rows: _transferCreationFormController
                                                  .transfercreationdataparticularUpdatelist
                                                  .value
                                                  .map((item) {
                                                return DataRow(cells: [
                                                  DataCell(
                                                    Obx(() => Checkbox(
                                                          fillColor: WidgetStateProperty
                                                              .resolveWith<
                                                                  Color?>((Set<
                                                                          WidgetState>
                                                                      states) =>
                                                                  ColorPalete
                                                                      .primaryBtnColor),
                                                          value: _transferCreationFormController
                                                                  .selectedRemoveItems
                                                                  .contains(item
                                                                      .id
                                                                      .toString())
                                                              ? true
                                                              : false,
                                                          onChanged:
                                                              (bool? value) {
                                                            _transferCreationFormController
                                                                .updateRemoveTempList(
                                                                    value!,
                                                                    item);
                                                          },
                                                        )),
                                                  ),
                                                  DataCell(Text(item
                                                      .metalDetailsName
                                                      .toString())),
                                                  DataCell(Text(item.grossWeight
                                                      .toString())),
                                                  DataCell(Text(item.dustWeight
                                                      .toString())),
                                                  DataCell(Text(item.netWeight
                                                      .toString())),
                                                  DataCell(Text(item
                                                      .customerName
                                                      .toString())),
                                                ]);
                                              }).toList(),
                                            )),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 20.h,
                            ),
                            SizedBox(
                              width: double.infinity,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 25),
                                    child: Text("Selected New Items",style: TextStyle(fontSize: 18.sp,fontWeight: FontWeight.w700),),
                                  ),
                                  SizedBox(height: 10.h,),
                                  Flexible(
                                    child: SingleChildScrollView(
                                      scrollDirection: Axis.horizontal,
                                      child: SizedBox(
                                        width: Responsive.isDesktop(context)
                                            ? size.width
                                            : null,
                                        child: Obx(() => DataTable(
                                              headingRowColor:
                                                  WidgetStateProperty.resolveWith<
                                                      Color?>((Set<WidgetState>
                                                          states) =>
                                                      ColorPalete
                                                          .tableHeaderBgColor),
                                              columns: [
                                                DataColumn(
                                                  label: SizedBox(
                                                    width: 100.w,
                                                    child: Text(
                                                      '#',
                                                      style: TextPalette
                                                          .tableHeaderTextStyle,
                                                    ),
                                                  ),
                                                ),
                                                DataColumn(
                                                  label: SizedBox(
                                                    width: 100.w,
                                                    child: Text(
                                                      'Metal Name',
                                                      style: TextPalette
                                                          .tableHeaderTextStyle,
                                                    ),
                                                  ),
                                                ),
                                                DataColumn(
                                                  label: SizedBox(
                                                    width: 75.w,
                                                    child: Text(
                                                      'Gross Weight',
                                                      style: TextPalette
                                                          .tableHeaderTextStyle,
                                                    ),
                                                  ),
                                                ),
                                                DataColumn(
                                                  label: SizedBox(
                                                    width: 75.w,
                                                    child: Text(
                                                      'Dust Weight',
                                                      style: TextPalette
                                                          .tableHeaderTextStyle,
                                                    ),
                                                  ),
                                                ),
                                                DataColumn(
                                                  label: SizedBox(
                                                    width: 75.w,
                                                    child: Text(
                                                      'Net Weight',
                                                      style: TextPalette
                                                          .tableHeaderTextStyle,
                                                    ),
                                                  ),
                                                ),
                                                DataColumn(
                                                  label: SizedBox(
                                                    width: 75.w,
                                                    child: Text(
                                                      'Customer Name',
                                                      style: TextPalette
                                                          .tableHeaderTextStyle,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                              rows: _transferCreationFormController
                                                  .transfercreationdataparticularlist
                                                  .value
                                                  .map((item) {
                                                return DataRow(cells: [
                                                  DataCell(
                                                    Obx(() => Checkbox(
                                                          fillColor: WidgetStateProperty
                                                              .resolveWith<
                                                                  Color?>((Set<
                                                                          WidgetState>
                                                                      states) =>
                                                                  ColorPalete
                                                                      .primaryBtnColor),
                                                          value: _transferCreationFormController
                                                                  .selectedEditItems
                                                                  .contains(item
                                                                      .id
                                                                      .toString())
                                                              ? true
                                                              : false,
                                                          onChanged:
                                                              (bool? value) {
                                                            _transferCreationFormController
                                                                .updateNewTempList(
                                                                    value!,
                                                                    item);
                                                          },
                                                        )),
                                                  ),
                                                  DataCell(Text(item
                                                      .metalDetailsName
                                                      .toString())),
                                                  DataCell(Text(item.grossWeight
                                                      .toString())),
                                                  DataCell(Text(item.dustWeight
                                                      .toString())),
                                                  DataCell(Text(item.netWeight
                                                      .toString())),
                                                  DataCell(Text(item
                                                      .customerName
                                                      .toString())),
                                                ]);
                                              }).toList(),
                                            )),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ],
                        )
                      : SizedBox()),
                ),
                Obx(() => _transferCreationFormController
                            .transfercreationFormMode.value ==
                        'create'
                    ? Container(
                        width: size.width,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          boxShadow: ShadowPalette.formElevation,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Flexible(
                              child: SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: SizedBox(
                                  width: Responsive.isDesktop(context)
                                      ? size.width
                                      : null,
                                  child: Obx(() => DataTable(
                                        headingRowColor: WidgetStateProperty
                                            .resolveWith<Color?>(
                                                (Set<WidgetState> states) =>
                                                    ColorPalete
                                                        .tableHeaderBgColor),
                                        columns: [
                                          DataColumn(
                                            label: SizedBox(
                                              width: 100.w,
                                              child: Text(
                                                '#',
                                                style: TextPalette
                                                    .tableHeaderTextStyle,
                                              ),
                                            ),
                                          ),
                                          DataColumn(
                                            label: SizedBox(
                                              width: 100.w,
                                              child: Text(
                                                'Metal Name',
                                                style: TextPalette
                                                    .tableHeaderTextStyle,
                                              ),
                                            ),
                                          ),
                                          DataColumn(
                                            label: SizedBox(
                                              width: 75.w,
                                              child: Text(
                                                'Gross Weight',
                                                style: TextPalette
                                                    .tableHeaderTextStyle,
                                              ),
                                            ),
                                          ),
                                          DataColumn(
                                            label: SizedBox(
                                              width: 75.w,
                                              child: Text(
                                                'Dust Weight',
                                                style: TextPalette
                                                    .tableHeaderTextStyle,
                                              ),
                                            ),
                                          ),
                                          DataColumn(
                                            label: SizedBox(
                                              width: 75.w,
                                              child: Text(
                                                'Net Weight',
                                                style: TextPalette
                                                    .tableHeaderTextStyle,
                                              ),
                                            ),
                                          ),
                                          DataColumn(
                                            label: SizedBox(
                                              width: 75.w,
                                              child: Text(
                                                'Customer Name',
                                                style: TextPalette
                                                    .tableHeaderTextStyle,
                                              ),
                                            ),
                                          ),
                                        ],
                                        rows: _transferCreationFormController
                                            .transfercreationdataparticularlist
                                            .value
                                            .map((item) {
                                          return DataRow(cells: [
                                            DataCell(
                                              Obx(() => Checkbox(
                                                    fillColor: WidgetStateProperty
                                                        .resolveWith<
                                                            Color?>((Set<
                                                                    WidgetState>
                                                                states) =>
                                                            ColorPalete
                                                                .primaryBtnColor),
                                                    value:
                                                        _transferCreationFormController
                                                                .selectedItems
                                                                .contains(item
                                                                    .id
                                                                    .toString())
                                                            ? true
                                                            : false,
                                                    onChanged: (bool? value) {
                                                      _transferCreationFormController
                                                          .updateTempList(
                                                              value!, item);
                                                    },
                                                  )),
                                            ),
                                            DataCell(Text(item.metalDetailsName
                                                .toString())),
                                            DataCell(Text(
                                                item.grossWeight.toString())),
                                            DataCell(Text(
                                                item.dustWeight.toString())),
                                            DataCell(Text(
                                                item.netWeight.toString())),
                                            DataCell(Text(
                                                item.customerName.toString())),
                                          ]);
                                        }).toList(),
                                      )),
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                    : SizedBox()),
                SizedBox(
                  height: 10.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    action(context),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  SizedBox action(BuildContext context) {
    return SizedBox(
      child: SizedBox(
          width: Responsive.isDesktop(context) || Responsive.isTablet(context)
              ? 115.w
              : double.infinity,
          child: Obx(() => PrimaryButton(
              btnHeight: 46.h,
              isLoading: _transferCreationFormController.isFormSubmit.value,
              text: "Save",
              onPressed: () {
                _transferCreationFormController
                    .submitTransferCreationForm(context);
              }))),
    );
  }

  SizedBox metal() {
    return SizedBox(
      width: 300.w,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomLabel(label: "Metal"),
          SizedBox(
            height: 7.w,
          ),
          Obx(() => CustomDropdownField(
                selectedValue:
                    _transferCreationFormController.selectedMetal.value,
                options: _transferCreationFormController.metalDropDown.value,
                onChanged: (value) {
                  _transferCreationFormController.selectedMetal(value);
                },
                hintText: "Metal",
              )),
        ],
      ),
    );
  }

  SizedBox datefilter(BuildContext context) {
    return SizedBox(
      width: 300.w,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomLabel(label: "Date Filter"),
          SizedBox(
            height: 7.w,
          ),
          CustomTextInput(
              readOnly: true,
              controller: _transferCreationFormController
                  .transferCreationDateFilterController,
              textInputAction: TextInputAction.done,
              keyboardType: TextInputType.text,
              filled: true,
              hasSuffixIcon: true,
              suffixIcon: Icons.close,
              suffixClicked: () {
                _transferCreationFormController
                    .transferCreationDateFilterController
                    .clear();
              },
              hintText: "Entry Date Range",
              onTap: () async {
                final today = DateTime.now();
                final endYear = today.year + 1;
                DateTimeRange? pickedDate = await showDateRangePicker(
                  context: context,
                  firstDate: DateTime(1900),
                  lastDate: DateTime(endYear),
                  builder: (context, child) {
                    return Center(
                      child: Container(
                        height: 450.h,
                        width: 400.w,
                        child: child,
                      ),
                    );
                  },
                );
                if (pickedDate != null) {
                  var startDate = pickedDate.start.toString().substring(0, 10);
                  var endDate = pickedDate.end
                      .add(Duration(days: 1))
                      .toString()
                      .substring(0, 10);
                  _transferCreationFormController
                      .transferCreationDateFilterController
                      .text = [startDate, endDate].join(" to ");
                } else {
                  _transferCreationFormController
                      .transferCreationDateFilterController
                      .clear();
                }
              }),
        ],
      ),
    );
  }

  SizedBox branch() {
    return SizedBox(
      width: 300.w,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomLabel(label: "branch"),
          SizedBox(
            height: 7.w,
          ),
          Obx(() => CustomDropdownField(
                selectedValue:
                    _transferCreationFormController.selectedBranch.value,
                options: _transferCreationFormController.branchDropDown.value,
                onChanged: (value) {
                  _transferCreationFormController.selectedBranch(value);
                },
                hintText: "Branch",
              )),
        ],
      ),
    );
  }
}
