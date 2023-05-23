import 'package:flutter/material.dart';
import 'package:quizz/tela2.dart';
import 'package:quizz/login.dart';

void main() {
  runApp(MaterialApp(debugShowCheckedModeBanner: false, home: HomePage()));
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Quizz',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.indigo,
      ),
      home: Scaffold(
        backgroundColor: Color(0xff03DAC5),
        appBar: AppBar(
          title: Center(child: Text("Quizz")),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.settings),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Login()),
                );
              },
            ),
          ],
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Image.asset(
                "assets/quizzzz.png",
                width: 300,
              ),
              Image.asset(
                "assets/logopenguin.png",
                width: 160,
              ),
              Text(
                "Está preparado?",
                style: TextStyle(fontSize: 25),
              ),
              TextButton(
                style: ButtonStyle(
                  foregroundColor:
                  MaterialStateProperty.all<Color>(Colors.white),
                  backgroundColor:
                  MaterialStateProperty.all<Color>(Color(0xff3700B3)),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18),
                      side: BorderSide(color: Colors.indigo),
                    ),
                  ),
                ),
                onPressed: () {
                  print("oi");
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Quizz()),
                  );
                },
                child: Text(
                  "JOGAR",
                  style: TextStyle(fontSize: 50),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
