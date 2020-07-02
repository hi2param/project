import 'package:firstproject/camerascreen.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


//import 'package:intl/intl.dart' show DateFormat;


class FireStore  extends StatelessWidget {
  
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
          home: Scaffold(
         body: new StreamBuilder(
            stream: Firestore.instance.collection('profile').snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
           //Navigator.push(context, MaterialPageRoute(builder: (context) => CustomerProfile()));
           if (!snapshot.hasData) {
           return CircularProgressIndicator();
           }
           return CircularProgressIndicator();
        },
      ),
      ),
    );
  }
}

class CustomerProfile extends StatefulWidget {

  @override
  _CustomerProfileState createState() => _CustomerProfileState();
}

class _CustomerProfileState extends State<CustomerProfile> {
   final databaseReference = Firestore.instance;

   final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
   String _district, _name, _gender, _dob, _issuedate, _idNumber, _address;

   List<String> typeNeg = [
"Male",
"Female",
"Other",];
  String dropdownValue = "Male";

  @override
  Widget build(BuildContext context) {

    return new SingleChildScrollView(

        child: Card(
          child: Padding(
            padding: EdgeInsets.all(25.0),
            child: Form(
              key: _formKey,
              child: Column(

                
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      new Container(
                        child: new Image.asset(
                          'assets/fb_image.png',
                          height: 25.0,
                          fit: BoxFit.cover,
                        ),
                        
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 15.0),
                         child: 
                         Text(
                         'Facebook'
                        ),
                        //Text(' ' + myUser.displayName),
                      )
                    ],
                  ),
                     TextFormField(
                      decoration: InputDecoration(
                          labelText: 'District Name'
                      ),
                      //validator: (input) => !input.contains('@') ? 'Not a valid Email' : null,
                     // validator: (value) => value.isEmpty ? 'District Name cannot be blank':null,
                     validator: (value) {
    if (value.isEmpty) {
      return 'Please enter some text';
    }
    return null;
  },
                      onSaved: (value) {
                        _district = value;
                      },
                    ),
                  
                  
                                      TextFormField(
                      decoration: InputDecoration(
                          labelText: ' Full Name'
                      ),
                     // validator: (input) => input.length < 8 ? 'You need at least 8 characters' : null,
                     // validator: (value) => value.isEmpty ? ' Name cannot be blank':null,
                     validator: (value) {
    if (value.isEmpty) {
      return 'Please enter some text';
    }
    return null;
  },
                      onSaved: (value) {
                        _name = value;
                      },
                      
                    ),
                  
                  DropdownButtonFormField<String>(
                    value: dropdownValue,
                    hint: Text("Gender"),
                    onChanged: (String newValue) {
                      setState(() {
                        dropdownValue = newValue;
                      });
                    },
                    validator: (value) {
                               if (value.isEmpty) {
                             return 'Please select gender';
                            }
                               return null;
                        },
                         items: typeNeg
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                   onSaved: (value) {
                        _gender = value;
                      },
                  ),
                  
                      TextFormField(
                      decoration: InputDecoration(
                          labelText: ' D.O.B'
                      ),
                     validator: (value) {
                             if (value.isEmpty) {
                                  return 'Please enter some text';
                                     }
                                   return null;
                    },
                      onSaved: (value) {
                        _dob = value;
                      },



                   ),
                   
                                        TextFormField(
                      decoration: InputDecoration(
                          labelText: ' Adhar Card Number'
                      ),
                     // validator: (input) => input.length < 15 ? 'You need at least 8 characters' : null,
                      //validator: (value) => value.isEmpty ? 'adhar card number cannot be blank':null,
                      validator: (value) {
    if (value.length <15) {
      return 'Please enter correct id';
    }
    return null;
  },
                      onSaved: (value) {
                        _idNumber = value;
                      },
                      
                  ),
                   
                                      TextFormField(
                      decoration: InputDecoration(
                          labelText: ' Expiry Date'
                      ),
                     // validator: (input) => input.length < 8 ? 'You need at least 8 characters' : null,
                     // validator: (value) => value.isEmpty ? 'Expiry Date cannot be blank':null,
                     validator: (value) {
    if (value.isEmpty) {
      return 'Please enter some text';
    }
    return null;
  },
                      onSaved: (value) {
                        _issuedate = value;
                      },
                      
                    ),
                  
                                     TextFormField(
                      decoration: InputDecoration(
                          labelText: ' Address'
                      ),
                     // validator: (input) => input.length < 8 ? 'You need at least 8 characters' : null,
                      //validator: (value) => value.isEmpty ? 'address cannot be blank':null,
                      validator: (value) {
    if (value.isEmpty) {
      return 'Please enter some text';
    }
    return null;
  },
                       onSaved: (value) {
                        _address = value;
                      },
                      
                    ),
                  
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      
                      
                      Container(
                        margin: EdgeInsets.only(top: 25.0),
                        child: Text(
                         'Front Image With Adhar Card',
                         
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 25.0),
                                              child: IconButton(
                          icon: Icon(Icons.photo_camera),
                          onPressed: () {
                            Navigator.push(
         context,
         MaterialPageRoute(
           builder: (context) => CameraScreen(),
         ),
     );
                 
                          },
                        ),
                      )
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: RaisedButton(
                          onPressed: (){
if (_formKey.currentState.validate()) {
  _sendToServer();
 Scaffold
          .of(context)
          .showSnackBar(SnackBar(content: Text('Processing Data')));
    }
                          },
                          child: Text('Submit'),
                          textColor: Colors.white,
                          color: Colors.black87,
                          
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
        ));
  }

  _sendToServer(){
    
      
      _formKey.currentState.save();
      Firestore.instance.runTransaction((Transaction transaction) async {
        CollectionReference reference = Firestore.instance.collection('profile');

        await reference.add({"district": _district, "name": _name, "gender": _gender, "dob": _dob
        , "adharnumber": _idNumber, "expirydate": _issuedate, "address": _address});
      });
   

  }
}
    
