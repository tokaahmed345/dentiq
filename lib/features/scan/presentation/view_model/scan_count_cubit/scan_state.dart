part of 'scan_cubit.dart';

sealed class ScanState extends Equatable {
  const ScanState();

  @override
  List<Object> get props => [];
}

final class ScanInitial extends ScanState {}

class ScanCountLoading extends ScanState {}

class ScanCountSuccess extends ScanState {
  final int count;
  const ScanCountSuccess(this.count);

  @override
  List<Object> get props => [count];
}

class ScanCountFailure extends ScanState {
  final String message;
  const ScanCountFailure(this.message);

  @override
  List<Object> get props => [message];
}



