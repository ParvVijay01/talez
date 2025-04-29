import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter/material.dart';
import 'package:hexacom_user/common/widgets/social_media_launcher.dart';

class SocialIconsWidget extends StatelessWidget {
  const SocialIconsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: IconButton(
              onPressed: () => openSocialMedia(
                  "https://www.facebook.com/share/1EZxgL2L41/?mibextid=wwXIfr"),
              icon: const Icon(
                FontAwesomeIcons.facebook,
                size: 20,
                color: Colors.blue,
              ),
            ),
          ),
          Center(
            child: IconButton(
              onPressed: () => openSocialMedia(
                  "https://www.instagram.com/talez_chd?igsh=emhjaG5rcTU0OXFq&utm_source=qr"),
              icon: ShaderMask(
                shaderCallback: (Rect bounds) {
                  return const LinearGradient(
                    colors: [
                      Color(0xFFFEDA75), // Yellow
                      Color(0xFFFA7E1E), // Orange
                      Color(0xFFD62976), // Pinkish Red
                      Color(0xFF962FBF), // Purple
                      Color(0xFF4F5BD5), // Deep Blue
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ).createShader(bounds);
                },
                child: const Icon(
                  FontAwesomeIcons.instagram,
                  size: 20,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          Center(
            child: IconButton(
              onPressed: () => openSocialMedia(
                  "https://youtube.com/@talezchd?si=RIH_EqKhVvTndsgA"),
              icon: const Icon(
                FontAwesomeIcons.youtube,
                size: 20,
                color: Colors.red,
              ),
            ),
          ),
          Center(
              child: IconButton(
            onPressed: () => openSocialMedia("https://snapchat.com/t/9JbNdhjS"),
            icon: Icon(
              FontAwesomeIcons.snapchat,
              size: 20,
              color: const Color.fromARGB(255, 224, 202, 0),
            ),
          )),
        ],
      ),
    );
  }
}
