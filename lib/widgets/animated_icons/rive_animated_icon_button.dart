import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';

class RiveIconButton extends StatefulWidget {
  final String name;
  final String animationName;
  final Function setStateFunction;

  RiveIconButton({
    Key key,
    @required this.name,
    @required this.animationName,
    @required this.setStateFunction,
  }) : super(key: key);

  @override
  _RiveIconButtonState createState() => _RiveIconButtonState();
}

class _RiveIconButtonState extends State<RiveIconButton> {
  String get name => widget.name;
  String get animationName => widget.animationName;
  Function get parentStateFunction => widget.setStateFunction;
  bool isOpen;
  bool isPressed;

  @override
  void initState() {
    super.initState();
    isOpen = false;
    isPressed = false;
  }

  whichAnimation() {
    if (isPressed) {
      if (isOpen) {
        return animationName;
      } else {
        return animationName + '_reverse';
      }
    } else {
      return 'idle';
    }
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      padding: EdgeInsets.all(10.0),
      onPressed: () {
        setState(() {
          isOpen = !isOpen;
          isPressed = true;
          try {
            parentStateFunction();
          } catch (e) {}
          }); 
        },
      icon: FlareActor(
        'assets/rive/animated_icons/$name.flr',
        alignment: Alignment.center,
        animation: whichAnimation(),
      ),
    );
  }
}
