import 'package:flutter/material.dart';

import '../../../../../theme/app_theme.dart';

class SettingTileWidget extends StatefulWidget {
  final IconData icon;
  final Color iconColor;
  final Color iconBgColor;
  final String title;

  String? subtitle;

  SettingTileWidget({
    super.key,
    required this.icon,
    required this.iconColor,
    required this.iconBgColor,
    required this.title,
    this.subtitle,
  });

  @override
  State<SettingTileWidget> createState() => _SettingTileWidgetState();
}

class _SettingTileWidgetState extends State<SettingTileWidget> {
  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        leading: Container(
          width: 44,
          height: 44,
          decoration: BoxDecoration(
            color: widget.iconBgColor,
            shape: BoxShape.circle,
          ),
          child: Icon(widget.icon, color: widget.iconColor, size: 22),
        ),
        title: Text(
          widget.title,
          style: AppTextStyles.bodyLarge.copyWith(fontWeight: FontWeight.w600),
        ),
        subtitle: widget.subtitle != null
            ? Text(
                widget.subtitle!,
                style: AppTextStyles.bodyMedium.copyWith(fontSize: 12),
              )
            : null,
        trailing: const Icon(Icons.chevron_right, color: Colors.black87),
        onTap: () {},
      ),
    );
  }
}
