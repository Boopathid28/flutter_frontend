import 'package:ausales_application/core/theme/color_palette.dart';
import 'package:ausales_application/core/theme/text_palette.dart';
import 'package:ausales_application/view/widgets/layouts/end_menu_drawer_widget.dart';
import 'package:ausales_application/view/widgets/layouts/footer.dart';
import 'package:ausales_application/view/widgets/layouts/header.dart';
import 'package:ausales_application/view/widgets/screen_widgets/item_tag_details/item_tag_details_form.dart';
import 'package:ausales_application/view/widgets/screen_widgets/item_tag_details/view_tag_details.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TagDetailsScreen extends StatefulWidget {
  const TagDetailsScreen({super.key});

  @override
  State<TagDetailsScreen> createState() => _TagDetailsScreenState();
}

class _TagDetailsScreenState extends State<TagDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
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
                children: [
                  Text(
                    "Tag",
                    style: TextPalette.screenTitle,
                  ),
                ],
              ),
            ),
            TagDetailsForm(),
            ViewTagDetails(),
            // TagDetailsTable(),
            // DiamondTagDetailsTable(),
          ],
        ),
      ),
    );
  }
}
