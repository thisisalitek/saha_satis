import 'package:auto_route/auto_route.dart';
import 'package:bootstrap_icons/bootstrap_icons.dart';
import 'package:dinamik10_pos/product/common/widget/one_info_card_widget.dart';
import 'package:dinamik10_pos/product/init/language/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gen/gen.dart';
import 'package:kartal/kartal.dart';
import 'package:widgets/widgets.dart';

@RoutePage()
class StockGeneralTabView extends StatelessWidget {
  const StockGeneralTabView({super.key, required this.stok});
  final StockCardModel stok;
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: ProjectPadding.allMedium(),
      child: Container(
        padding: ProjectPadding.allSmall(),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          color: context.general.colorScheme.primary.withValues(alpha: 0.1),
        ),
        child: Column(
          children: [
            Text(LocaleKeys.stock_stock_general_info, style: context.general.textTheme.titleLarge).tr(),
            SizedBox(height: 10),
            OneInfoCardWidget(
              label: LocaleKeys.stock_barcode.tr(),
              value: stok.barcode ?? '',
              icon: BootstrapIcons.upc_scan,
              trailingIcon: IconButton(
                onPressed: () {
                  Clipboard.setData(ClipboardData(text: stok.barcode.toString()));
                  ScaffoldMessenger.of(
                    context,
                  ).showSnackBar(SnackBar(content: Text(LocaleKeys.general_dialog_copy).tr()));
                },
                icon: Icon(Icons.copy_rounded),
              ),
            ),
            OneInfoCardWidget(
              label: LocaleKeys.stock_code.tr(),
              value: stok.stockCode ?? '',
              icon: BootstrapIcons.hash,
              trailingIcon: IconButton(
                onPressed: () {
                  Clipboard.setData(ClipboardData(text: stok.stockCode.toString()));
                  ScaffoldMessenger.of(
                    context,
                  ).showSnackBar(SnackBar(content: Text(LocaleKeys.general_dialog_copy).tr()));
                },
                icon: Icon(Icons.copy_rounded),
              ),
            ),
            OneInfoCardWidget(
              label: LocaleKeys.stock_name.tr(),
              value: stok.stockName ?? '',
              icon: BootstrapIcons.type,
            ),
            OneInfoCardWidget(
              label: LocaleKeys.stock_unit_name.tr(),
              value: stok.unitName ?? '',
              icon: BootstrapIcons.box_seam_fill,
            ),
            OneInfoCardWidget(
              label: LocaleKeys.stock_vendor_name.tr(),
              value: stok.vendorCode ?? '',
              icon: BootstrapIcons.shop,
            ),
            OneInfoCardWidget(
              label: LocaleKeys.stock_category_code.tr(),
              value: stok.categoryCode ?? '',
              icon: BootstrapIcons.layers_fill,
            ),
            OneInfoCardWidget(
              label: LocaleKeys.stock_brand_code.tr(),
              value: stok.brandCode ?? '',
              icon: BootstrapIcons.tags_fill,
            ),
            OneInfoCardWidget(
              label: LocaleKeys.stock_origin.tr(),
              value: stok.origin ?? '',
              icon: BootstrapIcons.flag_fill,
            ),
            OneInfoCardWidget(
              label: LocaleKeys.stock_sales_blocked.tr(),
              value: stok.salesBlocked == 1 ? LocaleKeys.stock_blocked.tr() : LocaleKeys.stock_not_blocked.tr(),
              icon: BootstrapIcons.building_lock,
              valueColor: stok.salesBlocked == 1 ? Colors.red : Colors.green,
            ),
            OneInfoCardWidget(
              label: LocaleKeys.stock_order_blocked.tr(),
              value: stok.orderBlocked == 1 ? LocaleKeys.stock_blocked.tr() : LocaleKeys.stock_not_blocked.tr(),
              icon: BootstrapIcons.building_lock,
              valueColor: stok.salesBlocked == 1 ? Colors.red : Colors.green,
            ),
            OneInfoCardWidget(
              label: LocaleKeys.stock_updated_at.tr(),
              value: stok.stockUpdatedAt ?? '',
              icon: BootstrapIcons.clock_fill,
            ),
          ],
        ),
      ),
    );
  }
}
