import 'dart:async';
import 'dart:io';

import 'package:async/async.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:shah_widgets/shah_widgets.dart';
import 'package:shah_widgets/src/services/coupon_service.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../extensions/color_ext.dart';
import '../../extensions/locale_ext.dart';

import '../../entities/coupon.dart';
import 'action_item.dart';
import 'alert_action.dart';
import 'painter.dart';

class CouponDetail extends StatefulWidget {
  final ShahCoupon? item;
  const CouponDetail({super.key, this.item});

  @override
  StateCouponDetail createState() => StateCouponDetail();
}

class StateCouponDetail extends State<CouponDetail> {
  Map? actions;
  ValueNotifier<bool> loading = ValueNotifier(false);
  String? get cookie => ShahWidgets.component.cookie(context);
  CancelableCompleter? completer;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.endOfFrame.then((_) {
      if (mounted) {
        onUpdateCouponAction(CouponAction.status);
      }
    });
  }

  Future<void> onUpdateCouponAction(CouponAction value) async {
    if (loading.value || (cookie?.isEmpty ?? true)) {
      return;
    }
    loading.value = true;
    if (actions != null) {
      unawaited(
        showDialog(
          context: context,
          builder: (_) => AlertActionWidget(
            loading: loading,
          ),
        ),
      );
    }
    setState(() {});
    await completer?.operation.cancel();
    completer = CancelableCompleter();
    completer?.complete(CouponService.shahCouponAction(
      id: '${widget.item?.id}',
      action: value,
      cookie: '$cookie',
    ));
    actions = await completer?.operation.valueOrCancellation();
    loading.value = false;
    if (completer?.isCanceled ?? false) {
      return;
    }
    setState(() {});
  }

  void openExternalCart() {
    try {
      final url = widget.item?.url;
      if (url?.isNotEmpty ?? false) {
        launchUrl(Uri.parse('$url'));
      }
    } catch (e) {
      return;
    }
  }

  Future<void> onTapCopy() async {
    if (loading.value) {
      return;
    }
    loading.value = true;
    if (actions != null) {
      unawaited(
        showDialog(
          context: context,
          builder: (_) => AlertActionWidget(
            loading: loading,
            message: 'تم نسخ الكوبون بنجاح!',
          ),
        ),
      );
    }
    setState(() {});
    await Clipboard.setData(ClipboardData(text: '${widget.item?.code}'));
    await Future.delayed(const Duration(seconds: 1));
    loading.value = false;
    setState(() {});
  }

  @override
  void dispose() {
    completer?.operation.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final detailHeight = Platform.isAndroid ? 340.0 : 300.0;
    final isRTL = context.isRTL;
    final image = widget.item?.image;
    var paddingTop = MediaQuery.sizeOf(context).height * 0.1;

    return Padding(
      padding: EdgeInsets.only(left: 10, right: 10, top: paddingTop),
      child: Stack(
        children: [
          Positioned(
            top: 60,
            left: 0,
            child: SizedBox(
              width: MediaQuery.sizeOf(context).width - 20,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(5),
                child: CustomPaint(
                  painter: CouponDetailPainter(
                    height: detailHeight,
                    color: Theme.of(context).colorScheme.surface,
                  ),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 40,
                    ),
                    child: Column(
                      children: [
                        SizedBox(
                          height: detailHeight - 30,
                          child: SingleChildScrollView(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(height: 65),
                                if (widget.item?.content?.isNotEmpty ??
                                    false) ...[
                                  Center(
                                    child: Text(
                                      '${widget.item?.content}',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium
                                          ?.copyWith(
                                            fontWeight: FontWeight.bold,
                                            height: 1.2,
                                          ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                ],
                                Center(
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(15),
                                      color: HexColor.fromHEX('#8c52ff'),
                                    ),
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 10,
                                      horizontal: 15,
                                    ),
                                    child: Text(
                                      '%خصم ${widget.item?.discountPercentage}',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyLarge
                                          ?.copyWith(
                                            color: Colors.white,
                                          ),
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 25),
                                Center(
                                  child: Text(
                                    '${widget.item?.title}',
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium
                                        ?.copyWith(
                                          fontWeight: FontWeight.bold,
                                          height: 1.2,
                                        ),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                                const SizedBox(height: 10),
                                Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    const Icon(
                                      CupertinoIcons.clock_solid,
                                      size: 16,
                                      color: Colors.red,
                                    ),
                                    const SizedBox(width: 2),
                                    Text(
                                      'متبقي ${widget.item?.dayUntilEnd} أيام',
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 10),
                                Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Icon(
                                      CupertinoIcons.checkmark_alt,
                                      size: 16,
                                      color: HexColor.fromHEX('#4de66d'),
                                    ),
                                    const SizedBox(width: 2),
                                    Text(
                                      'أخر استخدام من ${widget.item?.lastDateCopy}',
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                        Divider(color: HexColor.fromHEX('#4de66d')),
                        const SizedBox(height: 10),
                        Container(
                          width: double.infinity,
                          height: 50,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            border: Border.all(
                              color: Theme.of(context).dividerColor,
                            ),
                          ),
                          child: Row(
                            children: [
                              InkWell(
                                onTap: onTapCopy,
                                child: Container(
                                  height: 50,
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10),
                                  decoration: BoxDecoration(
                                    color: HexColor.fromHEX('#0d6efd'),
                                    borderRadius: BorderRadius.horizontal(
                                      right: isRTL
                                          ? const Radius.circular(50)
                                          : Radius.zero,
                                      left: isRTL
                                          ? Radius.zero
                                          : const Radius.circular(50),
                                    ),
                                  ),
                                  child: const Row(
                                    children: [
                                      Icon(
                                        Icons.copy,
                                        color: Colors.white,
                                      ),
                                      Text(
                                        ' نسخ',
                                        style: TextStyle(
                                          color: Colors.white,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Center(
                                  child: SelectableText('${widget.item?.code}'),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 10),
                        Divider(color: HexColor.fromHEX('#4de66d')),
                        const SizedBox(height: 10),
                        actions == null
                            ? ValueListenableBuilder(
                                valueListenable: loading,
                                builder: (context, value, _) {
                                  if (!value) {
                                    return const SizedBox();
                                  }
                                  return SpinKitThreeBounce(
                                    color: Theme.of(context).primaryColor,
                                    size: 18,
                                  );
                                })
                            : Row(
                                children: [
                                  ActionItem(
                                    icon: CupertinoIcons.hand_thumbsdown_fill,
                                    name: 'غير فعال',
                                    enable: actions?['isUnlike'] == true,
                                    onTap: () => onUpdateCouponAction(
                                      CouponAction.unlike,
                                    ),
                                    enableColor: HexColor.fromHEX('#8c52ff'),
                                  ),
                                  const Spacer(),
                                  ActionItem(
                                    icon: CupertinoIcons.hand_thumbsup_fill,
                                    name: 'فعال',
                                    enable: actions?['isLike'] == true,
                                    onTap: () => onUpdateCouponAction(
                                      CouponAction.like,
                                    ),
                                    enableColor: HexColor.fromHEX('#8c52ff'),
                                  ),
                                  const Spacer(),
                                  ActionItem(
                                    icon: CupertinoIcons.cart,
                                    name: 'تسوق',
                                    onTap: openExternalCart,
                                  ),
                                  const Spacer(),
                                  ActionItem(
                                    icon: CupertinoIcons.heart_fill,
                                    name: 'المفضلة',
                                    enable: actions?['isFavorite'] == true,
                                    onTap: () => onUpdateCouponAction(
                                      CouponAction.favorite,
                                    ),
                                    enableColor: Colors.red,
                                  ),
                                ],
                              ),
                        const SizedBox(height: 10),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.topCenter,
            child: (image?.isNotEmpty ?? false)
                ? Image.network(
                    '$image',
                    width: 100,
                    height: 100,
                  )
                : null,
          ),
          Align(
            alignment: AlignmentDirectional.topEnd,
            child: InkWell(
              onTap: () => Navigator.pop(context),
              child: Container(
                padding: const EdgeInsets.all(7),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.surface,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Icon(
                  CupertinoIcons.clear,
                  color: Theme.of(context).colorScheme.secondary,
                  size: 18,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
