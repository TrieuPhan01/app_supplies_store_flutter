import 'package:stacked/stacked.dart';
import 'package:witdailyquotes/app/setup.locator.dart';
import 'package:witdailyquotes/modules/base/view_model/app_viewmodel.dart';
import 'package:witdailyquotes/rx_value_helper/notification_rx_helper.dart';

class NotificationNavBarElementViewModel extends AppViewModel {
  NotificationRxHelper notificationRxHelper = locator<NotificationRxHelper>();

  @override
  List<ReactiveServiceMixin> get reactiveServices => [notificationRxHelper];

  int get notificationBadgeCount => this.notificationRxHelper.notificationBadgeCount;
}
