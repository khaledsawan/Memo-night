import 'package:flutter/material.dart';
import 'app_icons.dart';
import 'big_text.dart';


class IconThanText extends StatelessWidget {
  IconData icon;
  Color color;
  Color textColor;
  String  text;
   IconThanText({Key? key,required this.icon,required this.text,required this.color,this.textColor=Colors.black54}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
       children: [
          AppIcons(icon: icon,containerSize: 40,iconSize: 24,backgruondcolor: color,iconColor: Colors.white,),
          const SizedBox(width: 15,),
          BigText(textbody: text,color: textColor,),
       ],
     );
  }
}
