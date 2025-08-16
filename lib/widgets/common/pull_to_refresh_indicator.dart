import 'package:flutter/material.dart';

class PullToRefreshIndicator extends StatelessWidget {
  final Widget child;
  final Future<void> Function() onRefresh;
  final Color color;

  const PullToRefreshIndicator({
    super.key,
    required this.child,
    required this.onRefresh,
    this.color = Colors.white,
  });

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: onRefresh,
      color: color,
      child: child,
    );
  }
}
