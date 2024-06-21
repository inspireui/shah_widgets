import 'package:flutter/material.dart';

import '../../extensions/color_ext.dart';

class ActionItem extends StatelessWidget {
  final IconData? icon;
  final Function()? onTap;
  final String? name;
  final double size;
  final bool enable;
  final Color? enableColor;
  const ActionItem({super.key, 
    this.icon,
    this.onTap,
    this.name,
    this.size = 50,
    this.enable = false,
    this.enableColor,
  });

  @override
  Widget build(BuildContext context) {
    var background =
        enable ? enableColor : Theme.of(context).colorScheme.surface;
    var iconColor = enable ? Colors.white : HexColor.fromHEX('#4de66d');

    return ConstrainedBox(
      constraints: BoxConstraints(
        minWidth: size,
      ),
      child: Column(
        children: [
          InkWell(
            onTap: onTap,
            child: Container(
              width: size,
              height: size,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(size / 2),
                  color: background,
                  boxShadow: [
                    BoxShadow(
                        color: Theme.of(context)
                            .colorScheme
                            .secondary
                            .withOpacity(0.2),
                        blurRadius: 10.0,
                        spreadRadius: 2.0,
                        offset: const Offset(0, 1.0))
                  ]),
              child: Center(
                child: Icon(
                  icon,
                  color: iconColor,
                ),
              ),
            ),
          ),
          const SizedBox(height: 5),
          Text('$name', maxLines: 1),
        ],
      ),
    );
  }
}