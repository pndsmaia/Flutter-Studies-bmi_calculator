import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    title: 'BMI Calculator',
    home: Home(),
  ));
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  double _bmi = 0;
  String _info = 'Preencha com suas informações!';
  TextEditingController weightController = TextEditingController();
  TextEditingController heightController = TextEditingController();

  void _resetFields() {
    setState(() {
      weightController.text = '';
      heightController.text = '';
      _info = 'Preencha com suas informações!';
    });
  }

  void _calculateBmi(double weight, int height) {
    setState(() {
      _bmi = weight / ((height * height) / 10000);
      if (_bmi >= 18.5 && _bmi <= 24.99) {
        _info =
            'O IMC é: ${_bmi.toStringAsFixed(2)}.\n Você está no peso ideal!';
      } else if (_bmi >= 25 && _bmi <= 29.99) {
        _info =
            'O IMC é: ${_bmi.toStringAsFixed(2)}.\n Você está com Sobrepeso!';
      } else if (_bmi >= 30 && _bmi <= 34.99) {
        _info = 'O IMC é: ${_bmi.toStringAsFixed(2)}.\n Obesidade grau 1.';
      } else if (_bmi >= 35 && _bmi <= 39.99) {
        _info = 'O IMC é: ${_bmi.toStringAsFixed(2)}.\n Obesidade grau 2.';
      } else if (_bmi >= 40) {
        _info = 'O IMC é: ${_bmi.toStringAsFixed(2)}.\n Obesidade grau 3.';
      } else {
        _info =
            'O IMC é: ${_bmi.toStringAsFixed(2)}.\n Você está abaixo do peso!';
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.green,
          title: Text(
            'Calculadora de IMC',
            style: TextStyle(color: Colors.white),
          ),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.refresh),
              onPressed: _resetFields,
            ),
          ],
        ),
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
            child: Form(
                key: _formKey,
                child: Column(
                  children: <Widget>[
                    Icon(
                      Icons.person_outline,
                      size: 120,
                      color: Colors.green,
                    ),
                    TextFormField(
                      keyboardType: TextInputType.number,
                      maxLength: 3,
                      controller: weightController,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.all(5),
                        labelText: 'Peso(Kg):',
                        labelStyle: TextStyle(color: Colors.green),
                      ),
                      cursorColor: Colors.grey,
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.grey, fontSize: 22),
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Coloque seu peso!';
                        }
                      },
                    ),
                    TextFormField(
                      keyboardType: TextInputType.number,
                      maxLength: 3,
                      controller: heightController,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.all(5),
                        labelText: 'Altura(Cm):',
                        labelStyle: TextStyle(color: Colors.green),
                      ),
                      cursorColor: Colors.grey,
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.grey, fontSize: 22),
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Coloque sua altura!';
                        }
                      },
                    ),
                    RaisedButton(
                      onPressed: () {
                        if (_formKey.currentState.validate()) {
                          _calculateBmi(double.parse(weightController.text),
                              int.parse(heightController.text));
                        }
                      },
                      color: Colors.green,
                      child: Text(
                        'Calcular',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    Text(
                      '$_info',
                      style: TextStyle(color: Colors.green, fontSize: 22),
                      textAlign: TextAlign.center,
                    )
                  ],
                ))));
  }
}
