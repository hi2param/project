import 'package:firstproject/home%20_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_auth_buttons/flutter_auth_buttons.dart';

void main() {
  runApp(MaterialApp(
    home: MyMainPage(),
    ));
}

class MyMainPage extends StatefulWidget {
  @override
  _MyMainPageState createState() => _MyMainPageState();
}

class _MyMainPageState extends State<MyMainPage> {
FirebaseAuth _auth = FirebaseAuth.instance; 
bool isLogged = false;
FirebaseUser myUser;

Future<FirebaseUser> _loginWIthFacebook() async{
  var facebookLogin = new FacebookLogin();
  var result = await facebookLogin.logIn(['email']);

  debugPrint(result.status.toString());

   if(result.status == FacebookLoginStatus.loggedIn){
     AuthCredential authCredential  = FacebookAuthProvider.getCredential(accessToken: result.accessToken.token);
          // final AuthCredential credential = FacebookAuthProvider.getCredential(
          //     accessToken: result.accessToken.token);
              final FirebaseUser user = (await _auth.signInWithCredential(authCredential)).user;
    //  FirebaseUser user =
    //   await _auth.signInWithFacebook(accessToken: result.accessToken.token);
      
      return user;
   }
   return null;

}

// void _logout() async{
//   await _auth.signOut().then((response){
//      isLogged = false;
//      setState(() {});
//   });
// }

void _login(){
  _loginWIthFacebook().then((response){
    if(response != null){
      myUser = response;
      isLogged = true;
      setState(() {});
    }
  });
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text(isLogged ? "profile Page" : 'FaceBook Login'),
      //   actions: <Widget>[
      //     IconButton(icon: Icon(Icons.power_settings_new),
      //     onPressed: _logout,
      //     ), 
      //   ],
      // ),
      body: Center(
         child: isLogged ? HomePage()
        : FacebookSignInButton(
          
          onPressed: _login,
          ),
          ),
    );
  }
}