import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'administracao.dart';


class Adicionar extends StatefulWidget {
  @override
  _AdicionarState createState() => _AdicionarState();
}

class _AdicionarState extends State<Adicionar> {
  final _formKey = GlobalKey<FormState>();
  final _perguntaController = TextEditingController();
  final _resposta1Controller = TextEditingController();
  final _resposta2Controller = TextEditingController();
  final _resposta3Controller = TextEditingController();
  final _resposta4Controller = TextEditingController();
  final _alternativaCorretaController = TextEditingController();

  Future<void> _submitForm() async {
    final url = Uri.parse('https://apiperguntassenac3.azurewebsites.net/perguntas');
    final response = await http.post(
      url,
      body: {
        'pergunta': _perguntaController.text,
        'resposta1': _resposta1Controller.text,
        'resposta2': _resposta2Controller.text,
        'resposta3': _resposta3Controller.text,
        'resposta4': _resposta4Controller.text,
        'alternativacorreta': _alternativaCorretaController.text,
      },
    );

    print(response.statusCode);

    if (response.statusCode == 200) {
      // Pergunta criada com sucesso
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => Administracao()),
      );
    } else {
      // Falha ao criar pergunta
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: Text('Erro'),
          content: Text('Ocorreu um erro ao criar a pergunta.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('OK'),
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff03DAC5),
      appBar: AppBar(
        title: Text('Adicionar pergunta'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                TextFormField(
                  controller: _perguntaController,
                  decoration: InputDecoration(labelText: 'Pergunta'),
                ),
                TextFormField(
                  controller: _resposta1Controller,
                  decoration: InputDecoration(labelText: 'Resposta 1'),
                ),
                TextFormField(
                  controller: _resposta2Controller,
                  decoration: InputDecoration(labelText: 'Resposta 2'),
                ),
                TextFormField(
                  controller: _resposta3Controller,
                  decoration: InputDecoration(labelText: 'Resposta 3'),
                ),
                TextFormField(
                  controller: _resposta4Controller,
                  decoration: InputDecoration(labelText: 'Resposta 4'),
                ),

                TextFormField(
                  controller: _alternativaCorretaController,
                  decoration: InputDecoration(
                    labelText: 'Alternativa correta',
                  ),
                  keyboardType: TextInputType.number,
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp(r'[0-4]')),
                  ],
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
                    _submitForm();
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
