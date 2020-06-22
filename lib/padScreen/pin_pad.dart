import 'package:flutter/material.dart';
import 'package:mypocket_pin/padScreen/circle_input.dart';
import 'package:mypocket_pin/padScreen/keyboard_pin.dart';

class PinPad extends StatefulWidget {
  final int passwordDigits;
  final CircleInputConfig circleInputConfig;
  final TextEditingController pinInputController = TextEditingController();
  PinPad({Key key, this.passwordDigits = 4, this.circleInputConfig})
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
                  width: 30,
                ),
                Text("Entré votre mot de passe")
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
              keyColor: Colors.amber,
              clearKeyBackgroundColor: Colors.blue,
              pinInputLength: 4,
              currentPinInputLength: enteredPasscode.length,
              // pinInputController: widget.pinInputController,
              onKeyboardTap: _onKeyboardButtonPressed,
              onkeyboardRemoveTap: _onDeleteButtonPressed,
            ),
            SizedBox(
              height: 50,
            ),
            InkWell(
                radius: 80,
                // splashColor: Colors.amber,
                onTap: () {},
                child: Text("Code pin oublié ?"))
          ],
        ),
      ),
    );
  }

  List<Widget> _buildCircleInput() {
    var list = <Widget>[];
    // var config = widget.circleInputConfig;
    var config = CircleInputConfig(
        borderColor: Colors.white, fillColor: Colors.white, circleSize: 30);
    for (var i = 0; i < widget.passwordDigits; i++) {
      list.add(CircleInput(
          filled: i < enteredPasscode.length, circleUIConfig: config));
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
