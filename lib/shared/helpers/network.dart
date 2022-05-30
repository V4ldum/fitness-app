// TODO remove
class Network {
  /// Create the effect of network latency to be able to test asynchronous
  /// operations locally.
  static Future<void> emulate() async {
    return Future.delayed(const Duration(seconds: 2));
  }
}
