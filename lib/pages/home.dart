import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class homePage extends StatefulWidget
{
  const homePage({super.key});
  @override
  State<StatefulWidget> createState() {
    return _homePageState();
  }

}

class _homePageState extends State<homePage>
{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text('home'),
      ),
      body: SafeArea(
          child: Center(
            child:Column(
              children: [
                TextButton(onPressed: (){}, child: Icon(Icons.home)),
              ],
            )
          )
      ),

    );
  }

}