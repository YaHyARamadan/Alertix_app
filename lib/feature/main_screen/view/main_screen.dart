import 'package:alertix/core/style/my_text_style.dart';
import 'package:alertix/core/widgets/custom_text.dart';
import 'package:flutter/material.dart';

import '../../../core/routes/routes.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 70.0,
        backgroundColor: Color(0xfff1791e),
        title: const Padding(
          padding: EdgeInsets.only(top: 16, left: 2),
          child: Text(
            "Alertix",
            style: TextStyle(
                fontFamily: "Neofara",
                fontSize: 55,
                fontWeight: FontWeight.w600,
                color: Colors.white),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 32),
        child: GridView.count(
          crossAxisCount: 2,
          children: [
             FeaturesButton(
              imgPath: 'assets/img/bluetooth.png',
              title: "الاتصال بالحذاء",
              scale: 4.5,
              height: 2, onTap: () => Navigator.pushNamed(context, AppRoutes.bluetoothScreen)

            ),
            FeaturesButton(
                imgPath:
                    'assets/img/color-recognition_930x550-removebg-preview.png',
                title: "التعرف على اللون",
                scale: 0.1,
                height: 15,
                onTap: () =>
                    Navigator.pushNamed(context, AppRoutes.colorScreen)),
            FeaturesButton(
                imgPath: 'assets/img/download-removebg-preview (2).png',
                title: "قراءة النص",
                scale: 1,
                height: 4,
                onTap: () => Navigator.pushNamed(context, AppRoutes.rocScreen)
            ),
             FeaturesButton(
              imgPath: 'assets/img/gps.png',
              title: "رجعني البيت",
              scale: 4.4,
              height: 1,
                onTap: () => Navigator.pushNamed(context, AppRoutes.myHomeLocate)
            ),
            FeaturesButton(
                imgPath:
                    'assets/img/istockphoto-1468537521-612x612-removebg-preview.png',
                title: "الحقوووني",
                scale: 0.1,
                height: 10,
                onTap: () => Navigator.pushNamed(context, AppRoutes.smsScreen)),
            const FeaturesButton(
              imgPath: 'assets/img/save-money.png',
              title: "تحقق العمله",
              scale: 5,
              height: 5,
            ),
          ],
        ),
      ),
    );
  }
}

class FeaturesButton extends StatelessWidget {
  const FeaturesButton({
    super.key,
    required this.imgPath,
    required this.title,
    required this.scale,
    this.height,
    this.onTap,
  });

  final String imgPath;
  final String title;
  final double scale;
  final double? height;
  final GestureTapCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Container(
          width: 300,
          height: 700,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25),
            border: Border.all(color: Colors.grey.shade600, width: 4),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                SizedBox(
                  height: height,
                ),
                Image.asset(
                  imgPath,
                  scale: scale,
                ),
                SizedBox(
                  height: height,
                ),
                CustomText(text: title, style: MyTextStyle.cairo20Size500Weight.copyWith())
              ],
            ),
          ),
        ),
      ),
    );
  }
}
