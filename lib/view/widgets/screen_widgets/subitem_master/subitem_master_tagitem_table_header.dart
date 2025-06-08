import 'package:ausales_application/controller/subitem_master/tag_item_by_subitem_list_controller.dart';
import 'package:ausales_application/view/widgets/form_widgets/custom_text_input.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class SubitemMasterTagitemTableHeader extends StatefulWidget {
  const SubitemMasterTagitemTableHeader({super.key});

  @override
  State<SubitemMasterTagitemTableHeader> createState() =>
      _SubitemMasterTagitemTableHeaderState();
}

class _SubitemMasterTagitemTableHeaderState extends State<SubitemMasterTagitemTableHeader> {
  final TagItemBySubitemListController _tagItemBySubitemListController =
      Get.put(TagItemBySubitemListController());

  List? subItemDetails;

  @override
  void initState() {
    super.initState();
    subItemDetails = Get.arguments;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(15.w),
      child: searchFilter(context),
    );
  }

  SizedBox searchFilter(BuildContext context) {
    return SizedBox(
      width: 300.w,
      child: CustomTextInput(
          controller: _tagItemBySubitemListController.searchController,
          textInputAction: TextInputAction.done,
          keyboardType: TextInputType.text,
          filled: true,
          prefixIcon: Icons.search,
          hasPrefixIcon: true,
          hintText: "Search",
          onChanged: (value) {
            _tagItemBySubitemListController.getTagItemList(context, subItemDetails![1]);
          }),
    );
  }
}
