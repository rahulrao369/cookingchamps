// import 'package:cooking_champs/constant/my_color.dart';
// import 'package:cooking_champs/constant/my_fonts_style.dart';
// import 'package:cooking_champs/constant/stringfile.dart/language.dart';
// import 'package:cooking_champs/views/dashboard.dart';
// import 'package:cooking_champs/views/recipe/recipe_list_view.dart';
// import 'package:cooking_champs/views/story/story_view.dart';
// import 'package:flutter/material.dart';
//
// class MemoriesView extends StatefulWidget {
//   final Function? onCallBack;
//   final bool isAppbar;
//   const MemoriesView({super.key, this.onCallBack, required this.isAppbar});
//
//   @override
//   State<MemoriesView> createState() => _MemoriesViewState();
// }
//
// class _MemoriesViewState extends State<MemoriesView>
//     with TickerProviderStateMixin {
//   late final TabController _tabController;
//
//   @override
//   void initState() {
//     super.initState();
//     _tabController = TabController(length: 2, vsync: this);
//   }
//
//   @override
//   void dispose() {
//     _tabController.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     var size = MediaQuery.of(context).size;
//     return Scaffold(
//       appBar: !widget.isAppbar
//           ? null
//           : AppBar(
//               leadingWidth: 50,
//               backgroundColor: MyColor.yellowF6F1E1,
//               surfaceTintColor: MyColor.yellowF6F1E1,
//               leading: InkWell(
//                 radius: 80,
//                 onTap: () {
//                   if (widget.onCallBack != null) {
//                     Navigator.pop(context);
//                     widget.onCallBack!();
//                   } else {
//                     setState(() {
//                       isTabExplore = false;
//                       pageIndex = 0;
//                       tabCheck = "";
//                     });
//                     // CustomNavigators.pushReplacementNavigate(DashBoardView(pageIndex: 0,), context);
//                   }
//                 },
//                 child: Container(
//                   padding: EdgeInsets.only(left: 20),
//                   alignment: Alignment.center,
//                   child: const Icon(
//                     Icons.arrow_back_ios,
//                     size: 28,
//                     color: Colors.black,
//                   ),
//                 ),
//               ),
//               title: Text(Languages.of(context)!.memories,
//                   style: mediumTextStyle(fontSize: 18.0, color: MyColor.black)),
//               centerTitle: false,
//               elevation: 0,
//             ),
//       body: Column(
//         children: [
//           TabBar(
//             dividerColor: MyColor.colorE5E9F4,
//             indicatorColor: MyColor.appTheme,
//             controller: _tabController,
//             tabs: <Widget>[
//               Tab(
//                 child: SizedBox(
//                     width: size.width * 0.50,
//                     child: Center(
//                         child: Text(Languages.of(context)!.storiesJournal,
//                             style: mediumTextStyle(
//                                 fontSize: 16.0, color: MyColor.color1C1C1C)))),
//               ),
//               Tab(
//                 child: SizedBox(
//                     width: size.width * 0.50,
//                     child: Center(
//                         child: Text(Languages.of(context)!.recipe,
//                             style: mediumTextStyle(
//                                 fontSize: 16.0, color: MyColor.color1C1C1C)))),
//               ),
//             ],
//           ),
//           Expanded(
//             child: TabBarView(
//               physics: NeverScrollableScrollPhysics(),
//               controller: _tabController,
//               children: <Widget>[
//                 //storyUi(size),
//
//                 OurMemoryView(),
//                 RecipeListView(
//                   pageType: '',
//                 )
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
//


import 'package:cooking_champs/constant/my_color.dart';
import 'package:cooking_champs/constant/my_fonts_style.dart';
import 'package:cooking_champs/constant/stringfile.dart/language.dart';
import 'package:cooking_champs/views/dashboard.dart';
import 'package:cooking_champs/views/recipe/recipe_list_view.dart';
import 'package:cooking_champs/views/story/story_view.dart';
import 'package:flutter/material.dart';

class MemoriesView extends StatefulWidget {
  final Function? onCallBack;
  final bool isAppbar;
  const MemoriesView({super.key, this.onCallBack, required this.isAppbar});

  @override
  State<MemoriesView> createState() => _MemoriesViewState();
}

class _MemoriesViewState extends State<MemoriesView>
    with TickerProviderStateMixin {
  late final TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    final bool isIpad = MediaQuery.of(context).size.width > 600;

    return Scaffold(
      appBar: !widget.isAppbar
          ? null
          : AppBar(
        leadingWidth: isIpad ? 70 : 50,
        backgroundColor: MyColor.yellowF6F1E1,
        surfaceTintColor: MyColor.yellowF6F1E1,
        leading: InkWell(
          radius: 80,
          onTap: () {
            if (widget.onCallBack != null) {
              Navigator.pop(context);
              widget.onCallBack!();
            } else {
              setState(() {
                isTabExplore = false;
                pageIndex = 0;
                tabCheck = "";
              });
              // CustomNavigators.pushReplacementNavigate(DashBoardView(pageIndex: 0,), context);
            }
          },
          child: Container(
            padding: EdgeInsets.only(left: isIpad ? 30 : 20),
            alignment: Alignment.center,
            child: Icon(
              Icons.arrow_back_ios,
              size: isIpad ? 32 : 28,
              color: Colors.black,
            ),
          ),
        ),
        title: Text(
          Languages.of(context)!.memories,
          style: mediumTextStyle(
              fontSize: isIpad ? 24.0 : 18.0,
              color: MyColor.black
          ),
        ),
        centerTitle: false,
        elevation: 0,
      ),
      body: Column(
        children: [
          TabBar(
            dividerColor: MyColor.colorE5E9F4,
            indicatorColor: MyColor.appTheme,
            indicatorWeight: isIpad ? 3 : 2,
            labelPadding: EdgeInsets.symmetric(vertical: isIpad ? 16 : 0),
            controller: _tabController,
            tabs: <Widget>[
              Tab(
                child: SizedBox(
                  width: size.width * 0.50,
                  child: Center(
                    child: Text(
                      Languages.of(context)!.storiesJournal,
                      style: mediumTextStyle(
                          fontSize: isIpad ? 20.0 : 16.0,
                          color: MyColor.color1C1C1C
                      ),
                    ),
                  ),
                ),
              ),
              Tab(
                child: SizedBox(
                  width: size.width * 0.50,
                  child: Center(
                    child: Text(
                      Languages.of(context)!.recipe,
                      style: mediumTextStyle(
                          fontSize: isIpad ? 20.0 : 16.0,
                          color: MyColor.color1C1C1C
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          Expanded(
            child: TabBarView(
              physics: NeverScrollableScrollPhysics(),
              controller: _tabController,
              children: <Widget>[
                //storyUi(size),
                OurMemoryView(),
                RecipeListView(
                  pageType: '',
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}