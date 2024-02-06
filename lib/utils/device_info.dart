import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/services.dart';
import 'package:logger/logger.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:spllive/components/DeviceInfo/device_information_model.dart';

class DeviceInfo {
  final DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();

  String deviceType = "";
  static String deviceId = "";
  String deviceModelNo = "";
  String brandName = "";
  String manufacturer = "";
  String osVersion = "";
  String appVersion = "";

  Future<DeviceInformationModel> initPlatformState() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();

    var appVersionC = packageInfo.version;

    var deviceData = <String, dynamic>{};
    try {
      if (Platform.isAndroid) {
        deviceType = "Android";
        deviceData = _readAndroidBuildData(await deviceInfoPlugin.androidInfo);
        var androidInfo = await deviceInfoPlugin.androidInfo;
        deviceId = androidInfo.id.toString();
        print("device ID :---$deviceId");
        deviceModelNo = deviceData["model"] ?? "getting Null";
        manufacturer = deviceData["manufacturer"] ?? "getting Null";
        brandName = deviceData["brand"] ?? "getting Null";
        osVersion = deviceData["version.release"] ?? "getting Null";
        bool isRooted = androidInfo.isPhysicalDevice;
        appVersion = appVersionC;
        print("device isRooted :---$isRooted");
        Logger().i("device Version :--- ${appVersion}");
        // bool jailbroken = await FlutterJailbreakDetection.jailbroken;
        // if (jailbroken || isRooted) {
        //   SystemChannels.platform.invokeMethod('SystemNavigator.pop');
        // }
        // androidInfo = await deviceInfoPlugin.androidInfo;
        // print('Running on ${androidInfo.}'); // Android device model
      } else if (Platform.isIOS) {
        deviceType = "Ios";
        deviceData = _readIosDeviceInfo(await deviceInfoPlugin.iosInfo);
        deviceId = deviceData["identifierForVendor"] ?? "getting Null";
        deviceModelNo = deviceData["name"] ?? "getting Null";
        manufacturer = "Apple Inc";
        brandName = "Apple Inc";
        osVersion = deviceData["systemVersion"] ?? "getting Null";
      }
    } on PlatformException {
      deviceData = <String, dynamic>{'Error:': 'Failed to get platform version.'};
    }
    DeviceInformationModel model = DeviceInformationModel(
      appVersion: appVersionC,
      deviceId: deviceId,
      model: deviceModelNo,
      deviceOs: deviceType,
      brandName: brandName,
      manufacturer: manufacturer,
      osVersion: osVersion,
    );
    Logger().i(
        "User's device info :-\nappversion:-$appVersionC\ndeviceId :- $deviceId\nmodel :- $deviceModelNo\ndeviceOs :- $deviceType\n brandName :- $brandName\n manufacturer :- $manufacturer\n osVersion :- $osVersion ");
    return model;
  }

  Map<String, dynamic> _readAndroidBuildData(AndroidDeviceInfo build) {
    return <String, dynamic>{
      'version.securityPatch': build.version.securityPatch,
      'version.sdkInt': build.version.sdkInt,
      'version.release': build.version.release,
      'version.previewSdkInt': build.version.previewSdkInt,
      'version.incremental': build.version.incremental,
      'version.codename': build.version.codename,
      'version.baseOS': build.version.baseOS,
      'board': build.board,
      'bootloader': build.bootloader,
      'brand': build.brand,
      'device': build.device,
      'display': build.display,
      'fingerprint': build.fingerprint,
      'hardware': build.hardware,
      'host': build.host,
      'id': build.id,
      'manufacturer': build.manufacturer,
      'model': build.model,
      'product': build.product,
      'supported32BitAbis': build.supported32BitAbis,
      'supported64BitAbis': build.supported64BitAbis,
      'supportedAbis': build.supportedAbis,
      'tags': build.tags,
      'type': build.type,
      'isPhysicalDevice': build.isPhysicalDevice,
      // 'androidId': build.androidId,
      'systemFeatures': build.systemFeatures,
    };
  }

  Map<String, dynamic> _readIosDeviceInfo(IosDeviceInfo data) {
    return <String, dynamic>{
      'name': data.name,
      'systemName': data.systemName,
      'systemVersion': data.systemVersion,
      'model': data.model,
      'localizedModel': data.localizedModel,
      'identifierForVendor': data.identifierForVendor,
      'isPhysicalDevice': data.isPhysicalDevice,
      'utsname.sysname:': data.utsname.sysname,
      'utsname.nodename:': data.utsname.nodename,
      'utsname.release:': data.utsname.release,
      'utsname.version:': data.utsname.version,
      'utsname.machine:': data.utsname.machine,
    };
  }
}