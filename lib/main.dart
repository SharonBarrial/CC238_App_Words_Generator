import 'package:flutter/material.dart';

import 'package:english_words/english_words.dart';



void main() {
  runApp(const MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override

  Widget build(BuildContext context) {

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.green,
        appBarTheme: const AppBarTheme(
          color: Colors.green,  // Color del AppBar en tema claro
        ),
      ),

      themeMode: ThemeMode.dark,

      home: Scaffold(

        body: Center(

          child: RandomWord(),

        ),

      ),

    );

  }

}



class RandomWord extends StatefulWidget {

  const RandomWord({super.key});



  @override

  State<RandomWord> createState() => _RandomWordState();

}



class _RandomWordState extends State<RandomWord> {

  final List<WordPair> suggestions = <WordPair>[];

  final TextStyle biggerfont = TextStyle(fontSize: 18);

  final Set<WordPair> saved = Set<WordPair>();



  @override

  Widget build(BuildContext context) {

    //final WordPair wordPair = WordPair.random();

    //return Text(wordPair.asPascalCase);

    return Scaffold(

      appBar: AppBar(

        title: Text("Startup Generator!"),

        actions: <Widget>[

          IconButton(onPressed: pushSaved, icon: Icon(Icons.list))

        ],

      ),

      body: buildSuggestions(),

    );

  }



  Widget buildSuggestions(){

    return ListView.builder(

        padding: EdgeInsets.all(16),

        itemBuilder: (BuildContext context, int i){

          if (i.isOdd){

            return Divider(

              thickness: 2,

              color: Colors.green,

            );

          }

          final int index = i ~/ 2;

          if (index >= suggestions.length){

            suggestions.addAll(generateWordPairs().take(10));

          }
          return buildRow(suggestions[index]);
        }

    );

  }



  Widget buildRow(WordPair pair) {

    final bool alreadySaved = saved.contains(pair);



    return ListTile(

      title: Text(pair.asPascalCase,

        style: biggerfont,

      ),

      trailing: Icon(

        alreadySaved ? Icons.favorite : Icons.favorite_border,

        color: alreadySaved ? Colors.red : null,

      ),

      onTap: (){

        setState(() {

          if (alreadySaved){

            saved.remove(pair);

          }else{

            saved.add(pair);

          }

        });

      },

    );

  }



  void pushSaved() {
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (BuildContext context) {
          final Iterable<ListTile> tiles = saved.map(
                (WordPair pair) {
              return ListTile(
                title: Text(
                  pair.asPascalCase,
                  style: biggerfont,
                ),
              );
            },
          );

          final List<Widget> divided = ListTile.divideTiles(
            context: context,
            tiles: tiles,
          ).toList();

          return Scaffold(
            appBar: AppBar(
              title: const Text('Mis palabras favoritas'),
            ),
            body: ListView(children: divided),
          );
        },
      ),
    );

  }

}