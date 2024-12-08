import 'dart:io';

import 'package:flutter/services.dart';
import 'package:stacked/stacked.dart';
import 'package:witdailyquotes/app/setup.locator.dart';
import 'package:witdailyquotes/modules/base/view_model/app_viewmodel.dart';
import 'package:witdailyquotes/services/background_service.dart';
import 'package:witdailyquotes/services/base/alert_service/alert_service.dart';
import 'package:witdailyquotes/services/shared/network_service.dart';
import 'package:witdailyquotes/utils/utils_common.dart';

class AppLayoutViewModel extends AppViewModel {
  BackgroundService backgroundService = locator<BackgroundService>();
  NetworkService networkService = locator<NetworkService>();

  @override
  List<ReactiveServiceMixin> get reactiveServices => [backgroundService, networkService];

  List<SubmitCHTParams> get listSubmitCHTParams => backgroundService.listSubmitCHTParams;

  bool get networkConnected => this.networkService.networkConnected;

  void onClickUploadCHTPostFailed(SubmitCHTParams submitCHTParams) {
    if (isGlobalRedundantClick()) return;

    backgroundService.removeSubmitCHTParams(submitCHTParams.id);
    backgroundService.submitCHTPost(
      data: submitCHTParams.data,
    );
  }

  void removeSubmitCHTParams(String id) {
    this.backgroundService.removeSubmitCHTParams(id);
  }

  void removeSubmitVisionBoardParams(String id) {
    // this.backgroundService.removeSubmitVisionParams(id);
  }

  /// This func is called with params:
  /// didPop == true if closePage is called. canPop == false if physic back is pressed.
  ///
  void onPopInvoked(
    bool didPop, {
    // If True, show confirm dialog to back
    required bool closeAppConfirm,
  }) async {
    if (!didPop) {
      await _popInvoked(closeAppConfirm: closeAppConfirm);
    }
  }

  Future<void> _popInvoked({
    required bool closeAppConfirm,
  }) async {
    if (closeAppConfirm) {
      bool? result = await AlertService.showConfirm(
        title: "Bạn chắc chắn muốn thoát ứng dụng?",
      );
      if (result == true) {
        _closeApp();
      }
    } else {
      await _back();
    }
  }

  Future<void> _back() async {
    await navigationService.back();
  }

  Future<void> _closeApp() async {
    // close app
    if (Platform.isAndroid) {
      SystemNavigator.pop();
    } else if (Platform.isIOS) {
      exit(0);
    }
  }
}
