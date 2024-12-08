import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:witdailyquotes/constants/alert_messages.dart';
import 'package:witdailyquotes/modules/base/themes/colors/base_colors.dart';
import 'package:witdailyquotes/modules/base/themes/colors/theme_colors.dart';
import 'package:witdailyquotes/services/background_service.dart';

import '../widgets/app_on_top_message/on_top_message_upload.dart';
import 'app_layout_viewmodel.dart';

/// Enclose all the other layout and screen throughout the app to confirm close app by physic back button
class AppLayoutView extends StatelessWidget {
  final Widget? child;
  final bool preventBackGesture;

  AppLayoutView({
    Key? key,
    this.child,
    this.preventBackGesture = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => ViewModelBuilder<AppLayoutViewModel>.reactive(
        viewModelBuilder: () => AppLayoutViewModel(),
        builder: (context, viewModel, child) {
          bool haveOnTopMessageChuyenHienThuc =
              viewModel.listSubmitCHTParams.where((element) => element.data.localUploadMedias.isNotEmpty).isNotEmpty;

          return PopScope(
            canPop: false,
            onPopInvoked: (didPop) => viewModel.onPopInvoked(
              didPop,
              closeAppConfirm: this.preventBackGesture,
            ),
            child: _buildChild(
              context,
              viewModel,
              haveOnTopMessageChuyenHienThuc: haveOnTopMessageChuyenHienThuc,
            ),
          );
        },
      );

  Widget _buildChild(
    BuildContext context,
    AppLayoutViewModel viewModel, {
    required bool haveOnTopMessageChuyenHienThuc,
  }) =>
      GestureDetector(
        onTap: () => FocusScope.of(context).requestFocus(new FocusNode()),
        child: Material(
          color: Colors.transparent,
          child: Stack(
            fit: StackFit.expand,
            children: [
              Container(
                width: double.infinity,
                height: double.infinity,
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    if (this.child != null) this.child!,
                    if (haveOnTopMessageChuyenHienThuc)
                      OnTopMessageUpload(
                        bgColor: themeColors.bgPrimary2(),
                        listItemPrams: viewModel.listSubmitCHTParams
                            .where((element) => element.messageUpload.isNotEmpty)
                            .map(
                              (submitCHTParams) => ItemParams(
                                prefixIconSvg: "assets/svg/chuyen_hien_thuc_active.svg",
                                bgMessageColor:
                                    submitCHTParams.status != ChuyenHTSubmitPostStatus.Failed ? Colors.transparent : themeColors.bgError(),
                                fgMessageColor:
                                    submitCHTParams.status != ChuyenHTSubmitPostStatus.Failed ? themeColors.textBody() : themeColors.fgError(),
                                message: submitCHTParams.messageUpload,
                                listActionParams: submitCHTParams.status == ChuyenHTSubmitPostStatus.Failed
                                    ? [
                                        ActionParams(
                                          iconData: Icons.refresh,
                                          onPressedIcon: () => viewModel.onClickUploadCHTPostFailed(submitCHTParams),
                                        ),
                                        ActionParams(
                                          iconData: Icons.close,
                                          onPressedIcon: () => viewModel.removeSubmitCHTParams(submitCHTParams.id),
                                        ),
                                      ]
                                    : [],
                                haveSuffixLoading: submitCHTParams.status == ChuyenHTSubmitPostStatus.Uploading,
                              ),
                            )
                            .toList(),
                      ),
                  ],
                ),
              ),
              if (!viewModel.networkConnected)
                OnTopMessageUpload(
                  config: OnTopMessageUploadConfig(
                    prefixSvgIconColor: themeColors.textWhite(),
                  ),
                  listItemPrams: [
                    ItemParams(
                      prefixIconSvg: "assets/svg/icon-wifi-slash.svg",
                      // bgMessageColor: themeColors.bgBorder(),
                      bgMessageColor: BaseColors.chtPlayerBackground,
                      fgMessageColor: themeColors.textWhite(),
                      message: AlertMessage.networkError,
                    ),
                  ],
                ),
            ],
          ),
        ),
      );
}
