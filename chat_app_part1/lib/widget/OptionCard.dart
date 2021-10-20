import 'package:chatapppart1/Providers/UserProvider.dart';
import '../models/Auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:chatapppart1/Providers/Question.dart';
import '../models/SingleQuestion.dart';
enum AvailOptions{option1,option2,option3,option4,option5}
class OptionCard extends StatefulWidget {
  final String questionId;

  @override

  OptionCard(this.questionId);

  @override
  _OptionCardState createState() => _OptionCardState();
}

class _OptionCardState extends State<OptionCard> {
  int findSelectedOption(BuildContext context){
    final questions=Question();

    return questions.selectedOption(widget.questionId);
  }


  Widget build(BuildContext context) {
    final user=Provider.of<UserProvider>(context,listen:false);
    AvailOptions getOption(String userId,String questionId){
      int index=user.userSelectedOption(userId, questionId)!;
      AvailOptions option=AvailOptions.option5;
      switch(index){
        case 0:option=AvailOptions.option1;
        break;
        case 1:option=AvailOptions.option2;
        break;
        case 2:option=AvailOptions.option3;
        break;
        case 3:option=AvailOptions.option1;
        break;
        default:option=AvailOptions.option5;
        break;
      }
      return option;
    }
    final auth=Provider.of<AuthProvider>(context,listen:false);
    String userId=auth.getUserId!;
    SingleQuestion quest=Question.findById(widget.questionId);

    AvailOptions? _selectedOption=getOption(userId,widget.questionId);
    return Container(
        //width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.all(5),
      child:Column(

        children: [
          ListTile(
          title : Text(quest.options[0].optionTitle),
              leading: Radio<AvailOptions>
                (value: AvailOptions.option1,
                  groupValue: _selectedOption,
                  onChanged:(AvailOptions? opt){
                    setState(() {
                      user.getUser[userId]!.selectedOptions[widget.questionId]=0;
                      _selectedOption=opt;
                    });
                  })),

          ListTile(title:Text(quest.options[1].optionTitle) ,
              leading: Radio<AvailOptions>
                (value: AvailOptions.option2, groupValue: _selectedOption,
                  onChanged:(AvailOptions? opt){
                    setState(() {
                      user.getUser[userId]!.selectedOptions[widget.questionId]=1;
                      _selectedOption=opt;
                    });
                  })),

          ListTile(title:Text(quest.options[2].optionTitle)
              ,leading: Radio<AvailOptions>
                (value: AvailOptions.option3, groupValue: _selectedOption,
                  onChanged:(AvailOptions? opt){
                  setState(() {
                    user.getUser[userId]!.selectedOptions[widget.questionId]=2;
                    _selectedOption=opt;
                  });

                  })),

          ListTile( title: Text(quest.options[3].optionTitle) ,
              leading: Radio<AvailOptions>
                (value: AvailOptions.option4, groupValue: _selectedOption,
                  onChanged:(AvailOptions? opt){
                    setState(() {
                      user.getUser[userId]!.selectedOptions[widget.questionId]=3;
                      _selectedOption=opt;
                    });
                  })),
        ],

      )
    );
  }
}
