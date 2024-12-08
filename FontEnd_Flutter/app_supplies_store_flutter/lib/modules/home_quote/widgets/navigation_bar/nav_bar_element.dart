import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:witdailyquotes/constants/app_variables.dart';
import 'package:witdailyquotes/modules/base/themes/colors/theme_colors.dart';
import 'package:witdailyquotes/modules/base/themes/text_styles/theme_text_style_values.dart';
import 'package:witdailyquotes/modules/shared/widgets/buttons/shared_text_button.dart';
import 'package:witdailyquotes/modules/shared/widgets/containers/badge_container.dart';

class NavBarElement extends StatelessWidget {
  // if width < 64, NavBarElement will switch to narrow mode
  final narrowBreakPoint = 64.0;

  final String? svgIconAsset;
  final String? text;
  final void Function()? onPressed;
  final bool isSelected;
  final int? badge;

  const NavBarElement({
    Key? key,
    this.svgIconAsset,
    this.text,
    this.onPressed,
    this.isSelected = false,
    this.badge,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => LayoutBuilder(
        builder: (context, constraints) {
          bool isNarrowMode = false;
          if (constraints.maxWidth < 64) isNarrowMode = true;

          return SharedTextButton(
            onPressed: this.onPressed,
            style: ButtonStyle(
              alignment: Alignment.center,
              padding: MaterialStateProperty.all(EdgeInsets.symmetric(horizontal: appIndent(context) * 0.5)),
              minimumSize: MaterialStateProperty.all(Size.zero),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (svgIconAsset != null)
                  if (isNarrowMode)
                    Container(
                      margin: EdgeInsets.all(5.0),
                      child: Container(
                        constraints: BoxConstraints(
                          maxWidth: 28.0,
                          maxHeight: 28.0,
                        ),
                        child: BadgeContainer(
                          badge: this.badge,
                          child: SvgPicture.asset(
                            this.isSelected ? svgIconAsset! + "_active.svg" : svgIconAsset! + ".svg",
                          ),
                        ),
                      ),
                    )
                  else
                    SizedBox(
                      height: 22.0,
                      child: BadgeContainer(
                        badge: this.badge,
                        child: SvgPicture.asset(
                          this.isSelected ? svgIconAsset! + "_active.svg" : svgIconAsset! + ".svg",
                        ),
                      ),
                    ),
                if (!isNarrowMode) SizedBox(height: 6.0),
                if (!isNarrowMode)
                  Container(
                    height: 22.0,
                    alignment: Alignment.center,
                    child: Text(
                      this.text!,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: themeTextStyleValues.fontSizeNavBar(),
                        color: themeColors.textBody(),
                        height: 1.0,
                      ),
                    ),
                  ),
              ],
            ),
          );
        },
      );
}
