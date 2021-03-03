//import 'dart:js';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutterapplicationloginpage/data/join_or_login.dart';
import 'package:flutterapplicationloginpage/helper/login_background.dart';
import 'package:flutterapplicationloginpage/screens/mainpage.dart';
import 'package:provider/provider.dart';

class AuthPage extends StatelessWidget {
  @override
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          Container(
            color: Colors.blue,
          ),
          CustomPaint(
            size: size,
            painter: LoginBackground(
                isJoin: Provider.of<JoinOrLogin>(context).isJoin),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              logoImage(),
              Stack(
                children: <Widget>[
                  inputBox(size),
                  loginButton(size),
                ],
              ),
              Container(height: size.height * 0.10),
              Consumer<JoinOrLogin>(
                builder:
                    (BuildContext context, JoinOrLogin value, Widget child) =>
                        Padding(
                  padding: const EdgeInsets.only(left: 250),
                  child: GestureDetector(
                      onTap: () {
                        value.toggle();
                      },
                      child: value.isJoin
                          ? Text("新規登録",
                              style:
                                  TextStyle(fontWeight: FontWeight.bold,fontSize: 15, color: Colors.white))
                          : Text(
                              "ログイン",
                              style:
                                  TextStyle(fontWeight: FontWeight.bold,fontSize: 15, color: Colors.white),
                            )),
                ),
              ),
              Container(height: size.height * 0.05),
            ],
          ),
        ],
      ),
    );
  }

  void _register(BuildContext context) async{

    final UserCredential result = await FirebaseAuth.instance.createUserWithEmailAndPassword(email: _emailController.text, password: _passwordController.text);
    final User user = result.user;
    print("reg");
    if(user == null){
      final snacBar = SnackBar(content: Text("Please try again later"));
      Scaffold.of(context).showSnackBar(snacBar);
    }
    //Navigator.push(context,MaterialPageRoute(builder: (context)=>MainPage(email: user.email)));
  }

  void _login(BuildContext context) async{
    final UserCredential result = await FirebaseAuth.instance.signInWithEmailAndPassword(email: _emailController.text, password: _passwordController.text);
    final User user = result.user;
    print("log");
    if(user == null){
      final snacBar = SnackBar(content: Text("Please try again later"));
      Scaffold.of(context).showSnackBar(snacBar);
    }
    Navigator.push(context,MaterialPageRoute(builder: (context)=>MainPage(email: user.email)));
  }

  Widget logoImage() {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.only(
          left: 24,
          right: 24,
          top: 90,
          bottom: 10,
        ),
        child: FittedBox(
          child: CircleAvatar(
            backgroundImage: AssetImage('assets/korea.jfif'),


          ),
        ),
      ),
    );
  }

  Widget loginButton(Size size) {
    return Positioned(
      left: size.width * 0.1,
      right: size.width * 0.1,
      bottom: 0,
      child: SizedBox(
          height: 40,
          child: Consumer<JoinOrLogin>(
              builder:
                  (BuildContext context, JoinOrLogin value, Widget child) =>
                      RaisedButton(
                        color: value.isJoin?Colors.blueAccent:Colors.redAccent,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15)),
                        child: value.isJoin?Text("ログイン",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white)):Text("新規登録",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white)),
                        onPressed: () {
                          if(value.isJoin){
                            //로그인
                            if (_formKey.currentState.validate()) {
                              _login(context);
                            }
                          }else{
                            _register(context);
                            //회원가입
                          }

                        },
                      ))),
    );
  }

  Widget inputBox(Size size) {
    return Padding(
      padding: EdgeInsets.all(size.width * 0.05),
      child: Card(
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
        elevation: 6,
        child: Padding(
          padding:
              EdgeInsets.only(left: 12.0, right: 12.0, top: 12.0, bottom: 32.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                TextFormField(
                  controller: _emailController,
                  decoration: InputDecoration(
                    icon: Icon(Icons.account_box),
                    labelText: "Email",
                  ),
                  validator: (String value) {
                    //check
                    if (value.isEmpty) {
                      return "メールを記入してください";
                    }
                    return null;
                  },
                ),
                TextFormField(
                  obscureText: true,
                  controller: _passwordController,
                  decoration: InputDecoration(
                    icon: Icon(Icons.vpn_key),
                    labelText: "Password",
                  ),
                  validator: (String value) {
                    //check
                    if (value.isEmpty) {
                      return "パスワードを記入してください";
                    }
                    return null;
                  },
                ),
                Container(
                  height: 8,
                ),
                Consumer<JoinOrLogin>(
                  builder: (context,value,child)=>Opacity(
                    opacity: value.isJoin?1:0,
                    child:Text("パスワードを忘れましたか？"),

                  ),
                ),

              ],
            ),
          ),
        ),
      ),
    );
  }
}
