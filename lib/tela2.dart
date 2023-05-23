import 'package:flutter/material.dart';
import 'package:quizz/main.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';


void main(){
  runApp(Quizz());
}

class Quizz extends StatefulWidget {
  @override
  _QuizzState createState() => _QuizzState();
}

class _QuizzState extends State<Quizz> {

int pergunta =1;
int acertos=0;
int erros=0;
int total=0;

String mensagemfinal="";
String mensagembotao="";

List quiz = [
              {
                "id": "1",
                "Pergunta": "Carregando as perguntas, aguarde...",
                "Respostas": [
                  "carregando",
                  "carregando",
                  "carregando",
                  "carregando"
                ],
                "alternativa_correta": 2
              }
            ];
Future<String> getJSONData() async {
  var response = await http.get(
      Uri.parse("https://apiperguntassenac3.azurewebsites.net/perguntas"),
      headers: {"Accept": "application/json"});
  setState(() {
    quiz = json.decode(response.body);
  });
  return "Dados obtidos com sucesso";
}

@override
void initState() {
  super.initState();
  getJSONData();
}

  @override
  Widget build(BuildContext context) {
  void respondeu (int respostaNumero){
    setState(() {
      print ("Respondeu: $respostaNumero");
      print("Resposta do banco: ${quiz[pergunta-1]['alternativa_correta']}");
      if(pergunta!=quiz.length){
        if (quiz[pergunta-1]['alternativa_correta'] == respostaNumero) {
          print('acertou');
          acertos++;
        } else {
          print('errou');
          erros++;
        }
      }
      print('acertos totais: $acertos erros totais: $erros');
      print(quiz.length);

      if (pergunta == quiz.length) {
        total=acertos+1;
        if(acertos==0){
          print('Terminou o Quiz');
          mensagemfinal="Você acertou: $acertos";
          mensagembotao="Voltar";
        }else{
          mensagemfinal="Você acertou: $total";
          mensagembotao="Voltar";
        }
      } else {
        pergunta++;
      }
    });
  }

    return MaterialApp(
      title: 'Quizz',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(

        primarySwatch: Colors.indigo,
      ),
      home: Scaffold(
        backgroundColor: Color(0xff03DAC5),
        appBar:AppBar(
            title: Center(child: Text("Quizz "),),
            leading: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () => Navigator.pop(context),
            ),
        ),


        body: Padding(
          padding: EdgeInsets.all(18.0),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Align(
                  alignment: Alignment.center,
                  child:Text(mensagemfinal,style:TextStyle(fontSize: 20),),
                ),
                Align(
                  alignment: Alignment.topRight,
                  child:Text('Pergunta $pergunta de ${quiz.length}'),
                ),
                Text("Pergunta: "+quiz[pergunta-1]['Pergunta'],
                style:TextStyle(fontSize: 20),
                ),

                TextButton(
                  style: TextButton.styleFrom(
                      backgroundColor: Color(0xFF1E88E5),
                      foregroundColor: Colors.white,
                      padding: EdgeInsets.all(16),
                      minimumSize: Size(MediaQuery.of(context).size.width*0.8,0),
                  ),
                  onPressed:(){
                    print("Botão 01 pressionado");
                    respondeu(0);
                  }
                  , child: Text( quiz[pergunta-1]['Respostas'][0], style: TextStyle(fontSize: 20),),
                ),


                TextButton(
                  style: TextButton.styleFrom(
                    backgroundColor: Color(0xFF1E88E5),
                    foregroundColor: Colors.white,
                    padding: EdgeInsets.all(16),
                    minimumSize: Size(MediaQuery.of(context).size.width*0.8,0),
                  ),
                  onPressed:(){
                    print("Botão 02 pressionado");
                    respondeu(1);
                  }
                  , child: Text( quiz[pergunta-1]['Respostas'][1], style: TextStyle(fontSize: 20),),
                ),


                TextButton(
                  style: TextButton.styleFrom(
                    backgroundColor: Color(0xFF1E88E5),
                    foregroundColor: Colors.white,
                    padding: EdgeInsets.all(16),
                    minimumSize: Size(MediaQuery.of(context).size.width*0.8,0),
                  ),
                  onPressed:(){
                    print("Botão 03 pressionado");
                    respondeu(2);
                  }
                  , child: Text( quiz[pergunta-1]['Respostas'][2], style: TextStyle(fontSize: 20),),

                ),

                TextButton(
                  style: TextButton.styleFrom(
                    backgroundColor: Color(0xFF1E88E5),
                    foregroundColor: Colors.white,
                    padding: EdgeInsets.all(16),
                    minimumSize: Size(MediaQuery.of(context).size.width*0.8,0),
                  ),
                  onPressed:(){
                    print("Botão 04 pressionado");
                    respondeu(3);
                  }
                  , child: Text( quiz[pergunta-1]['Respostas'][3], style: TextStyle(fontSize: 20),),
                ),

                TextButton(
                  onPressed: (){
                    print("Botão Sair pressionado");
                    Navigator.push(
                      context,
                      new MaterialPageRoute(builder: (context) => new HomePage()),
                    );
                  },
                  child: Text(mensagembotao),
                ),

              ],
            ),
          ),
        ),

      ),
    );

  }
}
