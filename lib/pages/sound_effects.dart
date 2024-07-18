import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../main.dart';

class SoundEffects extends StatefulWidget {
  const SoundEffects({super.key});

  @override
  SoundEffectsState createState() => SoundEffectsState();
}

class SoundEffectsState extends State<SoundEffects> {
  @override
  Widget build(BuildContext context) {
    var dataModel = Provider.of<DataModel>(context, listen: false);
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
          title: const Text(
            '均衡器',
            style: TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold, fontSize: 30),
          ),
        ),
        body: const Center(
            child:
            Column()
        ),
      ),
    );
  }
}
