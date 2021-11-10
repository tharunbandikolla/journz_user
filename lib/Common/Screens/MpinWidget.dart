import '/Common/Screens/MpinAnimation.dart';
import 'package:flutter/material.dart';

class MpinAddDeleteController {
  void Function(String)? addInput;
  void Function()? delete;
  void Function()? reset;
}

class MpinWidget extends StatefulWidget {
  final int pinLength;
  final MpinAddDeleteController addDeleteController;
  final Function onCompleted;
  const MpinWidget(
      {Key? key,
      required this.pinLength,
      required this.addDeleteController,
      required this.onCompleted})
      : assert(pinLength <= 6 && pinLength > 0),
        super(key: key);

  @override
  _MpinWidgetState createState() => _MpinWidgetState(addDeleteController);
}

class _MpinWidgetState extends State<MpinWidget> {
  late List<MPinAnimationController> _animationList;
  String mPin = '';

  _MpinWidgetState(MpinAddDeleteController addDeleteController) {
    addDeleteController.addInput = addinput;
    addDeleteController.delete = delete;
    addDeleteController.reset = reset;
  }

  void addinput(String input) {
    mPin += input;
    if (mPin.length < widget.pinLength) {
      _animationList[mPin.length - 1].animate!(input);
    } else if (mPin.length == widget.pinLength) {
      _animationList[mPin.length - 1].animate!(input);
      widget.onCompleted.call(mPin);
    }
  }

  void delete() {
    if (mPin.isNotEmpty) {
      mPin = mPin.substring(0, mPin.length - 1);
      _animationList[mPin.length].animate!('');
    }
  }

  void reset() {
    print(' nnn reset otp');
    if (mPin.isNotEmpty) {
      mPin = '';
      for (int i = 0; i <= 5; i++) {
        print('see me $i');
        _animationList[i].animate!('');
        mPin = '';
      }
      //setState(() {});
    }
  }

  @override
  void initState() {
    _animationList = List.generate(widget.pinLength, (index) {
      return MPinAnimationController();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FittedBox(
      child: Container(
        width: MediaQuery.of(context).size.width,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(widget.pinLength, (index) {
            return MpinAnimation(
              animationController: _animationList[index],
            );
          }),
        ),
      ),
    );
  }
}
