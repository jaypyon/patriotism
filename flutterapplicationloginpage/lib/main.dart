import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'data/join_or_login.dart';
import 'screens/login.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}
//모든 컴포넌트가 위젯이다. 위젯트리형식 ( 리엑트의 돔트리같은 느낌인듯 )

class MyApp extends StatelessWidget{
  //StatelessWidget과 StatefulWidget으로 나뉜다.
  //클래스의 상태변화가 있는지 없는지에 따라 바뀐다.
  //전체화면
  @override
  Widget build(BuildContext context){
    //TODO : implement build
    return MaterialApp(
      home:ChangeNotifierProvider<JoinOrLogin>.value(
          value:JoinOrLogin(),
          child: AuthPage()),
    );

  }
}

