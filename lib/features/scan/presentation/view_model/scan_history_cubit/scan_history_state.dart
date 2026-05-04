part of 'scan_history_cubit.dart';

sealed class ScanHistoryState extends Equatable {
  const ScanHistoryState();

  @override
  List<Object> get props => [];
}

final class ScanHistoryInitial extends ScanHistoryState {}
class ScanHistoryLoading extends ScanHistoryState {}

class ScanHistorySuccess extends ScanHistoryState {
  final List<ScanModel> scans;

  const ScanHistorySuccess(this.scans);
}

class ScanHistoryFailure extends ScanHistoryState {
  final String message;

  const ScanHistoryFailure(this.message);
}
