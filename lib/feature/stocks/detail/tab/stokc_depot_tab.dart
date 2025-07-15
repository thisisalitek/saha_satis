import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:gen/gen.dart';

@RoutePage()
class StockDepotTabView extends StatelessWidget {
  const StockDepotTabView({super.key, required this.stok});
  final StockCardModel stok;

  @override
  Widget build(BuildContext context) {
    return Container(color: Colors.red);
  }
}
