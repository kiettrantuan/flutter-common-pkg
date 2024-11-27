import 'package:f_common_package_1/viewmodels/banner_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BareBanner extends StatelessWidget {
  const BareBanner({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<BannerViewModel>(builder: (ctx, banner, child) {
      final width = MediaQuery.of(context).size.width;
      final minHeight = MediaQuery.of(context).size.height -
          (Scaffold.of(context).appBarMaxHeight ?? 0);
      return ConstrainedBox(
        constraints: BoxConstraints(
            minWidth: width, maxWidth: width, minHeight: minHeight),
        child: ColoredBox(
          color: Theme.of(context).colorScheme.secondaryContainer,
          child: Column(
            children: banner.banners
                .map((item) => SizedBox(
                      width: width,
                      height: minHeight,
                      child: Image.network(
                        item.imageUrl,
                        fit: BoxFit.cover,
                        height: minHeight,
                        loadingBuilder: (_, child, progress) {
                          if (progress == null) return child;
                          return SizedBox(
                            width: width,
                            child: Center(
                              child: CircularProgressIndicator(
                                backgroundColor:
                                    Theme.of(context).colorScheme.secondary,
                                color: Colors.teal,
                                value: progress.expectedTotalBytes != null
                                    ? (progress.cumulativeBytesLoaded /
                                        progress.expectedTotalBytes!)
                                    : 0.0,
                              ),
                            ),
                          );
                        },
                      ),
                    ))
                .toList(),
          ),
        ),
      );
    });
  }
}
