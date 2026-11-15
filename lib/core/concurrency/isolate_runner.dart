import 'dart:isolate';

/// Runs CPU-bound work away from the UI isolate.
class const IsolateRunner() {
  Future<T> run<T, M>(T Function(M message) computation, M message) =>
      Isolate.run<T>(() => computation(message));
}
