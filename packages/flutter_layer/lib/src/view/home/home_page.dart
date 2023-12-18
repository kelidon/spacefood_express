import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_layer/src/common/constants/ui_constants.dart';
import 'package:flutter_layer/src/common/extensions/extensions.dart';
import 'package:flutter_layer/src/view/common/custom_icon_button.dart';
import 'package:flutter_layer/src/view/common/custom_text_button.dart';
import 'package:flutter_layer/src/view/home/widgets/animated_circle/animated_circle.dart';

class HomePage extends StatefulWidget {
  const HomePage({
    super.key,
  });

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final PageController pageController = PageController();
  double opacity = 0;
  double blurSigma = 0;

  @override
  void initState() {
    super.initState();
    pageController.addListener(() {
      setState(() {
        blurSigma = (pageController.page ?? 0) * 5;
        opacity = pageController.page ?? 0;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          const AnimatedCircle(),
          BackdropFilter(
            filter: ImageFilter.blur(
              sigmaY: blurSigma,
              sigmaX: blurSigma,
            ),
            child: const SizedBox.expand(),
          ),
          AnimatedOpacity(
            opacity: opacity,
            duration: UIC.commonAnimationDuration,
            child: Container(
              width: context.width,
              height: context.height,
              color: Colors.black.withOpacity(0.8),
            ),
          ),
          PageView(
            physics: const NeverScrollableScrollPhysics(),
            controller: pageController,
            children: [
              HomePageMainMenu(
                pageController: pageController,
              ),
              HomePageLevelSelector(
                pageController: pageController,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class HomePageMainMenu extends StatelessWidget {
  const HomePageMainMenu({
    required this.pageController,
    super.key,
  });

  final PageController pageController;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: context.width,
      child: Column(
        children: [
          Expanded(
            child: Center(
              child: Text(
                'SPACEFOOD EXPRESS',
                style: context.textTheme.titleLargeN.white.shadowed,
              ),
            ),
          ),
          const Expanded(flex: 2, child: SizedBox.shrink()),
          Expanded(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomTextButton(
                    onTap: () {
                      pageController.animateTo(
                        context.width,
                        duration: UIC.pageAnimationDuration,
                        curve: Curves.easeInOutQuad,
                      );
                    },
                    text: 'PLAY',
                  ),
                  const SizedBox(height: 10),
                  CustomTextButton(
                    onTap: () {},
                    text: 'SETTINGS',
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class HomePageLevelSelector extends StatelessWidget {
  const HomePageLevelSelector({
    required this.pageController,
    super.key,
  });

  final PageController pageController;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          AppBar(
            leading: CustomIconButton(
              icon: const Icon(
                Icons.chevron_left_rounded,
                size: 30,
                shadows: [],
              ),
              onTap: () {
                pageController.animateTo(
                  0,
                  duration: UIC.pageAnimationDuration,
                  curve: Curves.easeInOutQuad,
                );
              },
            ),
          ),
          SizedBox(
            width: context.width,
            height: context.height - kToolbarHeight,
            child: ListView.builder(
              itemCount: 20,
              itemBuilder: (context, i) {
                return Center(
                  child: CustomTextButton(
                    text: 'Level ${i.toString()}',
                    onTap: () {},
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
