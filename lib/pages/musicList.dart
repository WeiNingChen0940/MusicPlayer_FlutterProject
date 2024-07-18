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
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('播放列表'),
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
