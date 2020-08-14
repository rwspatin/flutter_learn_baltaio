import 'package:alcool_gasolina/widgets/logo.widget.dart';
import 'package:alcool_gasolina/widgets/submit-form.dart';
import 'package:alcool_gasolina/widgets/sucess.widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Color color = Colors.deepPurple;
  var gasCtrl = new MoneyMaskedTextController();
  var acCtrl = new MoneyMaskedTextController();
  var busy = false;
  var completed = false;
  var resultText = "Compensa utilizar álcool";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).primaryColor,
        body: AnimatedContainer(
          duration: Duration(
            milliseconds: 1200,
          ),
          color: color,
          child: ListView(
            children: <Widget>[
              Logo(),
              completed
                  ? Success(
                      func: reset,
                      result: resultText,
                    )
                  : SubmitForm(
                      acCtrl: acCtrl,
                      gasCtrl: gasCtrl,
                      busy: busy,
                      func: calculate,
                    )
            ],
          ),
        ));
  }

  Future calculate() {
    double alc = double.parse(
          acCtrl.text.replaceAll(new RegExp(r'[,.]'), ''),
        ) /
        100;

    double gas = double.parse(
          gasCtrl.text.replaceAll(new RegExp(r'[,.]'), ''),
        ) /
        100;

    double res = alc / gas;

    setState(() {
      color = Colors.deepPurpleAccent;
      completed = false;
      busy = true;
    });

    return new Future.delayed(const Duration(seconds: 1), () {
      setState(() {
        if (res >= 0.7) {
          resultText = "Compensa utilizar Gasolina!";
        } else {
          resultText = "Compensa utilizar Álcool!";
        }

        completed = true;
        busy = false;
      });
    });
  }

  reset() {
    setState(() {
      acCtrl = new MoneyMaskedTextController();
      gasCtrl = new MoneyMaskedTextController();
      completed = false;
      busy = false;
      color = Colors.deepPurple;
    });
  }
}
