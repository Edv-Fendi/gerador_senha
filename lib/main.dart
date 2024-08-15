import 'dart:math';

import 'package:flutter/material.dart';

void main() {
  runApp(GeradorSenhasApp());
}

class GeradorSenhasAppState extends State<GeradorSenhasApp> {
  bool maiusculas = true;
  bool minusculas = true;
  bool numeros = true;
  bool caracterespecial = true;
  double range = 6;
  String pass = "";
  double senhaForca = 0;

  var options = ['Senha Fraca', 'Senha Media','Senha Forte'];

  var passStrength = Text('Senha Fraca', style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold),)  ;
      

  void geradorPasswordState() {
    setState(() {
      pass = geradorPassword();
      senhaForca = avaliarForcaSenha(pass);
    });
  }

  String geradorPassword() {
    List<String> charList = <String>[
      maiusculas ? 'ABCDEFGHIJKLMNOPQRSTUVWXYZ' : '',
      minusculas ? 'abcdefghijklmnopqrstuvwxyz' : '',
      numeros ? '0123456789' : '',
      caracterespecial ? '!@#\$%*-=+,.<>;:/?()' : ''
    ];

    final String chars = charList.join('');
    Random rnd = Random();

    return String.fromCharCodes(Iterable.generate(
        range.round(), (_) => chars.codeUnitAt(rnd.nextInt(chars.length))));
  }

  double avaliarForcaSenha(String senha) {
    double pontos = 0;

    if (senha.length >= 8) pontos += 1; 
    if (maiusculas && senha.contains(RegExp(r'[A-Z]'))) pontos += 1;
    if (minusculas && senha.contains(RegExp(r'[a-z]'))) pontos += 1;
    if (numeros && senha.contains(RegExp(r'[0-9]'))) pontos += 1;
   if (caracterespecial && senha.contains(RegExp(r'[!@#\$%*-=+,.<>;:/?()]'))) pontos += 1;


    if( pontos <= 2 ){
      setState(() {
        passStrength = Text(options[0], style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold),)  ;
      });
    } 
     if (
      pontos >= 3 && pontos <= 4
    ) {
      setState(() {
        passStrength = Text(options[1], style: TextStyle(color: Colors.amber, fontWeight: FontWeight.bold),)  ;
      });
    }
    if (pontos >4){
      setState(() {
        passStrength = Text(options[2], style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),)  ;
      });
    }

    return pontos;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
      appBar: AppBar(
        title: const Text('Gerador de Senhas'),
      ),
      body: Column(
        children: [
          sizedBoxImg(),
          TextoMaior(),
          TextoMenor(),
          sizedBox(),
          opcoes(),
          SizedBox(),
          slider(),
          botao(),
          sizedBox(),
          resultado(),
          passStrength,
          forca(),

        ],
      ),
    ));
  }

  Widget sizedBoxImg() {
    return SizedBox(
      height: 200,
      width: 200,
      child: Image.network(
          'https://cdn.pixabay.com/photo/2013/04/01/09/02/read-only-98443_1280.png'),
    );
  }

  Widget TextoMaior() {
    return const Text(
      'Gerador de Senhas Automatico',
      style: TextStyle(fontSize: 32, fontWeight: FontWeight.w500),
      textAlign: TextAlign.center,
    );
  }

  Widget TextoMenor() {
    return const Text(
      'Aqui voce escolhe como deseja gerar sua senha',
      style: TextStyle(fontSize: 24, fontWeight: FontWeight.w400),
      textAlign: TextAlign.center,
    );
  }

  Widget opcoes() {
    return Row(children: [
      Checkbox(
          value: maiusculas,
          onChanged: (bool? value) {
            setState(() {
              maiusculas = value!;
            });
          }),
      Text('[A-Z]'),
      Checkbox(
          value: minusculas,
          onChanged: (bool? value) {
            setState(() {
              minusculas = value!;
            });
          }),
      Text('[a-z]'),
      Checkbox(
          value: numeros,
          onChanged: (bool? value) {
            setState(() {
              numeros = value!;
            });
          }),
      Text('[0-9]'),
      Checkbox(
          value: caracterespecial,
          onChanged: (bool? value) {
            setState(() {
              caracterespecial = value!;
            });
          }),
      Text('[@#!]'),
    ]);
  }

  Widget botao() {
    return Container(
      height: 50,
      padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
      child: ElevatedButton(
        child: const Text('Gerar Senha'),
        onPressed: geradorPasswordState,
      ),
    );
  }

  Widget sizedBox() {
    return SizedBox(
      height: 30,
    );
  }

  Widget slider() {
    return Slider(
        value: range,
        max: 50,
        divisions: 50,
        label: range.round().toString(),
        onChanged: (double newRange) {
          setState(() {
            range = newRange;
          });
        });
  }

    Widget forca(){
    return Slider(
        value: senhaForca,
        max: 5,
        divisions: 5,
        label: range.round().toString(),
        onChanged: null
        );
    }

  Widget resultado() {
    return Container(
      height: 50,
      width: MediaQuery.of(context).size.width * .70,
      decoration: BoxDecoration(
          color: Colors.black12, borderRadius: BorderRadius.circular(5)),
      child: Center(
        child: Text(
          pass,
          style: TextStyle(
              fontWeight: FontWeight.bold, fontSize: 20, color: Colors.black),
        ),
      ),
    );
  }


}

class GeradorSenhasApp extends StatefulWidget {
  @override
  GeradorSenhasAppState createState() {
    return GeradorSenhasAppState();
  }
}
