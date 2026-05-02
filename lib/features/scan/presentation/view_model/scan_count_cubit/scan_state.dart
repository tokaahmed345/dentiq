part of 'scan_cubit.dart';

sealed class ScanState extends Equatable {
  const ScanState();

  @override
  List<Object> get props => [];
}

// Initial state
final class ScanInitial extends ScanState {}

// =========================
// States للـ Count/Score
// =========================
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

// =========================
// States للـ Last Scan
// =========================

