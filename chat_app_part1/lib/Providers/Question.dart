import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../Modules/Option.dart';
import '../Modules/single_question.dart';
class Question with ChangeNotifier{
  List<SingleQuestion>_questions=[
    SingleQuestion( id:"1",question: "Honesty is a good trait",
        options:[
          OptionProvider(optionId: 1,optionTitle: "Stongly Agree",marks:2,isSelected: false),
          OptionProvider(optionId: 2,optionTitle: "Agree",marks:1,isSelected: false),
          OptionProvider(optionId: 3,optionTitle: "Disagree",marks:1,isSelected: false),
          OptionProvider(optionId: 4,optionTitle: "Stongly Disagree",marks:0,isSelected: false)],
        ),
    SingleQuestion( id:"2",question: "Cheating if done for success is good",
        options:[
          OptionProvider(optionId: 1,optionTitle: "Stongly Agree",marks:1,isSelected: false),
          OptionProvider(optionId: 2,optionTitle: "Agree",marks:1,isSelected: false),
          OptionProvider(optionId: 3,optionTitle: "Disagree",marks:2,isSelected: false),
          OptionProvider(optionId: 4,optionTitle: "Stongly Disagree",marks:0,isSelected: false),],
        ),
    SingleQuestion( id:"3",question: "I am an Introvert",
        options:[
          OptionProvider(optionId: 1,optionTitle: "Stongly Agree",marks:0,isSelected: false),
          OptionProvider(optionId: 2,optionTitle: "Stongly Agree",marks:0,isSelected: false),
          OptionProvider(optionId: 3,optionTitle: "Stongly Agree",marks:0,isSelected: false),
          OptionProvider(optionId: 4,optionTitle: "Stongly Agree",marks:0,isSelected: false),],
        ),
    SingleQuestion( id:"4",question: "I am thrill seeking",
        options:[
          OptionProvider(optionId: 1,optionTitle: "Stongly Agree",marks:0,isSelected: false),
          OptionProvider(optionId: 2,optionTitle: "Stongly Agree",marks:0,isSelected: false),
          OptionProvider(optionId: 3,optionTitle: "Stongly Agree",marks:0,isSelected: false),
          OptionProvider(optionId: 4,optionTitle: "Stongly Agree",marks:0,isSelected: false)],
        ),
  ];
  List<SingleQuestion> get testQuestions{
    return [..._questions];
   }
   SingleQuestion  findById(String id){
     SingleQuestion answer =SingleQuestion(id: "null",
         question:"Not Available",options: []);
      for(int i=0;i<_questions.length;i++){
        if(_questions[i].id==id)answer= _questions[i];
      }
      return answer;
   }
   void deSelectOptions(String questionId){
      SingleQuestion quest=findById(questionId);
      for(int i=0;i<quest.options.length;i++){

        quest.options[i].isSelected=false;
      }
      notifyListeners();
   }
   int selectedOption(String questionId){
    int index=-1;
     SingleQuestion quest=findById(questionId);
     for(int i=0;i<quest.options.length;i++){

       if(quest.options[i].isSelected==true)index=i;
     }
    return index;
   }
}