import 'package:ausales_application/controller/single_tag_update/single_tag_udpdate_stone_form_controller.dart';
import 'package:ausales_application/core/theme/text_palette.dart';
import 'package:ausales_application/model/single_tag_update/single_tag_update_model.dart';
import 'package:ausales_application/view/widgets/form_widgets/cancel_button.dart';
import 'package:ausales_application/view/widgets/form_widgets/primary_button.dart';
import 'package:ausales_application/view/widgets/screen_widgets/single_tag_update/tag_update_stone_details_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class DeleteTagUpdateStonePopup extends StatefulWidget {
  String itemIndex;
  TagStoneDetails item;
  DeleteTagUpdateStonePopup({super.key, required this.itemIndex, required this.item});

  @override
  State<DeleteTagUpdateStonePopup> createState() => _DeleteTagUpdateStonePopupState();
}

class _DeleteTagUpdateStonePopupState extends State<DeleteTagUpdateStonePopup> {

  final SingleTagUdpdateStoneFormController _singleTagUdpdateStoneFormController =
      Get.put(SingleTagUdpdateStoneFormController());
      
  @override
  Widget build(BuildContext context) {
    return AlertDialog.adaptive(
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "Stone Delete",
            style: TextPalette.screenTitle,
          ),
          IconButton(onPressed: () {
            Get.back();
          }, icon: Icon(Icons.close))
        ],
      ),
      content: Text('Are you sure want to delete the stone details?'),
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
                  _singleTagUdpdateStoneFormController.deleteUpdatetagStone(context, widget.itemIndex, widget.item);
                }
              ),
            )
          ],
        )
      ],
    );
  }
}