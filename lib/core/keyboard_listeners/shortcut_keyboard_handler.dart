import 'package:ausales_application/controller/home_controller.dart';
import 'package:ausales_application/controller/layout/end_drawer_controller.dart';
import 'package:ausales_application/core/constants/nav_controller.dart';
import 'package:ausales_application/core/shared_preferences/home_shared_prefs.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class ShorcutKeyboardHandler extends StatefulWidget {
  final Widget child;
  final bool isHome;
  void Function()? onRefresh;
  var scaffoldKey;

  ShorcutKeyboardHandler(
      {super.key, required this.child, this.isHome = false, this.onRefresh, required this.scaffoldKey});

  @override
  State<ShorcutKeyboardHandler> createState() => _ShorcutKeyboardHandlerState();
}

class _ShorcutKeyboardHandlerState extends State<ShorcutKeyboardHandler> {
  final HomeController _homeController = Get.put(HomeController());
  final EndDrawerController _endDrawerController =
      Get.put(EndDrawerController());

  late FocusNode _focusNode;

  bool _isLeftControlPressed = false;
  bool _isRightControlPressed = false;

  bool _isLeftShiftPressed = false;
  bool _isRightShiftPressed = false;

  void _handleKeyPress(KeyEvent event) {
    if (event is KeyDownEvent || event is KeyUpEvent) {
      final isKeyDown = event is KeyDownEvent;
      if (event.logicalKey == LogicalKeyboardKey.controlLeft) {
        setState(() {
          _isLeftControlPressed = isKeyDown;
        });
      }

      if (event.logicalKey == LogicalKeyboardKey.controlRight) {
        setState(() {
          _isRightControlPressed = isKeyDown;
        });
      }

      if (event.logicalKey == LogicalKeyboardKey.shiftLeft) {
        setState(() {
          _isLeftShiftPressed = isKeyDown;
        });
      }

      if (event.logicalKey == LogicalKeyboardKey.shiftRight) {
        setState(() {
          _isRightShiftPressed = isKeyDown;
        });
      }

      if (event.logicalKey == LogicalKeyboardKey.f6 && isKeyDown) {
        navHome();
      } else if (event.logicalKey == LogicalKeyboardKey.f5 && isKeyDown) {
        widget.onRefresh!();
      } else if (event.logicalKey == LogicalKeyboardKey.escape && isKeyDown) {
        _endDrawerController.menuGroupClicked(false);
        _endDrawerController.activeMenuIndex(0);
        _endDrawerController.activeMenuGroup(null);
      } else if (event.logicalKey == LogicalKeyboardKey.backquote && isKeyDown) {
        _endDrawerController.menuGroupClicked(false);
        _endDrawerController.activeMenuIndex(0);
        _endDrawerController.activeMenuGroup(null);
        widget.scaffoldKey.currentState?.openEndDrawer();
      }

      if (isKeyDown) {
        if (_isLeftControlPressed && _isLeftShiftPressed) {
          openDrawerMenuBar('Ctrl+Shift+${event.logicalKey.keyLabel}');
        } else if (_isLeftControlPressed && _isRightShiftPressed) {
          openDrawerMenuBar('Ctrl+Shift+${event.logicalKey.keyLabel}');
        } else if (_isLeftControlPressed || _isRightControlPressed) {
          openDrawerMenuBar('Ctrl+${event.logicalKey.keyLabel}');
        }
      }
    }
  }

  void openDrawerMenuBar(String key) {
    if (_endDrawerController.menuGroupClicked.value) {
      
      for (var i = 0; i < _homeController.userMenuPermissionList.length; i++) {
        if (i == _endDrawerController.activeMenuIndex.value) {
          for (var j = 0;
              j <
                  _homeController
                      .userMenuPermissionList.value[i].menuList!.length;
              j++) {
            if (_homeController
                    .userMenuPermissionList.value[i].menuList![j].shortcut
                    .toString() ==
                key) {
              widget.scaffoldKey.currentState?.openEndDrawer();
              HomeSharedPrefs.setCurrentMenu(_homeController
                  .userMenuPermissionList.value[i].menuList![j].id!);
              getNavFunction(
                  _homeController.userMenuPermissionList.value[i].menuList![j]);
              widget.scaffoldKey.currentState?.closeEndDrawer();
              break;
            }
          }
        }
      }
    } else {
      for (var i = 0; i < _homeController.userMenuPermissionList.length; i++) {
        if (_homeController.userMenuPermissionList.value[i].shortcut
                .toString() ==
            key) {
          _endDrawerController
              .activeMenuGroup(_homeController.userMenuPermissionList.value[i]);
          _endDrawerController.activeMenuIndex(i);
          _endDrawerController.menuGroupClicked(true);
          widget.scaffoldKey.currentState?.openEndDrawer();
          break;
        }
      }
    }
  }

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return KeyboardListener(
      autofocus: true,
      focusNode: _focusNode,
      onKeyEvent: _handleKeyPress,
      child: FocusTraversalGroup(
        policy: OrderedTraversalPolicy(),
        child: widget.child
      ),
    );
  }
}