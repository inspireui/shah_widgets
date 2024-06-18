import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shah_widgets/shah_widgets.dart';
import '../../extensions/color_ext.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';


class AlertActionWidget extends StatelessWidget {
  final ValueNotifier<bool> loading;
  final String? message;
  const AlertActionWidget({super.key, 
    required this.loading,
    this.message,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        InkWell(
          onTap: () {
            if (loading.value) {
              return;
            }
            Navigator.pop(context);
          },
          child: SizedBox(
            height: MediaQuery.sizeOf(context).height,
            width: MediaQuery.sizeOf(context).width,
          ),
        ),
        Align(
          child: Container(
            width: 200,
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surface,
              borderRadius: BorderRadius.circular(5),
            ),
            child: ValueListenableBuilder(
              valueListenable: loading,
              builder: (context, value, _) {
                if (value) {
                  return Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Text(
                        '...الرجاء الانتظار',
                      ),
                      const SizedBox(height: 10),
                      SpinKitThreeBounce(
                        color: Theme.of(context).primaryColor,
                        size: 16,
                      ),
                    ],
                  );
                }
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(
                      CupertinoIcons.check_mark_circled,
                      color: HexColor.fromHEX('#4de66d'),
                      size: 32,
                    ),
                    const SizedBox(height: 5),
                    Text(
                      message ?? 'تم بنجاح!',
                    ),
                    const SizedBox(height: 15),
                    Center(
                      child: InkWell(
                        onTap: () => Navigator.pop(context),
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 5),
                          decoration: BoxDecoration(
                            color: Theme.of(context).primaryColor,
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: Text(
                            ShahWidgets.component.trans.ok(context),
                            style: const TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}
