import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';

class PulseContainer extends StatefulWidget {
  final Widget child;
  final Function onTapRoot;

  const PulseContainer({
    super.key,
    required this.child,
    required this.onTapRoot,
  });

  @override
  State<PulseContainer> createState() => _PulseContainerState();
}

class _PulseContainerState extends State<PulseContainer> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    )..repeat(reverse: true);
    _animation = Tween<double>(begin: 0.9, end: 1.1).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return InkWell(
          child: Transform.scale(
            scale: _animation.value,
            child: Stack(
              alignment: Alignment.topCenter,
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(45.0)),
                    color: Colors.blue.withOpacity(0.8),
                  ),
                  padding: const EdgeInsets.all(16),
                  child: widget.child,
                ),
                Container(
                  alignment: Alignment.topRight,
                  child: AvatarGlow(
                    glowColor: Colors.blue,
                    child: const Icon(
                      Icons.clear,
                      color: Colors.black,
                    ),
                  ),
                ),
              ],
            ),
          ),
          onTap: () {
            widget.onTapRoot.call();
          },
        );
      },
    );
  }
}
