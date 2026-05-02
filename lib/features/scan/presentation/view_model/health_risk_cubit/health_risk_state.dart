part of 'health_risk_cubit.dart';

sealed class HealthRiskState extends Equatable {
  const HealthRiskState();

  @override
  List<Object> get props => [];
}

final class HealthRiskInitial extends HealthRiskState {}
final class HealthRiskLoading extends HealthRiskState {}

final class HealthRiskSuccess extends HealthRiskState {
  final double average; // 0.0 - 1.0
  final String risk;    // Low, Medium, High

  const HealthRiskSuccess(this.average, this.risk);

  @override
  List<Object> get props => [average, risk];
}

final class HealthRiskFailure extends HealthRiskState {
  final String message;
  const HealthRiskFailure(this.message);

  @override
  List<Object> get props => [message];
}
