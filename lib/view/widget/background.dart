import 'package:flutter/material.dart';

class Background extends StatelessWidget {
  final Widget child;
  final String topImage, bottomImage;
  const Background({
    Key? key,
    required this.child,
    required this.topImage ,
    this.bottomImage = "assets/images/login_bottom.png",
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: double.infinity,
        height: MediaQuery.of(context).size.height,
        child: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            Positioned(
              top: 0,
              left: 0,
              child: Image.asset(
                topImage,
                width: 120,
              ),
            ),
            Positioned(
              bottom: 0,
              right: 0,
              child: Image.asset(bottomImage, width: 110),
            ),
            Positioned(
              top: 0.0,
              left: 0.0,
              right: 0.0,
              bottom: 0.0,
              child: child,
            ),
          ],
        ),
      ),
    );
  }
}
