import 'package:bootstrap_icons/bootstrap_icons.dart';
import 'package:dinamik10_pos/feature/current/view_model/current_state.dart';
import 'package:dinamik10_pos/feature/current/view_model/current_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kartal/kartal.dart';
import 'package:widgets/widgets.dart';

class CurrentSearchAndFindWidget extends StatelessWidget {
  const CurrentSearchAndFindWidget({super.key, required this.searchController});

  final TextEditingController searchController;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CurrentViewModel, CurrentState>(
      builder: (context, state) {
        return Row(
          children: [
            Expanded(
              child: CustomFormField(
                controller: searchController,
                fieldType: CustomFormFieldType.text,
                isDone: true,
                decoration: customFormFieldDecoration(
                  context,
                  labelText: state.searchTypeText,
                  prefixIcon: Icon(BootstrapIcons.search),
                ),
              ),
            ),
            IconButton(
              onPressed: () {
                context.read<CurrentViewModel>().changeSearchType();
              },
              icon: Icon(BootstrapIcons.text_wrap, color: context.general.colorScheme.primary),
            ),
          ],
        );
      },
    );
  }
}
