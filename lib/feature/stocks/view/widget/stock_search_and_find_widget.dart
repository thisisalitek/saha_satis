import 'package:bootstrap_icons/bootstrap_icons.dart';
import 'package:dinamik10_pos/feature/stocks/view_model/stock_state.dart';
import 'package:dinamik10_pos/feature/stocks/view_model/stock_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kartal/kartal.dart';
import 'package:widgets/widgets.dart';

class StockSearchAndFindWidget extends StatelessWidget {
  const StockSearchAndFindWidget({super.key, required this.searchController});

  final TextEditingController searchController;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<StockViewModel, StockState>(
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
                context.read<StockViewModel>().changeSearchType();
              },
              icon: Icon(BootstrapIcons.text_wrap, color: context.general.colorScheme.primary),
            ),
            IconButton(
              onPressed: () {},
              icon: Icon(BootstrapIcons.qr_code_scan, color: context.general.colorScheme.primary),
            ),
          ],
        );
      },
    );
  }
}
