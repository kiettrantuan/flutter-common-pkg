import 'dart:math';

import 'package:f_common_package_1/viewmodels/auth_viewmodel.dart';
import 'package:f_common_package_1/viewmodels/banner_viewmodel.dart';
import 'package:f_common_package_1/views/bare/bare_screen.dart';
import 'package:f_common_package_1/views/home/widgets/home_banner.dart';
import 'package:f_common_package_1/views/login/login_screen.dart';
import 'package:f_common_package_1/views/user/user_screen.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:vector_graphics/vector_graphics.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Flutter Common Packages'),
      ),
      body: Stack(children: [
        const ScrollConfiguration(
          behavior: ScrollBehavior(),
          child: GlowingOverscrollIndicator(
              axisDirection: AxisDirection.down,
              color: Colors.black54,
              child: SingleChildScrollView(
                  physics: ClampingScrollPhysics(), child: HomeBanner())),
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
          Consumer<AuthViewModel>(
            builder: (_, auth, __) {
              if (auth.user != null) {
                return FloatingActionButton(
                  heroTag: 'user',
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const UserScreen(),
                      ),
                    );
                  },
                  child: const SvgPicture(
                    AssetBytesLoader('assets/knight.svg.vec'),
                    width: 30,
                    semanticsLabel: 'hollow-knight',
                    colorFilter:
                        ColorFilter.mode(Colors.blueGrey, BlendMode.srcIn),
                  ),
                );
              }
              return FloatingActionButton(
                heroTag: 'login',
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const LoginScreen(),
                    ),
                  );
                },
                child: const Icon(Icons.login),
              );
            },
            child: FloatingActionButton(
              heroTag: 'login',
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const LoginScreen(),
                  ),
                );
              },
              child: const Icon(Icons.login),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          FloatingActionButton(
            heroTag: 'in_memory',
            onPressed: () {
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (context) => const BareScreen(),
                ),
              );
            },
            child: const Icon(Icons.memory),
          ),
          const SizedBox(
            height: 10,
          ),
          Consumer<BannerViewModel>(
            builder: (ctx, banner, __) => FloatingActionButton(
              tooltip: 'Reload',
              backgroundColor: banner.isLoading ? Colors.black54 : null,
              foregroundColor: banner.isLoading ? Colors.grey : null,
              onPressed: banner.isLoading
                  ? null
                  : () async {
                      final page = 1 + Random().nextInt(10),
                          limit = 3 + Random().nextInt(10);
                      await banner.fetchBanners(page: page, limit: limit);
                      await FirebaseAnalytics.instance.logEvent(
                        name: "fetch_banners",
                        parameters: {"page": page, "limit": limit},
                      );
                    },
              child: const Icon(Icons.refresh),
            ),
          ),
        ],
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
