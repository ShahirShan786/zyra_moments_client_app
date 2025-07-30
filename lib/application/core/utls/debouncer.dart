import 'dart:async';
import 'dart:ui';

class Debouncer {
  final Duration delay;
  VoidCallback? action;
  Timer? _timer;

  Debouncer({this.delay = const Duration(milliseconds: 500)});

  run(VoidCallback action){
    _timer?.cancel();
    _timer = Timer(delay, action);
  }

  dispose(){
    _timer?.cancel();
  }

}