// lib/product/widgets/connection_status_icon.dart
import 'dart:async';
import 'package:bootstrap_icons/bootstrap_icons.dart';
import 'package:dinamik10_pos/product/init/language/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';
import 'package:widgets/widgets.dart';

import '../../service/check_connection_service.dart';

enum ConnectionStatus { connected, disconnected, checking }

class ConnectionStatusIcon extends StatefulWidget {
  const ConnectionStatusIcon({super.key});

  @override
  State<ConnectionStatusIcon> createState() => _ConnectionStatusIconState();
}

class _ConnectionStatusIconState extends State<ConnectionStatusIcon> {
  ConnectionStatus _status = ConnectionStatus.checking;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _startConnectionCheckTimer();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _startConnectionCheckTimer() {
    _timer = Timer.periodic(const Duration(seconds: 10), (timer) {
      _checkAndUpdateConnection();
    });
    _checkAndUpdateConnection();
  }

  Future<void> _checkAndUpdateConnection() async {
    if (!mounted) return;

    setState(() {
      _status = ConnectionStatus.checking;
    });

    final isConnected = await checkConnectionStatus();

    if (!mounted) return;

    setState(() {
      if (isConnected) {
        _status = ConnectionStatus.connected;
      } else {
        _status = ConnectionStatus.disconnected;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    Color iconColor;
    IconData iconData;
    String tooltipText;

    switch (_status) {
      case ConnectionStatus.connected:
        iconColor = Colors.green;
        iconData = BootstrapIcons.database_fill_check;
        tooltipText = LocaleKeys.general_dialog_connection_ok.tr();
        break;
      case ConnectionStatus.disconnected:
        iconColor = context.general.colorScheme.error;
        iconData = BootstrapIcons.database_fill_slash;
        tooltipText = LocaleKeys.general_dialog_connection_error.tr();
        break;
      case ConnectionStatus.checking:
        iconColor = Colors.orange;
        iconData = BootstrapIcons.database_fill;
        tooltipText = 'Bağlantı Kontrol Ediliyor...'.tr();
        break;
    }

    return IconButton(
      tooltip: tooltipText,
      onPressed: () {
        if (_status == ConnectionStatus.disconnected) {
          customShowDialogGeneric(
            context,
            alertEnum: AlertEnum.warning,
            subTitle: LocaleKeys.general_dialog_connection_error.tr(),
            okButtonFunction: () async {
              _checkAndUpdateConnection();
            },
          );
        } else {
          customShowDialogGeneric(
            context,
            alertEnum: AlertEnum.info,
            subTitle: LocaleKeys.general_dialog_connection_ok.tr(),
          );
        }
      },
      icon: Icon(iconData, color: iconColor, size: CustomResponsiveHelper.isMobileOrTablet(context) ? 28 : 40),
    );
  }
}
