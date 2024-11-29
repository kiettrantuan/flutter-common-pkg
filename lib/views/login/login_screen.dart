import 'package:f_common_package_1/viewmodels/auth_viewmodel.dart';
import 'package:f_common_package_1/views/user/user_screen.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:vector_graphics/vector_graphics.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: const Text('Login'),
        ),
        body: SizedBox(
          width: MediaQuery.of(context).size.width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SvgPicture(
                AssetBytesLoader('assets/logo.svg.vec'),
                width: 100,
                colorFilter: ColorFilter.mode(Colors.red, BlendMode.srcIn),
                semanticsLabel: 'Red dash paths',
              ),
              const SizedBox(
                height: 20,
              ),
              SvgPicture.network(
                'https://www.svgrepo.com/show/450884/find-path.svg',
                semanticsLabel: 'find-path',
                placeholderBuilder: (BuildContext context) =>
                    const Icon(Icons.image),
              ),
              const SizedBox(
                height: 20,
              ),
              Consumer<AuthViewModel>(
                builder: (ctx, auth, __) => ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: auth.isLoading ? Colors.black54 : null,
                    foregroundColor: auth.isLoading ? Colors.grey : null,
                  ),
                  onPressed: () async {
                    await ctx.read<AuthViewModel>().login();
                    await FirebaseAnalytics.instance.logLogin(
                        loginMethod: 'test-login',
                        parameters: {"user": "test"});
                    if (ctx.mounted) {
                      Navigator.of(ctx).pushReplacement(
                        MaterialPageRoute(
                          builder: (context) => const UserScreen(),
                        ),
                      );
                    }
                  },
                  child: const Text('Login'),
                ),
              )
            ],
          ),
        ));
  }
}
