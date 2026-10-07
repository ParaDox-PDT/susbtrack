import '../error/failures.dart';
import '../utils/result.dart';

/// Base contract for reactive stream-based UseCases (e.g., real-time subscription feeds, auth changes).
abstract class StreamUseCase<T, Params> {
  Stream<Result<T, Failure>> call(Params params);
}
