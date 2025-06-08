import 'package:ausales_application/controller/metal_master/metal_list_controller.dart';
import 'package:ausales_application/responsive.dart';
import 'package:ausales_application/view/widgets/form_widgets/custom_dropdown_field.dart';
import 'package:ausales_application/view/widgets/form_widgets/custom_label_filter.dart';
import 'package:ausales_application/view/widgets/form_widgets/custom_text_input.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class MetalTableHeader extends StatefulWidget {
  const MetalTableHeader({super.key});

  @override
  State<MetalTableHeader> createState() => _MetalTableHeaderState();
}

class _MetalTableHeaderState extends State<MetalTableHeader> {
  final MetalListController _metalListController = Get.put(MetalListController());

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(15.w),
      child: Responsive.isDesktop(context) || Responsive.isTablet(context) ? Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          activeStatusFilter(context),
          searchFilter(context)
        ],
      ) : Column(
        children: [
          activeStatusFilter(context),
          SizedBox(height: 7.h,),
          searchFilter(context)
        ],
      ),
    );
  }

  SizedBox searchFilter(BuildContext context) {
    return SizedBox(
          width: 300.w,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomLabelFilter(label: "Search"),
              CustomTextInput(
                  controller: _metalListController.searchController,
                  textInputAction: TextInputAction.done,
                  keyboardType: TextInputType.text,
                  filled: true,
                  prefixIcon: Icons.search,
                  hasPrefixIcon: true,
                  hintText: "Search",
                  onChanged: (value) {
                    _metalListController.getMetalList(context);
                  }),
            ],
          ),
        );
  }

  SizedBox activeStatusFilter(BuildContext context) {
    return SizedBox(
        width: 200.w,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomLabelFilter(label: "Active Status"),
            Obx(() => CustomDropdownField(
              filled: true,
                  selectedValue: _metalListController.selectedActiveStatus.value,
                  options: _metalListController.activeStatusFilterList.value,
                  onChanged: (value) {
                    _metalListController.selectedActiveStatus(value);
                    _metalListController.getMetalList(context);
                  },
                  hintText: "Active Status",
                )),
          ],
        ));
  }
}
