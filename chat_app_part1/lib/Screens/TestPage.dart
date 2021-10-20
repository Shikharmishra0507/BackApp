import '../models/Auth.dart';
import 'package:chatapppart1/Providers/UserProvider.dart';
import 'package:chatapppart1/Screens/HomeScreen.dart';
import 'package:flutter/material.dart';
import '../Providers/Question.dart';
import 'package:provider/provider.dart';
import '../widget/OptionCard.dart';

class TestPage extends StatefulWidget {
  static const String Route = '/testPage';

  @override
  _TestPageState createState() => _TestPageState();
}

class _TestPageState extends State<TestPage> {
  int _selectedIndex = 0;
  Map<String, int> selectedOption = {};
  int marks = 0;
  bool isLoading=false;
  @override
  Widget build(BuildContext context) {

    void showErrorDialog(String message) {
      showDialog(
          context: context,
          builder: (_) {
            return AlertDialog(
              title: Text("some thing went wrong"),
              content: Text(message),
              actions: [
                ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text("Okay"))
              ],
            );
          });
    }
    final questions =
        Question.testQuestions;
    return Scaffold(
        appBar: AppBar(
          title: Text("Your Test!"),
          actions: [
            ElevatedButton(
              onPressed: () async{
                if (_selectedIndex == questions.length - 1) {
                    setState(() {
                      isLoading=true;
                    });
                    final userId=Provider.of<AuthProvider>(context,listen:false).getUserId;
                    final user=Provider.of<UserProvider>(context,listen:false);
                    try{
                      await user.setUserSelectedOptions(userId!,user.getUser[userId]!.selectedOptions
                      );
                    }
                    catch(error){
                      showErrorDialog(error.toString());
                    }

                    setState(() {
                      isLoading=false;
                    });
                    Navigator.of(context).pushNamed(HomeScreen.route);
                }
              },
              child: Text("Submit"),
              style: ButtonStyle(
                backgroundColor: _selectedIndex == questions.length - 1
                    ? MaterialStateProperty.all<Color>(Colors.green)
                    : MaterialStateProperty.all<Color>(Colors.grey),
              ),
            )
          ],
        ),
        body: isLoading ? CircularProgressIndicator():Container(
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
                      if (_selectedIndex != questions.length - 1) {
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
