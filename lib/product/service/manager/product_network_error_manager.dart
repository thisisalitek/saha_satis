import 'dart:io';

import 'package:dinamik10_pos/product/init/language/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/widgets.dart';
import 'package:widgets/widgets.dart';

/// Manage your network error with screen
final class ProductNetworkErrorManager {
  ProductNetworkErrorManager(this.context);
  final BuildContext context;

  void handleError(int value) {
    if (value == HttpStatus.unauthorized) {
      if (context.mounted) {
        customShowDialogGeneric(
          context,
          alertEnum: AlertEnum.error,
          subTitle: LocaleKeys.general_dialog_unauthorized.tr(),
        );
      }
    }
    if (value == HttpStatus.notFound) {
      if (context.mounted) {
        customShowDialogGeneric(
          context,
          alertEnum: AlertEnum.error,
          subTitle: LocaleKeys.general_dialog_not_found.tr(),
        );
      }
    }
  }
}
