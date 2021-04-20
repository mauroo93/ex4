
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MovieFlix',
      theme: ThemeData(
        brightness: Brightness.dark,
      ),
      debugShowCheckedModeBanner: false,
      home: MyHomePage(title: 'MovieFlix'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Card> cards;
  List<Card> titulos;
  List<String> title=['Ola','Hello','Oye'];
  File _image;
  Future erro;
  final picker = ImagePicker();


  void initState() {
    super.initState();
    cards = _buildCardTile(11); //Contém os cards de filmes.
    titulos =  _buildCardTitleTile(3);
  }

  /*
  /Esta funcao gera uma lista de Cards baseado 
  /nos arquivos movie0.jpg até movie10.jpg.
  */

  Future getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
        cards.add(Card(child:Image.file(_image)));
        return 1;
      } else {
        print('No image selected.');
        return 2;
      }
    });
  }

  List<Card> _buildCardTile(int count) => List.generate(
        count,
        (i) => Card(
          child: Image.asset('movies/movie$i.jpg'),
        ),
      );
  List<Card> _buildCardTitleTile(int count) => List.generate(
    count,
        (i) => Card(
      child: Text(title[i]),
    ),
  );

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Column(children: [
        Expanded(
            child: SizedBox(

                height: 30,
                child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: cards.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Container(child: cards[index]);
                    }))),
        Expanded(
            child: SizedBox(
                height: 100,
                child: ListView.builder(
                    scrollDirection: Axis.vertical,
                    itemCount: titulos.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Container(child:titulos[index]);
                    }))),
        ElevatedButton(
            onPressed: ()=>{
              getImage()
            },
            child: Icon(Icons.add))
      ]),

      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0,
        items: [
          BottomNavigationBarItem(
            icon: new Icon(Icons.movie),
            title: new Text('Watch'),
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.search), title: Text('Search')),
          BottomNavigationBarItem(
              icon: Icon(Icons.person), title: Text('Profile')),

        ],
      ),
    );
  }
}
