import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'top_view.dart';
import '../models/user_model.dart';

class SimpleLoginScreen extends StatefulWidget {
  const SimpleLoginScreen({Key? key}) : super(key: key);

  @override
  _SimpleLoginScreenState createState() => _SimpleLoginScreenState();
}

class _SimpleLoginScreenState extends State<SimpleLoginScreen> {
  String userName = "";
  String age = "";
  String sex = "";
  String height = "";
  String weight = "";

  @override
  Widget build(BuildContext context) {
    final bottomSpace = MediaQuery.of(context).viewInsets.bottom;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text('Sign Up'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Center(
            child: SingleChildScrollView(
                reverse: true,
                child: Padding(
                  padding: EdgeInsets.only(bottom: bottomSpace),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text(
                        'Sign Up',
                        style: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 30),
                      TextFormField(
                        decoration: const InputDecoration(
                          icon: Icon(Icons.people),
                          labelText: 'Name',
                        ),
                        onChanged: (String value) {
                          setState(() {
                            userName = value;
                          });
                        },
                      ),
                      TextFormField(
                        decoration: const InputDecoration(
                          icon: Icon(Icons.numbers),
                          labelText: 'Age',
                        ),
                        onChanged: (String value) {
                          setState(() {
                            age = value;
                          });
                        },
                      ),
                      TextFormField(
                        decoration: const InputDecoration(
                          icon: Icon(Icons.wc),
                          labelText: 'Gender',
                        ),
                        onChanged: (String value) {
                          setState(() {
                            sex = value;
                          });
                        },
                      ),
                      TextFormField(
                        decoration: const InputDecoration(
                          icon: Icon(Icons.height),
                          labelText: 'Height',
                        ),
                        onChanged: (String value) {
                          setState(() {
                            height = value;
                          });
                        },
                      ),
                      TextFormField(
                        decoration: const InputDecoration(
                          icon: Icon(Icons.scale),
                          labelText: 'Weight',
                        ),
                        onChanged: (String value) {
                          setState(() {
                            weight = value;
                          });
                        },
                      ),
                      const SizedBox(height: 30),
                      RegisterButton(userName, age, sex, height, weight)
                    ],
                  ),
                ))),
      ),
    );
  }
}

class RegisterButton extends StatelessWidget {
  String userName = "";
  String age = "";
  String sex = "";
  String height = "";
  String weight = "";
  RegisterButton(this.userName, this.age, this.sex, this.height, this.weight,
      {Key? key})
      : super(key: key);

  Future _postInf() async {
    String url = "http://localhost:8000/user-create";
    Map<String, String> headers = {"content-type": "application/json"};
    final obj = {
      "userName": userName,
      "age": int.parse(age),
      "sex": int.parse(sex),
      "height": int.parse(height),
      "weight": int.parse(weight)
    };
    String body = json.encode(obj);
    print(body);

    http.Response res =
        await http.post(Uri.parse(url), headers: headers, body: body);
    return res;
  }

  Future _updateStatus() async {
    // resのステータスチェック
    //   if (res.statusCode != 200) {
    final res = await _postInf();
    if (res == null) return null;
    final body = json.decode(res.body);
    final user = User.fromJson(body);
    return user;
  }

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, ref, child) {
      final notifier = ref.read(topPageProvider.notifier);
      return ElevatedButton(
        onPressed: () {
          _updateStatus()
              .then((user) => notifier.register(
                  user.id,
                  user.userName,
                  user.status,
                  user.stapleValue,
                  user.mainValue,
                  user.sideValue))
              .whenComplete(() => Navigator.of(context).pop());
        },
        child: const Text('Sign Up'),
      );
    });
  }
}
