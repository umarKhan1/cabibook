import 'package:cabibook/model/vichele_model.dart';

abstract class RideState {}

class RideInitial extends RideState {}

class RideOptionsLoaded extends RideState {
  RideOptionsLoaded(this.options);
  final List<VehicleOption> options;
}

class RideOptionChosen extends RideState {
  RideOptionChosen(this.option);
  final VehicleOption option;
}

class FindingDriver extends RideState {}
