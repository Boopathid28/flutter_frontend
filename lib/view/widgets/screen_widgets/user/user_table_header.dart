import 'package:ausales_application/controller/user/user_list_controller.dart';
import 'package:ausales_application/responsive.dart';
import 'package:ausales_application/view/widgets/form_widgets/custom_dropdown_field.dart';
import 'package:ausales_application/view/widgets/form_widgets/custom_dropdown_search_field.dart';
import 'package:ausales_application/view/widgets/form_widgets/custom_label.dart';
import 'package:ausales_application/view/widgets/form_widgets/custom_text_input.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class UserTableHeader extends StatefulWidget {
  const UserTableHeader({super.key});

  @override
  State<UserTableHeader> createState() => _UserTableHeaderState();
}

class _UserTableHeaderState extends State<UserTableHeader> {
  final UserListController _userListController = Get.put(UserListController());

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(15.w),
      child: Responsive.isDesktop(context) || Responsive.isTablet(context)
          ? Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                activeStatusFilter(context),
                Obx(() => _userListController.isBranchuser.value ? branch() : SizedBox(),),
                searchFilter(context)
              ],
            )
          : Column(
              children: [
                activeStatusFilter(context),
                SizedBox(
                  height: 7.h,
                ),
                Obx(() => _userListController.isBranchuser.value ? branch() : SizedBox(),),
                SizedBox(
                  height: 7.h,
                ),
                searchFilter(context)
              ],
            ),
    );
  }

  SizedBox branch() {
    return SizedBox(
      width: 300.w,
      child: Obx(() => CustomDropdownSearchField(
        filled: true,
            controller: _userListController.branchSearchController,
            selectedValue: _userListController.selectedBranch.value,
            options: _userListController.branchDropDown.value,
            onChanged: (value) {
              _userListController.selectedBranch(value);
              _userListController.getUserList(context);
            },
            hintText: "Branch",
          )),
    );
  }

  SizedBox searchFilter(BuildContext context) {
    return SizedBox(
      width: 300.w,
      child: CustomTextInput(
          controller: _userListController.searchController,
          textInputAction: TextInputAction.done,
          keyboardType: TextInputType.text,
          filled: true,
          prefixIcon: Icons.search,
          hasPrefixIcon: true,
          hintText: "Search",
          onChanged: (value) {
            _userListController.getUserList(context);
          }),
    );
  }

  SizedBox activeStatusFilter(BuildContext context) {
    return SizedBox(
        width: 200.w,
        child: Obx(() => CustomDropdownField(
              filled: true,
              selectedValue: _userListController.selectedActiveStatus.value,
              options: _userListController.activeStatusFilterList.value,
              onChanged: (value) {
                _userListController.selectedActiveStatus(value);
                _userListController.getUserList(context);
              },
              hintText: "User Status",
            )));
  }
}
