import 'package:flutter/material.dart';
import 'installment_item.dart';

class AnimatedInstallmentItem extends StatefulWidget {
  final int delay;
  final dynamic installment;
  final VoidCallback onTap;

  const AnimatedInstallmentItem({
    super.key,
    required this.delay,
    required this.installment,
    required this.onTap,
  });

  @override
  State<AnimatedInstallmentItem> createState() =>
      _AnimatedInstallmentItemState();
}

class _AnimatedInstallmentItemState extends State<AnimatedInstallmentItem>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
    _slideAnimation = Tween<Offset>(
      begin: const Offset(1, 1),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut,
      ),
    );
    Future.delayed(Duration(milliseconds: widget.delay), () {
      if (mounted) {
        _controller.forward();
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: _slideAnimation,
      child: FadeTransition(
        opacity: _controller,
        child: InstallmentItem(
          onTap: widget.onTap,
          installment: widget.installment,
        ),
      ),
    );
  }
}
