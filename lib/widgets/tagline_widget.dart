import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TaglineWidget extends StatelessWidget {
  final String appName;
  final String motto;
  final double appNameHeight;
  final double mottoHeight;

  const TaglineWidget({
    super.key,
    this.appName = "Give Well",
    this.motto = "Connecting for a noble cause",
    this.appNameHeight = 60,
    this.mottoHeight = 30,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          height: appNameHeight,
          child: DefaultTextStyle(
            style: GoogleFonts.roboto(
              fontSize: 30,
              fontWeight: FontWeight.w700,
              color: Colors.black87,
            ),
            child: AnimatedTextKit(
              animatedTexts: [
                RotateAnimatedText(appName),
                RotateAnimatedText("Empowering Lives"),
                RotateAnimatedText("Supporting Heroes"),
                RotateAnimatedText("Transforming Futures"),
              ],
              repeatForever: true,
              onTap: () {
                print("App Name tapped");
              },
            ),
          ),
        ),
        const SizedBox(height: 12), // Adjusted spacing for better layout
        SizedBox(
          height: mottoHeight,
          child: DefaultTextStyle(
            style: GoogleFonts.lato(
              fontSize: 18,
              fontWeight: FontWeight.w400,
              color: Colors.grey.shade700,
            ),
            child: AnimatedTextKit(
              animatedTexts: [
                RotateAnimatedText(motto),
                RotateAnimatedText("Aid for Disaster Relief"),
                RotateAnimatedText("Medical Support for the Needy"),
                RotateAnimatedText("Helping NGOs Make a Difference"),
              ],
              repeatForever: true,
              onTap: () {
              },
            ),
          ),
        ),
      ],
    );
  }
}
