import 'package:flutter/material.dart';

class ListElementCategory extends StatelessWidget {
  final IconData iconName;
  final Color iconColor;
  final String text;
  final Color textColor;
  final void Function() onTap;
  const ListElementCategory(
      {super.key, required this.iconName,
      this.iconColor = Colors.black,
      required this.text,
      this.textColor = Colors.black, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
          margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          child: Row(
            children: [
              ClipOval(
                  child: Container(
                    color: iconColor,
                    width: 48,
                    height: 48,
                    child: Icon(iconName,color: Colors.white,size: 28,),
                  )
              ),
              Container(
                margin: const EdgeInsets.only(left: 20),
                child: Text(text,style: TextStyle(color: textColor,fontSize: 30,fontWeight: FontWeight.bold),),
              ),
            ],
          )
      )
    );
  }
}
