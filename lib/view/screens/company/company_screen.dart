import 'package:ausales_application/controller/company/company_form_controller.dart';
import 'package:ausales_application/core/theme/color_palette.dart';
import 'package:ausales_application/view/widgets/layouts/end_menu_drawer_widget.dart';
import 'package:ausales_application/view/widgets/layouts/footer.dart';
import 'package:ausales_application/view/widgets/layouts/header.dart';
import 'package:ausales_application/view/widgets/screen_widgets/company/company_form.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CompanyScreen extends StatefulWidget {
  @override
  State<CompanyScreen> createState() => _CompanyScreenState();
}

class _CompanyScreenState extends State<CompanyScreen> {

  final CompanyFormController _companyFormController =
      Get.put(CompanyFormController());

  @override
  void initState() {
    super.initState();
    _companyFormController.getCompanyDetails(context);
  }

  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: ColorPalete.inputFilledColor,
      appBar: PreferredSize(
        child: HeaderWidget(),
        preferredSize: Size.fromHeight(100.0),
      ),
      bottomNavigationBar: Footer(),
      endDrawer: EndMenuDrawerWidget(),
      body: CompanyForm(),
    );
  }
}
