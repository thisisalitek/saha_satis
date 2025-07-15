import 'package:auto_route/auto_route.dart';
import 'package:dinamik10_pos/feature/current/view/mixin/current_mixin.dart';
import 'package:dinamik10_pos/feature/current/view/widget/current_search_and_find_widget.dart';
import 'package:dinamik10_pos/feature/current/view_model/current_state.dart';
import 'package:dinamik10_pos/feature/current/view_model/current_view_model.dart';
import 'package:dinamik10_pos/product/common/widget/custom_appbar.dart';
import 'package:dinamik10_pos/product/common/widget/loading_list_widget.dart';
import 'package:dinamik10_pos/product/common/widget/row_test_widget.dart';
import 'package:dinamik10_pos/product/init/language/locale_keys.g.dart';
import 'package:dinamik10_pos/product/router/app_router.dart';
import 'package:dinamik10_pos/product/state/base/base_state.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:gen/gen.dart';
import 'package:kartal/kartal.dart';
import 'package:widgets/widgets.dart';
part 'widget/current_card_list.dart';

@RoutePage()
class CurrentView extends StatefulWidget {
  const CurrentView({super.key});

  @override
  State<CurrentView> createState() => _CurrentViewState();
}

class _CurrentViewState extends BaseState<CurrentView> with CurrentMixin {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => currentViewModel,
      child: Scaffold(
        appBar: CustomAppBar(title: Text(LocaleKeys.menu_currents).tr()),
        body: Container(
          decoration: BoxDecoration(
            color: context.general.colorScheme.primary.withValues(alpha: 0.1),
            borderRadius: BorderRadius.only(topLeft: Radius.circular(30), topRight: Radius.circular(30)),
          ),
          padding: ProjectPadding.allSmall(),
          child: Column(
            children: [
              CurrentSearchAndFindWidget(searchController: searchController),
              SizedBox(height: 8),
              Expanded(child: _CurrentCardList()),
            ],
          ),
        ),
      ),
    );
  }
}
