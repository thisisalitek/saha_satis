import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:gen/gen.dart';

import '../../feature/current/detail/current_detail_view.dart';
import '../../feature/current/detail/tab/current_balance_tab.dart';
import '../../feature/current/detail/tab/current_contact_tab.dart';
import '../../feature/current/detail/tab/current_general_tab.dart';
import '../../feature/current/view/current_view.dart';
import '../../feature/demo/home/view/home_view.dart';
import '../../feature/login/view/login_view.dart';
import '../../feature/layout/view/layout_view.dart';
import '../../feature/setting/view/setting_view.dart';
import '../../feature/splash/view/splash_view.dart';
import '../../feature/stocks/detail/stock_detail_view.dart';
import '../../feature/stocks/detail/tab/stock_price_tab.dart';
import '../../feature/stocks/detail/tab/stokc_depot_tab.dart';
import '../../feature/stocks/detail/tab/stock_general_tab.dart';
import '../../feature/stocks/view/stocks_view.dart';
import '../../feature/synchronization/view/synchronization_view.dart';

part 'app_router.gr.dart';

@AutoRouterConfig(replaceInRouteName: 'View,Route')
class AppRouter extends RootStackRouter {
  @override
  List<AutoRoute> get routes => [
    CustomRoute(page: SplashRoute.page, initial: true, transitionsBuilder: TransitionsBuilders.fadeIn),
    CustomRoute(page: LoginRoute.page, transitionsBuilder: TransitionsBuilders.fadeIn),
    CustomRoute(page: HomeRoute.page, transitionsBuilder: TransitionsBuilders.fadeIn),
    CustomRoute(page: LayoutRoute.page, transitionsBuilder: TransitionsBuilders.noTransition),
    CustomRoute(page: SettingRoute.page, transitionsBuilder: TransitionsBuilders.fadeIn),
    CustomRoute(
      page: SynchronizationRoute.page,
      transitionsBuilder: TransitionsBuilders.fadeIn,
      fullscreenDialog: true,
      opaque: false,
    ),
    CustomRoute(page: StocksRoute.page, transitionsBuilder: TransitionsBuilders.fadeIn),
    CustomRoute(
      page: StockDetailRoute.page,
      transitionsBuilder: TransitionsBuilders.fadeIn,
      children: [
        CustomRoute(page: StockGeneralTabRoute.page, transitionsBuilder: TransitionsBuilders.fadeIn),
        CustomRoute(page: StockPriceTabRoute.page, transitionsBuilder: TransitionsBuilders.fadeIn),
        CustomRoute(page: StockDepotTabRoute.page, transitionsBuilder: TransitionsBuilders.fadeIn),
      ],
    ),
    CustomRoute(page: CurrentRoute.page, transitionsBuilder: TransitionsBuilders.fadeIn),
    CustomRoute(
      page: CurrentDetailRoute.page,
      transitionsBuilder: TransitionsBuilders.fadeIn,
      children: [
        CustomRoute(page: CurrentGeneralTabRoute.page, transitionsBuilder: TransitionsBuilders.fadeIn),
        CustomRoute(page: CurrentBalanceTabRoute.page, transitionsBuilder: TransitionsBuilders.fadeIn),
        CustomRoute(page: CurrentContactTabRoute.page, transitionsBuilder: TransitionsBuilders.fadeIn),
      ],
    ),
  ];
}
