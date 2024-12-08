import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:witdailyquotes/constants/app_constant.dart';
import 'package:witdailyquotes/constants/app_variables.dart';
import 'package:witdailyquotes/modules/base/themes/colors/theme_colors.dart';
import 'package:witdailyquotes/modules/base/themes/text_styles/app_text_styles.dart';
import 'package:witdailyquotes/modules/shared/widgets/texts/padding_text_wrapper.dart';

class DefaultAppBarConfig {
  final SpacingConfig spacingConfig;

  const DefaultAppBarConfig({this.spacingConfig = const SpacingConfig()});
}

class DefaultAppBar extends StatelessWidget {
  final String? title;
  final Widget? titleWidget;
  final Widget? backButton;
  final Widget? action;
  final bool increaseScreenPaddingTop;
  final bool haveUnderline;
  final bool isLongTitle;
  final DefaultAppBarConfig config;
  final void Function()? onTapTitle;

  DefaultAppBar({
    Key? key,
    this.title,
    this.titleWidget,
    this.backButton,
    this.action,
    this.increaseScreenPaddingTop = true,
    this.haveUnderline = false,
    this.isLongTitle = false,
    this.config = const DefaultAppBarConfig(),
    this.onTapTitle,
  }) : super(key: key) {}

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: this.increaseScreenPaddingTop ? EdgeInsets.only(top: MediaQuery.of(context).padding.top) : EdgeInsets.zero,
      decoration: BoxDecoration(
        color: themeColors.bgApp(),
        border: Border(
          bottom: this.haveUnderline
              ? BorderSide(
                  color: themeColors.bgSeparator(),
                  width: 1.0,
                )
              : BorderSide.none,
        ),
      ),
      child: Stack(
        children: [
          Container(
            constraints: BoxConstraints(minHeight: AppConstants.minAppBarHeight),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  flex: this.config.spacingConfig.flexLeft,
                  child: Container(
                    alignment: Alignment.centerLeft,
                    child: this.backButton != null ? this.backButton! : null,
                  ),
                ),
                Expanded(
                  flex: this.config.spacingConfig.flexMiddle,
                  child: this.titleWidget ??
                      GestureDetector(
                        onTap: this.onTapTitle,
                        child: Container(
                          child: this.title != null && this.isLongTitle == false
                              ? PaddingTextWrapper(
                                  textWidget: AutoSizeText(
                                    this.title!,
                                    minFontSize: 12,
                                    textAlign: TextAlign.center,
                                    style: appTextStyles.bodyText1().copyWith(fontWeight: FontWeight.w600, height: 1.2),
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 2,
                                  ),
                                )
                              : SizedBox(),
                        ),
                      ),
                ),
                Expanded(
                  flex: this.config.spacingConfig.flexRight,
                  child: Container(
                    alignment: Alignment.centerRight,
                    padding: EdgeInsets.only(right: appIndent(context)),
                    child: this.action,
                  ),
                ),
              ],
            ),
          ),
          if (this.title != null && this.isLongTitle == true)
            Container(
              alignment: Alignment.center,
              width: double.infinity,
              constraints: BoxConstraints(minHeight: AppConstants.minAppBarHeight),
              padding: EdgeInsets.symmetric(horizontal: appIndent(context) * 3.0),
              child: Text(
                this.title!,
                textAlign: TextAlign.center,
                style: appTextStyles.bodyText1().copyWith(fontWeight: FontWeight.w600, height: 1.4),
                overflow: TextOverflow.ellipsis,
              ),
            ),
        ],
      ),
    );
  }
}

class SpacingConfig {
  final int flexLeft;
  final int flexMiddle;
  final int flexRight;

  const SpacingConfig({
    this.flexLeft = 2,
    this.flexMiddle = 5,
    this.flexRight = 2,
  });
}
