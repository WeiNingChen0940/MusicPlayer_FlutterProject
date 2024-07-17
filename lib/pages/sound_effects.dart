import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../main.dart';

class SoundEffects extends StatefulWidget {
  const SoundEffects({super.key});

  @override
  _SoundEffectsState createState() => _SoundEffectsState();
}

class _SoundEffectsState extends State<SoundEffects> {
  @override
  Widget build(BuildContext context) {
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
          appBar: AppBar(
            backgroundColor: Colors.white.withOpacity(0),
            title: const Text('播放',style: TextStyle(color: Colors.white),),
            iconTheme: const IconThemeData(color: Colors.white),
          ),
          body: Consumer<DataModel>(
            builder: (context, dataModel, _){
              return Center(
                  child: Column(
                    children: [],
                  )
              );
            },
          )

      ),
    );
  }
}
