import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'Option.dart';
import '../models/SingleQuestion.dart';
class Question {
   static List<SingleQuestion>_questions=[
    SingleQuestion( id:"1",question: "Honesty is a good trait",
        options:[
          Option(optionId: 1,optionTitle: "Stongly Agree",marks:2,),
          Option(optionId: 2,optionTitle: "Agree",marks:1,),
          Option(optionId: 3,optionTitle: "Disagree",marks:1,),
          Option(optionId: 4,optionTitle: "Stongly Disagree",marks:0,)],
        ),
    SingleQuestion ( id:"2",question: "Cheating if done for success is good",
        options:[
          Option(optionId: 1,optionTitle: "Stongly Agree",marks:1,),
          Option(optionId: 2,optionTitle: "Agree",marks:1,),
          Option(optionId: 3,optionTitle: "Disagree",marks:2,),
          Option(optionId: 4,optionTitle: "Stongly Disagree",marks:0,),],
        ),
    SingleQuestion( id:"3",question: "I am an Introvert",
        options:[
          Option(optionId: 1,optionTitle: "Stongly Agree",marks:0,),
          Option(optionId: 2,optionTitle: "Agree",marks:0,),
          Option(optionId: 3,optionTitle: "Disagree",marks:0,),
          Option(optionId: 4,optionTitle: "Stongly Disagree",marks:0,),],
        ),
    SingleQuestion( id:"4",question: "I am thrill seeking",
        options:[
          Option(optionId: 1,optionTitle: "Stongly Agree",marks:0,
              ),
          Option(optionId: 2,optionTitle: "Stongly Agree",marks:0,),
          Option(optionId: 3,optionTitle: "Stongly Agree",marks:0,),
          Option(optionId: 4,optionTitle: "Stongly Agree",marks:0,)],
        ),
  ];
  static List<SingleQuestion> get testQuestions{
    return [..._questions];
   }
   static SingleQuestion  findById(String id){
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


      }

   }
   int selectedOption(String questionId){
    int index=-1;
     SingleQuestion quest=findById(questionId);
     for(int i=0;i<quest.options.length;i++){


     }
    return index;
   }
}