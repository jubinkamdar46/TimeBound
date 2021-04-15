import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AddTaskScreen extends StatefulWidget {
  @override
  _AddTaskScreenState createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  //var uid = user.uid;
  //User user = FirebaseAuth.instance.getCurrentUser();
  //final collection = FirebaseFirestore.instance.collection(uid);
  final Shader linearGradient = LinearGradient(
    colors: <Color>[Colors.purple, Colors.blue],
  ).createShader(Rect.fromLTWH(0.0, 0.0, 200.0, 70.0));
  DateTime _dateTime = DateTime.now();
  GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  TextEditingController _tasktitle = TextEditingController();
  TextEditingController _taskdesc = TextEditingController();
  
  @override
  
  Widget build(BuildContext context) {
      final uid = _getUser();
      final collection = FirebaseFirestore.instance.collection(uid);
        return Scaffold(
          body: SingleChildScrollView(
            child: SafeArea(
              child: Stack(
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 25.0),
                    //padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 60.0), to make it center
                    child: Text(
                      "ADD TASK",
                      style: TextStyle(
                          fontSize: 55.0,
                          fontWeight: FontWeight.bold,
                          foreground: Paint()..shader = linearGradient),
                    ),
                  ),
                  Container(
                      height: 450.0,
                      padding: EdgeInsets.fromLTRB(20, 30, 20, 0),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey[600],
                              blurRadius: 5.0,
                              spreadRadius: 1.0,
                            ),
                          ],
                          borderRadius: BorderRadius.circular(20.0)),
                      margin:
                          EdgeInsets.symmetric(vertical: 130.0, horizontal: 20.0),
                      child: Form(
                        key: _formkey,
                        child: Column(
                          children: [
                            TextFormField(
                              controller: _tasktitle,
                              decoration: InputDecoration(
                                  focusedBorder: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.grey[300]),
                                      borderRadius: BorderRadius.circular(10.0)),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20.0),
                                    borderSide: BorderSide(
                                      color: Colors.grey[300],
                                      width: 2.0,
                                    ),
                                  ),
                                  hintText: "Title",
                                  fillColor: Colors.grey[300],
                                  filled: true),
                            ),
                            SizedBox(
                              height: 20.0,
                            ),
                            TextFormField(
                              controller: _taskdesc,
                              decoration: InputDecoration(
                                  focusedBorder: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.grey[300]),
                                      borderRadius: BorderRadius.circular(10.0)),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20.0),
                                    borderSide: BorderSide(
                                      color: Colors.grey[300],
                                      width: 2.0,
                                    ),
                                  ),
                                  hintText: "Description",
                                  fillColor: Colors.grey[300],
                                  filled: true),
                              maxLines: 5,
                            ),
                            SizedBox(
                              height: 20.0,
                            ),
                            SizedBox(
                              height: 100,
                              child: CupertinoDatePicker(
                                initialDateTime: _dateTime,
                                onDateTimeChanged: (dateTime) {
                                  setState(() {
                                    print(dateTime);
                                    _dateTime = dateTime;
                                  });
                                },
                              ),
                            ),
                          ],
                        ),
                      )),
                  Positioned(
                    bottom: 100,
                    left: MediaQuery.of(context).size.width * 0.25,
                    child: RaisedButton(
                      onPressed: () async {
                        print(_tasktitle.text);
                        print(_taskdesc.text);
                        print(_dateTime);
                        print(collection);
    
                        // Creating a new document
                        await collection.add({
                          'title': _tasktitle.text,
                          'description': _taskdesc.text,
                          'due': _dateTime
                        });
                        Navigator.pop(context);
                        /*Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => Home()));*/
                      },
                      /*onPressed:(){
                                  print(_tasktitle.text);
                                  print(_taskdesc.text);
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => HomeScreen()));
                                },*/
                      textColor: Colors.white,
                      padding: const EdgeInsets.all(0.0),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(35.0)),
                      child: Container(
                        decoration: const BoxDecoration(
                            gradient: LinearGradient(
                              colors: <Color>[Colors.purple, Colors.blue],
                            ),
                            borderRadius: BorderRadius.all(Radius.circular(80.0))),
                        padding: const EdgeInsets.fromLTRB(80, 20, 80, 20),
                        child: const Text('ADD', style: TextStyle(fontSize: 20)),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      }
  
}
  
    _getUser() {
User user = FirebaseAuth.instance.currentUser;
    String uid = user.uid.toString();
    return uid;
}
