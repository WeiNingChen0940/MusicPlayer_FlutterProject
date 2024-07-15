import 'package:as_demo1/pages/list_element_category.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class homePage extends StatefulWidget {
  const homePage({super.key});

  @override
  State<StatefulWidget> createState() {
    return _homePageState();
  }
}

class _homePageState extends State<homePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white.withOpacity(0),
      appBar: AppBar(
        backgroundColor: Colors.white.withOpacity(0),
        title: const Text('主页',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 30),),
      ),
      body: Container(
        color: Colors.black.withOpacity(0),
        child: SafeArea(
          minimum: const EdgeInsets.only(top: 20,bottom: 10),
            child: Center(
                child: ListView(
                  children: [
                    ListElementCategory(
                      iconName: Icons.music_note,
                      iconColor: Colors.red,
                      text: '所有歌曲',
                      textColor: Colors.white,
                      onTap: (){},
                    ),
                    ListElementCategory(
                      iconName: Icons.album_rounded,
                      iconColor: Colors.purple,
                      text: '专辑',
                      textColor: Colors.white,
                      onTap: (){},
                    ),
                    ListElementCategory(
                      iconName: Icons.people,
                      iconColor: Colors.green,
                      text: '歌手',
                      textColor: Colors.white,
                      onTap: (){},
                    ),
                    ListElementCategory(
                      iconName: Icons.folder,
                      iconColor: Colors.blue,
                      text: '文件夹',
                      textColor: Colors.white,
                      onTap: (){},
                    ),
                    ListElementCategory(
                      iconName: Icons.settings,
                      iconColor: Colors.blueGrey,
                      text: '设置',
                      textColor: Colors.white,
                      onTap: (){},
                    ),
                  ],
                ))),
      )

    );
  }
}
