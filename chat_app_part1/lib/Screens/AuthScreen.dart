import 'dart:math';
import 'package:chatapppart1/Screens/HomeScreen.dart';

import '../models/Auth.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import '../models/UserException.dart';
import 'firstSignupScreen.dart';

enum AuthMode { Signup, Login }

class AuthScreen extends StatelessWidget {
  static const routeName = '/auth';

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    // final transformConfig = Matrix4.rotationZ(-8 * pi / 180);
    // transformConfig.translate(-10.0);
    return Scaffold(
      // resizeToAvoidBottomInset: false,
      body: Stack(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color.fromRGBO(215, 117, 255, 1).withOpacity(0.5),
                  Color.fromRGBO(255, 188, 117, 1).withOpacity(0.9),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                stops: [0, 1],
              ),
            ),
          ),
          SingleChildScrollView(
            child: Container(
              height: deviceSize.height,
              width: deviceSize.width,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Flexible(
                    child: Container(
                      margin: EdgeInsets.only(bottom: 20.0),

                      // ..translate(-10.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.deepOrange.shade900,
                        boxShadow: [
                          BoxShadow(
                            blurRadius: 8,
                            color: Colors.black26,
                            offset: Offset(0, 2),
                          )
                        ],
                      ),
                      child: Text(
                        'CHAT APP',
                        style: TextStyle(
                          color: Theme.of(context).accentColor,
                          fontSize: 50,
                          fontFamily: 'Anton',
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    ),
                  ),
                  Flexible(
                    flex: deviceSize.width > 600 ? 2 : 1,
                    child: AuthCard(),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class AuthCard extends StatefulWidget {

  @override
  _AuthCardState createState() => _AuthCardState();
}

class _AuthCardState extends State<AuthCard> {
  void showErrorDialog(String message){
    showDialog(context: context, builder: (_){
      return AlertDialog(title: Text("Something went wrong"),content: Text(message),
      actions: [
        ElevatedButton(onPressed: (){
          Navigator.of(context).pop();
        }, child: Text("Okay"))
      ],);
    });
  }
  final GlobalKey<FormState> _formKey = GlobalKey();
  AuthMode _authMode = AuthMode.Login;
  Map<String, String> _authData = {
    'number': '',
    'password': '',
  };
  var _isLoading = false;
  final _passwordController = TextEditingController();

  void _submit() async {
    if (!_formKey.currentState!.validate()) {
      // Invalid!

      return;
    }
   // if(_formKey.currentState!.save())
    _formKey.currentState?.save();

    setState(() {
      _isLoading = true;
    });
    try {
      final auth=Provider.of<AuthProvider>(context,listen:false);
      if (_authMode == AuthMode.Login) {
        // Log user in

          await auth.logIn(
              _authData['number'].toString(), _authData['password'].toString());
          Navigator.of(context).pushNamed(HomeScreen.route);


      } else {

        // Sign user up
        await auth.signUp(
            _authData['number'].toString(), _authData['password'].toString());

        Navigator.of(context).pushNamed(FirstSignUpPage.route,arguments:auth.getUserId );
      }
    } on Exception catch (error) {
      print("here");
      var errorMessage="Authetication Failed!!";
      if(error.toString().contains("EMAIL_EXISTS")){
        errorMessage="This Email does not exists";
      }
      if(error.toString().contains("INVALID_EMAIL")){
        errorMessage="This Email does not exists";
      }
      if(error.toString().contains("WEAK_PASSWORD")){
        errorMessage="This Email does not exists";
      }
      if(error.toString().contains("EMAIL_NOT_FOUND")){
        errorMessage="This Email does not exists";
      }
      if(error.toString().contains("INVALID_PASSWORD")){
        errorMessage="This Email does not exists";
      }
      // TODO
      showErrorDialog(errorMessage);
    }
    catch(error){

        showErrorDialog("Something went wrong");
    }
    setState(() {
      _isLoading = false;
    });
  }

  Widget showSignUpDialog(){
    return new AlertDialog(
      title: const Text('Popup example'),
      content: new Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text("Hello"),
        ],
      ),
      actions: <Widget>[
        new FlatButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          textColor: Theme.of(context).primaryColor,
          child: const Text('Close'),
        ),
      ],
    );
  }
  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    return _isLoading==true ? CircularProgressIndicator() : Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      elevation: 8.0,
      child: _authMode==AuthMode.Signup ?  showSignUpDialog() : Container(
        child: Container(
          height: _authMode == AuthMode.Signup ? 320 : 260,
          constraints:
          BoxConstraints(minHeight: _authMode == AuthMode.Signup ? 320 : 260),
          width: deviceSize.width * 0.75,
          padding: EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Contact Number'),
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if(value==null)return 'Number cannot be Empty!!';
                      if (value.isEmpty || value.length!=10) {

                        return 'Invalid Mobile Number';
                      }
                      return null;

                    },
                    onSaved: (value) {
                      _authData['number'] = value.toString();
                    },
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Password'),
                    obscureText: true,
                    controller: _passwordController,
                    validator: (value) {
                      if(value==null)return "Password cannot be Empty";
                      if (value.isEmpty || value.length < 5) {
                        return 'Password is too short!';
                      }
                    },
                    onSaved: (value) {
                      _authData['password'] = value.toString();
                    },
                  ),
                  ElevatedButton(onPressed: (){}, child: Text("LOGIN")),
                  TextButton(
                      onPressed: (){
                        setState(() {
                          _authMode=AuthMode.Signup;
                      });
                  }, child:Text("Don't have an account , Sign up here" ,
                    style: TextStyle(fontSize: 6),) )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}