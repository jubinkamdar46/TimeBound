import 'dart:ui';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UpdateTask extends StatefulWidget {
  final id;
  final String title;
  final String desc;
  //final due;
  UpdateTask({this.id, this.title, this.desc});//,this.due
  @override
  _UpdateTaskState createState() => _UpdateTaskState();
}

class _UpdateTaskState extends State<UpdateTask> {
  //final collection = FirebaseFirestore.instance.collection('tasks');
  TextEditingController _tasktitle = TextEditingController();
  TextEditingController _taskdesc = TextEditingController();
  DateTime _dateTime = DateTime.now();
  final _formKey = GlobalKey<FormState>();
  

  @override
  Widget build(BuildContext context) {
    final uid = _getUser();
      final collection = FirebaseFirestore.instance.collection(uid);
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            color: Colors.white,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Container(
                  //height: 500,
                  width: 400,
                  child: FittedBox(
                    child: Image(
                      image: AssetImage("assets/updatetask.png"),
                      height: 200.0,
                    ),
                    fit: BoxFit.fitWidth,
                  ),
                  //color: Colors.transparent,
                ),
                SizedBox(
                  height: 5,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20)),
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey[300],
                                  blurRadius: 10.0,
                                  spreadRadius: 1.0,
                                ),
                              ]),
                          width: 350,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.fromLTRB(25, 8, 8, 4),
                                child: Text(
                                  "Title:",
                                  style: TextStyle(fontSize: 12),
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(25, 0, 25, 8),
                                child: TextFormField(
                                  decoration: InputDecoration(
                                    hintText: widget.title,
                                  ),
                                  controller: _tasktitle,
                                  validator: (value) {
                                    if (value.isEmpty) {
                                      _tasktitle.text = widget.title;
                                    }
                                    return null;
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20)),
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey[300],
                                  blurRadius: 10.0,
                                  spreadRadius: 1.0,
                                ),
                              ]),
                          width: 350,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.fromLTRB(25, 8, 8, 4),
                                child: Text(
                                  "Description:",
                                  style: TextStyle(fontSize: 12),
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(25, 0, 25, 8),
                                child: TextFormField(
                                  controller: _taskdesc,
                                  keyboardType: TextInputType.multiline,
                                  maxLines: 5,
                                  decoration:
                                      InputDecoration(hintText: widget.desc),
                                  //hintText: "Description",
                                  validator: (value) {
                                    if (value.isEmpty) {
                                     _taskdesc.text = widget.desc;
                                    }
                                    return null;
                                  },
                                  /*onChanged: (val) {
                                    _taskdesc = val;
                                  },*/
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                           
                            Container(
                              height: 100,
                              width: 300,
                              decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(30)),
                                color: Colors.white,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey[300],
                                    blurRadius: 10.0,
                                    spreadRadius: 1.0,
                                  ),
                                ],
                              ),
                              child: //Text(""),
                                  CupertinoDatePicker(
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
                        SizedBox(
                          height: 20,
                        ),
                        RaisedButton(
                          onPressed: () async {
                            if (_formKey.currentState.validate()) {
                              print(_tasktitle.text);
                              print(_taskdesc.text);
                              print(_dateTime);
                              /*if(_dateTime.toString() == widget.due){
                                await collection.doc(widget.id).update({
                                //await collection.doc().update({
                                'title': _tasktitle.text,
                                'description': _taskdesc.text,
                                'due': _dateTime
                              });
                              }
                              else{
                                await collection.doc(widget.id).update({
                                //await collection.doc().update({
                                'title': _tasktitle.text,
                                'description': _taskdesc.text,
                                'due': widget.due
                              });
                              }*/
                              await collection.doc(widget.id).update({
                                //await collection.doc().update({
                                'title': _tasktitle.text,
                                'description': _taskdesc.text,
                                'due': _dateTime
                              });
                              Navigator.pop(context);
                              /*Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => Home()));*/
                            }
                          },
                          textColor: Colors.white,
                          padding: const EdgeInsets.all(0.0),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(40.0)),
                          child: Container(
                            decoration: const BoxDecoration(
                                gradient: LinearGradient(
                                  colors: <Color>[Colors.purple, Colors.blue],
                                ),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20.0))),
                            padding: const EdgeInsets.fromLTRB(90, 20, 90, 20),
                            child: const Text('SAVE',
                                style: TextStyle(fontSize: 20)),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
              ],
            ),
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