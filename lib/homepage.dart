import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String newquotes = "loading";
  String author = "loading";
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    apiCall();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: GestureDetector(
          onPanStart: (updateQuote) {
            apiCall();
          },
          child: Stack(
            children: [
              Container(
                height: double.infinity,
                child: Image.asset(
                  "assets/bg.jpg",
                  fit: BoxFit.fill,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // text for quote
                    Text(
                      newquotes,
                      style: TextStyle(
                          color: Colors.amber,
                          fontSize: 30,
                          fontWeight: FontWeight.w900),
                    ),
                    SizedBox(height: 20),

                    // for Author's Name
                    Row(
                      children: [
                        Spacer(),
                        Text(
                          author,
                          style: TextStyle(
                              color: Colors.amber,
                              fontSize: 20,
                              fontWeight: FontWeight.w900),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  apiCall() {
    http.get(Uri.parse("http://api.quotable.io/random")).then((value) {
      var jsonResp = jsonDecode(value.body);
      newquotes = jsonResp["content"];
      author = jsonResp["author"];
      print("${newquotes}");
      print(author);
      setState(() {});
    });
  }
}
