import 'package:flutter/material.dart';
import 'package:flutter_session/flutter_session.dart';

var session = FlutterSession();
/*
await session.set("token", myToken);
await session.set("name", "anubhav");
await session.set("id", 1);
await session.set("price", 10.50);
*/

class Data {
  final int id;
  // final String data;
  final Object data;
  Data({this.data, this.id});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data["id"] = this.id;
    data["data"] = this.data;
    return data;
  }
}

// Data mappedData = Data(data: "Lorem ipsum something, something...", id: 1);

/*
await FlutterSession().set('mappedData', mappedData);

dynamic token = await FlutterSession().get("token");
*/

class Saving extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: FutureBuilder(
          future: saveData(context),
          builder: (context, snapshot) {
            return Text("You will not see this");
          }),
    );
  }

  Future<void> saveData(context) async {
    Data myData = Data(
        data:
            "my data content it could be something like the token you got from the API",
        id: 1);

    await FlutterSession().set('myData', myData);
    // Navigator.push(context, MaterialPageRoute(builder: (_context) => Page2()));
  }
}

class Reading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: FutureBuilder(
          future: FlutterSession().get('myData'),
          builder: (context, snapshot) {
            return Text(snapshot.hasData
                ? snapshot.data['id'].toString() + "|" + snapshot.data['data']
                : 'Loading...');
          }),
    );
  }
}
