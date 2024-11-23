import 'dart:io';

import 'package:ctware/services/cache_manage.dart';
import 'package:ctware/theme/base_layout.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:local_auth/local_auth.dart';

class Setting extends StatefulWidget {
  const Setting({super.key});

  @override
  State<Setting> createState() => _SettingState();
}

class _SettingState extends State<Setting> {
  late Map<String, dynamic> setting;
  late Future<bool> future;
  // Local auth
  final LocalAuthentication auth = LocalAuthentication();
  List<BiometricType> availableBiometrics = [];
  bool canCheckBiometrics = false;

  Future<bool> loadSetting() async {
    setting = {'notification': false, 'localAuth': false};
    final settingCache = await CacheManage.getSetting();
    if (settingCache != null) {
      setting = settingCache;
    }
    await _checkBiometrics();
    return true;
  }

  Future<void> _checkBiometrics() async {
    try {
      canCheckBiometrics = await auth.canCheckBiometrics;
      availableBiometrics = await auth.getAvailableBiometrics();
    } catch (e) {
      availableBiometrics = <BiometricType>[];
    }
  }

  @override
  void initState() {
    super.initState();
    future = loadSetting();
  }

  changeSetting() async {
    await CacheManage.setSetting(setting);
  }

  turnOnLocalAuth() async {
    if (!setting['localAuth']) {
      return;
    }
    final isAuth = await auth.authenticate(
        localizedReason: 'Thực hiện xác thực',
        options: const AuthenticationOptions(
            biometricOnly: false
        )
    );
    setState(() {
      setting['localAuth'] = isAuth;
    });
    await CacheManage.setSetting(setting);
  }

  Widget getAuthWidget() {
    if (!canCheckBiometrics) {
      return const SizedBox();
    }
    IconData? iconData;
    String authText = 'Bật xác thực bằng khuôn mặt / vân tay';
    // Default icon auth for platform
    if (Platform.isAndroid) {
      iconData = Icons.fingerprint;
      authText = 'Bật xác thực bằng vân tay';
    } else if (Platform.isIOS) {
      iconData = Iconsax.emoji_happy;
      authText = 'Bật xác thực bằng khuôn mặt';
    }
    if (availableBiometrics.contains(BiometricType.face)) {
      iconData = Iconsax.emoji_happy;
      authText = 'Bật xác thực bằng vân tay';
    } else if (availableBiometrics.contains(BiometricType.fingerprint)) {
      iconData = Icons.fingerprint;
      authText = 'Bật xác thực bằng khuôn mặt';
    }
    return SwitchListTile(
      title: Text(authText),
      secondary: Icon(iconData),
      value: setting['localAuth'],
      onChanged: (newValue) async {
        setState(() {
          setting['localAuth'] = newValue;
        });
        await changeSetting();
        await turnOnLocalAuth();
      },
      activeColor: Colors.blue,
      inactiveTrackColor: Colors.white,
    );
  }

  @override
  Widget build(BuildContext context) {
    return BaseLayout.view(
      context: context,
      title: "Cài đặt",
      body: FutureBuilder(
        future: future,
        builder: (context, snapshot) {
          if(snapshot.hasData) {
            return Padding(
              padding: const EdgeInsets.only(top: 10.0),
              child: Column(
                children: [
                  SwitchListTile(
                    title: const Text('Thông báo'),
                    secondary: const Icon(Icons.lightbulb_outline),
                    value: setting['notification'],
                    onChanged: (newValue) {
                      setState(() {
                        setting['notification'] = newValue;
                      });
                      changeSetting();
                    },
                    activeColor: Colors.blue,
                    inactiveTrackColor: Colors.white,
                  ),
                  getAuthWidget()
                ],
              ),
            );
          }
          return BaseLayout.loadingView(context);
        }
      ),
    );
  }
}
