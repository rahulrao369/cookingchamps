import 'package:cooking_champs/constant/assets_path.dart';
import 'package:cooking_champs/constant/my_color.dart';
import 'package:cooking_champs/constant/sized_box.dart';
import 'package:cooking_champs/utils/ui_utils.dart';
import 'package:flutter/material.dart';

class HoneyChapter9View extends StatelessWidget {
  const HoneyChapter9View({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal:20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            UiUtils.buildBoldText("The Life cycle of a Honeybee",color: MyColor.neonColor,fontSize:20.0),
            UiUtils.buildNormalText("There are four stages in the bee’s life cycle"),

            hsized15,
            Image.asset(AssetsPath.honeyChapter9Img),

            hsized5,
            UiUtils.buildBoldText("Egg",fontSize:20.0,color: MyColor.darkPink),
            UiUtils.buildNormalText("The Queen Bee lays the egg in a honeycomb cell."),

            hsized5,
            UiUtils.buildBoldText("Lava",fontSize:20.0,color: MyColor.darkPink),
            UiUtils.buildNormalText("The lava hatches from the egg after three days. The worker bees feed the lava royal jelly and then with a special beebread made from honey and pollen. The worker bee then seals the cell with beeswax."),

            hsized5,
            UiUtils.buildBoldText("Pupa",fontSize:20.0,color: MyColor.darkPink),
            UiUtils.buildNormalText("Inside the lava grows and spins a cocoon. The lava changes into a Pupa and continues to grow into a bee."),

            hsized5,
            UiUtils.buildBoldText("A Bee is Born",fontSize:20.0,color: MyColor.darkPink),
            UiUtils.buildNormalText("The Pupa grows wings and legs transforming into an adult bee. The Bee leaves the cell and commences its job as a worker, a drone or a Queen."),

            hsized100

          ],
        ),
      ),
    );
  }
}
