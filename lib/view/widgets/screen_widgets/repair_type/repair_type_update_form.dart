import 'package:ausales_application/controller/repair_type/repair_type_controller.dart';
import 'package:ausales_application/core/theme/text_palette.dart';
import 'package:ausales_application/responsive.dart';
import 'package:ausales_application/view/widgets/form_widgets/custom_text_input.dart';
import 'package:ausales_application/view/widgets/form_widgets/primary_button.dart';
import 'package:ausales_application/view/widgets/form_widgets/secondary_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class RepairTypeUpdateForm extends StatefulWidget {
  final int id;
  const RepairTypeUpdateForm({super.key,required this.id});

  @override
  State<RepairTypeUpdateForm> createState() => _RepairTypeUpdateFormState();
}

class _RepairTypeUpdateFormState extends State<RepairTypeUpdateForm> {
  final RepairTypeController _repairTypeController =
      Get.put(RepairTypeController());

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return AlertDialog.adaptive(
      insetPadding: EdgeInsets.all(Responsive.isMobile(context)?8.w:0),
      title: Form(
        key: _repairTypeController.updateFormKey,
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Update Repair Type',style:Responsive.isMobile(context)? TextPalette.tableDataTextStyle: TextPalette.screenTitle,),
                
                IconButton(onPressed: () {
                  Get.back();
                  _repairTypeController.resetForm();
                }, icon: const Icon(Icons.close))
              ],
            ),
          SizedBox(height: 15.h,),
            repairTypeInput(),
            SizedBox(height: 30.h,),
            actions(context)
          ],
        ),
      ),
    );
  }

  SizedBox actions(BuildContext context) {
    return SizedBox(
      height: 50.h,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
           SizedBox(
              width:Responsive.isMobile(context)?100.w: 145.w,
              child: SecondaryButton(
                  btnHeight:Responsive.isMobile(context)?30.h: 46.h,
                  isLoading: false,
                  text: "Clear",
                  onPressed: () async {
                    _repairTypeController.resetForm();
                  },
                ),
              ),
              SizedBox(
            width: 15.w,
          ),
          SizedBox(
              child: Obx(
                ()=> PrimaryButton(
                  btnWidth:Responsive.isMobile(context)?100.w: 145.w,
                  btnHeight:Responsive.isMobile(context)?30.h: 46.h,
                  isLoading: _repairTypeController.isSubmitLoading.value,
                  text: "Update",
                  onPressed: () async {
                     _repairTypeController.isSubmitLoading(true);
                    _repairTypeController.fromMode('update');
                    await _repairTypeController.submitRepairType(context, widget.id);
                     _repairTypeController.isSubmitLoading(false);
                    _repairTypeController.resetForm();
                  },
                ),
              )),
          
         
        ],
      ),
    );
  }

  SizedBox repairTypeInput() {
    return SizedBox(
      width: Responsive.isMobile(context) ? double.infinity : 300.w,
      child: CustomTextInput(
          hintText: 'Enter repair type',
          controller: _repairTypeController.repairController,
          textInputAction: TextInputAction.done,
          keyboardType: TextInputType.text),
    );
  }
}
