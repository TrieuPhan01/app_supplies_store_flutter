import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:witdailyquotes/constants/app_constant.dart';
import 'package:witdailyquotes/constants/app_variables.dart';
import 'package:witdailyquotes/modules/base/themes/colors/theme_colors.dart';
import 'package:witdailyquotes/modules/base/themes/text_styles/app_text_styles.dart';
import 'package:witdailyquotes/modules/shared/widgets/buttons/shared_text_button.dart';
import 'package:witdailyquotes/modules/shared/widgets/containers/indent_field.dart';
import 'package:witdailyquotes/modules/shared/widgets/icons/shared_circle_processing_icon.dart';
import 'package:witdailyquotes/modules/shared/widgets/separators/line_separator.dart';
import 'package:witdailyquotes/modules/shared/widgets/separators/padding_line.dart';
import 'package:witdailyquotes/utils/utils_list.dart';

class OnTopMessageUploadConfig {
  final Color? prefixSvgIconColor;

  const OnTopMessageUploadConfig({
    this.prefixSvgIconColor,
  });
}

class OnTopMessageUpload extends StatelessWidget {
  late final Color bgColor;
  final List<ItemParams> listItemPrams;
  final OnTopMessageUploadConfig config;

  OnTopMessageUpload({
    Key? key,
    Color? bgColor,
    required this.listItemPrams,
    this.config = const OnTopMessageUploadConfig(),
  }) : super(key: key) {
    this.bgColor = bgColor ?? themeColors.bgPrimary2();
  }

  @override
  Widget build(BuildContext context) => Positioned(
        bottom: AppConstants.navBarHeight + 10.0,
        child: Container(
          width: MediaQuery.of(context).size.width,
          child: IndentField(
            child: Container(
              clipBehavior: Clip.antiAlias,
              decoration: BoxDecoration(
                color: this.bgColor,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                verticalDirection: VerticalDirection.up,
                children: addInnerSeparator(
                  this
                      .listItemPrams
                      .map(
                        (item) => Container(
                          width: double.infinity,
                          padding: EdgeInsets.only(
                            left: appIndent(context) * 1.0,
                            right: appIndent(context) * 1.0,
                          ),
                          decoration: BoxDecoration(
                            color: item.bgMessageColor,
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              if (item.prefixIconSvg != null)
                                SizedBox(
                                  height: 22.0,
                                  width: 22.0,
                                  child: SvgPicture.asset(
                                    item.prefixIconSvg!,
                                    color: this.config.prefixSvgIconColor,
                                  ),
                                ),
                              if (item.prefixIconWidget != null) item.prefixIconWidget!,
                              PaddingLine(0.5),
                              Expanded(
                                child: Container(
                                  padding: EdgeInsets.only(top: 5.0, bottom: 7.0),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Expanded(
                                        child: Center(
                                          child: Text(
                                            item.message ?? "",
                                            textAlign: TextAlign.left,
                                            style: appTextStyles.bodyText3().copyWith(
                                                  color: item.fgMessageColor,
                                                ),
                                          ),
                                        ),
                                      ),
                                      if (item.haveSuffixLoading) ...[
                                        PaddingLine(0.5),
                                        SharedCircleProcessingIcon(
                                          size: 16.0,
                                        ),
                                      ],
                                    ],
                                  ),
                                ),
                              ),
                              if (item.listActionParams.isNotEmpty)
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  mainAxisSize: MainAxisSize.min,
                                  children: item.listActionParams
                                      .map(
                                        (actionParams) => Container(
                                          width: 30.0,
                                          height: 30.0,
                                          child: SharedTextButton(
                                            onPressed: actionParams.onPressedIcon,
                                            child: Icon(
                                              actionParams.iconData,
                                              size: 20.0,
                                            ),
                                            style: ButtonStyle(
                                              backgroundColor: MaterialStateProperty.all(item.bgMessageColor),
                                              foregroundColor: MaterialStateProperty.all(item.fgMessageColor),
                                              padding: MaterialStateProperty.all(EdgeInsets.zero),
                                              minimumSize: MaterialStateProperty.all(Size.zero),
                                            ),
                                          ),
                                        ),
                                      )
                                      .toList(),
                                ),
                            ],
                          ),
                          // ),
                        ),
                      )
                      .toList(),
                  separator: LineSeparator(),
                ),
              ),
            ),
          ),
        ),
      );
}

class ItemParams {
  late final Color? bgMessageColor;
  late final Color? fgMessageColor;
  String? message;

  final List<ActionParams> listActionParams;
  final String? prefixIconSvg;
  final Widget? prefixIconWidget;
  final bool haveSuffixLoading;

  ItemParams({
    Color? bgMessageColor,
    Color? fgMessageColor,
    this.message,
    this.listActionParams = const [],
    this.prefixIconSvg,
    this.prefixIconWidget,
    this.haveSuffixLoading = false,
  }) {
    this.bgMessageColor = bgMessageColor ?? Colors.transparent;
    this.fgMessageColor = fgMessageColor ?? themeColors.textBody();
  }
}

class ActionParams {
  final IconData? iconData;
  final void Function()? onPressedIcon;

  ActionParams({
    this.iconData,
    this.onPressedIcon,
  });
}
