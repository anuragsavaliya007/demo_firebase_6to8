import 'package:demo_firebase_6to8/database_realtime/insertpage.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class viewpage extends StatefulWidget {
  const viewpage({Key? key}) : super(key: key);

  @override
  State<viewpage> createState() => _viewpageState();
}

class _viewpageState extends State<viewpage> {
  List l = [];

  bool status = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    loadAllData();
  }

  loadAllData() async {
    DatabaseReference ref = FirebaseDatabase.instance.ref("contactbook");

    DatabaseEvent databaseEvent = await ref.once();

    DataSnapshot snapshot = databaseEvent.snapshot;

    print(snapshot.value);

    Map map = snapshot.value as Map;

    map.forEach((key, value) {
      // Map m = {"key" : key};
      // m.addAll(value);
      l.add(value);
    });

    setState(() {
      status = true;
    });
    print(l);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("View Data"),
      ),
      floatingActionButton: FloatingActionButton(onPressed: () {
        Navigator.pushReplacement(context, MaterialPageRoute(
          builder: (context) {
            return insertpage();
          },
        ));
      },child: Icon(Icons.add)),
      body: status
          ? ListView.builder(
              itemCount: l.length,
              itemBuilder: (context, index) {
                Map m = l[index];

                User user = User.fromJson(m);
                return ListTile(
                  onTap: () {
                    showDialog(
                        builder: (context1) {
                          return SimpleDialog(
                            title: Text("Select Choice"),
                            children: [
                              ListTile(
                                onTap: () {
                                  Navigator.pop(context1);

                                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
                                    return insertpage(map: m);
                                  },));

                                },
                                title: Text("Update"),
                              ),
                              ListTile(
                                onTap: () async {
                                  Navigator.pop(context1);
                                  DatabaseReference ref = FirebaseDatabase
                                      .instance
                                      .ref("contactbook")
                                      .child(user.userid!);

                                  await ref.remove();

                                  Navigator.pushReplacement(context,
                                      MaterialPageRoute(
                                    builder: (context) {
                                      return viewpage();
                                    },
                                  ));
                                },
                                title: Text("Delete"),
                              ),
                            ],
                          );
                        },
                        context: context);
                  },
                  title: Text("${user.name}"),
                  subtitle: Text("${user.contact}"),
                );
              },
            )
          : Center(child: CircularProgressIndicator()),
    );
  }
}

class User {
  String? contact;
  String? name;
  String? userid;

  User({this.contact, this.name, this.userid});

  User.fromJson(Map json) {
    contact = json['contact'];
    name = json['name'];
    userid = json['userid'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['contact'] = this.contact;
    data['name'] = this.name;
    data['userid'] = this.userid;
    return data;
  }
}
