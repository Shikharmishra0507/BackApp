import 'package:chatapppart1/Screens/HomeScreen.dart';
import 'package:flutter/material.dart';
import '../Providers/Question.dart';
import 'package:provider/provider.dart';
import '../models/OptionCard.dart';

class TestPage extends StatefulWidget {
  static const String Route = '/testPage';

  @override
  _TestPageState createState() => _TestPageState();
}

class _TestPageState extends State<TestPage> {
  int _selectedIndex = 0;
  Map<String,int>selectedOption={};
  int marks=0;
  @override
  Widget build(BuildContext context) {
    final questions =
        Provider.of<Question>(context, listen: false).testQuestions;
    return Scaffold(
        appBar: AppBar(
          title: Text("Your Test!"),
          actions: [
            ElevatedButton(
              onPressed: () {
                if(_selectedIndex==questions.length-1){
                  Navigator.of(context).pushNamed(HomeScreen.route);
                }
              },
              child: Text("Submit"),
              style: ButtonStyle(
                backgroundColor: _selectedIndex==questions.length-1 ?
                MaterialStateProperty.all<Color>(Colors.blue):
                MaterialStateProperty.all<Color>(Colors.grey) ,
              ),
            )
          ],
        ),
        body: Container(
            child: Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.2 * 0.2,
            ),
            Container(
              child: Text(
                questions[_selectedIndex].question,
                style: TextStyle(
                  fontSize: 40,
                ),
              ),
            ),
            OptionCard(questions[_selectedIndex].id),
            Divider(),
            SizedBox(height: MediaQuery.of(context).size.height * 0.5),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      if (_selectedIndex > 0) _selectedIndex--;
                    });
                  },
                  child: Text("Prev"),
                ),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      if (_selectedIndex != questions.length - 1){
                        _selectedIndex++;

                      }
                    });
                  },
                  child: Text("Next"),
                ),
              ],
            ),

          ],
        )));
  }
}
