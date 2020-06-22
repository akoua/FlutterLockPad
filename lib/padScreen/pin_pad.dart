import 'package:flutter/material.dart';
import 'package:mypocket_pin/padScreen/circle_input.dart';
import 'package:mypocket_pin/padScreen/keyboard_pin.dart';

typedef ClickForgetCallback = void Function();

class PinPad extends StatefulWidget {
  final int passwordDigits;
  final CircleInputConfig circleInputConfig;
  // final TextEditingController pinInputController = TextEditingController();
  final Text title;
  final Text titleforget;
  final double titleWidthMargin;
  final double circleInputPinWidthMargin;
  final ClickForgetCallback clickForgetCallback;
  PinPad(
      {Key key,
      @required this.title,
      @required this.titleforget,
      this.titleWidthMargin = 30,
      this.circleInputPinWidthMargin = 10,
      this.passwordDigits = 4,
      @required this.circleInputConfig,
      @required this.clickForgetCallback})
      : super(key: key);

  @override
  _PinPadState createState() => _PinPadState();
}

class _PinPadState extends State<PinPad> {
  String enteredPasscode = '';

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.blue, // TODO devrait être dynamique
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              height: 50,
            ),
            Row(
              children: <Widget>[
                IconButton(
                    icon: Icon(Icons.arrow_back_ios),
                    onPressed: () {
                      Navigator.of(context).pop();
                    }),
                SizedBox(
                  width: widget.titleWidthMargin,
                ),
                widget.title,
                // Text("Entré votre mot de passe")
              ],
            ),
            SizedBox(
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: _buildCircleInput(),
            ),
            SizedBox(
              height: 20,
            ),
            NumPinKeyboard(
              // keyColor: Colors.amber,
              // clearKeyBackgroundColor: Colors.blue,
              pinInputLength: 4,
              currentPinInputLength: enteredPasscode.length,
              // pinInputController: widget.pinInputController,
              onKeyboardTap: _onKeyboardButtonPressed,
              onkeyboardRemoveTap: _onDeleteButtonPressed,
            ),
            SizedBox(
              height: 50,
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
      list.add(CircleInput(
        filled: i < enteredPasscode.length,
        circleUIConfig: config,
        extraSize: widget.circleInputPinWidthMargin,
      ));
    }
    return list;
  }

  _onKeyboardButtonPressed(String text) {
    setState(() {
      if (enteredPasscode.length < widget.passwordDigits) {
        print("Text $text ");
        enteredPasscode += text;
        if (enteredPasscode.length == widget.passwordDigits) {
          print("Validate");
          // widget.passwordEnteredCallback(enteredPasscode);
        }
      }
    });
  }

  _onDeleteButtonPressed() {
    if (enteredPasscode.length > 0) {
      setState(() {
        enteredPasscode =
            enteredPasscode.substring(0, enteredPasscode.length - 1);
      });
    }
  }
}
