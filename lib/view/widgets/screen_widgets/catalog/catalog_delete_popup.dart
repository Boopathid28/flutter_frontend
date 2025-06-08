import 'package:ausales_application/controller/catalog/catalog_list_controller.dart';
import 'package:ausales_application/core/shared_preferences/home_shared_prefs.dart';
import 'package:ausales_application/model/catalog/catalog_models.dart';
import 'package:ausales_application/service/catalog/catalog_service.dart';
import 'package:ausales_application/view/widgets/form_widgets/cancel_button.dart';
import 'package:ausales_application/view/widgets/form_widgets/primary_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class CatalogDeletePopup extends StatelessWidget {
  CatalogListData catalog;
  CatalogDeletePopup({super.key, required this.catalog});

  final CatalogListController _catalogListController = Get.put(CatalogListController());

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Text("Are you sure want to delete the ${catalog.catalogNumber}"),
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
              child: Obx(() => PrimaryButton(
                isLoading: _catalogListController.isDeleteLoading.value, 
                text: "Yes", 
                onPressed: () async {
                  _catalogListController.isDeleteLoading(true);
                  int? menuId = await HomeSharedPrefs.getCurrentMenu();
                  if (menuId != null) {
                    await CatalogService.deleteCatalog(menuId: menuId.toString(), catalogId: catalog.id.toString(), context: context);
                  }
                  _catalogListController.getCatalogList(context);
                  _catalogListController.isDeleteLoading(false);
                }
              )),
            )
          ],
        )
      ],
    );
  }
}