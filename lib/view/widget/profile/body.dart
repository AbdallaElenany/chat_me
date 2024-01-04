import 'package:chat_me/core/constant/color.dart';
import 'package:flutter/material.dart';
import '../../../core/constant/size_config.dart';

class Body extends StatelessWidget {
  const Body({
    Key? key,
    required this.name,
    required this.email,
    required this.image,
  }) : super(key: key);
  final String name;
  final String email;
  final ImageProvider? image;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: SizeConfig.defaultSize! * 24, // 240
      child: Stack(
        children: <Widget>[
          ClipPath(
            clipper: CustomShape(),
            child: Container(
              height: SizeConfig.defaultSize! * 15, //150
              color: AppColor.primaryColor,
            ),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(bottom: SizeConfig.defaultSize!), //10
                  height: SizeConfig.defaultSize! * 14, //140
                  width: SizeConfig.defaultSize! * 14,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: Colors.white,
                      width: SizeConfig.defaultSize! * 0.8, //8
                    ),
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: image! ,
                    ),
                  ),
                ),
                Text(
                  name,
                  style: TextStyle(
                    fontSize: SizeConfig.defaultSize! * 2.2, // 22
                  ),
                ),
                SizedBox(height: SizeConfig.defaultSize! / 2), //5
                Text(
                  email,
                  style: const TextStyle(
                    fontWeight: FontWeight.w400,
                    color: Color(0xFF8492A2),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

class CustomShape extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    double height = size.height;
    double width = size.width;
    path.lineTo(0, height - 100);
    path.quadraticBezierTo(width / 2, height, width, height - 100);
    path.lineTo(width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }
}
