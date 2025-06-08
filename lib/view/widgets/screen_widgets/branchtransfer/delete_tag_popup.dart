import 'package:ausales_application/controller/branchtransfer/branch_transfer_form.dart';
import 'package:ausales_application/core/theme/text_palette.dart';
import 'package:ausales_application/view/widgets/form_widgets/cancel_button.dart';
import 'package:ausales_application/view/widgets/form_widgets/primary_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class DeleteBranchTagpopup extends StatefulWidget {
  String itemIndex;
  DeleteBranchTagpopup({super.key, required this.itemIndex});

  @override
  State<DeleteBranchTagpopup> createState() => _DeleteBranchTagpopupState();
}

class _DeleteBranchTagpopupState extends State<DeleteBranchTagpopup> {

  final BranchTransferFormController _branchTransferFormController =
      Get.put(BranchTransferFormController());
      
  @override
  Widget build(BuildContext context) {
    return AlertDialog.adaptive(
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "Tag Delete",
            style: TextPalette.screenTitle,
          ),
          IconButton(onPressed: () {
            Get.back();
          }, icon: Icon(Icons.close))
        ],
      ),
      content: Text('Are you sure want to delete the tag details?'),
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
                  _branchTransferFormController.deleteItemtag(context, widget.itemIndex);
                }
              ),
            )
          ],
        )
      ],
    );
  }
}