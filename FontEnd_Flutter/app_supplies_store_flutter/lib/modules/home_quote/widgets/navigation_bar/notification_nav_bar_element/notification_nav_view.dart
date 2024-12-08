import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../nav_bar_element.dart';
import 'notification_nav_bar_element_viewmodel.dart';

class NotificationNavBarElementView extends StatelessWidget {
  final void Function()? onPressed;
  final bool isSelected;

  const NotificationNavBarElementView({
    Key? key,
    this.onPressed,
    this.isSelected = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => ViewModelBuilder<NotificationNavBarElementViewModel>.reactive(
        viewModelBuilder: () => NotificationNavBarElementViewModel(),
        builder: (context, viewModel, child) => NavBarElement(
          svgIconAsset: "assets/svg/nav_notification",
          text: "Thông báo",
          onPressed: this.onPressed,
          isSelected: this.isSelected,
          badge: viewModel.notificationBadgeCount <= 0 ? null : viewModel.notificationBadgeCount,
          // badge: 6,
        ),
      );
}
