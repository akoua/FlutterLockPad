import 'dart:async';

import 'package:flutter/material.dart';
import 'package:mypocket_pin/padScreen/pin_pad.dart';

import 'padScreen/circle_input.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({
    Key key,
  }) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Color _backgroundColor;
  Text _title;

  /// Ce stream permet de prendre une décision après que la validation soit ok
  final StreamController<bool> _validationNotifier =
      StreamController<bool>.broadcast();

  @override
  void initState() {
    super.initState();
    _backgroundColor = Colors.blue;
    _title = Text("Entrer votre mot de passe",
        style: TextStyle(color: Colors.white));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PinPad(
        title: _title,
        titleforget: Text(
          "Mot de passe oublié ?",
          style: TextStyle(color: Colors.white),
        ),
        clickForgetCallback: () {
          print("forget");
        },
        circleInputConfig: CircleInputConfig(
            borderColor: Colors.white, fillColor: Colors.white, circleSize: 30),
        titleWidthMargin: 130,
        backgroundColor: _backgroundColor,
        passwordValidationCallback: _onPasswordValidationCallback,
        isValidationCallback: _isValidationCallback,
        triggerValidation: _validationNotifier.stream,
      ),
    );
  }

  _onPasswordValidationCallback(String enteredPasscode) {
    /// Vous pouvez attendre la reponse de votre serveur avant de passer
    /// par là
    bool isValid = '1234' == enteredPasscode;
    _validationNotifier.add(isValid);
    if (!isValid) {
      setState(() {
        this._backgroundColor = Colors.red;
      });
    }
  }

  _isValidationCallback(bool isValid) {
    if (isValid) {
      print("je peux faire la redirection vers la page de mon choix");
      setState(() {
        this._backgroundColor = Colors.blue;
      });
    } else {
      print(
          "Je peux mettre à jour un widget du pad, en fait je peux tout faire");
    }
  }
}
