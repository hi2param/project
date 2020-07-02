import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
/*class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body:  Container(
        padding: new EdgeInsets.all(5.0),
        height: 250,
        child: new Swiper(
          itemBuilder: (BuildContext context,int index){
            return new Image.network("https://picsum.photos/250?image=9",fit: BoxFit.fitWidth,);
          },
          itemCount: 2,
          viewportFraction: 0.8,
          scale: 1.2,
          pagination: new SwiperPagination(),
         // control: new SwiperControl(),
        ),
      ),
    );
  }
}*/

class Home extends StatefulWidget {
  
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: new Column(

        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          // Container(
          //   padding: new EdgeInsets.all(5.0),
          //   height: 250,
          //   child: new Swiper(
          //     itemBuilder: (BuildContext context,int index){
          //       return new Image.network("https://picsum.photos/250?image=9",fit: BoxFit.fitWidth,);
          //     },
          //     itemCount: 2,
          //     viewportFraction: 0.8,
          //     scale: 1.2,
          //     pagination: new SwiperPagination(),
          //     // control: new SwiperControl(),
          //   ),
          // ),
          StreamBuilder(

            stream: Firestore.instance.collection("courses").snapshots(),
            builder: (context, snapshot){

              return Container(
                padding: new EdgeInsets.all(10.0),
                height: 220.0,
              
                
                child: Swiper(
                  itemCount:  snapshot.data.documents.length,
                  // itemCount: 2,
                  itemBuilder: (context, index){
                    DocumentSnapshot courses = snapshot.data.documents[index];
                   // if(snapshot.data == null) return CircularProgressIndicator();
                   // return ListTile(
                       return new Image.network(courses['img'], fit: BoxFit.fill,);

                     //// leading: SizedBox(
                      //  height: 350,
                      //  width: 350,
                      //  child: Image.network(courses['img'], fit: BoxFit.fill,),
                      //),
                    //);
                  },
                        viewportFraction: 1.0,
                  scale: 1.0,

                  pagination: new SwiperPagination(),
                ),

              );

            },
          ),
        
          
          StreamBuilder(
              stream: Firestore.instance.collection("text").snapshots(),
            builder: (context, snapshot){
             // if(snapshot.data == null) return CircularProgressIndicator();
                      return Container(
                        margin: EdgeInsets.only(left:40.0, right:40.0, top:30.0,),
                                              child: Column(
                        
                          children: <Widget>[
                             Text(
                            'About',
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              color: Colors.black,
                              fontSize:18.0,

                            ),
                            ),
          //                   TextField(
                              
          //  textInputAction: TextInputAction.next,
          //       autocorrect: true,
          //       keyboardType: TextInputType.multiline,
          //       maxLines: 4,
          //       textCapitalization: TextCapitalization.sentences,
          //       decoration: InputDecoration(
                  
          //          contentPadding: new EdgeInsets.fromLTRB(20.0, 10.0, 100.0, 10.0),
          //         hintText: 'Text Area',
          //         border: OutlineInputBorder(
          //           borderRadius: BorderRadius.all(Radius.circular(1.0)),
          //         ),
          //       ),
          //                   ),
                            
                            Text(snapshot.data.documents[0]['f text']),
            //    Container(  
            //    margin: EdgeInsets.only(left:40.0, right:40.0, top:30.0,),
               
            //   child: new TextField(
                
               
            //     textInputAction: TextInputAction.next,
            //     autocorrect: true,
            //     keyboardType: TextInputType.multiline,
            //     maxLines: 4,
            //     textCapitalization: TextCapitalization.sentences,
            //     decoration: InputDecoration(
            //        contentPadding: new EdgeInsets.fromLTRB(20.0, 10.0, 100.0, 10.0),
            //       hintText: 'Text Area',
            //       border: OutlineInputBorder(
            //         borderRadius: BorderRadius.all(Radius.circular(1.0)),
            //       ),
            //     ),

            //   ),
            // ),
                          ],
                 
                        ),
                      );
            },
          ),
          StreamBuilder(
              stream: Firestore.instance.collection("text").snapshots(),
            builder: (context, snapshot){
              //if(snapshot.data == null) return CircularProgressIndicator();
                      return Container(
                        margin: EdgeInsets.only(left:40.0, right:40.0, top:30.0,),
                                              child: Column(
                                               
                           
                        
                          children: <Widget>[
                             Text(
                            'Persional Info',
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 18.0,

                            ),
                            ),
                            
                            Text(snapshot.data.documents[0]['s text']),
            //    Container(  
            //    margin: EdgeInsets.only(left:40.0, right:40.0, top:30.0,),
               
            //   child: new TextField(
                 
            //     textInputAction: TextInputAction.next,
            //     autocorrect: true,
            //     keyboardType: TextInputType.multiline,
            //     maxLines: 4,
            //     textCapitalization: TextCapitalization.sentences,
            //     decoration: InputDecoration(
            //        contentPadding: new EdgeInsets.fromLTRB(20.0, 10.0, 100.0, 10.0),
            //       hintText: 'Text Area',
                
            //       border: OutlineInputBorder(
            //         borderRadius: BorderRadius.all(Radius.circular(1.0)),
            //       ),
            //     ),


            //   ),
            // ),
                          ],
                 
                        ),
                      );
            },
          ),
          StreamBuilder(
              stream: Firestore.instance.collection("text").snapshots(),
            builder: (context, snapshot){
              //if(snapshot.data == null) return CircularProgressIndicator();
                      return Container(
                        margin: EdgeInsets.only(left:40.0, right:40.0, top:30.0, bottom:30,),
                        
                                              child: Column(
                                                
                        
                          children: <Widget>[
                            Text(
                            'Description',
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 18.0,

                            ),
                            ),
                            
                            Text(snapshot.data.documents[0]['t text']),
            //    Container(  
            //    margin: EdgeInsets.only(left:40.0, right:40.0, top:30.0,),
               
            //   child: new TextField(
               
            //     textInputAction: TextInputAction.next,
            //     autocorrect: true,
            //     keyboardType: TextInputType.multiline,
            //     maxLines: 4,
            //     textCapitalization: TextCapitalization.sentences,
            //     decoration: InputDecoration(
            //        contentPadding: new EdgeInsets.fromLTRB(20.0, 10.0, 100.0, 10.0),
            //       hintText: 'Text Area',
                 
            //       border: OutlineInputBorder(
            //         borderRadius: BorderRadius.all(Radius.circular(1.0)),
            //       ),
            //     ),

            //   ),
            // ),
                          ],
                 
                        ),
                      );
            },
          ),
        ],


      ),
    );
  }
}


