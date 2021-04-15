import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:timebound/signupscreen.dart';



class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
 
  GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();



Future<void> _login() async{
if(_formkey.currentState.validate()){
  _formkey.currentState.save();
  try {
  UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
    email: _emailController.text,
    password: _passwordController.text
  );
} on FirebaseAuthException catch (e) {
  if (e.code == 'user-not-found') {
    showDialog(
      context: context,
      builder: (BuildContext context){
        return AlertDialog(
          title: Text("Account Not Found"),
          actions: [
            FlatButton(
              onPressed: (){
                Navigator.pop(context);
              },
              child: Text("OK"),
            )
          ],
        );
      }
    );
  } else if (e.code == 'wrong-password') {
    showDialog(
      context: context,
      builder: (BuildContext context){
        return AlertDialog(
          title: Text("Password Doesn't Match"),
          actions: [
            FlatButton(
              onPressed: (){
                Navigator.pop(context);
              },
              child: Text("OK"),
            )
          ],
        );
      }
    );
  }
}
}
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.blue,Colors.purple[400]],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter
          )
        ),
        child: SingleChildScrollView(
                  child: Column(
            children: <Widget>[
              SizedBox(height: 10.0,),
              Container(
                child: Image(image: AssetImage("assets/login.png"),height: 300.0,),
                color: Colors.transparent,
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Container(
                 decoration: BoxDecoration(
                   borderRadius: BorderRadius.circular(20.0),
                   color: Colors.white,
                     boxShadow: [
                      BoxShadow(
                        color: Colors.grey[600],
                        blurRadius: 10.0,
                        spreadRadius: 1.0,
                      ),
                    ]
                    ),
                  height: 380,
                  width: 400,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Form(
                      key: _formkey,
                      child: Column(
                        children: <Widget>[
                          TextFormField(
                            controller: _emailController,
                            decoration: InputDecoration(
                             focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.grey[300]),borderRadius: BorderRadius.circular(10.0)),
                               enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20.0),
                                borderSide: BorderSide(
                                  color: Colors.grey[300],
                                  width: 2.0,
                                ),
                              ),
                              hintText: "E-MAIL",
                              fillColor: Colors.grey[300],
                              filled: true
                            ),
                            validator: (_val){
                              if(_val.isEmpty){
                                return "Email Required!";
                              }
                              else{
                                return null;
                              }
                            },
                            
                          ),
                          SizedBox(height: 30.0,),
                          TextFormField(
                            controller: _passwordController,
                            obscureText: true,
                            decoration: InputDecoration(
                              focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.grey[300]),borderRadius: BorderRadius.circular(10.0)),
                               enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20.0),
                                borderSide: BorderSide(
                                  color: Colors.grey[300],
                                  width: 2.0,
                                ),
                              ),
                              hintText: "PASSWORD",
                              fillColor: Colors.grey[300],
                              filled: true
                            ),
                            validator: (_val){
                              if(_val.isEmpty){
                                return "Password Required!";
                              }
                              else{
                                return null;
                              }
                            },
                           
                          ),
                          SizedBox(height: 25.0,),
                          RaisedButton(
                            onPressed:_login,
                            textColor: Colors.white,
                            padding: const EdgeInsets.all(0.0),
                            shape:RoundedRectangleBorder(borderRadius: BorderRadius.circular(35.0)),
                            child: Container(
                              decoration: const BoxDecoration(
                                gradient: LinearGradient(
                                  colors: <Color>[
                                    Colors.purple,
                                    Colors.blue
                                  ],
                                ),
                                borderRadius: BorderRadius.all(Radius.circular(80.0))
                              ),
                              padding: const EdgeInsets.fromLTRB(90, 20, 90, 20),
                              child: const Text(
                                  'LOGIN',
                                  style: TextStyle(fontSize: 20)
                              ),
                            ),
                          ),
                          SizedBox(height:25.0),
                           RaisedButton(
                            onPressed:(){
                              Navigator.push(context, MaterialPageRoute(builder: (context)=>SignupScreen()));
                            },
                            textColor: Colors.white,
                            padding: const EdgeInsets.all(0.0),
                            shape:RoundedRectangleBorder(borderRadius: BorderRadius.circular(35.0)),
                            child: Container(
                              decoration: const BoxDecoration(
                                gradient: LinearGradient(
                                  colors: <Color>[
                                    Colors.purple,
                                    Colors.blue
                                  ],
                                ),
                                borderRadius: BorderRadius.all(Radius.circular(80.0))
                              ),
                              padding: const EdgeInsets.fromLTRB(85, 20, 85, 20),
                              child: const Text(
                                  'SIGNUP',
                                  style: TextStyle(fontSize: 20)
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      )
      );
  }
}

