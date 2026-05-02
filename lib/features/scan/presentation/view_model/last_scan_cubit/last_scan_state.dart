part of 'last_scan_cubit.dart';

sealed class LastScanState extends Equatable {
  const LastScanState();

  @override
  List<Object> get props => [];
}

final class LastScanInitial extends LastScanState {}
class ScanLastLoading extends LastScanState {}

class ScanLastSuccess extends LastScanState {
  final Map<String, dynamic> data; 
  const ScanLastSuccess(this.data);

  @override
  List<Object> get props => [data];
}

class ScanLastFailure extends LastScanState {
  final String message;
  const ScanLastFailure(this.message);

  @override
  List<Object> get props => [message];
}