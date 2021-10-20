import 'package:chatapppart1/Providers/UserProvider.dart';
import 'package:chatapppart1/Screens/TestPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class FirstSignUpPage extends StatefulWidget {
  @override
  static const String route = '/FirstPageRoute';

  @override
  _FirstSignUpPageState createState() => _FirstSignUpPageState();
}

enum Gender { Male, Female, Other }

class _FirstSignUpPageState extends State<FirstSignUpPage> {
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

    final size = MediaQuery.of(context).size;
    String userId = ModalRoute.of(context)!.settings.arguments as String;
    final _formKey = GlobalKey<FormState>();
    var userInfo = {
      'Name': "",
      'Age': "",
    };
    Gender? _selectedGender = Gender.Male;
    bool isLoading = false;
    void SaveForm() async {
      if (!_formKey.currentState!.validate()) return;
      _formKey.currentState?.save();
      setState(() {
        isLoading = true;
      });
        Provider.of<UserProvider>(context,listen:false).setBasicUserInfo(
           userId: userId,gender:_selectedGender!.index==0 ? 'Male' : _selectedGender!.index==1 ? 'Female' :'Other',
            age: userInfo['Age'],name: userInfo['Age']);
      setState(() {
        isLoading = false;
      });
      Navigator.of(context).pushNamed(TestPage.Route);
    }

    return Scaffold(
        appBar: AppBar(
          title: Center(child: Text("User Information")),
        ),
        body: isLoading == true
            ? CircularProgressIndicator()
            : Container(
                alignment: Alignment.center,
                width: size.width,
                height: size.height,
                decoration: BoxDecoration(),
                child: Stack(
                  children: [
                    Container(
                        height: size.height * 0.4,
                        width: size.width * 0.5,
                        alignment: Alignment.topCenter,
                        child: Form(
                          key: _formKey,
                          child: Column(
                            children: [
                              TextFormField(
                                decoration: InputDecoration(hintText: "Name"),
                                validator: (value) {
                                  if (value == null) return "Not a Valid Name";
                                  return null;
                                },
                                onSaved: (value) {
                                  userInfo['Name'] = value!;
                                },
                              ),
                              Column(
                                children: [
                                  Container(child: Text("Gender")),
                                  ListTile(
                                    leading: Radio<Gender>(
                                      value: Gender.Male,
                                      groupValue: _selectedGender,
                                      onChanged: (Gender? value) {
                                        setState(() {
                                          _selectedGender = value;
                                          print(_selectedGender);
                                        });
                                      },
                                    ),
                                    title: Text("Male"),
                                  ),
                                  ListTile(
                                      leading: Radio<Gender>(
                                        value: Gender.Female,
                                        groupValue: _selectedGender,
                                        onChanged: (Gender? gender) {
                                          setState(() {
                                            _selectedGender = gender;
                                          });
                                        },

                                      ),
                                      title: Text("Female")),
                                  ListTile(
                                      leading: Radio<Gender>(
                                        value: Gender.Other,
                                        groupValue: _selectedGender,
                                        onChanged: (Gender? value) {
                                          setState(() {
                                            _selectedGender =value;
                                          });
                                        },
                                      ),
                                      title: Text("Other")),
                                ],
                              ),
                              TextFormField(
                                decoration: InputDecoration(hintText: "Age"),
                                keyboardType: TextInputType.number,
                                validator: (value) {
                                  if (value == null || int.parse(value) > 100)
                                    return "Invalid Age";
                                  return null;
                                },
                                onSaved: (value) {
                                  userInfo['Age'] = value!;
                                },
                              ),
                              ElevatedButton(
                                  onPressed: SaveForm, child: Text("Submit"))
                            ],
                          ),
                        ))
                  ],
                )));
  }
}
