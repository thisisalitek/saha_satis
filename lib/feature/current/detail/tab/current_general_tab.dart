import 'package:auto_route/auto_route.dart';
import 'package:bootstrap_icons/bootstrap_icons.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gen/gen.dart';
import 'package:kartal/kartal.dart';
import 'package:widgets/widgets.dart';

import '../../../../product/common/widget/one_info_card_widget.dart';
import '../../../../product/init/language/locale_keys.g.dart';

@RoutePage()
class CurrentGeneralTabView extends StatelessWidget {
  const CurrentGeneralTabView({super.key, required this.current});
  final CurrentAccountModel current;
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
            Text(LocaleKeys.current_current_general_info, style: context.general.textTheme.titleLarge).tr(),
            SizedBox(height: 10),
            OneInfoCardWidget(
              label: LocaleKeys.current_code.tr(),
              value: current.code ?? '-',
              icon: BootstrapIcons.hash,
              trailingIcon: IconButton(
                onPressed: () {
                  Clipboard.setData(ClipboardData(text: current.code.toString()));
                  ScaffoldMessenger.of(
                    context,
                  ).showSnackBar(SnackBar(content: Text(LocaleKeys.general_dialog_copy).tr()));
                },
                icon: Icon(Icons.copy_rounded),
              ),
            ),
            OneInfoCardWidget(
              label: LocaleKeys.current_current_name.tr(),
              value: current.title1 ?? '-',
              icon: BootstrapIcons.type,
            ),
            OneInfoCardWidget(
              label: LocaleKeys.current_tax_office_name.tr(),
              value: current.taxOfficeName ?? '-',
              icon: BootstrapIcons.tag_fill,
            ),
            OneInfoCardWidget(
              label: LocaleKeys.current_tax_office_no.tr(),
              value: current.taxOfficeNo ?? '-',
              icon: BootstrapIcons.tags_fill,
              trailingIcon: IconButton(
                onPressed: () {
                  Clipboard.setData(ClipboardData(text: current.code.toString()));
                  ScaffoldMessenger.of(
                    context,
                  ).showSnackBar(SnackBar(content: Text(LocaleKeys.general_dialog_copy).tr()));
                },
                icon: Icon(Icons.copy_rounded),
              ),
            ),
            OneInfoCardWidget(
              label: LocaleKeys.current_nace_code.tr(),
              value: current.naceCode1 ?? '-',
              icon: BootstrapIcons.file_earmark_code_fill,
            ),
            OneInfoCardWidget(
              label: LocaleKeys.current_nace_code2.tr(),
              value: current.naceCode2 ?? '-',
              icon: BootstrapIcons.file_earmark_code_fill,
            ),
            OneInfoCardWidget(
              label: LocaleKeys.current_updated_at.tr(),
              value: current.updatedAt ?? '-',
              icon: BootstrapIcons.clock_fill,
            ),
          ],
        ),
      ),
    );
  }
}
