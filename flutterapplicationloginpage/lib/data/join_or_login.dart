import 'package:flutter/foundation.dart';

class JoinOrLogin extends ChangeNotifier{
  //변경될때마다 종속된 위젯들이 알림을 받는다.
  bool _isJoin = true;

  bool get isJoin => _isJoin;
  void toggle(){
    _isJoin = !_isJoin;
    notifyListeners();
  }
}
