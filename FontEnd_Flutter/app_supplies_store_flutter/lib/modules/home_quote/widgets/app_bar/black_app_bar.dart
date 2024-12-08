import 'package:flutter/material.dart';
import 'package:witdailyquotes/constants/app_variables.dart';
import 'package:witdailyquotes/modules/base/themes/colors/base_colors.dart';
import 'package:witdailyquotes/modules/base/themes/colors/theme_colors.dart';
import 'package:witdailyquotes/modules/base/themes/text_styles/app_text_styles.dart';
import 'package:witdailyquotes/modules/base/themes/text_styles/theme_text_style_values.dart';
import 'package:witdailyquotes/modules/shared/widgets/separators/line_separator.dart';
import 'package:witdailyquotes/modules/shared/widgets/separators/padding_line.dart';

class BlackAppBar extends StatelessWidget {
  final String? title;
  final bool increaseScreenPaddingTop;
  final Widget? backButton;
  final Widget? action;
  final bool haveUnderline;

  BlackAppBar({
    Key? key,
    this.title,
    this.backButton,
    this.action,
    this.increaseScreenPaddingTop = true,
    this.haveUnderline = true,
  }) : super(key: key) {
    // setStatusBarLight();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: this.increaseScreenPaddingTop ? EdgeInsets.only(top: MediaQuery.of(context).padding.top) : EdgeInsets.zero,
      color: themeColors.textTitle(),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          PaddingLine(this.backButton != null || this.action != null ? 0.4 : 1),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                flex: 1,
                child: Container(
                  alignment: Alignment.centerLeft,
                  child: this.backButton != null ? this.backButton! : null,
                ),
              ),
              Expanded(
                flex: 3,
                child: Container(
                  alignment: Alignment.center,
                  child: this.title != null
                      ? Text(
                          this.title!,
                          textAlign: TextAlign.center,
                          style: appTextStyles.headingText6().copyWith(
                              fontFamily: themeTextStyleValues.stylishFontFamily(), color: themeColors.fgSecondary(), fontWeight: FontWeight.w700),
                        )
                      : null,
                ),
              ),
              Expanded(
                flex: 1,
                child: Container(
                  alignment: Alignment.centerRight,
                  padding: EdgeInsets.only(right: appIndent(context)),
                  child: this.action,
                ),
              ),
            ],
          ),
          PaddingLine(this.backButton != null || this.action != null ? 0.4 : 1),
          if (this.haveUnderline)
            LineSeparator(
              thickness: 6.0,
              color: BaseColors.otherColorAppBarSeparator,
            ),
        ],
      ),
    );
  }
}
