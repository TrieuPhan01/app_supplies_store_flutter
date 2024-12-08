import 'package:flutter/material.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:witdailyquotes/app/setup.locator.dart';
import 'package:witdailyquotes/constants/app_variables.dart';
import 'package:witdailyquotes/modules/base/themes/colors/theme_colors.dart';
import 'package:witdailyquotes/modules/base/themes/text_styles/app_text_styles.dart';
import 'package:witdailyquotes/modules/shared/widgets/buttons/shared_text_button.dart';
import 'package:witdailyquotes/modules/shared/widgets/separators/padding_line.dart';
import 'package:witdailyquotes/utils/utils_common.dart';

class AppBarDefaultBackButton extends StatelessWidget {
  final void Function()? onPressed;
  final bool isBlackNavBar;
  final String? text;

  const AppBarDefaultBackButton({
    Key? key,
    this.isBlackNavBar = false,
    this.onPressed,
    this.text = "",
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => SharedTextButton(
        onPressed: this.onPressed ??
            () {
              if (isGlobalRedundantClick()) return;
              NavigationService navigationService = locator<NavigationService>();
              navigationService.back();
            },
        style: ButtonStyle(
          padding: MaterialStateProperty.all(EdgeInsets.only(right: appIndent(context))),
          alignment: Alignment.centerLeft,
        ),
        child: FittedBox(
          fit: BoxFit.scaleDown,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              PaddingLine(),
              Icon(
                Icons.chevron_left,
                color: this.isBlackNavBar ? themeColors.fgSecondary() : themeColors.textBody(),
                size: 36.0,
              ),
              if (this.text != null)
                Text(
                  this.text!,
                  style:
                      appTextStyles.bodyText1().copyWith(height: 1.4, color: this.isBlackNavBar ? themeColors.fgSecondary() : themeColors.textBody()),
                ),
              PaddingLine(0.5),
            ],
          ),
        ),
      );
}
