import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flash_chat/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ChatScreen extends StatefulWidget {
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final msgcontroller = TextEditingController();
  final _auth = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance;
  String text;

  @override
  void initState() {
    super.initState();

    currentuser();
  }

  void currentuser() {
    final user = _auth.currentUser;
    if (user == null) {
      print(user == null);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: null,
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.close),
              onPressed: () {
                _auth.signOut();
                Navigator.pop(context);
              }),
        ],
        title: Text('⚡️Chat'),
        backgroundColor: Colors.lightBlueAccent,
      ),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            StreamBuilder<QuerySnapshot>(
              stream: _firestore
                  .collection('chat')
                  .orderBy('timestamp',descending: true)
                  .snapshots(),
              builder: (context, snapshot) {
                List<Msgbubble> msg = [];
                if (snapshot.hasData) {
                  snapshot.data.docs.forEach(
                    (doc) {
                      final msgtext = doc["text"];
                      final msgid = doc["id"];

                      msg.add(
                        Msgbubble(
                          text: msgtext,
                          sender: msgid,
                          me: msgid == _auth.currentUser.email,
                        ),
                      );
                    },
                  );
                }

                return Expanded(
                  child: ListView(
                    reverse: true,
                    children: msg,
                  ),
                );
              },
            ),
            Container(
              decoration: kMessageContainerDecoration,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: TextField(
                      controller: msgcontroller,
                      style: TextStyle(color: Colors.black),
                      onChanged: (value) {
                        text = value;
                      },
                      decoration: kMessageTextFieldDecoration,
                    ),
                  ),
                  // ignore: deprecated_member_use
                  FlatButton(
                    onPressed: () {
                      msgcontroller.clear();

                      _firestore.collection('chat').add({
                        'timestamp': Timestamp.now(),
                        'text': text,
                        'id': _auth.currentUser.email,
                      });
                    },
                    child: Text(
                      'Send',
                      style: kSendButtonTextStyle,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Msgbubble extends StatelessWidget {
  Msgbubble({this.text, this.sender, this.me});

  final String text;
  final String sender;
  final bool me;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment:
          me ? CrossAxisAlignment.end : CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(right: 10, left: 10),
          child: Text(
            sender,
            style: TextStyle(color: Colors.black54),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(bottom: 15, right: 10, left: 10),
          child: Material(
              elevation: 5.0,
              color: me ? Colors.blueAccent : Color(0xFF009688),
              borderRadius: BorderRadius.only(
                  topLeft: me ? Radius.circular(30) : Radius.circular(0),
                  bottomLeft: Radius.circular(30),
                  bottomRight: Radius.circular(30),
                  topRight: me ? Radius.circular(0) : Radius.circular(30)),
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                child: Text(
                  text,
                  style: TextStyle(fontSize: 20.0, color: Colors.white),
                ),
              )),
        ),
      ],
    );
  }
}
