import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'administracao.dart';
import 'dart:convert';

class Atualizar extends StatefulWidget {

  final String id;

  const Atualizar({
    Key? key,
    required this.id,
  }) : super(key: key);

  @override
  _AtualizarState createState() => _AtualizarState();
}

class _AtualizarState extends State<Atualizar> {
  final formKey = GlobalKey<FormState>();
  final perguntaController = TextEditingController();
  final resposta1Controller = TextEditingController();
  final resposta2Controller = TextEditingController();
  final resposta3Controller = TextEditingController();
  final resposta4Controller = TextEditingController();
  final alternativaCorretaController = TextEditingController();

  @override
  void initState() {
    super.initState();

    // Faz uma requisição GET para obter os dados da pergunta
    final url = Uri.parse('https://apiperguntassenac3.azurewebsites.net/perguntas/${widget.id}');
    http.get(url).then((response) {
      if (response.statusCode == 200) {
        final data = json.decode(response.body)[0];
        setState(() {
          print(data);

          // Preenche os campos do formulário com os valores recuperados
          perguntaController.text = data['pergunta'];
          resposta1Controller.text = data['resposta1'];
          resposta2Controller.text = data['resposta2'];
          resposta3Controller.text = data['resposta3'];
          resposta4Controller.text = data['resposta4'];
          alternativaCorretaController.text = data['alternativacorreta'].toString();
        });
      } else {
        print('Falha ao carregar a pergunta');
      }
    });
  }

  Future<void> submitForm() async {
    final url = Uri.parse('https://apiperguntassenac3.azurewebsites.net/perguntas/${widget.id}');
    final response = await http.put(
      url,
      body: {
        'pergunta': perguntaController.text,
        'resposta1': resposta1Controller.text,
        'resposta2': resposta2Controller.text,
        'resposta3': resposta3Controller.text,
        'resposta4': resposta4Controller.text,
        'alternativacorreta': alternativaCorretaController.text,
      },
    );

    if (response.statusCode == 200) {
      // Pergunta atualizada com sucesso
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => Administracao()),
      );
    } else {
      // Falha ao atualizar pergunta
      print('Erro ao atualizar');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xff03DAC5),
        appBar: AppBar(
          title: Text('Atualizar'),
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () => Navigator.pop(context),
          ),
        ),
        body: SingleChildScrollView(
        child: Form(
        key: formKey,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
            TextFormField(
            controller: perguntaController,
            decoration: InputDecoration(labelText: 'Pergunta: '),
            ),
            TextFormField(
            controller: resposta1Controller,
            decoration: InputDecoration(labelText: 'Resposta 1: '),
            ),
            TextFormField(
            controller: resposta2Controller,
            decoration: InputDecoration(labelText: 'Resposta 2: '),
            ),
            TextFormField(
            controller: resposta3Controller,
            decoration: InputDecoration(labelText: 'Resposta 3: '),
            ),
            TextFormField(
            controller: resposta4Controller,
            decoration: InputDecoration(labelText: 'Resposta 4: '),
            ),
            TextFormField(
              controller: alternativaCorretaController,
              decoration: InputDecoration(labelText: 'Alternativa Corrreta: '),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              style: TextButton.styleFrom(
                backgroundColor: Color(0xFF1E88E5),
                foregroundColor: Colors.white,
                padding: EdgeInsets.all(16),
                minimumSize: Size(MediaQuery.of(context).size.width*0.8,0),
              ),
              onPressed: () {
                submitForm();
              },
              child: Text('Salvar'),
            ),
          ],
          ),
        ),
        ),
        ),
    );
  }
}