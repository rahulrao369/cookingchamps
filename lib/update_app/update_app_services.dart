import 'dart:io';

import 'package:cooking_champs/update_app/update_app_view.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:version/version.dart';

class UpdateAppServices {
  Future<void> checkForUpdate(BuildContext context) async {
    try {
      // Get current app version
      PackageInfo packageInfo = await PackageInfo.fromPlatform();
      String installedVersion = packageInfo.version;
      print("Installed Version: $installedVersion");

      // Initialize Remote Config
      FirebaseRemoteConfig remoteConfig = FirebaseRemoteConfig.instance;
      await remoteConfig.setConfigSettings(RemoteConfigSettings(
        fetchTimeout: Duration(seconds: 10),
        minimumFetchInterval: Duration.zero,
      ));

      // Fetch and activate
      bool updated = await remoteConfig.fetchAndActivate();
      print("Remote Config updated: $updated");

      // Get values
      String newVersion = remoteConfig.getString(
          Platform.isIOS ? "ios_update_version" : "android_update_version");
      print("New Version from Remote Config: $newVersion");

      bool isForceUpdate = remoteConfig.getBool("is_force_update");
      String updateDescription = remoteConfig.getString("update_des");

      print("Force Update: $isForceUpdate, Description: $updateDescription");

      // Version comparison
      if (newVersion.isNotEmpty && installedVersion.isNotEmpty) {
        Version latest = Version.parse(newVersion);
        Version current = Version.parse(installedVersion);

        if (latest > current) {
          _showUpdateDialog(
              context, newVersion, updateDescription, isForceUpdate);
        }
      }
    } catch (e) {
      print("Error checking update: $e");
    }
  }

  void _showUpdateDialog(
      BuildContext context, String latestVersion, String des, bool isForce) {
    showDialog(
      context: context,
      barrierDismissible: isForce ? false : true,
      builder: (context) {
        return UpdateAppView(
          latestVersion: '$latestVersion',
          des:
              " A new version is available for Cooking Champs. Please update to latest.",
          isForce: isForce,
        );
      },
    );
  }

  void launchStore() async {
    final Uri storeUrl = Uri.parse(Platform.isAndroid
        ? "https://play.google.com/store/apps/details?id=com.cc.cookingchamps"
        : "https://apps.apple.com/in/app/cooking-champs/id6742489468");

    if (await canLaunchUrl(storeUrl)) {
      await launchUrl(storeUrl, mode: LaunchMode.externalApplication);
    } else {
      print("Could not open the store link");
    }
  }
}
