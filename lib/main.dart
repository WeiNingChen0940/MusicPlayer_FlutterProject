import 'dart:io';
import 'package:as_demo1/pages/home_all.dart';
import 'package:audio_metadata_reader/audio_metadata_reader.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
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
import 'package:sqflite/sqflite.dart';
import 'package:as_demo1/databaseControl.dart';
import 'package:flutter_soloud/flutter_soloud.dart';
class DataModel with ChangeNotifier {
  var pagesIndex = [0, 1, 1];
  static final List<Widget> _pages = <Widget>[
    const HomePage(),
    const MusicListPage(),
    const HomeAll(),
  ];
  int songsIndex = 0;
  String songTitle = '';
  String songArtist = '';

  void changePagesIndex(List<int> list) {
    pagesIndex = list;
    notifyListeners();
  }

  int selectedIndex = 0;
  var databaseControl = DatabaseControl();
  List<String> songs = [];
  var soLoud = SoLoud.instance;
  late Future<AudioSource> _source;
  late AudioSource source;
  late Future<SoundHandle> _handle;
  late SoundHandle handle;
  bool isPlaying = false;
  Future<void> ready2PlaySong() async {
    await soLoud.init();

    source = await soLoud.loadFile(songs.elementAt(songsIndex));
    //Fluttertoast.showToast(msg: 'ready: ${songs.elementAt(songsIndex)}');
    _handle = soLoud.play(source);
    soLoud.setPause(handle, false);

    notifyListeners();
  }

  Future<void> play() async {
    Fluttertoast.showToast(msg: 'play');
    //Fluttertoast.showToast(msg: 'isP:$isPlaying');
    soLoud.setPause(handle, false);
    handle = await _handle;
    isPlaying = true;
    var fil = soLoud.getFilterParamNames(FilterType.eqFilter);

    int i =0;
    for(;i<fil.length;i++){
      var filI = soLoud.getFilterParameter(FilterType.eqFilter, i);
      print('fil:${fil[i]} -- $filI');
    }

    notifyListeners();
  }

  Future<void> pause() async {
    Fluttertoast.showToast(msg: 'pause');
    soLoud.setPause(handle, true);
    isPlaying = false;
    //Fluttertoast.showToast(msg: 'isP:$isPlaying');
    notifyListeners();
  }

  Future<void> changeIndex(int index) async {
    songsIndex = index;
    var metaData = await readMetadata(File(songs.elementAt(index)));
    songTitle = metaData.title!;
    songArtist = metaData.artist!;
    notifyListeners();
  }

  Future<void> getSongs() async {
    songs = [];
    var settings = await databaseControl.getSettings();
    var songDirs = [
      for (var i in settings)
        if (i.name.startsWith('musicDir')) i.stringValue
    ];
    print('songsDirs:${songDirs.length}');
    for (var i in songDirs) {
      for (var j in Directory(i).listSync(recursive: true)) {
        if (j.path.endsWith('.mp3') ||
            j.path.endsWith('.flac') ||
            j.path.endsWith('.ogg')) {
          var metaData = await readMetadata(File(j.path));
          if (metaData.duration!.inSeconds < 90) {
            continue;
          }
          songs.add(j.path);
        }
      }
    }
    // songs.sort((a, b) =>
    //     File(a).lastModifiedSync().compareTo(File(b).lastModifiedSync()));
    print('songsLen${songs.length}');
    for (var i in songs) {
      print('songs:$i');
      //Fluttertoast.showToast(msg: 'songs:${i.path}');
    }
  }

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
  if (permissionStatus.isDenied) {
    permissionStatus = await Permission.storage.request();
  } else if (permissionStatus.isGranted) {
    // Fluttertoast.showToast(
    //   msg: '已获取到外部存储权限',
    // );
  }
  if (permissionStatus.isPermanentlyDenied) {
    Fluttertoast.showToast(
      msg: '无法获取到外部存储权限，请手动打开应用权限!',
    );
  }
  Directory sdDir = Directory('/storage/emulated/0/');
  var li = await sdDir.listSync();

  var myDir = await getApplicationDocumentsDirectory();
  var isFirstOpen = await Directory('${myDir.path}/isFirstOpen.txt').exists();
  if (isFirstOpen == false) //第一次打开
  {
    await Directory('${myDir.path}/isFirstOpen.txt').create();
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    Provider.of<DataModel>(context, listen: false).getSongs();
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
            body: DataModel._pages.elementAt(
                dataModel.pagesIndex.elementAt(dataModel.selectedIndex)),
            bottomNavigationBar: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                mainAxisSize: MainAxisSize.min,
                children: [
                  MusicBar(),
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
                          dataModel.onItemTapped(index);
                          if(index == 0){
                            dataModel.changePagesIndex([0,1,1]);
                          }
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
