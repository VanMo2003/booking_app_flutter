import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import "package:get/get.dart";

import '../../controller/loading_controller.dart';

class LoadingWidget extends StatelessWidget {
  LoadingWidget({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Stack(
      children: [
        child,
        GetBuilder<LoadingController>(
          builder: (controller) {
            return Visibility(
              visible: controller.isLoading,
              child: Container(
                height: size.height,
                color: Colors.white.withOpacity(0.3),
                child: const Center(
                  child: SpinKitCubeGrid(
                    color: Colors.blue,
                    size: 50.0,
                  ),
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}
