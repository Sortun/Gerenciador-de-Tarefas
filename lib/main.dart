   
import 'package:flutter/material.dart';

TextEditingController txtTitulo = TextEditingController();
TextEditingController txtSubtitulo = TextEditingController();
TextEditingController txtQuery = TextEditingController();

double borderGeral = 5.0;
double paddingGeral = 10;
Color colorGeral = const Color.fromARGB(0xFF, 0x41, 0x69, 0xE1);
Color txtGeral = const Color.fromARGB(255, 196, 196, 196);

class Content {
  String titulo, subtitulo;
  Content({required this.titulo, required this.subtitulo});
}

List<Content> conteudo = [];

List<Content> lista = [];



void main() {
  runApp(const MyApp());
  lista = conteudo;
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(title: 'Flutter', home: MyHomePage());
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  void search(String query) {
    if (query.isEmpty){
      lista = conteudo;
      setState(() {});
      return;
    }

    query = query.toLowerCase();
    List<Content> consulta = [];
    for (var u in lista){
      var name = u.titulo.toString().toLowerCase();
      if (name.contains(query)) {
        consulta.add(u);
      }
    }
    lista = consulta;
    setState(() {});
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Agenda de Tarefas'),
          leading: const Icon(Icons.task),
        backgroundColor: colorGeral,),

        body: Padding 
        (padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(
              controller: txtTitulo,
              keyboardType: TextInputType.text,
              cursorColor:colorGeral,
              decoration: InputDecoration(
                labelText: "Tarefa",
                labelStyle: TextStyle(color: colorGeral),
                focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: txtGeral)),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(borderGeral)),
           ))),

            SizedBox(height: paddingGeral),

            TextField(
                controller: txtSubtitulo,
                keyboardType: TextInputType.text,
                cursorColor:colorGeral,
                decoration: InputDecoration(
                  labelText: "Descrição",
                  labelStyle: TextStyle(color: colorGeral),
                  focusedBorder: OutlineInputBorder( 
                  borderSide: BorderSide(color: txtGeral)),
                  border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(borderGeral),
                  )))),
            SizedBox(height: paddingGeral),

            ElevatedButton(style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(colorGeral),
            ),
              child: const Text("Adicionar Tarefa"),
              onPressed: () {
              Content content = Content(
                titulo: txtTitulo.text, subtitulo: txtSubtitulo.text);
              conteudo.add(content);
              txtTitulo.text ="";
              txtSubtitulo.text = "";
              setState(() {});
            }),
            SizedBox(height: paddingGeral),
            
            TextFormField(
              controller: txtQuery,
              onChanged: search,
              cursorColor:colorGeral,
              decoration: InputDecoration(
                focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: txtGeral)),
                hintText: "Pesquisar",
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
              prefixIcon: Icon(Icons.search, color: colorGeral),  
              suffixIcon: IconButton(icon: const Icon(Icons.clear), color: colorGeral,
              onPressed: () {
                txtQuery.text = '';
                search(txtQuery.text);
              }))),
              SizedBox(height: paddingGeral),
              
            Expanded(
            child: ListView.builder(
              itemCount: lista.length,
              itemBuilder: (context, index) {
                return Card(
                 child: ListTile(
                  onTap: () {
                    txtTitulo.text = conteudo[index].titulo;
                    txtSubtitulo.text = conteudo[index].subtitulo;
                  },
                      leading: CircleAvatar(
                        backgroundColor: colorGeral,
                        foregroundColor: Colors.white, 
                        child:  Text(lista[index].titulo.substring(0, 2))),
                        title: Text("Tarefa: ${lista[index].titulo}"), 
                        subtitle: Text("Descrição: ${lista[index].subtitulo}"),
                        trailing: 
                        Row(mainAxisSize: MainAxisSize.min, children: [
                          IconButton(icon: const Icon(Icons.search),
                          onPressed: () {
                            Widget okbutton = ElevatedButton(
                              style: ButtonStyle(
                             backgroundColor: MaterialStateProperty.all<Color>(colorGeral)),
                              child: const Icon(Icons.check),
                            onPressed: () {
                              Navigator.of(context).pop();
                            });
                            showDialog(context: context,
                              builder: (context) {
                                return AlertDialog(
                                  title: Text("Tarefa: ${lista[index].titulo}"), 
                                  content: Text("Descrição: ${lista[index].subtitulo}"), 
                                  actions: [okbutton,],
                                );
                              });
                          }),
                          IconButton(icon: const Icon(Icons.edit),
                          onPressed: () { 
                            conteudo[index].titulo = txtTitulo.text;
                            conteudo[index].subtitulo = txtSubtitulo.text;
                            txtTitulo.text = '';
                            txtSubtitulo.text = '';
                            setState(() {});
                            }),

                          IconButton(icon: const Icon(Icons.delete),
                          onPressed: (){
                            conteudo.remove(conteudo[index]);
                            setState(() {});
                          }),
                        ])));
              })),

           FloatingActionButton(
              backgroundColor: (colorGeral),
            child: const Icon(Icons.clear), onPressed: () {
            txtQuery.clear();
            txtSubtitulo.text ="";
            txtTitulo.text ="";
            search(txtQuery.text);
           })   
        ],
      ),
    ));
  }
}
