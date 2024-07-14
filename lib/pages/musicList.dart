import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class musicListPage extends StatefulWidget
{
  const musicListPage({super.key});
  @override
  State<StatefulWidget> createState() {
    return _musicListPageState();
  }

}

class _musicListPageState extends State<musicListPage>
{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text('musicList'),
      ),
      body: SafeArea(
          child: Center(
              child:Column(
                children: [
                  TextButton(onPressed: (){}, child: Icon(Icons.music_note_rounded)),
                ],
              )
          )
      ),

    );
  }

}