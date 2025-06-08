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
  MenuGroupCard({super.key, required this.item, required this.index});

  final EndDrawerController _endDrawerController =
      Get.put(EndDrawerController());

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _endDrawerController.activeMenuGroup(item);
        _endDrawerController.activeMenuIndex(index);
        _endDrawerController.menuGroupClicked(true);
        Scaffold.of(context).openEndDrawer();
      },
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.r),
          side: BorderSide(
            color: Colors.grey,
            width: 0.5,
          ),
        ),
        color: Colors.white,
        child: SizedBox(
          height: 20.h,
          child: Stack(
            children: [
              Visibility(
                visible: Responsive.isDesktop(context) ||
                        Responsive.isTablet(context)
                    ? true
                    : false,
                child: Positioned(
                    right: 5.w,
                    top: 5.h,
                    child: Container(
                      
                      padding: EdgeInsets.all(5.w),
                      decoration: BoxDecoration(
                        color: Color(0xFFE2E8F0),
                        borderRadius: BorderRadius.circular(5.r)
                      ),
                      child: Text(
                        item.shortcut??"",
                        style: TextStyle(
                            color: Color(0xFF656575),
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w500),
                      ),
                    )),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 30.w),
                child: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Image(image: NetworkImage('$baseMediaUrl/${item.menuGroupIcon}'), width: 35.w,),
                      SizedBox(
                        width: 20.w,
                      ),
                      Text(
                        item.menuGroupName!,
                        style: TextStyle(
                            fontSize: 15.sp, fontWeight: FontWeight.w600),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
