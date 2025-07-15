import 'package:auto_route/auto_route.dart';
import 'package:bootstrap_icons/bootstrap_icons.dart';
import 'package:dinamik10_pos/product/common/widget/custom_appbar.dart';
import 'package:dinamik10_pos/product/init/language/locale_keys.g.dart';
import 'package:dinamik10_pos/product/router/app_router.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:gen/gen.dart';
import 'package:kartal/kartal.dart';
import 'package:widgets/widgets.dart';

@RoutePage()
class CurrentDetailView extends StatelessWidget {
  const CurrentDetailView({super.key, required this.current});
  final CurrentAccountModel current;
  @override
  Widget build(BuildContext context) {
    return AutoTabsRouter.tabBar(
      routes: [
        CurrentGeneralTabRoute(current: current),
        CurrentContactTabRoute(current: current),
        CurrentBalanceTabRoute(current: current),
      ],
      builder: (context, child, tabController) {
        return Scaffold(
          appBar: CustomAppBar(
            title: Text(LocaleKeys.current_current_detail).tr(),
            leading: AutoLeadingButton(color: context.general.colorScheme.primary),
            bottom: TabBar(
              controller: tabController,
              tabs: [
                Tab(text: LocaleKeys.current_general.tr(), icon: Icon(BootstrapIcons.info_circle_fill)),
                Tab(text: LocaleKeys.current_contact.tr(), icon: Icon(BootstrapIcons.person_lines_fill)),
                CustomBadgesWidget(
                  isShow: true,
                  child: Tab(text: LocaleKeys.current_balance.tr(), icon: Icon(BootstrapIcons.safe2_fill)),
                ),
              ],
            ),
          ),
          body: child,
        );
      },
    );
  }
}
