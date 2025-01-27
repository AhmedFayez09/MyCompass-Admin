import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

class DrawerListTile extends StatelessWidget {
  const DrawerListTile({
    super.key,
    required this.title,
    required this.svgSrc,
    required this.press,
    this.isNotSvg = false,
    required this.isSelected,
  });

  final String title, svgSrc;
  final VoidCallback press;
  final bool isSelected;
  final bool? isNotSvg;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: isSelected ? Colors.blueAccent : Colors.transparent,
            width: 1,
          ),
        ),
      ),
      child: ListTile(
        onTap: press,
        horizontalTitleGap: 0.0,
        leading: isNotSvg == true
            ? kIsWeb
            ? Image.network(
          svgSrc,
          color: isSelected ? Colors.blueAccent : Colors.white54,
          height: 16,
        )
            : Image.asset(
          svgSrc,
          color: isSelected ? Colors.blueAccent : Colors.white54,
          height: 16,
        )
            : SvgPicture.asset(
          svgSrc,
          colorFilter: ColorFilter.mode(
            isSelected ? Colors.blueAccent : Colors.white54,
            BlendMode.srcIn,
          ),
          height: 16,
        ),
        title: Text(
          title,
          style: GoogleFonts.cairo(
            color: isSelected ? Colors.blue : Colors.white54,
          ),
        ),
      ),
    );
  }
}
