import 'package:auto_route/auto_route.dart';
import 'package:bootstrap_icons/bootstrap_icons.dart';
import 'package:dinamik10_pos/product/common/widget/connection_status_icon.dart';
import 'package:dinamik10_pos/product/router/app_router.dart';
import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';
import 'package:widgets/widgets.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Widget title;
  final PreferredSizeWidget? bottom;
  final bool? isExit;
  final bool? isSynchronization;
  final bool? isSetting;
  final Widget? leading;

  const CustomAppBar({
    super.key,
    required this.title,
    this.bottom,
    this.isExit = false,
    this.leading,
    this.isSynchronization = false,
    this.isSetting = false,
  });
  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: title,
      actions: [
        isSynchronization == true
            ? IconButton(
              onPressed: () {
                context.router.push(SynchronizationRoute(showAsDialog: false, clearExisting: false));
              },
              icon: Icon(
                BootstrapIcons.cloud_arrow_down_fill,
                color: context.general.colorScheme.tertiary,
                size: CustomResponsiveHelper.isMobileOrTablet(context) ? 28 : 40,
              ),
            )
            : SizedBox(),
        isSetting == true
            ? IconButton(
              onPressed: () {
                context.router.push(SettingRoute());
              },
              icon: Icon(
                Icons.settings,
                color: context.general.colorScheme.tertiary,
                size: CustomResponsiveHelper.isMobileOrTablet(context) ? 28 : 40,
              ),
            )
            : SizedBox(),
        const ConnectionStatusIcon(),
      ],
      leading:
          isExit == true
              ? IconButton(
                onPressed: () {
                  customShowDialogGeneric(
                    context,
                    alertEnum: AlertEnum.warning,
                    subTitle: 'Çıkış Yapmak İstediğinize Emin Misiniz?',
                    okButtonFunction: () async {
                      context.router.replace(SplashRoute());
                    },
                    okButtonTitle: 'Çıkış Yap',
                  );
                },
                icon: Icon(
                  Icons.exit_to_app,
                  color: context.general.colorScheme.error,
                  size: CustomResponsiveHelper.isMobileOrTablet(context) ? 28 : 40,
                ),
              )
              : leading ?? AutoLeadingButton(color: context.general.colorScheme.primary),
      bottom: bottom,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(bottom == null ? kToolbarHeight : 125);
}
