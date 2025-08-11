import 'package:permission_handler/permission_handler.dart';

enum AppPermissionType {
  location,
  camera,
  gallery,
  notification,
}

extension AppPermissionMapper on AppPermissionType {
  Permission get handler {
    switch (this) {
      case AppPermissionType.location:
        return Permission.locationWhenInUse;
      case AppPermissionType.camera:
        return Permission.camera;
      case AppPermissionType.gallery:
        return Permission.photos; 
      case AppPermissionType.notification:
        return Permission.notification;
    }
  }
}
