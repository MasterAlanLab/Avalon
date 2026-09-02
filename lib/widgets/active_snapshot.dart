import 'package:avalon/common/activity.dart';
import 'package:avalon/widgets/inherited.dart';
import 'package:flutter/widgets.dart';

/// Tracks whether a view is both the current page and backed by an active UI.
///
/// Event-driven views keep receiving core events while the window is hidden.
/// This mixin lets them buffer those events instead of running list diffing,
/// notifier writes and layout that nobody can observe, then publish one
/// snapshot once the view becomes visible again.
mixin ActiveSnapshotMixin<T extends StatefulWidget> on State<T> {
  bool _isPageActive = true;
  bool _isUiActive = appActivity.value.isUiActive;

  bool get isSnapshotActive => _isPageActive && _isUiActive;

  /// Invoked when the view stops being observable; drop pending UI work.
  void onSnapshotSuspended();

  /// Invoked when the view becomes observable again; publish the latest data.
  void onSnapshotResumed();

  @override
  void initState() {
    super.initState();
    appActivity.addListener(_handleActivityChanged);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _syncActive(pageActive: PageActivityScope.isActiveOf(context));
  }

  @override
  void dispose() {
    appActivity.removeListener(_handleActivityChanged);
    super.dispose();
  }

  void _handleActivityChanged() {
    if (!mounted) {
      return;
    }
    _syncActive(uiActive: appActivity.value.isUiActive);
  }

  void _syncActive({bool? pageActive, bool? uiActive}) {
    final wasActive = isSnapshotActive;
    _isPageActive = pageActive ?? _isPageActive;
    _isUiActive = uiActive ?? _isUiActive;
    if (isSnapshotActive == wasActive) {
      return;
    }
    if (isSnapshotActive) {
      onSnapshotResumed();
    } else {
      onSnapshotSuspended();
    }
  }
}
