import 'package:flutter/material.dart';
import 'package:flutterapplicationloginpage/data/join_or_login.dart';

class LoginBackground extends CustomPainter{

  LoginBackground({@required this.isJoin});//optional
  final bool isJoin;

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint1 = Paint()..color=isJoin?Colors.red:Colors.blue;
    Paint paint2 = Paint()..color=Colors.white;
    Paint paint3 = Paint()..color=isJoin?Colors.blue:Colors.red;
    //위 문장은 Paint paint; paint.color = Colors.blueAccent와 같다.
    //즉, 해당 Paint클래스의 객체 paint의 변수 color에 빠르게 접근하는 ShortCut이다.
    canvas.drawCircle(Offset(size.width*0.2,size.height*0.2),size.height*0.5,paint1);
    canvas.drawCircle(Offset(size.width*0.9,size.height*1.3),size.height*0.5,paint2);
    canvas.drawCircle(Offset(size.width*0.9,size.height*1.3),size.height*0.48,paint3);
    canvas.drawCircle(Offset(size.width*0.9,size.height*1.3),size.height*0.46,paint2);
    canvas.drawCircle(Offset(size.width*0.9,size.height*1.3),size.height*0.44,paint3);
    canvas.drawCircle(Offset(size.width*0.9,size.height*1.3),size.height*0.42,paint2);
    canvas.drawCircle(Offset(size.width*0.9,size.height*1.3),size.height*0.40,paint3);

  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    // TODO: implement shouldRepaint

    return false;
  }//프레임별로 계속 그리냐?

}