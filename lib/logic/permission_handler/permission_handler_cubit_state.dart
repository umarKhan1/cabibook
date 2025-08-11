import 'package:cabibook/model/permission_model.dart';

abstract class PermissionState {}

class PermissionInitial extends PermissionState {}

class LocationPermissionGranted extends PermissionState {}

class LocationPermissionDenied extends PermissionState {}

class OtherPermissionGranted extends PermissionState {}

class OtherPermissionDenied extends PermissionState {
  OtherPermissionDenied(this.type);
  final AppPermissionType type;
}
