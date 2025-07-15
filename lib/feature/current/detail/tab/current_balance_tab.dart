import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:gen/gen.dart';

@RoutePage()
class CurrentBalanceTabView extends StatelessWidget {
  const CurrentBalanceTabView({super.key, required this.current});
  final CurrentAccountModel current;
  @override
  Widget build(BuildContext context) {
    return Container(color: Colors.red);
  }
}
