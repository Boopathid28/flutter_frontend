import 'package:ausales_application/controller/layout/end_drawer_controller.dart';
import 'package:ausales_application/core/constants/app_configuration.dart';
import 'package:ausales_application/model/home_model.dart';
import 'package:ausales_application/responsive.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class MenuGroupCard extends StatelessWidget {
  UserMenuDataList item;
  int index;

  MenuGroupCard({super.key,required this.item, required this.index});

  final EndDrawerController _endDrawerController = Get.put(EndDrawerController());

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _endDrawerController.menuGroupClicked(true);
        _endDrawerController.activeMenuIndex(index);
        _endDrawerController.activeMenuGroup(item);
      },
      child: Container(
        decoration: const BoxDecoration(
          border: Border(
            bottom: BorderSide(color: Color(0XFFCDCDD0))
          ),
        ),
        padding: EdgeInsets.symmetric(vertical: 10.w),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Image(image: NetworkImage('$baseMediaUrl/${item.menuGroupIcon}'), width: 35.w,),
                SizedBox(
                  width: 15.w,
                ),
                Text(item.menuGroupName??"", style: TextStyle(
                  fontSize: 15.sp,
                  color: Color(0XFF656575)
                ),),
              ],
            ),
            
            Visibility(
              visible:
                  Responsive.isDesktop(context) || Responsive.isTablet(context)
                      ? true
                      : false,
              child: Text(
                item.shortcut??"",
                style: TextStyle(
                    color: Colors.grey.shade500,
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w500),
              ),
            ),
          ],
        ),
      ),
    );
  }
}