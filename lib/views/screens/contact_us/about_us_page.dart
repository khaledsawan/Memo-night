import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../componet/icon_than_text/icon_than_text.dart';
import '../../../utils/colors.dart';

class AboutUsPage extends StatelessWidget {
  const AboutUsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    _makingPhoneCall() async {
      var url = Uri.parse("tel:(+963) 967184204");
      if (await canLaunchUrl(url)) {
        await launchUrl(url);
      } else {
        throw 'Could not launch $url';
      }
    }

    _sendingMails() async {
      var url = Uri.parse("mailto:khaled963sawan@gmail.com@email.com");
      if (await canLaunchUrl(url)) {
        await launchUrl(url);
      } else {
        throw 'Could not launch $url';
      }
    }

    _openntelegram() async {
      var url = Uri.parse("https://t.me/Al_Hornet");
      if (await canLaunchUrl(url)) {
        await launchUrl(url);
      } else {
        throw 'Could not launch $url';
      }
    }

    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
        appBar: AppBar(
            backgroundColor: AppColors.mainColor,
            title:  Text(
              'Who we are',
              style: GoogleFonts.marckScript(
                fontSize: 35,
                fontStyle: FontStyle.italic,
                fontWeight: FontWeight.w500,
                color: AppColors.blue,
              )
            )),
        body: Container(
          margin: const EdgeInsets.only(left: 30, right: 30),
          padding: const EdgeInsets.only(bottom: 5),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: height * 0.05,
                ),
                Center(
                  child: SizedBox(
                      width: width - 17,
                      height: height * 0.22,
                      child: Image.asset('images/assets/team1.png')),
                ),
                SizedBox(
                  height: height * 0.05,
                ),
                GestureDetector(
                  onTap: () {
                    _sendingMails();
                  },
                  child: IconThanText(
                    icon: Icons.alternate_email_outlined,
                    text: 'khaled963sawan@gmail.com',
                    color: AppColors.iconColor1,
                    textColor: AppColors.blue,
                  ),
                ),
                const Divider(
                  color: AppColors.textColor,
                ),
                SizedBox(
                  height: height * 0.05,
                ),
                GestureDetector(
                  onTap: () {
                    _makingPhoneCall();
                  },
                  child: IconThanText(
                    icon: Icons.phone_android_outlined,
                    text: '+963 0967184204',
                    color: AppColors.iconColor1,
                    textColor: AppColors.blue,
                  ),
                ),
                const Divider(
                  color: AppColors.textColor,
                ),
                SizedBox(
                  height: height * 0.05,
                ),
                GestureDetector(
                  onTap: () {
                    _openntelegram();
                  },
                  child: IconThanText(
                    icon: Icons.telegram_outlined,
                    text: 'https://t.me/KHALEDSAWAN',
                    color: AppColors.iconColor1,
                    textColor: AppColors.blue,
                  ),
                ),
                const Divider(
                  color: AppColors.textColor,
                ),
                SizedBox(
                  height: height * 0.05,
                ),
              ],
            ),
          ),
        ));
  }
}
