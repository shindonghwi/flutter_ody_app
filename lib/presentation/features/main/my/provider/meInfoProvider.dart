import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:ody_flutter_app/app/OrotApp.dart';
import 'package:ody_flutter_app/data/models/me/ResponseMeInfoModel.dart';
import 'package:ody_flutter_app/data/models/me/ResponseMeNotificationModel.dart';
import 'package:ody_flutter_app/data/models/me/ResponseMeProfileModel.dart';
import 'package:ody_flutter_app/presentation/features/cache/UserCache.dart';
import 'package:riverpod/riverpod.dart';

final meInfoProvider = StateNotifierProvider<MeInfoNotifier, ResponseMeInfoModel?>(
  (_) => MeInfoNotifier(),
);

class MeInfoNotifier extends StateNotifier<ResponseMeInfoModel?> {
  MeInfoNotifier() : super(null);

  void updateMeInfo(ResponseMeInfoModel? meInfo) async {
    if (meInfo == null) {
      GoogleSignIn().disconnect();
      FirebaseAuth.instance.signOut();
    }
    state = meInfo;
    userCache.setUserInfo(meInfo);
  }

  ResponseMeProfileModel? getMeProfile(){
    return state?.profile;
  }

  void updateMeInfoNick(String nick) {
    ResponseMeInfoModel meInfo = state!.copyWith(
      nick: nick,
    );
    debugPrint("updateMeInfoNick : ${meInfo.toJson()}");
    state = meInfo;
  }

  void updateMeInfoHeight(int height) {
    ResponseMeInfoModel meInfo = state!.copyWith(profile: state!.profile?.copyWith(height: height));
    debugPrint("updateMeInfoHeight : ${meInfo.profile?.toJson()}");
    state = meInfo;
  }

  void updateMeInfoWeight(int weight) {
    ResponseMeInfoModel meInfo = state!.copyWith(profile: state!.profile?.copyWith(weight: weight));
    debugPrint("updateMeInfoWeight : ${meInfo.profile?.toJson()}");
    state = meInfo;
  }

  void updateMeInfoBirthday(String birthday) {
    ResponseMeInfoModel meInfo = state!.copyWith(profile: state!.profile?.copyWith(birthday: birthday));
    debugPrint("updateMeInfoBirthday : ${meInfo.profile?.toJson()}");
    state = meInfo;
  }

  void updateMeConfigNotification(ResponseMeNotificationModel notification) {
    ResponseMeInfoModel meInfo = state!.copyWith(config: state!.config?.copyWith(notification: notification));
    debugPrint("updateMeConfigNotification : ${meInfo.config?.notification?.toJson()}");
    state = meInfo;
  }
}
