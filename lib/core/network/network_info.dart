/// Contract to check device network connectivity state.
abstract class NetworkInfo {
  Future<bool> get isConnected;
}

/// Simple implementation of [NetworkInfo].
/// Can be extended with connectivity_plus or internet_connection_checker.
class NetworkInfoImpl implements NetworkInfo {
  @override
  Future<bool> get isConnected async {
    // Default implementation can be wired to actual connection checkers.
    return true;
  }
}
