import 'package:flutter/material.dart';

import 'Data.dart';
import 'package:page_view_indicator/page_view_indicator.dart';



void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: 'Quicksand',
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int indexPage = 0;
  PageController pc = new PageController(initialPage: 0);

  final pageIndexNotifier = ValueNotifier<int>(0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        child: PageView(
          controller: pc,
          children: myData.map((item) {
            return Container(
              width: double.infinity,
              height: double.infinity,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 150,
                  ),
                  Image.asset(
                    "assets/images/" + item.imageName.toString(),
                    width: double.infinity,
                    height: 350,
                    fit: BoxFit.fitWidth,
                  ),
                  Text(
                    item.tiltle.toString(),
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                    child: Text(
                      item.subTitle.toString(),
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  SizedBox(
                    height: indexPage<=2?150:80,
                  ),
                  indexPage<=2?Container(
                    margin: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Icon(
                          Icons.arrow_back,
                          color: Colors.redAccent,
                          size: 35,
                        ),
                        PageViewIndicator(
                          pageIndexNotifier: pageIndexNotifier,
                          length: myData.length,
                          normalBuilder: (_, index) => Circle(
                            size: 8.0,
                            color: Colors.grey,
                          ),
                          highlightedBuilder: (animationController, _) =>
                              ScaleTransition(
                            scale: CurvedAnimation(
                              parent: animationController,
                              curve: Curves.ease,
                            ),
                            child: Circle(
                              size: 12.0,
                              color: Colors.redAccent,
                            ),
                          ),
                        ),
                        FloatingActionButton(
                          onPressed: () {
                            setState(() {
                              indexPage++;
                            });
                            // pageIndexNotifier.value = indexPage;
                          },
                          child: Icon(Icons.arrow_forward),
                          backgroundColor: Colors.redAccent,
                        )
                      ],
                    ),
                  ):RaisedButton(
                    color: Colors.redAccent,
                    textColor: Colors.white,
                      onPressed: () {
                      },

                    child: Text("Start Shopping",style: TextStyle(fontSize: 18),),),
                ],
              ),
            );
          }).toList(),
          onPageChanged: (val) {
            pageIndexNotifier.value = val;
            setState(() {
              indexPage = val;
            });
          },
        ),
      ),
    );
  }
}
