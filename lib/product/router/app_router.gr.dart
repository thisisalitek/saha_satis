// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

part of 'app_router.dart';

/// generated route for
/// [CurrentBalanceTabView]
class CurrentBalanceTabRoute extends PageRouteInfo<CurrentBalanceTabRouteArgs> {
  CurrentBalanceTabRoute({
    Key? key,
    required CurrentAccountModel current,
    List<PageRouteInfo>? children,
  }) : super(
         CurrentBalanceTabRoute.name,
         args: CurrentBalanceTabRouteArgs(key: key, current: current),
         initialChildren: children,
       );

  static const String name = 'CurrentBalanceTabRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<CurrentBalanceTabRouteArgs>();
      return CurrentBalanceTabView(key: args.key, current: args.current);
    },
  );
}

class CurrentBalanceTabRouteArgs {
  const CurrentBalanceTabRouteArgs({this.key, required this.current});

  final Key? key;

  final CurrentAccountModel current;

  @override
  String toString() {
    return 'CurrentBalanceTabRouteArgs{key: $key, current: $current}';
  }
}

/// generated route for
/// [CurrentContactTabView]
class CurrentContactTabRoute extends PageRouteInfo<CurrentContactTabRouteArgs> {
  CurrentContactTabRoute({
    Key? key,
    required CurrentAccountModel current,
    List<PageRouteInfo>? children,
  }) : super(
         CurrentContactTabRoute.name,
         args: CurrentContactTabRouteArgs(key: key, current: current),
         initialChildren: children,
       );

  static const String name = 'CurrentContactTabRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<CurrentContactTabRouteArgs>();
      return CurrentContactTabView(key: args.key, current: args.current);
    },
  );
}

class CurrentContactTabRouteArgs {
  const CurrentContactTabRouteArgs({this.key, required this.current});

  final Key? key;

  final CurrentAccountModel current;

  @override
  String toString() {
    return 'CurrentContactTabRouteArgs{key: $key, current: $current}';
  }
}

/// generated route for
/// [CurrentDetailView]
class CurrentDetailRoute extends PageRouteInfo<CurrentDetailRouteArgs> {
  CurrentDetailRoute({
    Key? key,
    required CurrentAccountModel current,
    List<PageRouteInfo>? children,
  }) : super(
         CurrentDetailRoute.name,
         args: CurrentDetailRouteArgs(key: key, current: current),
         initialChildren: children,
       );

  static const String name = 'CurrentDetailRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<CurrentDetailRouteArgs>();
      return CurrentDetailView(key: args.key, current: args.current);
    },
  );
}

class CurrentDetailRouteArgs {
  const CurrentDetailRouteArgs({this.key, required this.current});

  final Key? key;

  final CurrentAccountModel current;

  @override
  String toString() {
    return 'CurrentDetailRouteArgs{key: $key, current: $current}';
  }
}

/// generated route for
/// [CurrentGeneralTabView]
class CurrentGeneralTabRoute extends PageRouteInfo<CurrentGeneralTabRouteArgs> {
  CurrentGeneralTabRoute({
    Key? key,
    required CurrentAccountModel current,
    List<PageRouteInfo>? children,
  }) : super(
         CurrentGeneralTabRoute.name,
         args: CurrentGeneralTabRouteArgs(key: key, current: current),
         initialChildren: children,
       );

  static const String name = 'CurrentGeneralTabRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<CurrentGeneralTabRouteArgs>();
      return CurrentGeneralTabView(key: args.key, current: args.current);
    },
  );
}

class CurrentGeneralTabRouteArgs {
  const CurrentGeneralTabRouteArgs({this.key, required this.current});

  final Key? key;

  final CurrentAccountModel current;

  @override
  String toString() {
    return 'CurrentGeneralTabRouteArgs{key: $key, current: $current}';
  }
}

/// generated route for
/// [CurrentView]
class CurrentRoute extends PageRouteInfo<void> {
  const CurrentRoute({List<PageRouteInfo>? children})
    : super(CurrentRoute.name, initialChildren: children);

  static const String name = 'CurrentRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const CurrentView();
    },
  );
}

/// generated route for
/// [HomeView]
class HomeRoute extends PageRouteInfo<void> {
  const HomeRoute({List<PageRouteInfo>? children})
    : super(HomeRoute.name, initialChildren: children);

  static const String name = 'HomeRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const HomeView();
    },
  );
}

/// generated route for
/// [LayoutView]
class LayoutRoute extends PageRouteInfo<void> {
  const LayoutRoute({List<PageRouteInfo>? children})
    : super(LayoutRoute.name, initialChildren: children);

  static const String name = 'LayoutRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const LayoutView();
    },
  );
}

/// generated route for
/// [LoginView]
class LoginRoute extends PageRouteInfo<void> {
  const LoginRoute({List<PageRouteInfo>? children})
    : super(LoginRoute.name, initialChildren: children);

  static const String name = 'LoginRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const LoginView();
    },
  );
}

/// generated route for
/// [SettingView]
class SettingRoute extends PageRouteInfo<void> {
  const SettingRoute({List<PageRouteInfo>? children})
    : super(SettingRoute.name, initialChildren: children);

  static const String name = 'SettingRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const SettingView();
    },
  );
}

/// generated route for
/// [SplashView]
class SplashRoute extends PageRouteInfo<void> {
  const SplashRoute({List<PageRouteInfo>? children})
    : super(SplashRoute.name, initialChildren: children);

  static const String name = 'SplashRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const SplashView();
    },
  );
}

/// generated route for
/// [StockDepotTabView]
class StockDepotTabRoute extends PageRouteInfo<StockDepotTabRouteArgs> {
  StockDepotTabRoute({
    Key? key,
    required StockCardModel stok,
    List<PageRouteInfo>? children,
  }) : super(
         StockDepotTabRoute.name,
         args: StockDepotTabRouteArgs(key: key, stok: stok),
         initialChildren: children,
       );

  static const String name = 'StockDepotTabRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<StockDepotTabRouteArgs>();
      return StockDepotTabView(key: args.key, stok: args.stok);
    },
  );
}

class StockDepotTabRouteArgs {
  const StockDepotTabRouteArgs({this.key, required this.stok});

  final Key? key;

  final StockCardModel stok;

  @override
  String toString() {
    return 'StockDepotTabRouteArgs{key: $key, stok: $stok}';
  }
}

/// generated route for
/// [StockDetailView]
class StockDetailRoute extends PageRouteInfo<StockDetailRouteArgs> {
  StockDetailRoute({
    Key? key,
    required StockCardModel stok,
    List<PageRouteInfo>? children,
  }) : super(
         StockDetailRoute.name,
         args: StockDetailRouteArgs(key: key, stok: stok),
         initialChildren: children,
       );

  static const String name = 'StockDetailRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<StockDetailRouteArgs>();
      return StockDetailView(key: args.key, stok: args.stok);
    },
  );
}

class StockDetailRouteArgs {
  const StockDetailRouteArgs({this.key, required this.stok});

  final Key? key;

  final StockCardModel stok;

  @override
  String toString() {
    return 'StockDetailRouteArgs{key: $key, stok: $stok}';
  }
}

/// generated route for
/// [StockGeneralTabView]
class StockGeneralTabRoute extends PageRouteInfo<StockGeneralTabRouteArgs> {
  StockGeneralTabRoute({
    Key? key,
    required StockCardModel stok,
    List<PageRouteInfo>? children,
  }) : super(
         StockGeneralTabRoute.name,
         args: StockGeneralTabRouteArgs(key: key, stok: stok),
         initialChildren: children,
       );

  static const String name = 'StockGeneralTabRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<StockGeneralTabRouteArgs>();
      return StockGeneralTabView(key: args.key, stok: args.stok);
    },
  );
}

class StockGeneralTabRouteArgs {
  const StockGeneralTabRouteArgs({this.key, required this.stok});

  final Key? key;

  final StockCardModel stok;

  @override
  String toString() {
    return 'StockGeneralTabRouteArgs{key: $key, stok: $stok}';
  }
}

/// generated route for
/// [StockPriceTabView]
class StockPriceTabRoute extends PageRouteInfo<StockPriceTabRouteArgs> {
  StockPriceTabRoute({
    Key? key,
    required StockCardModel stok,
    List<PageRouteInfo>? children,
  }) : super(
         StockPriceTabRoute.name,
         args: StockPriceTabRouteArgs(key: key, stok: stok),
         initialChildren: children,
       );

  static const String name = 'StockPriceTabRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<StockPriceTabRouteArgs>();
      return StockPriceTabView(key: args.key, stok: args.stok);
    },
  );
}

class StockPriceTabRouteArgs {
  const StockPriceTabRouteArgs({this.key, required this.stok});

  final Key? key;

  final StockCardModel stok;

  @override
  String toString() {
    return 'StockPriceTabRouteArgs{key: $key, stok: $stok}';
  }
}

/// generated route for
/// [StocksView]
class StocksRoute extends PageRouteInfo<void> {
  const StocksRoute({List<PageRouteInfo>? children})
    : super(StocksRoute.name, initialChildren: children);

  static const String name = 'StocksRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const StocksView();
    },
  );
}

/// generated route for
/// [SynchronizationView]
class SynchronizationRoute extends PageRouteInfo<SynchronizationRouteArgs> {
  SynchronizationRoute({
    Key? key,
    bool showAsDialog = false,
    PageRouteInfo<Object?>? redirectToRoute,
    required bool clearExisting,
    List<PageRouteInfo>? children,
  }) : super(
         SynchronizationRoute.name,
         args: SynchronizationRouteArgs(
           key: key,
           showAsDialog: showAsDialog,
           redirectToRoute: redirectToRoute,
           clearExisting: clearExisting,
         ),
         initialChildren: children,
       );

  static const String name = 'SynchronizationRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<SynchronizationRouteArgs>();
      return SynchronizationView(
        key: args.key,
        showAsDialog: args.showAsDialog,
        redirectToRoute: args.redirectToRoute,
        clearExisting: args.clearExisting,
      );
    },
  );
}

class SynchronizationRouteArgs {
  const SynchronizationRouteArgs({
    this.key,
    this.showAsDialog = false,
    this.redirectToRoute,
    required this.clearExisting,
  });

  final Key? key;

  final bool showAsDialog;

  final PageRouteInfo<Object?>? redirectToRoute;

  final bool clearExisting;

  @override
  String toString() {
    return 'SynchronizationRouteArgs{key: $key, showAsDialog: $showAsDialog, redirectToRoute: $redirectToRoute, clearExisting: $clearExisting}';
  }
}
