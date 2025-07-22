import 'dart:developer';
import 'package:flutter/material.dart';
import 'mixin/dialog_buttons.dart';
import 'mixin/dialog_config.dart';
import 'mixin/dialog_loading_bar.dart';

Future<void> customShowDialogGeneric(
  BuildContext context, {
  required AlertEnum alertEnum,
  required String subTitle,
  Future<void> Function()? okButtonFunction,
  Future<void> Function()? cancelButtonFunction,
  Future<void> Function()? specialButtonFunction,
  String? okButtonTitle,
  String? cancelButtonTitle,
  String? specialButtonTitle,
  int? offTime,
}) async {
  final config = alertConfigs[alertEnum]!;
  final theme = Theme.of(context);

  return showDialog(
    barrierDismissible: config.dismissible,
    context: context,
    builder: (BuildContext dialogContext) {
      WidgetsBinding.instance.addPostFrameCallback((_) async {
        if (!config.dismissible) {
          await Future.delayed(Duration(milliseconds: offTime ?? 2000), () {
            if (dialogContext.mounted) Navigator.of(dialogContext).pop();
          });
        }
      });

      return AlertDialog(
        backgroundColor: theme.colorScheme.surfaceContainer,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        icon: config.icon,
        title: Text(config.title, style: theme.textTheme.headlineSmall),
        elevation: 10,
        actions:
            config.dismissible
                ? [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        buildDialogButton(
                          cancelButtonTitle ?? 'Vazgeç',
                          cancelButtonFunction ??
                              () async {
                                log('cancelButtonFunction eksik');
                                Navigator.of(context).pop();
                              },
                          hasBorder: true,
                        ),
                        if (specialButtonFunction != null) const SizedBox(width: 10),
                        if (specialButtonFunction != null)
                          buildDialogButton(specialButtonTitle ?? 'Özel', specialButtonFunction, hasBorder: true),
                        const SizedBox(width: 10),
                        buildDialogButton(okButtonTitle ?? 'Tamam', () async {
                          if (okButtonFunction != null) {
                            Navigator.of(context).pop();
                            await okButtonFunction();
                          } else {
                            log('okButtonFunction eksik', name: 'CustomShowDialog', error: 'null');
                            Navigator.of(context).pop();
                          }
                        }),
                      ],
                    ),
                  ),
                ]
                : [],
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              subTitle,
              textAlign: TextAlign.center,
              style: theme.textTheme.bodyMedium,
              maxLines: 10,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 50),
            if (!config.dismissible) HorizontalLoading(offTime: offTime ?? 2000),
          ],
        ),
      );
    },
  );
}
