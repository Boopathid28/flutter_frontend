import 'package:ausales_application/core/constants/app_configuration.dart';
import 'package:ausales_application/model/subitem_master/subitem_master_model.dart';
import 'package:ausales_application/service/subitem_master/subitem_master_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TagItemBySubitemListController extends GetxController {

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  
  TextEditingController searchController = TextEditingController();
  RxInt itemsPerPage = initialRowsPerPage.obs;
  RxInt page = 1.obs;
  RxInt totalpages = 1.obs;

  RxBool isTableLoading = true.obs;

  RxList<SubItemTaggedDetailsData> tableData = <SubItemTaggedDetailsData>[].obs;

  Future getTagItemList(BuildContext context, String subItemId) async {
    isTableLoading(true);

    final Map<String, dynamic>? itemList =
        await SubitemMasterService.getItemsDetailsBySubItem(
          context: context,
          search: searchController.text,
          page: page.value.toString(),
          itemsPerPage: itemsPerPage.toString(),
          subItemId: subItemId,
        );

    if (itemList != null) {
      tableData(itemList['data']);
      totalpages(itemList['total_pages']);
    } else {
      tableData([]);
      totalpages(1);
    }
    isTableLoading(false);
  }
}