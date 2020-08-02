import 'dart:async';
import 'package:permission/permission.dart';

Future<bool> queryPermissions() async {
  List<Permissions> permissionsStatus = await Permission.getPermissionsStatus(
    [PermissionName.Contacts, PermissionName.SMS],
  );

  bool allGranted = permissionsStatus.every(
      (Permissions perm) => perm.permissionStatus == PermissionStatus.allow);

  while (!allGranted) {
    await Permission.requestPermissions(
      [PermissionName.Contacts, PermissionName.SMS],
    );

    permissionsStatus = await Permission.getPermissionsStatus(
      [PermissionName.Contacts, PermissionName.SMS],
    );

    allGranted = permissionsStatus.every(
        (Permissions perm) => perm.permissionStatus == PermissionStatus.allow);
  }

  return allGranted;
}
