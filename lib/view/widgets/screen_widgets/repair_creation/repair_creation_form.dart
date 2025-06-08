import 'package:ausales_application/controller/repair_type/repair_type_controller.dart';
import 'package:ausales_application/core/theme/text_palette.dart';
import 'package:ausales_application/responsive.dart';
import 'package:ausales_application/view/widgets/form_widgets/custom_text_input.dart';
import 'package:ausales_application/view/widgets/form_widgets/primary_button.dart';
import 'package:ausales_application/view/widgets/form_widgets/secondary_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class RepairCreationForm extends StatefulWidget {
  const RepairCreationForm({super.key});

  @override
  State<RepairCreationForm> createState() => _RepairCreationFormState();
}

class _RepairCreationFormState extends State<RepairCreationForm> {
  final RepairTypeController _repairTypeController =
      Get.put(RepairTypeController());

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return AlertDialog.adaptive(
      insetPadding: EdgeInsets.all(Responsive.isMobile(context)?8.w:0),
      title: Form(
        key: _repairTypeController.createFormKey,
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Repair',style:Responsive.isMobile(context)?TextPalette.tableDataTextStyle: TextPalette.screenTitle,),
                
                IconButton(onPressed: () {
                  Get.back();
                  _repairTypeController.resetForm();
                }, icon: const Icon(Icons.close))
              ],
            ),
          SizedBox(height: 15.h,),
           Wrap(
            children: [
              
            ],
           ),
            SizedBox(height: 30.h,),
            actions(context)
          ],
        ),
      ),
    );
  }

  SizedBox actions(BuildContext context) {
    return SizedBox(
      height:Responsive.isMobile(context)?30.h: 50.h,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
           SizedBox(
              width:Responsive.isMobile(context)?100.w: 145.w,
              child: 
               SecondaryButton(
                  btnHeight: 46.h,
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
              width:Responsive.isMobile(context)?100.w: 145.w,
              child: Obx(
                ()=> PrimaryButton(
                  btnWidth: 145.w,
                  btnHeight: 46.h,
                  isLoading: _repairTypeController.isSubmitLoading.value,
                  text: "Done",
                  onPressed: () async {
                    _repairTypeController.isSubmitLoading(true);
                    _repairTypeController.fromMode('create');
                    await _repairTypeController.submitRepairType(context, null);
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
