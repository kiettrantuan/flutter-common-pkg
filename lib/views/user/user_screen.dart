import 'package:cached_network_image/cached_network_image.dart';
import 'package:f_common_package_1/viewmodels/auth_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UserScreen extends StatelessWidget {
  const UserScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('User'),
      ),
      body: SizedBox(
          width: MediaQuery.of(context).size.width,
          child: Consumer<AuthViewModel>(builder: (ctx, auth, __) {
            final List<Widget> widgets = [];

            if (auth.user != null) {
              for (var entry in auth.user!.toJson().entries) {
                if (!entry.key.contains('Token')) {
                  widgets.add(Text('${entry.key}: ${entry.value}'));
                }
              }
            }

            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                if (auth.user?.image != null)
                  CachedNetworkImage(imageUrl: auth.user!.image),
                ...widgets,
                Text(auth.user?.email ?? 'something wrong'),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: auth.isLoading ? Colors.black54 : null,
                    foregroundColor: auth.isLoading ? Colors.grey : null,
                  ),
                  onPressed: auth.isLoading
                      ? null
                      : () async {
                          await ctx.read<AuthViewModel>().logout();
                          if (ctx.mounted) {
                            Navigator.of(ctx)
                                .popUntil(ModalRoute.withName('/'));
                          }
                        },
                  child: const Text('Logout'),
                ),
              ],
            );
          })),
    );
  }
}
