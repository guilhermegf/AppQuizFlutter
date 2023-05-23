import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'administracao.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  String _errorMessage = '';

  Future<void> _handleLogin(BuildContext context) async {
    final String apiUrl = 'https://apiperguntassenac3.azurewebsites.net/login';

    String username = _usernameController.text;
    String password = _passwordController.text;

    Map<String, dynamic> payload = {
      'login': username,
      'senha': password
    };

    try {
      http.Response response = await http.post(
        Uri.parse(apiUrl),
        body: json.encode(payload),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        print('Login bem-sucedido');
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Administracao()),
        );
      } else {
        print('Credenciais inválidas');
        setState(() {
          _errorMessage = 'Credenciais inválidas';
        });
      }
    } catch (exception) {
      print('Erro na autenticação: $exception');
      setState(() {
        _errorMessage = 'Erro na autenticação: $exception';
      });
    }
    print(payload);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Login',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.indigo,
        backgroundColor: Color(0xff03DAC5),
      ),
      home: Scaffold(
        backgroundColor: Color(0xff03DAC5),
        appBar: AppBar(
          title: Text('Login'),
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () => Navigator.pop(context),
          ),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Image.asset(
                "assets/quizzzz.png",
                width: 300,
              ),
              TextField(
              controller: _usernameController,
              decoration: InputDecoration(
                hintText: 'Digite seu usuário',
              ),
            ),
              SizedBox(height: 20),
              TextField(
                controller: _passwordController,
                obscureText: true,
                decoration: InputDecoration(
                  hintText: 'Digite sua senha',
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                style: TextButton.styleFrom(
                  backgroundColor: Color(0xFF1E88E5),
                  foregroundColor: Colors.white,
                  padding: EdgeInsets.all(16),
                  minimumSize: Size(MediaQuery.of(context).size.width*0.8,0),
                ),
                onPressed: () {
                  _handleLogin(context); // Chamar o método de login ao pressionar o botão
                },
                child: Text('Entrar'),
              ),
              SizedBox(height: 10),
              Text(
                _errorMessage,
                style: TextStyle(
                  color: Colors.red,
                  fontSize: 16,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
