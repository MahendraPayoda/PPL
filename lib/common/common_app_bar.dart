import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:payoda/common/app_colors.dart';
import 'package:payoda/gen/assets.gen.dart';

class CommonAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Widget? title;
  final bool? centerTitle;
  final List<Widget>? actions;
  final Color? backgroundColor;

  const CommonAppBar({super.key, this.title, this.actions, this.centerTitle, this.backgroundColor});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: title,
      backgroundColor: backgroundColor ?? AppColors.greyColor,
      centerTitle: centerTitle,
      elevation: 0,
      actions: actions,
      leading: IconButton(
        icon: SvgPicture.asset(Assets.icons.drawerIcon),
        onPressed: () => Scaffold.of(context).openDrawer(),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
