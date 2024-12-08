import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:witdailyquotes/modules/base/themes/colors/theme_colors.dart';
import 'package:witdailyquotes/modules/shared/widgets/buttons/shared_elevated_button.dart';
import 'package:witdailyquotes/modules/shared/widgets/icons/shared_circle_processing_icon.dart';

class AppBarPositiveButtonConfig {
  final ButtonStyle? style;

  const AppBarPositiveButtonConfig({
    this.style,
  });
}

class AppBarPositiveButton extends StatelessWidget {
  final bool enabled;
  final void Function()? onPressed;
  final String? text;
  final bool isProcessing;
  final AppBarPositiveButtonConfig config;

  const AppBarPositiveButton({
    Key? key,
    this.enabled = true,
    this.onPressed,
    this.text,
    this.isProcessing = false,
    this.config = const AppBarPositiveButtonConfig(),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => AbsorbPointer(
        absorbing: !this.enabled,
        child: Container(
          padding: EdgeInsets.only(top: 2.0),
          child: SharedElevatedButton(
            type: SharedElevatedButtonType.Rounded,
            level: SharedElevatedButtonLevel.Secondary,
            onPressed: this.isProcessing ? null : this.onPressed,
            style: this.config.style != null ? this.config.style!.merge(_defaultButtonStyle()) : _defaultButtonStyle(),
            height: 32.0,
            child: this.isProcessing
                ? SharedCircleProcessingIcon(
              color: themeColors.textSecondary(),
              size: 16.0,
            )
                : AutoSizeText(
              this.text != null ? this.text! : "Lưu",
              textScaleFactor: 0.9,
              textAlign: TextAlign.center,
              maxLines: 1,
              // style: TextStyle(
              //   fontSize: 16.0,
              //   height: 1.6,
              // ),
            ),
          ),
        ),
      );

  ButtonStyle _defaultButtonStyle() => ButtonStyle(
        alignment: Alignment.center,
        backgroundColor: this.enabled
            ? MaterialStateProperty.all(themeColors.bgSecondary().withOpacity(0.1))
            : MaterialStateProperty.all(themeColors.bgSeparator()),
        foregroundColor: this.enabled ? MaterialStateProperty.all(themeColors.textSecondary()) : MaterialStateProperty.all(themeColors.bgTernary2()),
        padding: MaterialStatePropertyAll(EdgeInsets.symmetric(horizontal: 10.0)),
      );
}
