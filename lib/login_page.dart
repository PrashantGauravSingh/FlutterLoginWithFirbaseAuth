import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginPage extends StatefulWidget {

  @override
  _LoginPageState createState() => new _LoginPageState();
}
class _LoginPageState extends State<LoginPage> {
  static String tag = 'login-page';
  String _email;
  String _password;
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final logo = Hero(
      tag: 'hero',
      child: CircleAvatar(
        backgroundColor: Colors.transparent,
        radius: 48.0,
        child: Image.asset('images/gym.png'),
      ),
    );

    final email = new TextFormField(
      keyboardType: TextInputType.emailAddress,
      autofocus: false,
      decoration: new InputDecoration(labelText: "Email",
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(20.0)),
      ),
        validator:(value) => value.isEmpty?"Email cant be empty email": null,
      onSaved: (value) => _email=value,
    );

    final password = new TextFormField(
      autofocus: false,
      obscureText: true,
      decoration: new InputDecoration(labelText: "Password",
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(20.0)),
      ),
       validator:(value)=> value.isEmpty ? "Password cant be empty email": null,
      onSaved: (value) => _password=value,
    );

    final loginButton = Padding(
      padding: EdgeInsets.symmetric(vertical: 16.0),
      child: Material(
        borderRadius: BorderRadius.circular(30.0),
        shadowColor: Colors.lightBlueAccent.shade100,
        elevation: 5.0,
        child: MaterialButton(
          minWidth: 200.0,
          height: 50.0,
          onPressed: () {
            // Navigator.of(context).pushNamed(HomePage.tag);
           // _showDialog("Alert","Login Success");
            loginAuth();
          },
          color: Colors.lightBlueAccent,
          child: Text('Log In', style: TextStyle(color: Colors.white)),
        ),
      ),
    );

    final forgotLabel = FlatButton(
      child: Text(
        'Forgot password?',
        style: TextStyle(color: Colors.black54,fontFamily: 'Oswald',),
      ),
      onPressed: () {},
    );
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        title: Text("Login", textDirection: TextDirection.rtl,
          style: TextStyle(
            color: Colors.white,
            decoration: TextDecoration.none,
            fontFamily: 'Oswald',
            fontSize: 20.0,
          ),),
      ),
      backgroundColor: Colors.white,
      body: new Container(
         padding: EdgeInsets.all(30.00),
         child:  Form(
           key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            logo,
            SizedBox(height: 60.0),
            email,
            SizedBox(height: 15.0),
            password,
            SizedBox(height: 15.0),
            loginButton,
            SizedBox(height: 30.0),
            forgotLabel,
            SizedBox(height: 30.0),
          ],
        ),
      ),
      ),
    );

}

  bool validateForm(){
    final form=formKey.currentState;
    form.save();
    if(form.validate()){
      print('Form valid $_email $_password');
     return true;
    }else{
      print('Form not valid $_email $_password');
     return false;
    }
  }

  Future<void> loginAuth() async{
    if(validateForm()) {
      try {
        FirebaseUser user = await FirebaseAuth.instance
            .signInWithEmailAndPassword(email: _email, password: _password);
        //TODO navigate to home
        _showDialog("Auth","Login successfull");
      } catch (e) {
        e.message();
      }
    }
  }
// user alert function
  void _showDialog(String title,String message) {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text(title),
          content: new Text(message),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new FlatButton(
              child: new Text("Close"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

}

