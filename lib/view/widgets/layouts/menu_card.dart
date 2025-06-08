import 'package:ausales_application/core/constants/nav_controller.dart';
import 'package:ausales_application/core/shared_preferences/home_shared_prefs.dart';
import 'package:ausales_application/model/home_model.dart';
import 'package:ausales_application/responsive.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MenuCard extends StatelessWidget {
  MenuList item;

  MenuCard({super.key, required this.item});

  

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        HomeSharedPrefs.setCurrentMenu(item.id!);
        getNavFunction(item);
      },
      child: Container(
        decoration: BoxDecoration(
          border: Border(bottom: BorderSide()),
        ),
        padding: EdgeInsets.symmetric(vertical: 10.w),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              item.menuName ?? "",
              style: TextStyle(fontSize: 15.sp, color: Color(0XFF656575)),
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