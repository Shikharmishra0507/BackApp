   import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:chatapppart1/Providers/Question.dart';

class SingleOption extends StatefulWidget {
  @override
  final String? id;
  final int? index;

  SingleOption({this.id,this.index});

  @override
  _SingleOptionState createState() => _SingleOptionState();
}

class _SingleOptionState extends State<SingleOption> {
  Color unSelectedColor=Colors.white70;
  Color   selectedColor=Colors.green;
  Widget build(BuildContext context) {

    final question = Provider.of<Question>(context, listen: false);
    return Container(
      width: MediaQuery.of(context).size.width*0.2,
      child:Card(
        color: question.findById(widget.id!).options[widget.index!].isSelected==true?selectedColor :unSelectedColor ,
        child: ListTile(
          onTap: (){
            setState(() {
              //bool currentStatus=question.findById(widget.id!).options[widget.index!].isSelected!;
              question.deSelectOptions(widget.id!);
//              if(currentStatus){
//
//                question.findById(widget.id!).options[widget.index!].isSelected=false;
//              }
//              else if(!currentStatus){
//
//                question.findById(widget.id!).options[widget.index!].isSelected=true;
//              }


            });

          },
          leading: CircleAvatar(
            backgroundColor:
            question.findById(widget.id!).options[widget.index!].isSelected==true
                ?selectedColor : unSelectedColor,),
          title:Text(question.findById(widget.id!).options[widget.index!].optionTitle!,
              style: TextStyle(fontSize: 20))
          ,),
      ),
    );
  }
}
