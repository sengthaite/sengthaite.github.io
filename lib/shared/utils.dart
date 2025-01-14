import 'dart:async';

class Debouncer {
  Timer? _debounceTimer;

  void debounce({
    required Duration duration,
    required Function() onDebounce,
    @Deprecated("Please use the 'type' parameter instead.")
    bool isLeadingEdge = false,
  }) {
    _debounceTimer?.cancel();
    _debounceTimer = Timer(duration, () {
      onDebounce();
    });
  }
}
