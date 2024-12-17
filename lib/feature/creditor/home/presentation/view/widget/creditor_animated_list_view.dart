import 'package:flutter/material.dart';
import 'creditor_installment_item.dart';

class CreditorAnimatedInstallmentItem extends StatefulWidget {
  final int delay;
  final dynamic installment;
  final VoidCallback onTap;

  const CreditorAnimatedInstallmentItem({
    super.key,
    required this.delay,
    required this.installment,
    required this.onTap,
  });

  @override
  State<CreditorAnimatedInstallmentItem> createState() =>
      _CreditorAnimatedInstallmentItemState();
}

class _CreditorAnimatedInstallmentItemState
    extends State<CreditorAnimatedInstallmentItem>
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
        child: CreditorInstallmentItem(
          onTap: widget.onTap,
          installment: widget.installment,
        ),
      ),
    );
  }
}
