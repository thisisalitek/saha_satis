part of '../stocks_view.dart';

class _StockCardList extends StatelessWidget {
  const _StockCardList();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<StockViewModel, StockState>(
      builder: (context, state) {
        if (state.isLoading) {
          return LoadingListWidget();
        }
        if (state.stocks.isEmpty) {
          return CustomEmptyWidget();
        }
        return AnimationLimiter(
          child: ListView.builder(
            itemCount: state.stocks.length,
            itemBuilder: (BuildContext context, int index) {
              final StockCardModel stock = state.stocks[index];
              return _animationWidget(index, context, stock);
            },
          ),
        );
      },
    );
  }

  AnimationConfiguration _animationWidget(int index, BuildContext context, StockCardModel stock) {
    return AnimationConfiguration.staggeredList(
      position: index,
      duration: const Duration(milliseconds: 375),
      child: SlideAnimation(
        verticalOffset: 250.0,
        child: FadeInAnimation(
          child: InkWell(
            onTap: () {
              context.router.push(StockDetailRoute(stok: stock));
            },
            child: Card(
              elevation: 5,
              shape: RoundedRectangleBorder(borderRadius: ProjectBorderRadius.medium()),
              child: ListTile(
                isThreeLine: false,
                dense: false,
                title: Text(
                  stock.stockName ?? '',
                  style: context.general.textTheme.bodyMedium!.copyWith(fontWeight: FontWeight.bold),
                ),
                subtitle: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    RowTextWidget(title: LocaleKeys.stock_code.tr(), description: stock.stockCode ?? ''),
                    RowTextWidget(
                      title: LocaleKeys.stock_unit_name.tr(),
                      description:
                          '(${stock.unitName} = ADET: ${(stock.unitMultiplier ?? 0) < 0 ? (-(stock.unitMultiplier ?? 0)) : stock.unitMultiplier})',
                    ),
                  ],
                ),
                trailing: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    RowTextWidget(title: 'V.D Fiyat:', description: (stock.priceIncludingTax ?? 0).toStringAsFixed(2)),
                    RowTextWidget(title: 'V.H Fiyat:', description: (stock.priceExcludingTax ?? 0).toStringAsFixed(2)),
                    // RowTextWidget(title: 'Fiyat Liste No:', description: '1'),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
