import 'package:flutter/material.dart';
import 'package:ketquaxoso/mckimquyen/common/const/color_constants.dart';

class PulseContainer extends StatefulWidget {
  final Widget child;

  const PulseContainer({super.key, required this.child});

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
        return Transform.scale(
          scale: _animation.value,
          child: Stack(
            alignment: Alignment.topCenter,
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(45.0)),
                  color: ColorConstants.appColor.withOpacity(0.8),
                ),
                padding: const EdgeInsets.all(16),
                child: widget.child,
              ),
              Container(
                alignment: Alignment.topRight,
                child: InkWell(
                  customBorder: const CircleBorder(),
                  splashColor: Colors.red,
                  onTap: () {},
                  child: const Icon(
                    Icons.clear,
                    color: Colors.black,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
