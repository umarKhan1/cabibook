import 'package:cabibook/logic/permission_handler/permission_handler_cubit_state.dart';
import 'package:cabibook/model/permission_model.dart';
import 'package:cabibook/utils/log_file.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:permission_handler/permission_handler.dart';

class PermissionCubit extends Cubit<PermissionState> {
  PermissionCubit() : super(PermissionInitial());

  Future<bool> checkLocationPermission() async {
    final status = await AppPermissionType.location.handler.status;
    if (status.isGranted) {
      emit(LocationPermissionGranted());
      return true;
    } else if (status.isPermanentlyDenied) {
      emit(LocationPermissionDenied(permanently: true));
      return false;
    } else {
      emit(LocationPermissionDenied());
      return false;
    }
  }

  Future<void> requestLocationPermission() async {
    logInfo('Requesting location status');
    final current = await AppPermissionType.location.handler.status;

    if (current.isPermanentlyDenied) {
      emit(LocationPermissionDenied(permanently: true));
      return;
    }
   logInfo('Requesting location permission');
    final result = await AppPermissionType.location.handler.request();

    if (result.isGranted) {
         logInfo('Requesting permission granted');
      emit(LocationPermissionGranted());
    } else if (result.isPermanentlyDenied) {
         logInfo('Requesting permission permanently denied');
      emit(LocationPermissionDenied(permanently: true));
    } else {
          logInfo('Requesting permission denied');
      emit(LocationPermissionDenied());
    }
  }

  Future<void> checkOrRequest(AppPermissionType type) async {
    final result = await type.handler.request();
    if (result.isGranted) {
      emit(OtherPermissionGranted());
    } else {
      emit(OtherPermissionDenied(type));
    }
  }

  Future<void> openSettings() async {
    await openAppSettings();
  }
}


class LocationPermissionDenied extends PermissionState {
  LocationPermissionDenied({this.permanently = false});
  final bool permanently;
}
