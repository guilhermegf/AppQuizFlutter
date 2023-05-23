import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'adicionar.dart';
import 'atualizar.dart';

class Administracao extends StatefulWidget {
  @override
  _AdministracaoState createState() => _AdministracaoState();
}

class _AdministracaoState extends State<Administracao> {
  List<dynamic> perguntas = [];

  @override
  void initState() {
    super.initState();
    _carregarPerguntas();
  }

  Future<void> _carregarPerguntas() async {
    final response = await http.get(Uri.parse('https://apiperguntassenac3.azurewebsites.net/perguntas_administracao'));
    final data = jsonDecode(response.body);
    setState(() {
      perguntas = data;
    });
  }

  Future<void> excluirPergunta(String id) async {
    final response = await http.delete(
        Uri.parse('https://apiperguntassenac3.azurewebsites.net/perguntas/$id'));
    if (response.statusCode == 200) {
      setState(() {
        perguntas.removeWhere((pergunta) => pergunta['id'].toString() == id);
      });
    } else {
      print('Não foi possível exluir');
    }
  }

  Future<void> adicionarPergunta() async {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => Adicionar()),
    );
  }

  Future<void> atualizarPergunta(String id) async {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => Atualizar(id: id)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Administração',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.indigo,
        backgroundColor: Color(0xff03DAC5),
      ),
      home: Scaffold(
        backgroundColor: Color(0xff03DAC5),
        appBar: AppBar(
          title: Text('Administração'),
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () => Navigator.pop(context),
          ),
        ),
        body: SingleChildScrollView(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 20),
                ElevatedButton(
                  style: TextButton.styleFrom(
                    backgroundColor: Color(0xFF1E88E5),
                    foregroundColor: Colors.white,
                    padding: EdgeInsets.all(16),
                    minimumSize: Size(MediaQuery.of(context).size.width*0.8,0),
                  ),
                  onPressed: adicionarPergunta,
                  child: Text('Adicionar pergunta'),
                ),
                SizedBox(height: 20),
                DataTable(
                  columns: [
                    DataColumn(label: Text('ID')),
                    DataColumn(label: Text('Pergunta')),
                    DataColumn(label: Text('Ações')),
                  ],
                  rows: perguntas.map((pergunta) {
                    return DataRow(cells: [
                      DataCell(Text(pergunta['id'].toString())),
                      DataCell(
                        Text(
                          pergunta['Pergunta'],
                          style: TextStyle(fontSize: 12),
                        ),
                      ),
                      DataCell(Row(
                        children: [
                          IconButton(
                            icon: Icon(Icons.edit),
                            onPressed: () => atualizarPergunta(pergunta['id'].toString()),
                          ),
                          IconButton(
                            icon: Icon(Icons.delete),
                            onPressed: () => excluirPergunta(pergunta['id'].toString()),
                          ),
                        ],
                      )),
                    ]);
                  }).toList(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}