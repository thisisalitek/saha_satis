import 'package:flutter/material.dart';

class HorizontalLoading extends StatefulWidget {
  const HorizontalLoading({super.key, required this.offTime});
  final int offTime;

  @override
  State<HorizontalLoading> createState() => _HorizontalLoadingState();
}

class _HorizontalLoadingState extends State<HorizontalLoading> with TickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    duration: Duration(milliseconds: widget.offTime),
    vsync: this,
  )..forward();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 300,
      height: 5,
      child: AnimatedBuilder(
        animation: _controller,
        builder: (_, __) => LinearProgressIndicator(value: _controller.value),
      ),
    );
  }
}
