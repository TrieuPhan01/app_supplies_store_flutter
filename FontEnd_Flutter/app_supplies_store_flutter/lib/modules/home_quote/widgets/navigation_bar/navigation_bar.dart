import 'package:flutter/material.dart';
import 'package:witdailyquotes/app/setup.locator.dart';
import 'package:witdailyquotes/constants/app_constant.dart';
import 'package:witdailyquotes/models/enums/layout/navigation_bar_event.dart';
import 'package:witdailyquotes/models/wit_models/home_screen_models/quote_model.dart';
import 'package:witdailyquotes/modules/base/pages/menu/menu_view.dart';
import 'package:witdailyquotes/modules/base/themes/colors/theme_colors.dart';
import 'package:witdailyquotes/modules/chuyen_hien_thuc/main_page/chuyen_hien_thuc_view.dart';
import 'package:witdailyquotes/modules/chuyen_noi_tam/main_page/chuyen_nt_view.dart';
import 'package:witdailyquotes/modules/diary/main_page/diary_view.dart';
import 'package:witdailyquotes/modules/home/main_page/home_view.dart';
import 'package:witdailyquotes/modules/layout/app_layout/app_layout_view.dart';
import 'package:witdailyquotes/modules/layout/widgets/navigation_bar/nav_bar_element.dart';
import 'package:witdailyquotes/modules/notifications/notifications_view.dart';
import 'package:witdailyquotes/modules/shared/widgets/separators/line_separator.dart';
import 'package:witdailyquotes/rx_value_helper/app_rx_helper.dart';

import 'notification_nav_bar_element/notification_nav_bar_element_view.dart';

class NavigationBar extends StatefulWidget {
  final NavigationBarEventType? eventType;
  final dynamic arguments;

  const NavigationBar({
    Key? key,
    this.eventType,
    this.arguments,
  }) : super(key: key);

  @override
  State<NavigationBar> createState() => _NavigationBarState();
}

class _NavigationBarState extends State<NavigationBar> {
  late PageController _pageController;
  int currentPage = 0;

  AppRxHelper appRxHelper = locator<AppRxHelper>();

  @override
  void initState() {
    super.initState();
    if (widget.eventType != null) {
      switch (widget.eventType!) {
        case NavigationBarEventType.HomeQuoteNotification:
          this._pageController = PageController(initialPage: 0);
          this.currentPage = 0;
          break;
        case NavigationBarEventType.DiaryNotification:
          this._pageController = PageController(initialPage: 1);
          this.currentPage = 1;
          break;
        case NavigationBarEventType.CHTNotification:
          this._pageController = PageController(initialPage: 2);
          this.currentPage = 2;
          break;
        case NavigationBarEventType.TruyenNTNotification:
          this._pageController = PageController(initialPage: 3);
          this.currentPage = 3;
          break;
        case NavigationBarEventType.OtherNotification:
          this._pageController = PageController(initialPage: 4);
          this.currentPage = 4;
          break;
        default:
          this._pageController = PageController(initialPage: 0);
          this.currentPage = 0;
          break;
      }
    } else {
      this._pageController = PageController(initialPage: currentPage);
    }
  }

  void _goToPage(int index) {
    setState(() {
      this.currentPage = index;
      this._pageController.jumpToPage(index);
    });
  }

  bool _checkIsSelected(int index) => this.currentPage == index;

  @override
  Widget build(BuildContext context) => AppLayoutView(
        child: Scaffold(
          backgroundColor: themeColors.bgCard(),
          body: Column(
            children: [
              Expanded(
                child: PageView.builder(
                  controller: this._pageController,
                  physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    switch (index) {
                      case 1:
                        return DiaryView();
                      case 2:
                        return ChuyenHienThucView();
                      case 3:
                        return ChuyenNTView();
                      case 4:
                        return NotificationsView();
                      case 5:
                        return MenuView();
                      case 0:
                      default:
                        HomeQuoteModel? initQuote;
                        if (widget.arguments is HomeQuoteModel) initQuote = widget.arguments;
                        return HomeView(
                          initQuote: initQuote,
                        );
                    }
                  },
                ),
              ),
              Container(
                color: themeColors.bgApp(),
                child: Container(
                  height: AppConstants.navBarHeight,
                  margin: EdgeInsets.only(bottom: appRxHelper.isIosShelfArea == true ? AppConstants.isIosShelfArea : 0),
                  child: Column(
                    children: [
                      LineSeparator(),
                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Expanded(
                              child: NavBarElement(
                                svgIconAsset: "assets/svg/home",
                                text: "Trang chủ",
                                onPressed: () => this._goToPage(0),
                                isSelected: _checkIsSelected(0),
                              ),
                            ),
                            Expanded(
                              child: NavBarElement(
                                svgIconAsset: "assets/svg/bai_hoc_tdn",
                                text: "Nhật ký",
                                onPressed: () => this._goToPage(1),
                                isSelected: _checkIsSelected(1),
                              ),
                            ),
                            Expanded(
                              child: NavBarElement(
                                svgIconAsset: "assets/svg/chuyen_hien_thuc",
                                text: "Hiện thực",
                                onPressed: () => this._goToPage(2),
                                isSelected: _checkIsSelected(2),
                              ),
                            ),
                            Expanded(
                              child: NavBarElement(
                                svgIconAsset: "assets/svg/chuyen_noi_tam",
                                text: "Chuyện",
                                onPressed: () => this._goToPage(3),
                                isSelected: _checkIsSelected(3),
                              ),
                            ),
                            Expanded(
                              child: NotificationNavBarElementView(
                                onPressed: () => this._goToPage(4),
                                isSelected: _checkIsSelected(4),
                              ),
                            ),
                            Expanded(
                              child: NavBarElement(
                                svgIconAsset: "assets/svg/menu",
                                text: "Thêm",
                                onPressed: () => this._goToPage(5),
                                isSelected: _checkIsSelected(5),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      );
}
