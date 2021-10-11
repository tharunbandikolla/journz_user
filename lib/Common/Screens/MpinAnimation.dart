import 'package:flutter/material.dart';

class MPinAnimationController {
  void Function(String)? animate;
}

class MpinAnimation extends StatefulWidget {
  MPinAnimationController animationController;
  MpinAnimation({required this.animationController});
  @override
  _MpinAnimationState createState() => _MpinAnimationState(animationController);
}

class _MpinAnimationState extends State<MpinAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _sizeAnimation;
  
  String pin = '';

  void animate(String input) {
    _controller.forward();
    setState(() {
      pin = input;
    });
  }

  _MpinAnimationState(animationController) {
    animationController?.animate = animate;
  }

  @override
  void initState() {
    _controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 200));

    _sizeAnimation = Tween<double>(begin: 24, end: 72).animate(_controller);
    
    _controller.addListener(() {
      if (_controller.status == AnimationStatus.completed) {
        _controller.reverse();
      }
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 30,
      width: 30,
      alignment: Alignment.center,
      child: Container(
          alignment: Alignment.center,
          height: _sizeAnimation.value,
          width: _sizeAnimation.value,
          decoration: BoxDecoration(
              color: pin == "" ? Colors.grey[200] : Colors.grey[400],
              shape: BoxShape.rectangle),
          child: Transform.scale(
            scale: _sizeAnimation.value / 30,
            child: Text(
              pin,
              style: Theme.of(context)
                  .textTheme
                  .headline5!
                  .copyWith(fontWeight: FontWeight.bold),
            ),
          )),
    );
  }
}
