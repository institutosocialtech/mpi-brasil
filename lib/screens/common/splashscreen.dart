import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:package_info_plus/package_info_plus.dart';
import '../../constants.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(10.0),
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/bg_shadow.png'),
            colorFilter: ColorFilter.mode(kColorMPIGreen, BlendMode.multiply),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // header
            SizedBox(height: 50),

            // logo and progress indicator
            SvgPicture.asset('assets/images/group3.svg'),

            // footer
            Column(
              children: [
                // progress indicator
                Center(
                  child: CircularProgressIndicator(
                    backgroundColor: kColorMPIWhite,
                    valueColor:
                        AlwaysStoppedAnimation<Color>(kColorMPIGreenOpaque),
                  ),
                ),

                Container(
                  height: 50,
                  alignment: Alignment.bottomCenter,
                  child: FutureBuilder<PackageInfo>(
                    // use future builder to pull package info
                    future: PackageInfo.fromPlatform(),
                    builder: (context, snapshot) {
                      switch (snapshot.connectionState) {
                        // draw app version
                        case ConnectionState.done:
                          return Text(
                            'v${snapshot.data.version}',
                            textAlign: TextAlign.center,
                            style: Theme.of(context)
                                .textTheme
                                .caption
                                .copyWith(color: kColorMPIWhite),
                          );

                        // draw empty text
                        default:
                          return Text('');
                      }
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
