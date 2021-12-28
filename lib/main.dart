// import 'package:flutter/material.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// void main() {
//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'モバイル端末保存',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       home: MyHomePage(),
//     );
//   }
// }

// class MyHomePage extends StatefulWidget {
//   const MyHomePage({Key? key}) : super(key: key);

//   @override
//   _MyHomePageState createState() => _MyHomePageState();
// }

// class _MyHomePageState extends State<MyHomePage> {
//   late SharedPreferences prefs;
//   String stuff = '';

//   // create instance
//   Future<void> setInstance() async {
//     prefs = await SharedPreferences.getInstance();
//     //端末機同時に保存されているデータを持ってくる処理
//     getData();
//     setState(() {});
//   }

//   // data warehouse
//   Future<void> setData() async {
//     await prefs.setString('stuff', '8888');
//   }

//   void getData() {
//     stuff = prefs.getString('stuff')!;

//     // Null を避ける
//     // prefs.getInt('stuffA') ?? '';
//   }

//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();

//     setInstance();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('shared preferences'),
//         centerTitle: true,
//       ),
//       body: Center(
//         child: Text(
//           stuff,
//           style: TextStyle(fontSize: 50),
//         ),
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: () {
//           setState(() {
//             setData();
//           });
//         },
//         child: Icon(Icons.add),
//       ),
//     );
//   }
// }



import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'tlmemo',
      theme: ThemeData(),
      home: AppMain(title: 'tlmemo'),
    );
  }
}

class AppMain extends StatefulWidget {
  AppMain({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  _AppMainState createState() => _AppMainState();
}

class _AppMainState extends State<AppMain> {
  //データ編集用のコントローラ
  final redController = TextEditingController();
  final yellowController = TextEditingController();
  final greenController = TextEditingController();
  var isLoaded = false;

  @override
  void initState() {
    super.initState();
    load();
  }

  //データロード用関数*3(loadRed, loadYellow, loadGreen)
  Future<void> load() async {
    final prefs = await SharedPreferences.getInstance();
    redController.text = prefs.getString('red') ?? '';
    yellowController.text = prefs.getString('yellow') ?? '';
    greenController.text = prefs.getString('green') ?? '';
    setState(() {
      isLoaded = true;
    });
  }

  //データ保存用関数*3(saveRed, saveYellow, saveGreen)
  Future<void> save(key, text) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(key, text);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(),
        body: Visibility(
          visible: isLoaded,
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Text(''),
                Text(''),
                Text('tlmemo'),
                Text(''),
                //赤色の部分:緊急/ASAP
                TextField(
                    controller: redController,
                    onChanged: (text) {
                      save('red', text);
                    },
                    minLines: 3,
                    maxLines: 3,
                    maxLength: 150,
                    maxLengthEnforced: true,
                    decoration: InputDecoration(
                      fillColor: Colors.red[200],
                      filled: true,
                      border: OutlineInputBorder(),
                      hintText: '緊急/ASAP',
                    )),

                //黄色の部分:重要/Important
                TextField(
                    controller: yellowController,
                    onChanged: (text) {
                      save('yellow', text);
                    },
                    minLines: 5,
                    maxLines: 5,
                    maxLength: 250,
                    maxLengthEnforced: true,
                    decoration: InputDecoration(
                      fillColor: Colors.yellow[300],
                      filled: true,
                      border: OutlineInputBorder(),
                      hintText: '重要/Important',
                    )),

                //緑色の部分:その他/Other
                TextField(
                    controller: greenController,
                    onChanged: (text) {
                      save('green', text);
                    },
                    minLines: 7,
                    maxLines: 7,
                    maxLength: 350,
                    maxLengthEnforced: true,
                    decoration: InputDecoration(
                      fillColor: Colors.green[300],
                      filled: true,
                      border: OutlineInputBorder(),
                      hintText: 'その他/Other',
                    )),
                Text(''),
                Text(''),
              ],
            ),
          ),
        ));
  }
}