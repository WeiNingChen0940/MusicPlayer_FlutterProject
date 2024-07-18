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
        body: Center(
            child:
            Column(
              children: [
                ListView.builder(
                    shrinkWrap: true,
                    itemCount: 9,
                    itemBuilder: (context, index) {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(dataModel.filterParamNames[index],style: const TextStyle(color: Colors.white,fontSize: 15,fontWeight: FontWeight.bold),),
                          const Text('   0',style: TextStyle(color: Colors.white,fontSize: 12,fontWeight: FontWeight.normal)),
                          Slider(
                              min: 0,
                              max: index == 0 ? 1 : 4,
                              label: dataModel.filterParameters[index].toString(),
                              value: dataModel.filterParameters[index],
                              onChanged: (value) {
                                setState(() {
                                  dataModel.filterParameters[index] = value;
                                });
                              }),
                          Text('${index==0?1:4}   ',style: const TextStyle(color: Colors.white,fontSize: 12,fontWeight: FontWeight.normal)),
                          Text(dataModel.filterParameters[index].toStringAsPrecision(3),style: const TextStyle(color: Colors.white,fontSize: 15,fontWeight: FontWeight.bold),),
                        ],
                      );
                    }),
                TextButton(
                    onPressed: () {
                      dataModel.setFilterParameter();
                    },
                    child: const Text('应用',style: TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.bold),))
              ],
            )
        ),
      ),
    );
  }
}
