import 'package:as_demo1/musicBar.dart';
import 'package:as_demo1/pages/home.dart';
import 'package:as_demo1/pages/musicList.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'dart:ui' as ui;

class DataModel with ChangeNotifier {
  static final List<Widget> _widgetOptions = <Widget>[
    const homePage(),
    const musicListPage(),
    const homePage(),
  ];

  static List<Widget> get widgetOptions => _widgetOptions;
  int selectedIndex = 0;

  void onItemTapped(int index) {
    selectedIndex = index;
    notifyListeners();
  }
}

void main() {
  runApp(ChangeNotifierProvider<DataModel>(
    create: (context) => DataModel(),
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      debugShowMaterialGrid: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  void update() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<DataModel>(
      builder: (context, dataModel, _) {
        return Scaffold(
          body: DataModel._widgetOptions.elementAt(dataModel.selectedIndex),
          bottomNavigationBar: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              mainAxisSize: MainAxisSize.min,
              children: [
                const Row(
                  children: [
                    Icon(Icons.music_note),
                    Icon(Icons.music_note),
                    Icon(Icons.music_note),
                  ],
                ),
                ClipRect(
                  child: BackdropFilter(
                    filter: ui.ImageFilter.blur(sigmaX: 20, sigmaY: 20),
                    child: BottomNavigationBar(
                      elevation: 0,
                      backgroundColor: Colors.white10,
                      items: const <BottomNavigationBarItem>[
                        BottomNavigationBarItem(
                          icon: Icon(Icons.music_note_outlined),
                          label: '主页',
                        ),
                        BottomNavigationBarItem(
                          icon: Icon(Icons.queue_music_outlined),
                          label: '播放列表',
                        ),
                        BottomNavigationBarItem(
                          icon: Icon(Icons.graphic_eq_outlined),
                          label: '歌单',
                        ),
                      ],
                      currentIndex: dataModel.selectedIndex,
                      selectedItemColor: Colors.green,
                      onTap: (int index) {
                        setState(() {
                          dataModel.onItemTapped(index);
                        });
                      },
                    ),
                  ),
                ),
              ]),
        );
      },
    );
  }
}
