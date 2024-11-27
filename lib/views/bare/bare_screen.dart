import 'dart:math';

import 'package:f_common_package_1/viewmodels/banner_viewmodel.dart';
import 'package:f_common_package_1/views/bare/widgets/bare_banner.dart';
import 'package:f_common_package_1/views/home/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BareScreen extends StatelessWidget {
  const BareScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Bare Screen'),
      ),
      body: Stack(children: [
        const ScrollConfiguration(
          behavior: ScrollBehavior(),
          child: GlowingOverscrollIndicator(
              axisDirection: AxisDirection.down,
              color: Colors.black54,
              child: SingleChildScrollView(
                  physics: ClampingScrollPhysics(), child: BareBanner())),
        ),
        Consumer<BannerViewModel>(
          builder: (ctx, banner, __) {
            if (banner.isLoading) {
              return Container(
                color: Colors.black45,
                width: MediaQuery.of(ctx).size.width,
                height: MediaQuery.of(ctx).size.height -
                    (Scaffold.of(ctx).appBarMaxHeight ?? 0),
                alignment: Alignment.center,
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: const LinearProgressIndicator(),
              );
            }
            return const SizedBox.shrink();
          },
        )
      ]),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            heroTag: 'in_disk',
            onPressed: () {
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (context) => const HomeScreen(),
                ),
              );
            },
            child: const Icon(Icons.storage),
          ),
          const SizedBox(
            height: 10,
          ),
          Consumer<BannerViewModel>(
            builder: (ctx, banner, __) => IgnorePointer(
              ignoring: banner.isLoading,
              child: FloatingActionButton(
                tooltip: 'Reload',
                backgroundColor: banner.isLoading ? Colors.black54 : null,
                foregroundColor: banner.isLoading ? Colors.grey : null,
                onPressed: () {
                  banner.fetchBanners(
                      page: 1 + Random().nextInt(10),
                      limit: 3 + Random().nextInt(10));
                },
                child: const Icon(Icons.refresh),
              ),
            ),
          ),
        ],
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
