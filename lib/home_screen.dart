import 'package:flutter/material.dart';
import 'dart:math' as math;

import 'package:provider/provider.dart';

import 'providers/theme_provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Color? bgColor;
  Color? fontColor;
  final random = math.Random();
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Consumer<ThemeProvider>(
        builder: (context, theme, child) => GestureDetector(
              onTap: () => getBackgroundColor(theme.themeMode),
              child: Scaffold(
                  extendBodyBehindAppBar: true,
                  backgroundColor: bgColor ??
                      (theme.themeMode == ThemeMode.dark
                          ? Colors.black
                          : Colors.white),
                  appBar: AppBar(
                    title: const Text("Change Color App"),
                    titleTextStyle: TextStyle(
                        color: fontColor ??
                            (theme.themeMode == ThemeMode.dark
                                ? Colors.white
                                : Colors.black),
                        fontSize: size.width * 0.05,
                        fontWeight: FontWeight.bold),
                    actions: [
                      //switch to chaange light and dark mode
                      Switch(
                        value: theme.themeMode == ThemeMode.dark,
                        thumbIcon: MaterialStateProperty.all(
                          Icon(
                            Icons.nightlight_round,
                            color: bgColor,
                          ),
                        ),
                        activeTrackColor: fontColor ??
                            (theme.themeMode == ThemeMode.dark
                                ? Colors.white
                                : Colors.black),
                        onChanged: (value) {
                          final provider = Provider.of<ThemeProvider>(context,
                              listen: false);
                          provider.toggleTheme();
                          getBackgroundColor(theme.themeMode);
                        },
                      ),
                    ],
                  ),
                  body: Center(
                    child: Text(
                      "Hello there",
                      style: TextStyle(
                        color: fontColor ??
                            (theme.themeMode == ThemeMode.dark
                                ? Colors.white
                                : Colors.black),
                        fontSize: size.width * 0.045,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  )),
            ));
  }

  Color getBackgroundColor(ThemeMode themeMode) {
    setState(() {
      bgColor = themeMode == ThemeMode.dark
          ? getDarkRandomColor()
          : getLightRandomColor();
      fontColor = getFontColorForBackground();
    });
    return bgColor!;
  }

  getLightRandomColor() {
    int red = random.nextInt(128) +
        128; // Random value between 128 and 255 for red channel
    int green = random.nextInt(128) +
        128; // Random value between 128 and 255 for green channel
    int blue = random.nextInt(128) +
        128; // Random value between 128 and 255 for blue channel

    return Color.fromARGB(255, red, green, blue);
  }

  getDarkRandomColor() {
    int red =
        random.nextInt(128); // Random value between 0 and 127 for red channel
    int green =
        random.nextInt(128); // Random value between 0 and 127 for green channel
    int blue =
        random.nextInt(128); // Random value between 0 and 127 for blue channel

    return Color.fromARGB(255, red, green, blue);
  }

  Color getFontColorForBackground() {
    return (bgColor!.computeLuminance() > 0.2) ? Colors.black : Colors.white;
  }
}
