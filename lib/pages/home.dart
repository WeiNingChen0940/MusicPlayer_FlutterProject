import 'dart:io';

import 'package:as_demo1/databaseControl.dart';
import 'package:as_demo1/pages/list_element_category.dart';
import 'package:audio_metadata_reader/audio_metadata_reader.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

import '../main.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<StatefulWidget> createState() {
    return _HomePageState();
  }
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white.withOpacity(0),
        appBar: AppBar(
          backgroundColor: Colors.white.withOpacity(0),
          title: const Text(
            '主页',
            style: TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold, fontSize: 30),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          tooltip: '重新扫描歌曲',
          onPressed: () async {
            Set<String> musicDir = {};
            int count = 0;
            DataModel dataModel =
                Provider.of<DataModel>(context, listen: false);
            var databaseControl = dataModel.databaseControl;

            await databaseControl.deleteSongs();
            Directory sdDir = Directory('/storage/emulated/0');
            var li = sdDir.listSync();
            for (var i in li) {
              if (i.path != '/storage/emulated/0/Android') {
                print('parent:${i.path}');
                var subI = Directory(i.path).listSync(recursive: true);
                for (var j in subI) {
                  //print('subI:${j.path}');
                  if (j.path.endsWith('.mp3') ||
                      j.path.endsWith('.flac') ||
                      j.path.endsWith('.ogg')) {
                    var metaData = await readMetadata(File(j.path));
                    if (metaData.duration!.inSeconds < 90) {
                      continue;
                    }
                    musicDir.add(j.parent.path);
                    count += 1;
                  }
                }
              }
            }
            print('musicDir:${musicDir.length}  songs:$count');
            count = 0;
            for (var i in musicDir) {
              print('final:$i');
              databaseControl.setSettings(
                  Settings(name: 'musicDir$count', stringValue: i));
              count += 1;
            }
            dataModel.getSongs();
          },
          child: const Icon(Icons.refresh),
        ),
        body: Container(
          color: Colors.black.withOpacity(0),
          child: SafeArea(
              minimum: const EdgeInsets.only(top: 20, bottom: 10),
              child: Center(
                  child: ListView(
                children: [
                  ListElementCategory(
                    iconName: Icons.music_note,
                    iconColor: Colors.red,
                    text: '所有歌曲',
                    textColor: Colors.white,
                    onTap: () {
                      var dataModel =
                          Provider.of<DataModel>(context, listen: false);
                      dataModel.changePagesIndex([2, 1, 0]);
                    },
                  ),
                  ListElementCategory(
                    iconName: Icons.album_rounded,
                    iconColor: Colors.purple,
                    text: '专辑',
                    textColor: Colors.white,
                    onTap: () {},
                  ),
                  ListElementCategory(
                    iconName: Icons.people,
                    iconColor: Colors.green,
                    text: '歌手',
                    textColor: Colors.white,
                    onTap: () {},
                  ),
                  ListElementCategory(
                    iconName: Icons.folder,
                    iconColor: Colors.blue,
                    text: '文件夹',
                    textColor: Colors.white,
                    onTap: () {
                      var dataModel =
                          Provider.of<DataModel>(context, listen: false);
                      dataModel.changePagesIndex([0, 0, 1]);
                    },
                  ),
                  ListElementCategory(
                    iconName: Icons.settings,
                    iconColor: Colors.blueGrey,
                    text: '设置',
                    textColor: Colors.white,
                    onTap: () {
                      var dataModel =
                          Provider.of<DataModel>(context, listen: false);
                      dataModel.changePagesIndex([0, 1, 1]);
                    },
                  ),
                ],
              ))),
        ));
  }
}
