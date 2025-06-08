import 'package:ausales_application/controller/estimation/estimation_stone_form_controller.dart';
import 'package:ausales_application/controller/mannual_estimation/mannual_estimation_stone_form_controller.dart';
import 'package:ausales_application/core/theme/text_palette.dart';
import 'package:ausales_application/view/widgets/form_widgets/cancel_button.dart';
import 'package:ausales_application/view/widgets/form_widgets/primary_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class DeleteMannualEstimationStonePopup extends StatefulWidget {
  String itemIndex;
  DeleteMannualEstimationStonePopup({super.key, required this.itemIndex});

  @override
  State<DeleteMannualEstimationStonePopup> createState() => _DeleteMannualEstimationStonePopupState();
}

class _DeleteMannualEstimationStonePopupState extends State<DeleteMannualEstimationStonePopup> {

  final MannualEstimationStoneFormController _mannualEstimationStoneFormController
   =
      Get.put(MannualEstimationStoneFormController());
      
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
                  _mannualEstimationStoneFormController
                  .deleteItemtagStone(context, widget.itemIndex);
                }
              ),
            )
          ],
        )
      ],
    );
  }
}