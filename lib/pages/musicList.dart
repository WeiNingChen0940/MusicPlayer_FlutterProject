import 'dart:io';

import 'package:as_demo1/main.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';

import '../databaseControl.dart';

class MusicListPage extends StatefulWidget {
  const MusicListPage({super.key});

  @override
  State<StatefulWidget> createState() {
    return _MusicListPageState();
  }
}

class _MusicListPageState extends State<MusicListPage> {
  Future<void> onTap() async {
    var dataModel = Provider.of<DataModel>(context, listen: false);
    dataModel.getSongs();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white.withOpacity(0),
      appBar: AppBar(
        backgroundColor: Colors.white.withOpacity(0),
        title: const Text(
          '播放列表',
          style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 30),
        ),
      ),
      body: SafeArea(
          child: Center(
              child: Column(
        children: [
          TextButton(
              onPressed: () async {
                onTap();
              },
              child: const Icon(Icons.music_note_rounded)),
        ],
      ))),
    );
  }
}
