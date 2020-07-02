import 'package:flutter/material.dart';
import 'package:firstproject/home.dart';
import 'package:firstproject/customer_profile.dart';
import 'package:firstproject/condidate_profile.dart';

class HomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {

    final tabController = new DefaultTabController(
      length: 3,
      child: new Scaffold(
        backgroundColor: Colors.white,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(50.0),
          child: AppBar(
            backgroundColor: Colors.white,
            bottom: new TabBar(
                indicatorColor: Colors.red,
                indicatorWeight: 1.0,
                tabs: [
                  new Tab(icon: new Icon(Icons.home, color: Colors.black,),),
                  new Tab(icon: new Icon(Icons.group, color: Colors.black,),),
                  new Tab(icon: new Icon(Icons.person, color: Colors.black,), ),

                ]),
          ),
        ),
        body: new TabBarView(
            children: [
              new Home(),
              new CustomerProfile(),
              new CondidateProfile(),

            ]
        ),
      ),
    );
    return new MaterialApp(
        title: "Home",
        home: tabController
    );
  }
}

