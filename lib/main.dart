import 'package:flutter/material.dart';
import 'package:flutter_fetch_apidata_example/post_model.dart';
import 'package:flutter_fetch_apidata_example/services.dart';
//import 'package:fluttertoast/fluttertoast.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter API fetcher',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Tesouro'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Future<List<Post>> initPost;
  void initState(){
    super.initState();
    initPost = getAllPosts();
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text("DEMO", style: TextStyle(fontSize: 16.0),),
        backgroundColor: Colors.blueGrey,
        centerTitle: true,
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: Icon(Icons.search),
          )
        ],
        elevation: 0.0,
      ),
      body: FutureBuilder<List<Post>>(
        future: initPost,
        builder: (context, snapshot){
          if(snapshot.connectionState == ConnectionState.done){
            if(snapshot.hasError){
              return ErrorWidget(snapshot.error);
            }
            //String text = "Title from Post JSON: ${snapshot.data.title}" + 
            //" \n \nAnd Body: ${snapshot.data.body}";
            print('Data length: ' + snapshot.data.length.toString());
            return ListView.separated(
              padding: const EdgeInsets.all(8.0),
              itemCount: snapshot.data.length,
              itemBuilder: (BuildContext context, int index){
                return InkWell(
                  onTap: (){
                    /*Fluttertoast.showToast(
                        msg: "Index: " + index.toString() + "\nColorCode: " + colorCode.toString(),
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.CENTER,
                        timeInSecForIos: 2,
                        backgroundColor: Colors.red,
                        textColor: Colors.white,
                        fontSize: 16.0
                    );*/
                    Navigator.push(
                      context, 
                      MaterialPageRoute(builder: (context) => DetailScreen(),
                        settings: RouteSettings(
                          arguments: ScreenArguments(
                            snapshot.data[index].title,
                            snapshot.data[index].body,
                            snapshot.data[index].id,
                          ))
                      ),
                    );
                  },
                  child: new Card(
                    child: new Column(
                      children: <Widget>[
                        new ListTile(
                          leading: new Icon(Icons.description, color: Colors.blue, size: 26.0,),
                          title: new Text(snapshot.data[index].title),
                          subtitle: Text('Index ' + index.toString()),
                        )
                      ],
                    ),
                  ),
                );
              },
              separatorBuilder: (BuildContext context, int index) => const Divider(),
            );
          }
          else{
            return Align(
              alignment: Alignment.topCenter,
              child: CircularProgressIndicator()
            );
          }
        }
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              child: Text(
                'Header', 
                style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
              decoration: BoxDecoration(
                color: Colors.blue
              ),
            ),
            ListTile(
              title: Text('Item 1'),
              onTap: (){
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: Text('Item 2'),
              onTap: (){
                Navigator.pop(context);
              },
            ),
          ],
        )
      ),
    );
  }
}

class DetailScreen extends StatelessWidget {
  static const routeName = '/extractArguments';
  @override
  Widget build(BuildContext context) {
    final ScreenArguments args = ModalRoute.of(context).settings.arguments;
    var stack = Stack(
        children: <Widget>[
          Align(
            alignment: Alignment.bottomCenter,
            child: RaisedButton(
              child: Text('Go Back'),
              onPressed: (){
                Navigator.pop(context);
              },
            ),
          ),
          Align(
            alignment: Alignment.topCenter,
            child: Text('Index ' + args.index.toString())
          ),
          Align(
            alignment: Alignment(0.1, -0.5),
            child: Text('Title: ' + args.title)
          ),
          Align(
            alignment: Alignment(0.1, 0),
            child: Text('Body: ' + args.body)
          )
        ]
        
      );
    return Scaffold(
      appBar: AppBar(
        title: Text('Detail Route'),
      ),
      body: ListView(
        children: <Widget>[
          Align(
            alignment: 
              Alignment.center,
              child: 
                Text(
                  'Item Details',
                  style: TextStyle(
                    fontSize: 26.0,
                    color: Colors.black87
                  ),
              )
          ),

          Container(
            height: 1.5,
            color: Colors.grey,
          ),

          ListTile(
            title: Text(args.title),
            subtitle: Text('Title'),
          ),

          Container(
            height: 1.5,
            color: Colors.grey,
          ),

          ListTile(
            title: Text(args.body),
            subtitle: Text('Text'),
          )

        ],
        
      ),
    );
  }
}

class ScreenArguments {
  final String title;
  final String body;
  final int index;

  ScreenArguments(this.title, this.body, this.index);
}