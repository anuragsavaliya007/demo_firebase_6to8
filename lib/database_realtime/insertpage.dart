import 'package:demo_firebase_6to8/database_realtime/viewpage.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class insertpage extends StatefulWidget {
  Map? map;

  insertpage({this.map});

  @override
  State<insertpage> createState() => _insertpageState();
}

class _insertpageState extends State<insertpage> {
  TextEditingController tname = TextEditingController();
  TextEditingController tcontact = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    if (widget.map != null) {
      tname.text = widget.map!['name'];
      tcontact.text = widget.map!['contact'];
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(child: Scaffold(
      appBar: AppBar(
        leading: IconButton(onPressed: () {
          Navigator.pushReplacement(context, MaterialPageRoute(
            builder: (context) {
              return viewpage();
            },
          ));
        }, icon: Icon(Icons.arrow_back)),
        title: Text("Insert Page"),
      ),
      body: Column(
        children: [
          TextField(
            controller: tname,
          ),
          TextField(
            controller: tcontact,
          ),
          ElevatedButton(
              onPressed: () {
                FirebaseDatabase database = FirebaseDatabase.instance;

                String name = tname.text;
                String contact = tcontact.text;

                if (widget.map == null) {
                  DatabaseReference ref = database.ref("contactbook").push();

                  String? userid = ref.key;

                  Map m = {"userid": userid, "name": name, "contact": contact};

                  ref.set(m);
                } else {
                  String userid = widget.map!['userid'];
                  DatabaseReference ref =
                  database.ref("contactbook").child(userid);

                  Map m = {"userid": userid, "name": name, "contact": contact};

                  ref.set(m);
                }

                Navigator.pushReplacement(context, MaterialPageRoute(
                  builder: (context) {
                    return viewpage();
                  },
                ));
              },
              child: Text(widget.map ==null ? "Insert" : "Update"))
        ],
      ),
    ), onWillPop: goback);
  }

  Future<bool> goback()
  {
    Navigator.pushReplacement(context, MaterialPageRoute(
      builder: (context) {
        return viewpage();
      },
    ));

    return Future.value();
  }
}
