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
  String email = '';
  String password = '';
  bool hidePassword = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sign Up'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'Login',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                ),
              ),
              TextFormField(
                decoration: const InputDecoration(
                  icon: Icon(Icons.mail),
                  hintText: 'hogehoge@qmail.com',
                  labelText: 'Email Address',
                ),
                onChanged: (String value) {
                  setState(() {
                    email = value;
                  });
                },
              ),
              TextFormField(
                obscureText: hidePassword,
                decoration: InputDecoration(
                  icon: const Icon(Icons.lock),
                  labelText: 'Password',
                  suffixIcon: IconButton(
                    icon: Icon(
                      hidePassword ? Icons.visibility_off : Icons.visibility,
                    ),
                    onPressed: () {
                      setState(() {
                        hidePassword = !hidePassword;
                      });
                    },
                  ),
                ),
                onChanged: (String value) {
                  setState(() {
                    password = value;
                  });
                },
              ),
              const SizedBox(height: 15),
              const RegisterButton()
            ],
          ),
        ),
      ),
    );
  }
}

class RegisterButton extends StatelessWidget {
  const RegisterButton({Key? key}) : super(key: key);

  Future _postInf() async {
    String url = "http://localhost:8000/user-create";
    Map<String, String> headers = {"content-type": "application/json"};
    final obj = {
      "userName": "testUser",
      "age": 22,
      "sex": 1,
      "height": 170,
      "weight": 60
    };
    String body = json.encode(obj);

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
    // final user = User.fromJson({"id": 0, "userName": "testUser", "status": 0});
    return user;
  }

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, ref, child) {
      final notifier = ref.read(topPageProvider.notifier);
      return ElevatedButton(
        onPressed: () {
          _updateStatus()
              .then((user) =>
                  notifier.register(user.id, user.userName, user.status))
              .whenComplete(() => Navigator.of(context).pop());
        },
        child: const Text('Sign Up'),
      );
    });
  }
}
