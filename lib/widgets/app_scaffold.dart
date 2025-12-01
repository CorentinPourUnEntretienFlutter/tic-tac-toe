import 'package:flutter/material.dart';
import 'package:tictactoe/widgets/app_background.dart';

class AppScaffold extends StatelessWidget {
  const AppScaffold({super.key, required this.body, this.appBar});
  final PreferredSizeWidget? appBar;
  final Widget body;

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        Positioned.fill(child: AppBackground()),
        Scaffold(
          backgroundColor: Colors.transparent,
          appBar: appBar,
          body: ClipRRect(clipBehavior: Clip.hardEdge, child: body),
        ),
      ],
    );
  }
}
