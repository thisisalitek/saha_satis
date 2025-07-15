import 'package:auto_route/auto_route.dart';
import 'package:bootstrap_icons/bootstrap_icons.dart';
import 'package:core/core.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:gen/gen.dart';
import 'package:kartal/kartal.dart';
import 'package:widgets/widgets.dart';

import '../../../../product/common/widget/one_info_card_widget.dart';
import '../../../../product/init/language/locale_keys.g.dart';

@RoutePage()
class CurrentContactTabView extends StatelessWidget {
  const CurrentContactTabView({super.key, required this.current});
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
            Text(LocaleKeys.stock_stock_general_info, style: context.general.textTheme.titleLarge).tr(),
            SizedBox(height: 10),
            OneInfoCardWidget(
              label: LocaleKeys.current_email.tr(),
              value: current.email ?? '-',
              icon: BootstrapIcons.envelope_at_fill,
              trailingIcon: IconButton(
                onPressed: () {
                  launchEmail(current.email);
                },
                icon: Icon(BootstrapIcons.envelope_arrow_up_fill),
              ),
            ),
            OneInfoCardWidget(
              label: LocaleKeys.current_mobile_phone.tr(),
              value: current.mobilePhone ?? '-',
              icon: BootstrapIcons.telephone_fill,
              trailingIcon: IconButton(
                onPressed: () {
                  launchPhoneCall(current.mobilePhone);
                },
                icon: Icon(BootstrapIcons.telephone_outbound_fill),
              ),
            ),
            OneInfoCardWidget(
              label: LocaleKeys.current_country_city.tr(),
              value: '${current.city ?? '-'} / ${current.county ?? '-'}',
              icon: BootstrapIcons.map_fill,
            ),
            OneInfoCardWidget(
              label: LocaleKeys.current_address.tr(),
              value: current.street ?? '-',
              icon: BootstrapIcons.globe_europe_africa,
            ),
            OneInfoCardWidget(
              label: LocaleKeys.current_see_location.tr(),
              value: '',
              icon: BootstrapIcons.geo_fill,
              trailingIcon: IconButton(
                onPressed: () {
                  if (current.gpsLatitude == 0 || current.gpsLongitude == 0) {
                    launchMapWithAddress(current.street);
                  } else {
                    launchMapWithLatLng(current.gpsLatitude, current.gpsLongitude);
                  }
                },
                icon: Icon(BootstrapIcons.pin_map_fill),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
