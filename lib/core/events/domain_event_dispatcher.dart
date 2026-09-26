import 'dart:async';

import 'domain_event.dart';

/// In-memory asynchronous event bus for dispatching domain events to listeners
/// (such as analytics projectors, notifications, and recovery handlers).
class DomainEventDispatcher {
  final StreamController<DomainEvent> _controller;

  DomainEventDispatcher({StreamController<DomainEvent>? controller})
      : _controller = controller ?? StreamController<DomainEvent>.broadcast();

  /// Exposes the raw event stream.
  Stream<DomainEvent> get stream => _controller.stream;

  /// Publishes a [DomainEvent] to all active subscribers asynchronously.
  void publish(DomainEvent event) {
    if (!_controller.isClosed) {
      _controller.add(event);
    }
  }

  /// Subscribes to events of a specific type [E].
  StreamSubscription<E> subscribe<E extends DomainEvent>(
    void Function(E event) onData, {
    Function? onError,
    void Function()? onDone,
    bool? cancelOnError,
  }) {
    return _controller.stream
        .where((event) => event is E)
        .cast<E>()
        .listen(
          onData,
          onError: onError,
          onDone: onDone,
          cancelOnError: cancelOnError,
        );
  }

  /// Closes the underlying event controller.
  Future<void> dispose() async {
    await _controller.close();
  }
}
