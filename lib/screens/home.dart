import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import './countries.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  var _defaultCountryCode = "in";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('First News'),
        backgroundColor: Colors.black,
        actions: <Widget>[
          FlatButton(
            onPressed: () async {
              var countrycode = await Navigator.of(context).pushNamed(
                Countries.router,
              );
              if (countrycode.toString().isNotEmpty) {
                setState(() {
                  _defaultCountryCode = countrycode;
                });
              }
            },
            child: Text(
              'Change',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
              ),
            ),
          ),
        ],
      ),
      body: FutureBuilder(
        future: http.get(
            'http://newsapi.org/v2/top-headlines?country=$_defaultCountryCode&category=business&apiKey=82a23e9532034f8bbb16bac7b3d940a8'),
        builder: (context, newsData) => newsData.connectionState ==
                ConnectionState.waiting
            ? Center(
                child: CircularProgressIndicator(),
              )
            : ListView.builder(
                itemCount: json.decode(newsData.data.body)['articles'].length,
                itemBuilder: (context, index) => Card(
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      children: <Widget>[
                        Image.network(
                          json.decode(newsData.data.body)['articles'][index]
                                  ['urlToImage'] ??
                              "https://i.ya-webdesign.com/images/no-image-available-png-4.png",
                          loadingBuilder: (context, child, progress) {
                            if (progress == null) return child;

                            return Container(
                              height: 200,
                              width: double.infinity,
                              child: Center(
                                child: CircularProgressIndicator(
                                    value: progress.expectedTotalBytes != null
                                        ? progress.cumulativeBytesLoaded /
                                            progress.expectedTotalBytes
                                        : null),
                              ),
                            );
                          },
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Text(
                          json.decode(newsData.data.body)['articles'][index]
                              ['title'],
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
      ),
    );
  }
}
