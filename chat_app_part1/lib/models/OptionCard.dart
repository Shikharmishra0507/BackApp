import 'package:chatapppart1/Screens/TestPage.dart';
import 'package:chatapppart1/models/single_option.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:chatapppart1/Providers/Question.dart';
import '../Modules/single_question.dart';
enum AvailOptions{option1,option2,option3,option4,option5}
class OptionCard extends StatefulWidget {
  final String id;

  @override

  OptionCard(this.id);

  @override
  _OptionCardState createState() => _OptionCardState();
}

class _OptionCardState extends State<OptionCard> {
  int findSelectedOption(BuildContext context){
    final questions=Provider.of<Question>(context,listen:false);
    return questions.selectedOption(widget.id);
  }
  AvailOptions? _selectedOption=null;

  @override
  void didChangeDependencies() {
    // Theme.of(context)
    print(widget.id);

    int index=findSelectedOption(context);
    switch(index){
      case 0:_selectedOption=AvailOptions.option1;
      break;
      case 1:_selectedOption=AvailOptions.option2;
      break;
      case 2:_selectedOption=AvailOptions.option3;
      break;
      case 3:_selectedOption=AvailOptions.option4;
      break;
      case -1:_selectedOption=AvailOptions.option5;
      break;
    }

    super.didChangeDependencies();
  }



  Widget build(BuildContext context) {
    final questions=Provider.of<Question>(context,listen:false);
    SingleQuestion quest=questions.findById(widget.id);
    return Container(
        //width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.all(5),
      child:Column(

        children: [
          ListTile(
          title : Text(quest.options[0].optionTitle!),
              leading: Radio<AvailOptions>
                (value: AvailOptions.option1,
                  groupValue: _selectedOption,
                  onChanged:(AvailOptions? opt){
                  setState(() {

                    _selectedOption=opt;
                    questions.deSelectOptions(widget.id);
                    for(int i=0;i<4;i++){
                      print(quest.options[i].isSelected);
                    }
                    quest.options[0].isSelected=true;
                  });
                  })),

          ListTile(title:Text(quest.options[1].optionTitle!) ,
              leading: Radio<AvailOptions>
                (value: AvailOptions.option2, groupValue: _selectedOption,
                  onChanged:(AvailOptions? opt){
                    setState(() {
                      _selectedOption=opt;
                      questions.deSelectOptions(widget.id);
                      for(int i=0;i<4;i++){
                        print(quest.options[i].isSelected);
                      }
                      quest.options[1].isSelected=true;
                    });
                  })),

          ListTile(title:Text(quest.options[2].optionTitle!)
              ,leading: Radio<AvailOptions>
                (value: AvailOptions.option3, groupValue: _selectedOption,
                  onChanged:(AvailOptions? opt){
                    setState(() {
                      _selectedOption=opt;
                      questions.deSelectOptions(widget.id);
                      for(int i=0;i<4;i++){
                        print(quest.options[i].isSelected);
                      }
                      quest.options[2].isSelected=true;
                    });
                  })),

          ListTile( title: Text(quest.options[3].optionTitle!) ,
              leading: Radio<AvailOptions>
                (value: AvailOptions.option4, groupValue: _selectedOption,
                  onChanged:(AvailOptions? opt){
                    setState(() {
                      _selectedOption=opt;
                      questions.deSelectOptions(widget.id);
                      for(int i=0;i<4;i++){
                        print(quest.options[i].isSelected);
                      }
                      quest.options[3].isSelected=true;
                    });
                  })),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [

          ElevatedButton(

              onPressed: (){

          }, child: Text("Submit Answer")),
            ElevatedButton(onPressed: (){}, child: Text("Clear Answer")),

        ],)
        ],

      )
    );
  }
}
