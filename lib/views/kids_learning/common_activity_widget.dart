import 'package:cooking_champs/constant/my_color.dart';
import 'package:cooking_champs/utils/ui_utils.dart';
import 'package:flutter/material.dart';

class CommonPageView extends StatefulWidget {
  final List<Widget> pages; // List of widgets (pages)
  final int initialIndex; // Initial page index
  final Color? bottomNavColor; // Optional color for bottom navigation bar
  final bool isBottom;

  const CommonPageView({
    super.key,
    required this.pages,
    this.initialIndex = 0,
    this.bottomNavColor,
    required this.isBottom,
  });

  @override
  State<CommonPageView> createState() => _CommonPageViewState();
}
late PageController activityPageController;
int activityCurrentIndex = 0;
class _CommonPageViewState extends State<CommonPageView> {


  @override
  void initState() {
    super.initState();
    activityCurrentIndex = widget.initialIndex;
    activityPageController = PageController(initialPage: widget.initialIndex);
  }

  void onPageChanged(int index) {
    setState(() {
      activityCurrentIndex = index;
    });
  }

  void navigateToPage(int newIndex) {
    activityPageController.jumpToPage(newIndex);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColor.white,
      body: Column(
        children: [
          Expanded(
            child: PageView.builder(
              controller: activityPageController,
              itemCount: widget.pages.length,
              onPageChanged: onPageChanged,
              itemBuilder: (context, index) {
                return widget.pages[index];
              },
            ),
          ),

          if (widget.isBottom) Container(
            color: widget.bottomNavColor ?? Colors.white,
            height: 50,
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // "Previous" Button
                activityCurrentIndex > 0
                    ? InkWell(
                  onTap: () => navigateToPage(activityCurrentIndex - 1),
                  child: Text(
                    "Previous",
                    style: const TextStyle(
                        fontSize: 18, color: Colors.blueAccent),
                  ),
                )
                    : const SizedBox.shrink(),

                // "Next" Button
                activityCurrentIndex < widget.pages.length - 1
                    ? InkWell(
                  onTap: () => navigateToPage(activityCurrentIndex + 1),
                  child: Text(
                    "Next",
                    style: const TextStyle(
                        fontSize: 18, color: Colors.blueAccent),
                  ),
                )
                    : const SizedBox.shrink(),
              ],
            ),
          ) else SizedBox.shrink()

        ],
      ),
      bottomNavigationBar:Container(
        color: MyColor.white,
        height:45,
        child: Container(
          alignment: Alignment.topCenter,
          color: MyColor.white,
          padding: EdgeInsets.only(top: 5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(widget.pages.length, (int index){
              return   Padding(
                padding: const EdgeInsets.all(5.0),
                child: UiUtils.indicatorDotsWidget(
                    color: activityCurrentIndex == index
                        ? MyColor.appTheme
                        : activityCurrentIndex == 2
                        ? MyColor.blueLite1
                        : const Color.fromARGB(
                        255, 219, 217, 217),
                    width: 10),
              );
            })

          ),
        ),
      ),
    );
  }
}
