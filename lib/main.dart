import 'package:flutter/material.dart';
import 'package:rwa_deep_ar/rwa_deep_ar.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  CameraDeepArController cameraDeepArController;
  int currentPage = 0;
  final vp = PageController(viewportFraction: .24);
  Effects currentEffect = Effects.none;
  Filters currentFilter = Filters.none;
  Masks currentMask = Masks.none;
  bool isRecording = false;

  final maskNames = [];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Stack(
          children: [
            CameraDeepAr(
                onCameraReady: (isReady) {
                  print("Camera status $isReady");
                },
                onImageCaptured: (path) {
                  print("Image Taken $path");
                },
                onVideoRecorded: (path) {
                  print("Video Recorded @ $path");
                },
                //Enter the App key generate from Deep AR
                androidLicenceKey:
                    "1bd4019671c0c8b454188e66ccd4edd4418e6adf2639f72039b8a1452c6fadba4f4ac6215aa176f2",
                iosLicenceKey:
                    "37eed3bf3271dd53cfbaf6a8e12aad37dd0817b70a0325097a09b4a2b7cdd57462b486c2c6270b9a",
                cameraDeepArCallback: (c) async {
                  cameraDeepArController = c;
                  setState(() {});
                }),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                width: double.infinity,
                height: 130,
                color: Colors.white.withOpacity(0.5),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      padding: EdgeInsets.all(8),
                      child: Row(
                        children: List.generate(8, (p) {
                          bool active = currentPage == p;
                          return GestureDetector(
                            onTap: () {
                              currentPage = p;
                              cameraDeepArController.changeMask(p);
                              setState(() {});
                            },
                            child: AnimatedContainer(
                                duration: kThemeAnimationDuration,
                                margin: EdgeInsets.all(5),
                                alignment: Alignment.center,
                                padding: EdgeInsets.symmetric(
                                  vertical: active ? 12 : 8,
                                  horizontal: 16,
                                ),
                                decoration: BoxDecoration(
                                  color:
                                      active ? Colors.lightBlue : Colors.white,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Text(
                                  p == 0 ? "Disable" : "Mask $p",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: active ? 16 : 14,
                                      color:
                                          active ? Colors.white : Colors.black,
                                      fontWeight: FontWeight.w800),
                                )),
                          );
                        }),
                      ),
                    ),
                    Text('Ali Raghebi Shendi'),
                    Padding(
                      padding: const EdgeInsets.only(top: 8, bottom: 16),
                      child: Text('Prof. Dr. Maryam Moghimi'),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
