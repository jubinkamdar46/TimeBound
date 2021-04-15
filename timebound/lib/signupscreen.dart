import 'package:flutter/material.dart';
import 'package:timebound/loginscreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';


class SignupScreen extends StatefulWidget {
  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _confirmpasswordController = TextEditingController();
  GlobalKey<FormState> _formkey = GlobalKey<FormState>();
    Future<void> _createUser() async{
      if(_formkey.currentState.validate()){
         _formkey.currentState.save();
    try {
  UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
    email: _emailController.text,
    password: _passwordController.text
  );
} on FirebaseAuthException catch (e) {
   
    if (e.code == 'weak-password') {
    showDialog(
      context: context,
      builder: (BuildContext context){
        return AlertDialog(
          title: Text("Weak Password"),
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
  } else if (e.code == 'email-already-in-use') {
    showDialog(
      context: context,
      builder: (BuildContext context){
        return AlertDialog(
          title: Text("Account Already Exists"),
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
  
} catch (e) {
  print(e);
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
                child: Image(image: AssetImage("assets/signup.png"),),
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
                  height: 412,
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
                                return "Cannot Be Empty";
                              }else{
                                return null;
                              }
                            },
                          ),
                          SizedBox(height: 20.0,),
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
                                return "Cannot Be Empty";
                              }else{
                                return null;
                              }
                            },
                          ),
                          SizedBox(height: 20.0,),
                          TextFormField(
                            controller: _confirmpasswordController,
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
                              hintText: "CONFIRM PASSWORD",
                              fillColor: Colors.grey[300],
                              filled: true
                            ),
                            validator: (val){
                              if(val.isEmpty){
                                return "Cannot Be Empty";
                              }
                              else{
                                return null;
                              }
                            },
                          ),
                          SizedBox(height: 20.0,),
                          RaisedButton(
                            onPressed:_createUser,
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
                                  'SIGNUP',
                                  style: TextStyle(fontSize: 20)
                              ),
                            ),
                          ),
                          SizedBox(height:15.0),
                          InkWell(
                            onTap: (){
                              Navigator.push(context, MaterialPageRoute(builder: (context)=>LoginScreen()));
                            },
                            child: Column(
                              children: [
                                Text("Already Have An Account..?",style: TextStyle(fontWeight: FontWeight.bold),),
                                Text("LOGIN",style: TextStyle(fontWeight: FontWeight.bold),)
                              ],
                            ),
                          )
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