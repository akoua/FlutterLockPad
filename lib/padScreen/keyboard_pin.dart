import 'package:flutter/material.dart';

typedef KeyboardTapCallback = void Function(String text);
typedef KeyboardRemoveCallback = void Function();

class NumPinKeyboard extends StatelessWidget {
  var clearKeyBackgroundColor, backKeyBackgroundColor, keyColor, keyFontColor;
  var backKeyFontColor, clearKeyFontColor;
  final int pinInputLength;
  final int currentPinInputLength;
  // final TextEditingController pinInputController;
  final KeyboardTapCallback onKeyboardTap;
  final KeyboardRemoveCallback onkeyboardRemoveTap;
  // final NumPadController numPadController;

  NumPinKeyboard({
    this.pinInputLength = 4,
    this.currentPinInputLength,
    this.clearKeyBackgroundColor,
    this.backKeyBackgroundColor = Colors.transparent,
    this.keyColor = Colors.black26,
    this.keyFontColor = Colors.white,
    this.backKeyFontColor = Colors.white,
    this.clearKeyFontColor = Colors.white,
    // @required this.pinInputController,
    @required this.onKeyboardTap,
    @required this.onkeyboardRemoveTap,
    // this.numPadController,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(0.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              NumPinKey(
                digit: '1',
                keyBackgrounColor: keyColor,
                keyContentColor: keyFontColor,
                onPressed: () {
                  if (currentPinInputLength < pinInputLength) {
                    print("click on 1  $pinInputLength ");
                    onKeyboardTap("1");
                  }
                },
              ),
              NumPinKey(
                digit: '2',
                keyBackgrounColor: keyColor,
                keyContentColor: keyFontColor,
                onPressed: () {
                  if (currentPinInputLength < pinInputLength) {
                    // print("click on 1  $pinInputLength ");
                    onKeyboardTap("2");
                  }
                },
              ),
              NumPinKey(
                digit: '3',
                keyBackgrounColor: keyColor,
                keyContentColor: keyFontColor,
                onPressed: () {
                  if (currentPinInputLength < pinInputLength) {
                    // print("click on 1  $pinInputLength ");
                    onKeyboardTap("3");
                  }
                },
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(0.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              NumPinKey(
                digit: '4',
                keyBackgrounColor: keyColor,
                keyContentColor: keyFontColor,
                onPressed: () {
                  if (currentPinInputLength < pinInputLength) {
                    // print("click on 1  $pinInputLength ");
                    onKeyboardTap("4");
                  }
                },
              ),
              NumPinKey(
                digit: '5',
                keyBackgrounColor: keyColor,
                keyContentColor: keyFontColor,
                onPressed: () {
                  if (currentPinInputLength < pinInputLength) {
                    // print("click on 1  $pinInputLength ");
                    onKeyboardTap("5");
                  }
                },
              ),
              NumPinKey(
                digit: '6',
                keyBackgrounColor: keyColor,
                keyContentColor: keyFontColor,
                onPressed: () {
                  if (currentPinInputLength < pinInputLength) {
                    // print("click on 1  $pinInputLength ");
                    onKeyboardTap("6");
                  }
                },
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(0.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              NumPinKey(
                digit: '7',
                keyBackgrounColor: keyColor,
                keyContentColor: keyFontColor,
                onPressed: () {
                  if (currentPinInputLength < pinInputLength) {
                    // print("click on 1  $pinInputLength ");
                    onKeyboardTap("7");
                  }
                },
              ),
              NumPinKey(
                digit: '8',
                keyBackgrounColor: keyColor,
                keyContentColor: keyFontColor,
                onPressed: () {
                  if (currentPinInputLength < pinInputLength) {
                    // print("click on 1  $pinInputLength ");
                    onKeyboardTap("8");
                  }
                },
              ),
              NumPinKey(
                digit: '9',
                keyBackgrounColor: keyColor,
                keyContentColor: keyFontColor,
                onPressed: () {
                  if (currentPinInputLength < pinInputLength) {
                    // print("click on 1  $pinInputLength ");
                    onKeyboardTap("9");
                  }
                },
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(0.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              NumPinKey(
                digit: '',
                keyBackgrounColor: keyColor,
                keyContentColor: keyFontColor,
                onPressed: null,
              ),
              NumPinKey(
                digit: '0',
                keyBackgrounColor: keyColor,
                keyContentColor: keyFontColor,
                onPressed: () {
                  if (currentPinInputLength < pinInputLength) {
                    onKeyboardTap("0");
                  }
                },
              ),
              NumPinKey(
                  digit: Icon(
                    Icons.backspace,
                    size: 20,
                    color: backKeyFontColor,
                  ),
                  keyBackgrounColor: backKeyBackgroundColor,
                  onPressed: () {
                    // print("delete");
                    onkeyboardRemoveTap();
                  }),
              // NumPinKey(
              //     digit: Icon(
              //       Icons.clear,
              //       size: 20,
              //       color: clearKeyFontColor,
              //     ),
              //     keyBackgrounColor: clearKeyBackgroundColor,
              //     onPressed: () {
              //       // NumPadController.shakeAnimation.forward();
              //       pinInputController.clear();
              //     }),
            ],
          ),
        ),
      ],
    );
  }
}

class NumPinKeyContent extends StatelessWidget {
  var content, color;

  NumPinKeyContent({this.content, this.color});

  @override
  Widget build(BuildContext context) {
    if (content is String) {
      return Container(
        alignment: Alignment.center,
        child: Text(
          content,
          style: TextStyle(
              fontSize: 25, color: color, fontWeight: FontWeight.normal),
        ),
      );
    } else if (content is Icon) {
      return Container(
        alignment: Alignment.center,
        child: content,
      );
    }
    return null;
  }
}

class NumPinKey extends StatelessWidget {
  var digit;
  var keyBackgrounColor, keyContentColor;
  final Function onPressed;

  NumPinKey(
      {this.digit,
      this.keyBackgrounColor,
      this.keyContentColor,
      this.onPressed});

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    var width = screenSize.width;
    var height = screenSize.height;
    double margin = 15.0;

    var size = (height / 10);
    return Container(
      child: FittedBox(
          fit: BoxFit.cover,
          child: FlatButton(
            padding: EdgeInsets.all(margin),
            color: Colors.transparent,

            ///peut-être utilisé pour ajouter de la couleur au contour rond
            // color: keyBackgrounColor,
            shape: CircleBorder(),
            child: NumPinKeyContent(content: digit, color: keyContentColor),
            /* Append new digit to current text string. */
            onPressed: onPressed,
          )),
      margin: EdgeInsets.fromLTRB(margin - 3, margin - 11, margin, margin - 11),
      height: size + 10,
      width: size + 10,
    );
  }
}
