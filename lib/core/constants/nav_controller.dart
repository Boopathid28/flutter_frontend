import 'dart:developer';

import 'package:ausales_application/model/home_model.dart';
import 'package:ausales_application/view/screens/advance/advance_list_screen.dart';
import 'package:ausales_application/view/screens/approval_issues/approval_issues_list_screen.dart';
import 'package:ausales_application/view/screens/catalog/catalog_list_screen.dart';
import 'package:ausales_application/view/screens/branch_transfer/branch_transfer_list_screen.dart';
import 'package:ausales_application/view/screens/bulk_tag_update/bulk_tag_update_screen.dart';
import 'package:ausales_application/view/screens/company/company_screen.dart';
import 'package:ausales_application/view/screens/company_ledger/company_ledger_list_screen.dart';
import 'package:ausales_application/view/screens/counter/counter_list_screen.dart';
import 'package:ausales_application/view/screens/customer/customer_list_screen.dart';
import 'package:ausales_application/view/screens/customer_group/customer_group_list_screen.dart';
import 'package:ausales_application/view/screens/customer_ledger/customer_ledger_list_screen.dart';
import 'package:ausales_application/view/screens/designer/designer_list_screen.dart';
import 'package:ausales_application/view/screens/diamond_master/diamond_master_screen.dart';
import 'package:ausales_application/view/screens/direct_issues/direct_issues_list_screen.dart';
import 'package:ausales_application/view/screens/estimation/estimation_screen.dart';
import 'package:ausales_application/view/screens/estimation_history/estimation_history_screen.dart';
import 'package:ausales_application/view/screens/expense_account/expense_list_screen.dart';
import 'package:ausales_application/view/screens/floor/floor_list_screen.dart';
import 'package:ausales_application/view/screens/home_screen.dart';
import 'package:ausales_application/view/screens/invoice/invoice_screen.dart';
import 'package:ausales_application/view/screens/invoice_history/invoice_history_screen.dart';
import 'package:ausales_application/view/screens/item_master/item_master_list_screen.dart';
import 'package:ausales_application/view/screens/item_tag_details/item_tag_details_screen.dart';
import 'package:ausales_application/view/screens/itemtag/itemtag_list_screen.dart';
import 'package:ausales_application/view/screens/login_screen.dart';
import 'package:ausales_application/view/screens/lot/lot_list_screen.dart';
import 'package:ausales_application/view/screens/mannual_estimation/mannual_estimation_screen.dart';
import 'package:ausales_application/view/screens/manual_estimation_history/manual_estimation_history_screen.dart';
import 'package:ausales_application/view/screens/manual_invoice/manual_invoice_screen.dart';
import 'package:ausales_application/view/screens/melting_receipt/melting_receipt_list_screen.dart';
import 'package:ausales_application/view/screens/menu_permission/menu_permission_screen.dart';
import 'package:ausales_application/view/screens/metal_entries/metal_entries_screen.dart';
import 'package:ausales_application/view/screens/metal_ledger/metal_ledger_list_screen.dart';
import 'package:ausales_application/view/screens/metal_master/metal_master_list_screen.dart';
import 'package:ausales_application/view/screens/metal_rates/metal_rates_screen.dart';
import 'package:ausales_application/view/screens/new_purchase/new_purchase_list_screen.dart';
import 'package:ausales_application/view/screens/old_metal_rate/old_metal_rate_list_screen.dart';
import 'package:ausales_application/view/screens/old_purchase/old_purchase_list_screen.dart';
import 'package:ausales_application/view/screens/order/order_list_screen.dart';
import 'package:ausales_application/view/screens/purification/purification_list_screen.dart';
import 'package:ausales_application/view/screens/purity_master/purity_master_screen.dart';
import 'package:ausales_application/view/screens/repair_creation/repair_creation_screen.dart';
import 'package:ausales_application/view/screens/repair_type/repair_type_screen.dart';
import 'package:ausales_application/view/screens/reports/all_metal_daily_sale_report_list_screen.dart';
import 'package:ausales_application/view/screens/reports/approval_issued_report_list_screens.dart';
import 'package:ausales_application/view/screens/reports/approval_pending_report_list_screens.dart';
import 'package:ausales_application/view/screens/reports/approval_received_report_screens.dart';
import 'package:ausales_application/view/screens/reports/bill_repayment_report_list_screen.dart';
import 'package:ausales_application/view/screens/reports/billing_cr_dr_report_list_screen.dart';
import 'package:ausales_application/view/screens/reports/billing_gst_report_screen.dart';
import 'package:ausales_application/view/screens/reports/cash_purchase_report_list_screen.dart';
import 'package:ausales_application/view/screens/reports/catalog_verification_list_screen.dart';
import 'package:ausales_application/view/screens/reports/customer_cr_dr_report_list_screen.dart';
import 'package:ausales_application/view/screens/reports/customer_summary_report_list_screen.dart';
import 'package:ausales_application/view/screens/reports/daily_payment_report_screen.dart';
import 'package:ausales_application/view/screens/reports/daily_report_list_screen.dart';
import 'package:ausales_application/view/screens/reports/daily_sale_report_list_screen.dart';
import 'package:ausales_application/view/screens/reports/daily_stock_designer_wise_report_screen.dart';
import 'package:ausales_application/view/screens/reports/daily_stock_item_wise_report_screen.dart';
import 'package:ausales_application/view/screens/reports/daily_stock_metal_wise_report_screen.dart';
import 'package:ausales_application/view/screens/reports/daily_stock_purity_wise_report_screen.dart';
import 'package:ausales_application/view/screens/reports/daily_stock_subitem_wise_report_screen.dart';
import 'package:ausales_application/view/screens/reports/day_book_report_list_screen.dart';
import 'package:ausales_application/view/screens/reports/direct_issue_report_list_screen.dart';
import 'package:ausales_application/view/screens/reports/estimation_item_wise_report_list_screen.dart';
import 'package:ausales_application/view/screens/reports/estimation_metal_wise_report_list_screen.dart';
import 'package:ausales_application/view/screens/reports/estimation_purity_wise_report_list_screen.dart';
import 'package:ausales_application/view/screens/reports/estimation_sub_item_wise_report_list_screen.dart';
import 'package:ausales_application/view/screens/reports/estimation_vendor_wise_report_list_screen.dart';
import 'package:ausales_application/view/screens/reports/item_closing_report_screens.dart';
import 'package:ausales_application/view/screens/reports/item_wise_repair_report_list_screens.dart';
import 'package:ausales_application/view/screens/reports/item_wise_sales_report_screen.dart';
import 'package:ausales_application/view/screens/reports/live_stock_report_screens.dart';
import 'package:ausales_application/view/screens/reports/manual_estimation_billing_report_screens.dart';
import 'package:ausales_application/view/screens/reports/metal_wise_repair_report_list_screens.dart';
import 'package:ausales_application/view/screens/reports/metal_wise_sales_report_screen.dart';
import 'package:ausales_application/view/screens/reports/order_bill_report_list_screens.dart';
import 'package:ausales_application/view/screens/reports/order_item_wise_report_list_screen.dart';
import 'package:ausales_application/view/screens/reports/order_metal_wise_report_list_screen.dart';
import 'package:ausales_application/view/screens/reports/order_pending_report_list_screen.dart';
import 'package:ausales_application/view/screens/reports/order_purity_wise_report_list_screen.dart';
import 'package:ausales_application/view/screens/reports/order_report_list_screen.dart';
import 'package:ausales_application/view/screens/reports/order_sub_item_wise_report_list_screen.dart';
import 'package:ausales_application/view/screens/reports/order_vendor_wise_report_list_screen.dart';
import 'package:ausales_application/view/screens/reports/overall_daily_report_list_screen.dart';
import 'package:ausales_application/view/screens/reports/payment_flow_report_list_screen.dart';
import 'package:ausales_application/view/screens/reports/pending_bill_payment_report_list_screen.dart';
import 'package:ausales_application/view/screens/reports/purchase_and_billing_item_wise_report_list_screen.dart';
import 'package:ausales_application/view/screens/reports/purchase_and_billing_metal_wise_report_list_screen.dart';
import 'package:ausales_application/view/screens/reports/purchase_and_billing_purity_wise_report_list_screen.dart';
import 'package:ausales_application/view/screens/reports/purchase_and_billing_sub_item_wise_report_list_screen.dart';
import 'package:ausales_application/view/screens/reports/purchase_and_billing_vendor_wise_report_list_screen.dart';
import 'package:ausales_application/view/screens/reports/purchase_item_report_screen.dart';
import 'package:ausales_application/view/screens/reports/purchase_sub_item_report_screen.dart';
import 'package:ausales_application/view/screens/reports/purchase_wise_metal_report_screens.dart';
import 'package:ausales_application/view/screens/reports/purchase_wise_vendor_report_screen.dart';
import 'package:ausales_application/view/screens/reports/purity_wise_purchase_report_list_screen.dart';
import 'package:ausales_application/view/screens/reports/purity_wise_repair_report_list_screens.dart';
import 'package:ausales_application/view/screens/reports/purity_wise_sales_report_screen.dart';
import 'package:ausales_application/view/screens/reports/repair_report_list_screens.dart';
import 'package:ausales_application/view/screens/reports/stock_outwards_report_screens.dart';
import 'package:ausales_application/view/screens/reports/subitem_wise_sales_report_screen.dart';
import 'package:ausales_application/view/screens/reports/suspense_pending_report_screen.dart';
import 'package:ausales_application/view/screens/reports/suspense_redeem_report_list_screen.dart';
import 'package:ausales_application/view/screens/reports/suspense_repayment_report_list_screen.dart';
import 'package:ausales_application/view/screens/reports/tds_deduction_report_list_screen.dart';
import 'package:ausales_application/view/screens/reports/vendor_crdr_report_list_screen.dart';
import 'package:ausales_application/view/screens/reports/vendor_inwards_report_list_screens.dart';
import 'package:ausales_application/view/screens/reports/vendor_item_wise_sales_report_screen.dart';
import 'package:ausales_application/view/screens/reports/vendor_metal_wise_sales_report_screen.dart';
import 'package:ausales_application/view/screens/reports/vendor_outwards_report_screens.dart';
import 'package:ausales_application/view/screens/reports/vendor_purity_wise_sales_report_screen.dart';
import 'package:ausales_application/view/screens/reports/vendor_subitem_wise_sales_report_screen.dart';
import 'package:ausales_application/view/screens/reports/vendor_wise_repair_report_list_screens.dart';
import 'package:ausales_application/view/screens/reports/vendor_wise_report_screen.dart';
import 'package:ausales_application/view/screens/single_tag_update/single_tag_update_screen.dart';
import 'package:ausales_application/view/screens/stock_assign/stock_assign_list_screen.dart';
import 'package:ausales_application/view/screens/stock_ledger/stock_ledger_list_screen.dart';
import 'package:ausales_application/view/screens/stock_list/stock_list_screen.dart';
import 'package:ausales_application/view/screens/stone_master/stone_master_screen.dart';
import 'package:ausales_application/view/screens/sub_expense_account/sub_expense_account_list_screen.dart';
import 'package:ausales_application/view/screens/sub_item_wise_purchase_report/sub_item_wise_purchase_report_list_screen.dart';
import 'package:ausales_application/view/screens/subitem_master/subitem_master_list_screen.dart';
import 'package:ausales_application/view/screens/suspense/suspense_list_screen.dart';
import 'package:ausales_application/view/screens/tag_master/tag_master_screen.dart';
import 'package:ausales_application/view/screens/tax_master/tax_master_list_screen.dart';
import 'package:ausales_application/view/screens/transfer_creation/transfer_creation_list_screen.dart';
import 'package:ausales_application/view/screens/user/user_list_screen.dart';
import 'package:ausales_application/view/screens/user_role/user_role_screen.dart';
import 'package:ausales_application/view/screens/value_addition_customer/value_addition_customer_list_screen.dart';
import 'package:ausales_application/view/screens/value_addition_designer/value_addition_designer_list_screen.dart';
import 'package:ausales_application/view/screens/vendor_discount/vendor_discount_screen.dart';
import 'package:ausales_application/view/screens/vendor_ledger/vendor_ledger_list_screen.dart';
import 'package:ausales_application/view/screens/vendor_payment/vendor_payment_list_screen.dart';
import 'package:get/get.dart';

navLogin() {
  Get.offAll(() => LoginScreen());
}

navHome() {
  Get.offAll(() => HomeScreen());
}

navUserList() {
  Get.offAll(() => UserListScreen());
}

navUserRoleList() {
  Get.offAll(() => UserRoleScreen());
}

navMetalList() {
  Get.offAll(() => MetalListScreen());
}

navPurityMasterList() {
  Get.offAll(() => PurityMasterScreen());
}

navTaxList() {
  Get.offAll(() => TaxMasterListScreen());
}

navTagMasterList() {
  Get.offAll(() => TagMasterScreen());
}

navStoneMasterList() {
  Get.offAll(() => StoneMasterScreen());
}

navCounterList() {
  Get.offAll(() => CounterListScreen());
}

navFloorList() {
  Get.offAll(() => FloorListScreen());
}

navCustomergroupList() {
  Get.offAll(() => CustomergroupListScreen());
}

navCustomerList() {
  Get.offAll(() => CustomerListScreen());
}

navCompanyList() {
  Get.offAll(() => CompanyScreen());
}

navDiamondMasterList() {
  Get.offAll(() => DiamondMasterScreen());
}

navMetalRateMasterList() {
  Get.offAll(() => MetalRatesScreen());
}

navMenuPermissionList() {
  Get.offAll(() => MenuPermissionScreen());
}

navItemMasterList() {
  Get.offAll(() => ItemMasterListScreen());
}

navSubItemMasterList() {
  Get.offAll(() => SubitemMasterListScreen());
}

navDesignerList() {
  Get.offAll(() => DesignerListScreen());
}

navValueAdditioDesignerList() {
  Get.offAll(() => ValueAdditionDesignerListScreen());
}

navLotList() {
  Get.offAll(() => LotListScreen());
}

navItemTagList() {
  Get.offAll(() => ItemtagListScreen());
}

navValueAdditionCustomerList() {
  Get.offAll(() => ValueAdditionCustomerListScreen());
}

navCatalogList() {
  Get.offAll(() => CatalogListScreen());
}

navOldMetalRateList() {
  Get.offAll(() => OldMetalRateListScreen());
}

navOldPurchaseList() {
  Get.offAll(() => OldPurchaseListScreen());
}

navTagDetails() {
  Get.offAll(() => TagDetailsScreen());
}

navNewPurchaseList() {
  Get.offAll(() => NewPurchaseListScreen());
}

navVendorLedgerList() {
  Get.offAll(() => VendorLedgerListScreen());
}

navStockLedgerList() {
  Get.offAll(() => StockLedgerListScreen());
}

navStockList() {
  Get.offAll(() => StockListScreen());
}

navStockAssignList() {
  Get.offAll(() => StockAssignListScreen());
}

navVendorPaymentList() {
  Get.offAll(() => VendorPaymentListScreen());
}

navBranchTransferList() {
  Get.offAll(() => BranchTransferListScreen());
}

navTransferCreationList() {
  Get.offAll(() => TransferCreationListScreen());
}

navSingleTagUpdateList() {
  Get.offAll(() => SingleTagUpdateScreen());
}

navBulkTagUpdateList() {
  Get.offAll(() => BulkTagUpdateScreen());
}

navAdvanceList() {
  Get.offAll(() => AdvanceListScreen());
}

navVendorDiscountList() {
  Get.offAll(() => VendorDiscountScreen());
}

navEstimation() {
  Get.offAll(() => EstimationScreen());
}

navTransferCreation() {
  Get.offAll(() => TransferCreationListScreen());
}

navMeltingReceipt() {
  Get.offAll(() => MeltingReceiptScreen());
}

navPurification() {
  Get.offAll(() => PurificationListScreen());
}

navExpenseAccountList() {
  Get.offAll(() => ExpenseListScreen());
}

navSubExpenseAccountList() {
  Get.offAll(() => SubExpenseAccountListScreen());
}

navCompanyLedgerList() {
  Get.offAll(() => CompanyLedgerListScreen());
}

navEstimationHistoryList() {
  Get.offAll(() => EstimationHistoryScreen());
}

navBilling() {
  Get.offAll(() => InvoiceScreen());
}

navBillingHistoryList() {
  Get.offAll(() => InvoiceHistoryScreen());
}

navSuspenseList() {
  Get.offAll(() => SuspenseListScreen());
}

navCustomerLedgerList() {
  Get.offAll(() => CustomerLedgerListScreen());
}

navOrderList() {
  Get.offAll(() => OrderListScreen());
}

navSubItemWisePurchaseReportList() {
  Get.offAll(() => SubItemWisePurchaseReportListScreen());
}

navSuspenseRedeemReport() {
  Get.offAll(() => SuspenseRedeemReportListScreen());
}

navSuspenseRepaymentReport() {
  Get.offAll(() => SuspenseRepaymentReportListScreen());
}

navTdsdedutionReport() {
  Get.offAll(() => TdsDeductionReportListScreen());
}

navDailyStockSubItemWiseReport() {
  Get.offAll(() => const DailyStockSubitemWiseReportScreen());
}

navDailyStockItemWiseReport() {
  Get.offAll(() => const DailyStockItemWiseReportScreen());
}

navDailyStockMetalWiseReport() {
  Get.offAll(() => const DailyStockMetalWiseReportScreen());
}

navDailyStockDesignerWiseReport() {
  Get.offAll(() => const DailyStockDesignerWiseReportScreen());
}

navVendorWiseReport() {
  Get.offAll(() => const VendorWiseReportScreen());
}

navVendorMetalWiseSalesReport() {
  Get.offAll(() => const VendorMetalWiseSalesReportScreen());
}

navVendorPurityWiseSalesReport() {
  Get.offAll(() => const VendorPurityWiseSalesReportScreen());
}

navVendorSubitemWiseSalesReport() {
  Get.offAll(() => const VendorSubitemWiseSalesReportScreen());
}

navVendorItemWiseSalesReport() {
  Get.offAll(() => const VendorItemWiseSalesReportScreen());
}

navMetalWiseSalesReport() {
  Get.offAll(() => const MetalWiseSalesReportScreen());
}

navPurityWiseSalesReport() {
  Get.offAll(() => const PurityWiseSalesReportScreen());
}

navItemWiseSalesReport() {
  Get.offAll(() => const ItemWiseSalesReportScreen());
}

navSubitemWiseSalesReport() {
  Get.offAll(() => const SubitemWiseSalesReportScreen());
}

navMetalEntriesList() {
  Get.offAll(() => MetalEntriesScreen());
}

navRepairType() {
  Get.offAll(() => const RepairTypeScreen());
}

navRepairCreation() {
  Get.offAll(() => const RepairCreationScreen());
}

navMetalLedgetList() {
  Get.offAll(() => MetalLedgerListScreen());
}

navPurityWisePurchaseReport() {
  Get.offAll(() => PurityWisePurchaseReportListScreen());
}

navSuspensePendingReport() {
  Get.offAll(() => SuspensePendingReportScreen());
}

navOrderWiseItemReport() {
  Get.offAll(() => OrderItemWiseReportListScreen());
}

navOrderSubItemWiseReport() {
  Get.offAll(() => OrderSubItemWiseReportListScreen());
}

navOrderMetalWiseReport() {
  Get.offAll(() => OrderMetalWiseReportListScreen());
}

navOrderVendorWiseReport() {
  Get.offAll(() => OrderVendorWiseReportListScreen());
}

navOrderPurityWiseReport() {
  Get.offAll(() => OrderPurityWiseReportListScreen());
}

navEstimationMetalWiseReport() {
  Get.offAll(() => EstimationMetalWiseReportListScreen());
}

navEstimationPurityWiseReport() {
  Get.offAll(() => EstimationPurityWiseReportListScreen());
}

navEstimationItemWiseReport() {
  Get.offAll(() => EstimationItemWiseReportListScreen());
}

navEstimationSubItemWiseReport() {
  Get.offAll(() => EstimationSubItemWiseReportListScreen());
}

navEstimationVendorWiseReport() {
  Get.offAll(() => EstimationVendorWiseReportListScreen());
}

navCatalogVerificationReport() {
  Get.offAll(() => CatalogVerificationListScreen());
}

navApprovalIssues() {
  Get.offAll(() => ApprovalIssuesListScreen());
}

navDailyPaymentReport() {
  Get.offAll(() => DailyPaymentReportScreen());
}

navOverAllReport() {
  Get.offAll(() => OverallDailyReportListScreen());
}

navdailyStockPurityReport() {
  Get.offAll(() => DailyStockPurityWiseReportScreen());
}

navCustomerSummaryReport() {
  Get.offAll(() => CustomerSummaryReportListScreen());
}

navMetalWiseRepairReport() {
  Get.offAll(() => MetalWiseRepairReportListScreens());
}

navItemWiseRepairReport() {
  Get.offAll(() => ItemWiseRepairReportListScreens());
}

navPurityWiseRepairReport() {
  Get.offAll(() => PurityWiseRepairReportListScreens());
}

navVendorWiseRepairReport() {
  Get.offAll(() => VendorWiseRepairReportListScreens());
}

navBillinggstReport() {
  Get.offAll(() => BillingGstReportScreen());
}

navPendingBillingReport() {
  Get.offAll(() => PendingBillPaymentReportListScreen());
}

navPurchaseandBillingMetalwiseReport() {
  Get.offAll(() => PurchaseAndBillingMetalWiseReportListScreen());
}

navPurchaseandBillingPuritywiseReport() {
  Get.offAll(() => PurchaseAndBillingPurityWiseReportListScreen());
}

navPurchaseandBillingItemwiseReport() {
  Get.offAll(() => PurchaseAndBillingItemWiseReportListScreen());
}

navPurchaseandBillingSubItemwiseReport() {
  Get.offAll(() => PurchaseAndBillingSubItemWiseReportListScreen());
}

navPurchaseandBillingVendorwiseReport() {
  Get.offAll(() => PurchaseAndBillingVendorWiseReportListScreen());
}

navdailyReport() {
  Get.offAll(() => DailyReportListScreen());
}

navdailysaleReport() {
  Get.offAll(() => DailySaleReportListScreen());
}

navAllMetalDailySaleReport() {
  Get.offAll(() => AllMetalDailySaleReportListScreen());
}

navPurchaseitemlistReport() {
  Get.offAll(() => PurchaseitemReportScreen());
}

navPurchasesubitemlistReport() {
  Get.offAll(() => PurchaseSubItemReportScreen());
}

navPurchasemetallistReport() {
  Get.offAll(() => PurchaseWiseMetalReportScreens());
}

navPurchasevendorlistReport() {
  Get.offAll(() => PurchaseWiseVendorReportScreen());
}

navCustomerCRDRlistReport() {
  Get.offAll(() => CustomerCrDrReportListScreen());
}

navBillingCRDRlistReport() {
  Get.offAll(() => BillingCrDrReportListScreen());
}

navVendorCrDrListReport() {
  Get.offAll(() => VendorCrdrReportListScreen());
}

navCashPurchaseListReport() {
  Get.offAll(() => CashPurchaseReportListScreen());
}

navItemClosingReport() {
  Get.offAll(() => ItemClosingReportScreens());
}

navLIveStockReport() {
  Get.offAll(() => LiveStockReportScreens());
}

navRepairReport() {
  Get.offAll(() => RepairReportListScreens());
}

navOrderReportScreen() {
  Get.offAll(() => OrderReportListScreen());
}

navOrderBillReport() {
  Get.offAll(() => OrderBillReportListScreens());
}

navApprovalPendingReport() {
  Get.offAll(() => ApprovalPendingReportListScreens());
}

navApprovalReceivedReport() {
  Get.offAll(() => ApprovalReceivedReportScreens());
}

navApprovalIssuedReport() {
  Get.offAll(() => ApprovalIssuedReportListScreens());
}

navDirectIssuedScreen() {
  Get.offAll(() => DirectIssuesListScreen());
}

navDayBookReport() {
  Get.offAll(() => DayBookReportListScreen());
}

navDirectIssueReport() {
  Get.offAll(() => DirectIssueReportListScreen());
}

navBillRepaymentReport() {
  Get.offAll(() => BillRepaymentReportListScreen());
}
 
navPaymentFlowReport() {
  Get.offAll(() => PaymentFlowReportListScreen());
}
 
 
navVendorInwardsReport() {
  Get.offAll(() => VendorInwardsReportListScreens());
}
navVendorOutwardsReport() {
  Get.offAll(() => VendorOutwardsReportScreens());
}

navSStockOutwardsReport() {
  Get.offAll(() => StockOutwardsReportScreens());
}
navorderpendingReport() {
  Get.offAll(() => OrderPendingReportListScreen());
}

navManualBilling() {
  Get.offAll(() => ManualInvoiceScreen());
}

navmannualestimation() {
  Get.offAll(() => MannualEstimationScreen());
}

navmannualestimationhistory() {
  Get.offAll(() => ManualEstimationHistoryScreen());
}

navmannualestimationbillingreport() {
  Get.offAll(() => ManualEstimationBillingReportScreens());
}

void getNavFunction(MenuList menu) {
  if (menu.menuName!.toLowerCase() == "user") {
    navUserList();
  } else if (menu.menuName!.toLowerCase() == "user role") {
    navUserRoleList();
  } else if (menu.menuName!.toLowerCase() == "purity") {
    navPurityMasterList();
  } else if (menu.menuName!.toLowerCase() == "tag") {
    navTagMasterList();
  } else if (menu.menuName!.toLowerCase() == "stone") {
    navStoneMasterList();
  } else if (menu.menuName!.toLowerCase() == "metal") {
    navMetalList();
  } else if (menu.menuName!.toLowerCase() == "tax details") {
    navTaxList();
  } else if (menu.menuName!.toLowerCase() == "counter") {
    navCounterList();
  } else if (menu.menuName!.toLowerCase() == "floor") {
    navFloorList();
  } else if (menu.menuName!.toLowerCase() == "customer-group") {
    navCustomergroupList();
  } else if (menu.menuName!.toLowerCase() == "customer") {
    navCustomerList();
  } else if (menu.menuName!.toLowerCase() == "company") {
    navCompanyList();
  } else if (menu.menuName!.toLowerCase() == "diamond") {
    navDiamondMasterList();
  } else if (menu.menuName!.toLowerCase() == "metal rate") {
    navMetalRateMasterList();
  } else if (menu.menuName!.toLowerCase() == "menu permission") {
    navMenuPermissionList();
  } else if (menu.menuName!.toLowerCase() == "item master") {
    navItemMasterList();
  } else if (menu.menuName!.toLowerCase() == "sub item master") {
    navSubItemMasterList();
  } else if (menu.menuName!.toLowerCase() == "vendor") {
    navDesignerList();
  } else if (menu.menuName!.toLowerCase() == "value addition designer") {
    navValueAdditioDesignerList();
  } else if (menu.menuName!.toLowerCase() == "lot") {
    navLotList();
  } else if (menu.menuName!.toLowerCase() == "item tag") {
    navItemTagList();
  } else if (menu.menuName!.toLowerCase() == "value addition customer") {
    navValueAdditionCustomerList();
  } else if (menu.menuName!.toLowerCase() == "catalogue") {
    navCatalogList();
  } else if (menu.menuName!.toLowerCase() == "old metal rate") {
    navOldMetalRateList();
  } else if (menu.menuName!.toLowerCase() == "old purchase") {
    navOldPurchaseList();
  } else if (menu.menuName!.toLowerCase() == "tag details") {
    navTagDetails();
  } else if (menu.menuName!.toLowerCase() == "new purchase") {
    navNewPurchaseList();
  } else if (menu.menuName!.toLowerCase() == "vendor ledger") {
    navVendorLedgerList();
  } else if (menu.menuName!.toLowerCase() == "stock ledger") {
    navStockLedgerList();
  } else if (menu.menuName!.toLowerCase() == "stock list") {
    navStockList();
  } else if (menu.menuName!.toLowerCase() == "stock assign") {
    navStockAssignList();
  } else if (menu.menuName!.toLowerCase() == "vendor payment") {
    navVendorPaymentList();
  } else if (menu.menuName!.toLowerCase() == "vendor discount") {
    navVendorDiscountList();
  } else if (menu.menuName!.toLowerCase() == "branch  transfer") {
    navBranchTransferList();
  } else if (menu.menuName!.toLowerCase() == "transfer creation") {
    navTransferCreationList();
  } else if (menu.menuName!.toLowerCase() == "single tag update") {
    navSingleTagUpdateList();
  } else if (menu.menuName!.toLowerCase() == "bulk tag update") {
    navBulkTagUpdateList();
  } else if (menu.menuName!.toLowerCase() == "advance") {
    navAdvanceList();
  } else if (menu.menuName!.toLowerCase() == "estimation") {
    navEstimation();
  } else if (menu.menuName!.toLowerCase() == "melting receipt") {
    navMeltingReceipt();
  } else if (menu.menuName!.toLowerCase() == "purification") {
    navPurification();
  } else if (menu.menuName!.toLowerCase() == "expense account") {
    navExpenseAccountList();
  } else if (menu.menuName!.toLowerCase() == "sub expense account") {
    navSubExpenseAccountList();
  } else if (menu.menuName!.toLowerCase() == "transfer creation") {
    navTransferCreationList();
  } else if (menu.menuName!.toLowerCase() == "company ledger") {
    navCompanyLedgerList();
  } else if (menu.menuName!.toLowerCase() == "estimation history") {
    navEstimationHistoryList();
  } else if (menu.menuName!.toLowerCase() == "billing") {
    navBilling();
  } else if (menu.menuName!.toLowerCase() == "billing history") {
    navBillingHistoryList();
  } else if (menu.menuName!.toLowerCase() == "suspense") {
    navSuspenseList();
  } else if (menu.menuName!.toLowerCase() == "customer ledger") {
    navCustomerLedgerList();
  } else if (menu.menuName!.toLowerCase() == "order") {
    navOrderList();
  } else if (menu.menuName!.toLowerCase() == "sub item wise purchase report") {
    navSubItemWisePurchaseReportList();
  } else if (menu.menuName!.toLowerCase() == "suspense redeem report") {
    navSuspenseRedeemReport();
  } else if (menu.menuName!.toLowerCase() == "suspense repayment report") {
    navSuspenseRepaymentReport();
  } else if (menu.menuName!.toLowerCase() == "tds deduction report") {
    navTdsdedutionReport();
  } else if (menu.menuName!.toLowerCase() ==
      "daily stock subitem wise report") {
    navDailyStockSubItemWiseReport();
  } else if (menu.menuName!.toLowerCase() == "daily stock item wise report") {
    navDailyStockItemWiseReport();
  } else if (menu.menuName!.toLowerCase() == "daily stock metal wise report") {
    navDailyStockMetalWiseReport();
  } else if (menu.menuName!.toLowerCase() ==
      "daily stock designer wise report") {
    navDailyStockDesignerWiseReport();
  } else if (menu.menuName!.toLowerCase() == "vendor wise") {
    navVendorWiseReport();
  } else if (menu.menuName!.toLowerCase() == "vendor metal wise sales report") {
    navVendorMetalWiseSalesReport();
  } else if (menu.menuName!.toLowerCase() ==
      "vendor purity wise sales report") {
    navVendorPurityWiseSalesReport();
  } else if (menu.menuName!.toLowerCase() ==
      "vendor sub item wise sales report") {
    navVendorSubitemWiseSalesReport();
  } else if (menu.menuName!.toLowerCase() == "vendor item wise sale report") {
    navVendorItemWiseSalesReport();
  } else if (menu.menuName!.toLowerCase() == "metal wise sale report") {
    navMetalWiseSalesReport();
  } else if (menu.menuName!.toLowerCase() == "purity wise sale report") {
    navPurityWiseSalesReport();
  } else if (menu.menuName!.toLowerCase() == "item wise sales report") {
    navItemWiseSalesReport();
  } else if (menu.menuName!.toLowerCase() == "sub item wise sales report") {
    navSubitemWiseSalesReport();
  } else if (menu.menuName!.toLowerCase() == "metal entries") {
    navMetalEntriesList();
  } else if (menu.menuName!.toLowerCase() == "repair type") {
    navRepairType();
  } else if (menu.menuName!.toLowerCase() == "repair creation") {
    navRepairCreation();
  } else if (menu.menuName!.toLowerCase() == "metal ledger") {
    navMetalLedgetList();
  } else if (menu.menuName!.toLowerCase() == "purity wise purchase report") {
    navPurityWisePurchaseReport();
  } else if (menu.menuName!.toLowerCase() == "suspense pending report") {
    navSuspensePendingReport();
  } else if (menu.menuName!.toLowerCase() == "order item wise report") {
    navOrderWiseItemReport();
  } else if (menu.menuName!.toLowerCase() == "order sub item wise report") {
    navOrderSubItemWiseReport();
  } else if (menu.menuName!.toLowerCase() == "order metal wise report") {
    navOrderMetalWiseReport();
  } else if (menu.menuName!.toLowerCase() == "order purity wise report") {
    navOrderPurityWiseReport();
  } else if (menu.menuName!.toLowerCase() == "order vendor wise report") {
    navOrderVendorWiseReport();
  } else if (menu.menuName!.toLowerCase() == "catalog verification report") {
    navCatalogVerificationReport();
  } else if (menu.menuName!.toLowerCase() == "estimation metal wise report") {
    navEstimationMetalWiseReport();
  } else if (menu.menuName!.toLowerCase() == "estimation purity wise report") {
    navEstimationPurityWiseReport();
  } else if (menu.menuName!.toLowerCase() == "estimation item wise report") {
    navEstimationItemWiseReport();
  } else if (menu.menuName!.toLowerCase() ==
      "estimation sub item wise report") {
    navEstimationSubItemWiseReport();
  } else if (menu.menuName!.toLowerCase() == "estimation vendor wise report") {
    navEstimationVendorWiseReport();
  } else if (menu.menuName!.toLowerCase() == "approval issues") {
    navApprovalIssues();
  } else if (menu.menuName!.toLowerCase() == "daily payment report") {
    navDailyPaymentReport();
  } else if (menu.menuName!.toLowerCase() == "overall daily report") {
    navOverAllReport();
  } else if (menu.menuName!.toLowerCase() == "daily stock purity wise report") {
    navdailyStockPurityReport();
  } else if (menu.menuName!.toLowerCase() == "customer summary report") {
    navCustomerSummaryReport();
  } else if (menu.menuName!.toLowerCase() == "metal wise repair report") {
    navMetalWiseRepairReport();
  } else if (menu.menuName!.toLowerCase() == "item wise repair report") {
    navItemWiseRepairReport();
  } else if (menu.menuName!.toLowerCase() == "purity wise repair report") {
    navPurityWiseRepairReport();
  } else if (menu.menuName!.toLowerCase() == "vendor wise repair report") {
    navVendorWiseRepairReport();
  } else if (menu.menuName!.toLowerCase() == "billing gst report") {
    navBillinggstReport();
  } else if (menu.menuName!.toLowerCase() == "pending bill payment") {
    navPendingBillingReport();
  } else if (menu.menuName!.toLowerCase() ==
      "metal wise purchase sales report") {
    navPurchaseandBillingMetalwiseReport();
  } else if (menu.menuName!.toLowerCase() ==
      "purity wise purchase sales report") {
    navPurchaseandBillingPuritywiseReport();
  } else if (menu.menuName!.toLowerCase() ==
      "item wise purchase sales report") {
    navPurchaseandBillingItemwiseReport();
  } else if (menu.menuName!.toLowerCase() ==
      "subitem wise purchase sales report") {
    navPurchaseandBillingSubItemwiseReport();
  } else if (menu.menuName!.toLowerCase() ==
      "vendor wise purchase sales report") {
    navPurchaseandBillingVendorwiseReport();
  } else if (menu.menuName!.toLowerCase() == "daily reports") {
    navdailyReport();
  } else if (menu.menuName!.toLowerCase() == "dailysale report") {
    navdailysaleReport();
  } else if (menu.menuName!.toLowerCase() == "all metal daily sale report") {
    navAllMetalDailySaleReport();
  } else if (menu.menuName!.toLowerCase() == "item wise purchase report") {
    navPurchaseitemlistReport();
  } else if (menu.menuName!.toLowerCase() == "subitem wise purchase report") {
    navPurchasesubitemlistReport();
  } else if (menu.menuName!.toLowerCase() == "metal wise purchase report") {
    navPurchasemetallistReport();
  } else if (menu.menuName!.toLowerCase() == "vendor wise purchase report") {
    navPurchasevendorlistReport();
  } else if (menu.menuName!.toLowerCase() == "customer cr dr report") {
    navCustomerCRDRlistReport();
  } else if (menu.menuName!.toLowerCase() == "billing cr dr report") {
    navBillingCRDRlistReport();
  } else if (menu.menuName!.toLowerCase() == "vendor cr dr report") {
    navVendorCrDrListReport();
  } else if (menu.menuName!.toLowerCase() == "cash purchase report") {
    navCashPurchaseListReport();
  } else if (menu.menuName!.toLowerCase() == "item close report") {
    navItemClosingReport();
  } else if (menu.menuName!.toLowerCase() == "live stock report") {
    navLIveStockReport();
  } else if (menu.menuName!.toLowerCase() == "repair report") {
    navRepairReport();
  } else if (menu.menuName!.toLowerCase() == "order report") {
    navOrderReportScreen();
  } else if (menu.menuName!.toLowerCase() == "order delivered report") {
    navOrderBillReport();
  } else if (menu.menuName!.toLowerCase() == "approval pending report") {
    navApprovalPendingReport();
  } else if (menu.menuName!.toLowerCase() == "approval received report") {
    navApprovalReceivedReport();
  } else if (menu.menuName!.toLowerCase() == "approval issued report") {
    navApprovalIssuedReport();
  } else if (menu.menuName!.toLowerCase() == "direct issue") {
    navDirectIssuedScreen();
  } else if (menu.menuName!.toLowerCase() == "day book report") {
    navDayBookReport();
  } else if (menu.menuName!.toLowerCase() == "direct issue report") {
    navDirectIssueReport();
  } else if (menu.menuName!.toLowerCase() == "bill repayment report") {
    navBillRepaymentReport();
  } else if (menu.menuName!.toLowerCase() == "payment flow report") {
    navPaymentFlowReport();
  } else if (menu.menuName!.toLowerCase() == "vendor inward report") {
    navVendorInwardsReport();
  }  else if (menu.menuName!.toLowerCase() == "vendor outward report") {
    navVendorOutwardsReport();
  } else if (menu.menuName!.toLowerCase() == "stock outward report") {
    navSStockOutwardsReport();
  } else if (menu.menuName!.toLowerCase() == "order pending report") {
    navorderpendingReport();
  } else if (menu.menuName!.toLowerCase() == "manual billing") {
    navManualBilling();
  } else if (menu.menuName!.toLowerCase() == "manual estimation") {
    navmannualestimation();
  } else if (menu.menuName!.toLowerCase() == "manual estimation history") {
    navmannualestimationhistory();
  } else if (menu.menuName!.toLowerCase() == "manual estimation report") {
    navmannualestimationbillingreport();
  }
}
