import 'dart:io';

import 'package:as_demo1/musicBar.dart';
import 'package:as_demo1/pages/home.dart';
import 'package:as_demo1/pages/musicList.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:permission_handler/permission_handler.dart';
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

Future<void> main() async {
  runApp(ChangeNotifierProvider<DataModel>(
    create: (context) => DataModel(),
    child: const MyApp(),
  ));
  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(
      systemNavigationBarColor: Colors.white.withOpacity(0), // 根据主题设置底栏颜色
      statusBarColor: Colors.white.withOpacity(0), // 如果想要状态栏透明，可以设置为透明色
    ),
  );
  // 让 Flutter 在导航栏后面绘制
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
  //获取读写外部存储权限
  WidgetsFlutterBinding.ensureInitialized();
  var permissionStatus = await Permission.storage.request();
  if(permissionStatus.isDenied) {
    permissionStatus = await Permission.storage.request();
  }
  Directory dir = Directory('/storage/emulated/0/');
  if(dir.existsSync()) {
    if (kDebugMode) {
      print('已获取到外部存储权限');
    }
  } else {
    Fluttertoast.showToast(
      msg: '无法获取到外部存储权限，请手动打开应用权限!',
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.CENTER,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.red,
      textColor: Colors.white,
      fontSize: 16.0,
    );
    }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '多彩音乐',
      debugShowCheckedModeBanner: false,
      debugShowMaterialGrid: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: const MainPage(),
    );
  }
}

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    return Consumer<DataModel>(
      builder: (context, dataModel, _) {
        return Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                Colors.blue.withOpacity(0.5),
                Colors.white,
              ])),
          child: Scaffold(
            backgroundColor: Colors.white.withOpacity(0),
            body: DataModel._widgetOptions.elementAt(dataModel.selectedIndex),
            bottomNavigationBar: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    children: [
                      MusicPlayerBar(),
                    ],
                  ),
                  ClipRect(
                    child: BackdropFilter(
                      filter: ui.ImageFilter.blur(sigmaX: 20, sigmaY: 20),
                      child: BottomNavigationBar(
                        elevation: 0,
                        backgroundColor: Colors.white.withOpacity(0),
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
                            label: '均衡器',
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
          ),
        );
      },
    );
  }
}
