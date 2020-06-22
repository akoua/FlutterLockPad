import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mypocket_pin/padScreen/circle_input.dart';
import 'package:mypocket_pin/padScreen/keyboard_pin.dart';

import 'shake_curve.dart';

typedef ClickForgetCallback = void Function();
typedef PasswordValidationCallback = void Function(String text);
// typedef IsValidCallback = void Function();
typedef IsValidationCallback = void Function(bool isValid);

class PinPad extends StatefulWidget {
  final int passwordDigits;
  final CircleInputConfig circleInputConfig;
  final Text title;
  final Text titleforget;
  final double titleWidthMargin;
  final double circleInputPinWidthMargin;
  final Color backgroundColor;
  final Stream<bool> triggerValidation;
  final int animationDuration;
  final ClickForgetCallback clickForgetCallback;
  final PasswordValidationCallback passwordValidationCallback;
  final IsValidationCallback isValidationCallback;

  PinPad(
      {Key key,
      @required this.title,
      @required this.titleforget,
      this.titleWidthMargin = 30,
      this.circleInputPinWidthMargin = 10,
      this.passwordDigits = 4,
      this.animationDuration = 500,
      @required this.circleInputConfig,
      @required this.backgroundColor,
      @required this.triggerValidation,
      @required this.clickForgetCallback,
      @required this.passwordValidationCallback,
      @required this.isValidationCallback})
      : super(key: key);

  @override
  _PinPadState createState() => _PinPadState();
}

class _PinPadState extends State<PinPad> with SingleTickerProviderStateMixin {
  StreamSubscription<bool> _streamSubscription;
  String _enteredPasscode = '';
  AnimationController _controller;
  Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    /// ce Stream écoute toutes les actions se produisant dans la methode renvoyée
    /// à isValidationCallback afin de prendre une décision
    this._streamSubscription = widget.triggerValidation.listen((isValid) {
      print("Listener");
      if (isValid) {
        widget.isValidationCallback(isValid);
        _enteredPasscode = '';
      } else {
        _controller.forward();
      }
    });
    _controller = AnimationController(
        duration: Duration(milliseconds: widget.animationDuration),
        vsync: this);
    final Animation curve =
        CurvedAnimation(parent: _controller, curve: ShakeCurve());
    _animation = Tween(begin: 0.0, end: 5.0).animate(curve)
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          setState(() {
            // print("Curve $curve");
            _enteredPasscode = '';
            _controller.value = 0;
          });
        }
      })
      ..addListener(() {
        setState(() {
          // the animation object’s value is the changed state
        });
      });
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(width: 750.0, height: 1334.0, allowFontScaling: true);
    return Container(
      color: widget.backgroundColor, // TODO devrait être dynamique
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              height: 120.h,
            ),
            Row(
              children: <Widget>[
                IconButton(
                    icon: Icon(
                      Icons.arrow_back_ios,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      Navigator.of(context).pop();
                    }),
                SizedBox(
                  width: widget.titleWidthMargin.w,
                ),
                widget.title,
                // Text("Entré votre mot de passe")
              ],
            ),
            SizedBox(
              height: 80.h,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: _buildCircleInput(),
            ),
            SizedBox(
              height: 50.h,
            ),
            NumPinKeyboard(
              // keyColor: Colors.amber,
              // clearKeyBackgroundColor: Colors.blue,
              pinInputLength: widget.passwordDigits,
              currentPinInputLength: _enteredPasscode.length,
              onKeyboardTap: _onKeyboardButtonPressed,
              onkeyboardRemoveTap: _onDeleteButtonPressed,
            ),
            SizedBox(
              height: 100.h,
            ),
            _buildForgetText()
          ],
        ),
      ),
    );
  }

  Widget _buildForgetText() {
    return FlatButton(
      child: widget.titleforget,

      /// permet de donner un contour rond lors du click
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(25),
      ),
      // padding: const EdgeInsets.all(10),

      onPressed: () {
        widget.clickForgetCallback();
      },
    );
  }

  List<Widget> _buildCircleInput() {
    var list = <Widget>[];
    // var config = widget.circleInputConfig;
    var config = widget.circleInputConfig;
    for (var i = 0; i < widget.passwordDigits; i++) {
      list.add(Padding(
        padding:
            EdgeInsets.symmetric(horizontal: widget.circleInputPinWidthMargin),
        child: CircleInput(
          filled: i < _enteredPasscode.length,
          circleUIConfig: config,

          /// C'est sa maj qui fait toute l'animation
          extraSize: _animation.value,
        ),
      ));
    }
    return list;
  }

  _onKeyboardButtonPressed(String text) {
    setState(() {
      if (_enteredPasscode.length < widget.passwordDigits) {
        // print("Text $text ");
        _enteredPasscode += text;
        if (_enteredPasscode.length == widget.passwordDigits) {
          print("Validate");
          widget.passwordValidationCallback(_enteredPasscode);
          // widget.passwordEnteredCallback(_enteredPasscode);
        }
      }
    });
  }

  _onDeleteButtonPressed() {
    if (_enteredPasscode.length > 0) {
      setState(() {
        _enteredPasscode =
            _enteredPasscode.substring(0, _enteredPasscode.length - 1);
      });
    }
  }

  @override
  void dispose() {
    _streamSubscription.cancel();
    _controller.dispose();
    super.dispose();
  }
}
