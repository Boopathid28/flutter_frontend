import 'package:ausales_application/controller/single_tag_update/single_tag_update_diamond_form_controller.dart';
import 'package:ausales_application/core/theme/text_palette.dart';
import 'package:ausales_application/model/single_tag_update/single_tag_update_model.dart';
import 'package:ausales_application/view/widgets/form_widgets/cancel_button.dart';
import 'package:ausales_application/view/widgets/form_widgets/primary_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class DeleteTagUpdateDiamondPopup extends StatefulWidget {
  String itemIndex;
  TagDiamondDetails item;
  DeleteTagUpdateDiamondPopup({super.key, required this.itemIndex, required this.item});

  @override
  State<DeleteTagUpdateDiamondPopup> createState() => _DeleteTagUpdateDiamondPopupState();
}

class _DeleteTagUpdateDiamondPopupState extends State<DeleteTagUpdateDiamondPopup> {

  final SingleTagUpdateDiamondFormController _singleTagUpdateDiamondFormController =
      Get.put(SingleTagUpdateDiamondFormController());
      
  @override
  Widget build(BuildContext context) {
    return AlertDialog.adaptive(
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "Diamond Delete",
            style: TextPalette.screenTitle,
          ),
          IconButton(onPressed: () {
            Get.back();
          }, icon: Icon(Icons.close))
        ],
      ),
      content: Text('Are you sure want to delete the diamond details?'),
      actions: [
        Row(
          children: [
            SizedBox(
              width: 200.w,
              child: CancelButton(
                isLoading: false, 
                text: "No", 
                onPressed: () {
                  Get.back();
                }
              ),
            ),
            SizedBox(width: 15.w,),
            SizedBox(
              width: 200.w,
              child: PrimaryButton(
                isLoading: false, 
                text: "Yes", 
                onPressed: () async {
                  _singleTagUpdateDiamondFormController.deleteUpdatetagDiamond(context, widget.itemIndex, widget.item);
                }
              ),
            )
          ],
        )
      ],
    );
  }
}