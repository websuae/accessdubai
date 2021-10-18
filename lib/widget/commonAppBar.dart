import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:page_transition/page_transition.dart';
import 'package:visa_app/constants/appImages.dart';
import 'package:visa_app/widget/customdrawer.dart';

class CommonAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String? title;
  final String? subtitle;
  final Function()? onPress;
  final bool? isLeading;
  final bool? isDrawer;
  final List<Widget>? action;
  final AppBar? appBar;
  final Color? AppBarBackground;
  final Color? textColor;
  final BuildContext? context;
  final GlobalKey<ScaffoldState>? scaffoldKey;
  final angle = 0.0;

  CommonAppBar(
      {this.title,
      this.context,
      this.subtitle,
      this.onPress,
      @required this.appBar,
      this.isLeading = true,
      this.isDrawer = false,
      this.action,
      this.scaffoldKey,
      this.textColor,
      this.AppBarBackground});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      key: scaffoldKey,
      centerTitle: false,
      brightness: Brightness.light,
      systemOverlayStyle: SystemUiOverlayStyle(statusBarColor: Colors.orange),
      leading: isLeading == true
          ? IconButton(
              icon: Icon(Icons.arrow_back_ios,
                  color:
                      AppBarBackground != null ? Colors.white : Colors.black),
              onPressed: onPress != null
                  ? onPress
                  : () {
                      Navigator.pop(context);
                    })
          : Transform.rotate(
              angle: angle,
              child: PlatformIconButton(
                icon: Padding(
                  padding: EdgeInsets.only(left: 10.h),
                  child: Image.asset(
                    drawerImage,
                  ),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    PageTransition(
                      type: PageTransitionType.leftToRight,
                      child: CustomDrawer(),
                    ),
                  );
                },
              ),
            ),
      elevation: 0,
      actions: action,
      backgroundColor:
          AppBarBackground != null ? AppBarBackground : Colors.white,
      title: Text(
        (title ?? "").toUpperCase(),
        style: TextStyle(
            color: textColor != null ? textColor : Colors.black,
            fontSize: 16.sp,
            fontWeight: FontWeight.w500),
      ),
    );
  }

  @override
  Size get preferredSize => new Size.fromHeight(appBar!.preferredSize.height);
}
