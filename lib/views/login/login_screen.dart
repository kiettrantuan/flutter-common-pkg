import 'package:f_common_package_1/viewmodels/auth_viewmodel.dart';
import 'package:f_common_package_1/views/user/user_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: const Text('Login'),
        ),
        body: Center(
          child: Consumer<AuthViewModel>(
            builder: (ctx, auth, __) => ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: auth.isLoading ? Colors.black54 : null,
                foregroundColor: auth.isLoading ? Colors.grey : null,
              ),
              onPressed: () async {
                await ctx.read<AuthViewModel>().login();
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
          ),
        ));
  }
}
