import 'package:auto_route/auto_route.dart';
import 'package:bootstrap_icons/bootstrap_icons.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:gen/gen.dart';
import 'package:kartal/kartal.dart';
import 'package:widgets/widgets.dart';

import '../../../../product/common/widget/one_info_card_widget.dart';
import '../../../../product/init/language/locale_keys.g.dart';

@RoutePage()
class StockPriceTabView extends StatelessWidget {
  const StockPriceTabView({super.key, required this.stok});
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
            Text(LocaleKeys.stock_price_list.tr(), style: context.general.textTheme.titleLarge),
            SizedBox(height: 10),
            OneInfoCardWidget(
              label: LocaleKeys.stock_price_including_tax.tr(args: [stok.unitName.toString()]),
              value: (stok.priceIncludingTax ?? 0.0).toString(),
              icon: BootstrapIcons.cash_stack,
            ),
            OneInfoCardWidget(
              label: LocaleKeys.stock_price_excluding_tax.tr(args: [stok.unitName.toString()]),
              value: (stok.priceExcludingTax ?? 0.0).toString(),
              icon: BootstrapIcons.cash,
            ),
            OneInfoCardWidget(
              label: LocaleKeys.stock_vat.tr(),
              value: '%${(stok.retailTaxPercentage ?? 0.0)}'.toString(),
              icon: BootstrapIcons.tag_fill,
            ),
            OneInfoCardWidget(
              label: LocaleKeys.stock_list_sequence_no.tr(),
              value: (stok.currentListSequenceNo ?? 0.0).toString(),
              icon: BootstrapIcons.safe_fill,
              valueColor: Colors.indigo,
            ),
            OneInfoCardWidget(
              label: LocaleKeys.stock_price_warehouse_no.tr(),
              value: (stok.currentPriceWarehouseNo ?? 0.0).toString(),
              icon: BootstrapIcons.safe2_fill,
              valueColor: Colors.indigo,
            ),
          ],
        ),
      ),
    );
  }
}
