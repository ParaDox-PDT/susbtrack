import 'package:equatable/equatable.dart';
import '../error/failures.dart';
import '../utils/result.dart';

/// Base contract for asynchronous single-execution UseCases.
/// Enforces returning a [Result] containing either data of type [T] or a [Failure].
abstract class UseCase<T, Params> {
  Future<Result<T, Failure>> call(Params params);
}

/// Represents parameters for a UseCase that requires no input arguments.
class NoParams extends Equatable {
  const NoParams();

  @override
  List<Object?> get props => [];
}
