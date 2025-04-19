import 'dart:async';
import 'common.dart'; // Assuming you have a Common class for logging

class TimerUtils {
  Timer? _checkTypingTimer;

  void startTypingTimer(Function(String) onTimerEnd, String searchText, {int millis = 1500}) {
    _checkTypingTimer?.cancel();
    _checkTypingTimer = Timer(Duration(milliseconds: millis), () {
      onTimerEnd(searchText);
    });
  }

  void startTimer(Function() onTimerEnd){
    _checkTypingTimer?.cancel();
    _checkTypingTimer = Timer(const Duration(milliseconds: 500), () {
      onTimerEnd();
    });
  }

  void resetTimer() {
    _checkTypingTimer?.cancel();
  }


}