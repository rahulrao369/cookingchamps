import 'package:cooking_champs/constant/assets_path.dart';
import 'package:cooking_champs/constant/dimen.dart';
import 'package:cooking_champs/constant/my_color.dart';
import 'package:cooking_champs/constant/my_fonts_style.dart';
import 'package:cooking_champs/constant/sized_box.dart';
import 'package:cooking_champs/constant/stringfile.dart/language.dart';
import 'package:cooking_champs/model/static_model/food_recipe_model.dart';
import 'package:cooking_champs/utils/navigators.dart';
import 'package:cooking_champs/utils/ui_utils.dart';
import 'package:cooking_champs/views/kids_learning/go_to_page_number_view.dart';
import 'package:cooking_champs/views/kids_learning/the_basic/basic_activity4_view.dart';
import 'package:cooking_champs/views/kids_learning/the_basic/basic_activity4_view.dart';
import 'package:cooking_champs/widgets/global_button.dart';
import 'package:flutter/material.dart';

String recipeName = "Trail Mix";

// FoodRecipeModel recipe = FoodRecipeModel();
class KidsRecipeView extends StatefulWidget {
  final String recipeName;
  final String chapter;
  final FoodRecipeModel recipe;
  final Color color;
  final String appBarTitle;

  const KidsRecipeView(
      {super.key,
      required this.recipeName,
      this.chapter = "",
      required this.recipe,
      this.color = MyColor.green,
      required this.appBarTitle});

  @override
  State<KidsRecipeView> createState() => _KidsRecipeViewState();
}

class _KidsRecipeViewState extends State<KidsRecipeView> {
  String activity = "2.1";

  @override
  void initState() {
    setData();
    super.initState();
  }

  setData() {
    setState(() {
      recipeName = widget.recipeName;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColor.white,
      body: Stack(
        children: [
          Column(
            children: [
              Padding(
                padding: EdgeInsets.only(left: 20, right: 20, top: 45),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    UiUtils().foodEnergyAppBar(
                        text: "Recipe ${widget.appBarTitle}", () => back()),
                    UiUtils.bookReadGirl(widget.color, AssetsPath.sheff, true)
                  ],
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            UiUtils.buildBoldText(widget.recipe.title ?? "",
                                fontSize: 23.0, color: widget.color),

                            Visibility(
                              visible: widget.recipe.description!.isNotEmpty,
                              child: Padding(
                                padding: EdgeInsets.only(top: 2),
                                child: UiUtils.buildNormalText(
                                    widget.recipe.description ?? "",
                                    fontSize: 16.0,
                                    color: MyColor.black),
                              ),
                            ),
                            //:SizedBox.shrink(),

                            hsized20,
                            Image.asset(
                              widget.recipe.image ?? "",
                              height: 200,
                              fit: BoxFit.cover,
                            ),

                            hsized20,
                            SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: widget.recipe.tools!
                                    .map((tool) => Container(
                                        alignment: Alignment.center,
                                        height: 86,
                                        width: 73,
                                        margin:
                                            EdgeInsets.only(right: 15, left: 5,bottom: 5,top: 5),
                                        padding:
                                            EdgeInsets.symmetric(horizontal: 3),
                                        decoration: BoxDecoration(
                                            color: MyColor.white,
                                            borderRadius:
                                                BorderRadius.circular(23),
                                            boxShadow: [
                                              BoxShadow(
                                                  blurRadius:2,
                                                  color: MyColor.liteGray
                                                      .withOpacity(0.60))
                                            ]
                                        ),
                                        child: Image.asset(
                                          tool,
                                          height: 55,
                                        )))
                                    .toList(),
                              ),
                            ),

                            hsized20,
                            UiUtils.buildBoldText("You Will Need",
                                fontSize: 18.0, color: MyColor.appTheme),

                            hsized10,
                            UiUtils.buildBulletPoints(
                                widget.recipe.ingredients ?? [],
                                bottomPadding: 5),
                            // _buildBulletPoints(recipe.ingredients),

                            hsized20,
                            UiUtils.buildBoldText("How To",
                                fontSize: 18.0, color: MyColor.appTheme),

                            hsized10,
                            UiUtils.buildSteps(
                              widget.recipe.steps ?? [],
                              bottomPadding: 5,
                              step: "step",
                            ),

                            widget.appBarTitle == "5.1"
                                ? UiUtils.extensionBox(
                                    title: "Basil Pesto",
                                    titleColor: MyColor.red1,
                                    "While making the pesto use all your senses, smell and feel the basil leaves, taste the pesto. Is the basil sweet or bitter? You can replace the pine nuts with walnuts. Do the walnuts taste different, how?")
                                : SizedBox.shrink(),

                            widget.appBarTitle == "2.2"
                                ? Container(
                                    margin: EdgeInsets.only(top: 15),
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                        color: MyColor.green,
                                        borderRadius: BorderRadius.circular(5)),
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 15, vertical: 15),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        UiUtils.buildBoldText(
                                            "FOR SOMETHING DIFFERENT:",
                                            color: MyColor.darkYellow,
                                            fontSize: 15.0),
                                        UiUtils.buildNormalText(
                                            "Instead of cocoa powder add malt powder or  Replace frozen fruit with fresh fruit and add 3-5 ice cubes while blending and yoghurt in place of milk or Replace milk with almond milk or coconut milk or You may add nuts and seeds of your choice",
                                            color: MyColor.white,
                                            fontSize: 15.0),
                                      ],
                                    ),
                                  )
                                : SizedBox.shrink(),

                            Visibility(
                              visible: widget.appBarTitle == "6.1",
                              child: UiUtils.buildJokeSection(
                                  "Q. Why did the tomato blush?",
                                  "A. Because he saw a salad dressing! He! He!"),
                            ),

                            Visibility(
                              visible: widget.appBarTitle == "7.2",
                              child: Padding(
                                padding: const EdgeInsets.only(top: 20.0),
                                child: UiUtils.extensionBox(
                                    "Create your own fruit rainbow. You can use any seasonal fruit and instead of the coconut water you may use lemon infused water, apple juice, or beaten yogurt.",
                                    extension: "Activity 7.3 | Extension",
                                    topPadding: 15),
                              ),
                            ),

                            Visibility(
                              visible: widget.appBarTitle == "7.2",
                              child: Padding(
                                padding: const EdgeInsets.only(top: 20.0),
                                child: UiUtils.buildFunFact(
                                    title: "Fun Fact",
                                    fact:
                                        'The Durian fruit, known as the world’s smelliest fruit, is so stinky that in parts of Asia it is not allowed to be taken on buses or into hotels.'),
                              ),
                            ),
                            Visibility(
                              visible: widget.appBarTitle == "8.1",
                              child: Padding(
                                padding: const EdgeInsets.only(top: 20.0),
                                child: UiUtils.buildFunFact(
                                    title: "Fun Fact",
                                    fact:
                                        'One bee will only make 1/12 of a teaspoon of honey in its entire life! Wow!'),
                              ),
                            ),

                            Visibility(
                              visible: widget.appBarTitle == "7.2",
                              child: Padding(
                                  padding: const EdgeInsets.only(top: 20.0),
                                  child:
                                      Image.asset(AssetsPath.durianFruitImg)),
                            ),

                            Visibility(
                              visible: widget.appBarTitle == "7.1" ||
                                  widget.appBarTitle == "6.2" ||
                                  widget.appBarTitle == "4.2" ||
                                  widget.appBarTitle == "2.1" ||  widget.appBarTitle == "8.3",
                              child: Align(
                                alignment: widget.appBarTitle == "4.2"
                                    ? Alignment.centerRight
                                    : Alignment.center,
                                child: Padding(
                                    padding: const EdgeInsets.only(top: 20.0),
                                    child: Image.asset(
                                      AssetsPath.maleFemaleSheff,
                                      height: 185,
                                    )),
                              ),
                            ),

                            // buttonText().isNotEmpty?  GlobalButton(
                            //   buttonText(),
                            //   widget.color,
                            //   widget.color,
                            //   btnSize55,
                            //   double.infinity,
                            //   () => setList(),
                            //   55,
                            //   0,
                            //   0,
                            //   semiBoldTextStyle(
                            //       fontSize: 18.0, color: MyColor.white),
                            // ):SizedBox.shrink(),

                            hsized30,
                          ],
                        ),
                      ),
                      Visibility(
                        visible: widget.recipeName == "Sweet Lassi",
                        child: Align(
                          alignment: Alignment.bottomRight,
                          child: Image.asset(
                            AssetsPath.punjabSweetLassi,
                          ),
                        ),
                      ),
                      hsized80,
                      hsized80,
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  String buttonText() {
    if (recipeName == "Rainbow Soup" || recipeName == "Basil Pesto") {
      return Languages.of(context)!.submit;
    } else if (widget.chapter == "7" ||
        widget.chapter == "6" ||
        widget.chapter == "8") {
      return "Back";
    } else if (widget.chapter == "Activity 6" ||
        widget.chapter == "Activity 8") {
      return "";
    }
    return Languages.of(context)!.next;
  }

  back() {
    Navigator.pop(context);
  }

/*setList() {
    if (widget.recipeName == "Punjab Sweet Lassi") {
    } else if (widget.recipeName == "Jelly Fruit cups") {
      setState(() {
        tropoJellyData();
      });
      CustomNavigators.pushNavigate(
          KidsRecipeView(
              recipeName: "Tropo Jelly",
              recipe: recipeModel,
              appBarTitle: "Activity 4.6",
              color: MyColor.purple),
          context);
    } else if (widget.recipeName == "Tropo Jelly") {
      CustomNavigators.pushNavigate(BasicActivity4View(), context);
    } else if (widget.recipeName == "Basil Pesto") {
      CustomNavigators.popNavigate(context);
    }
    else if ( widget.chapter != "Activity 6" && widget.appBarTitle == "Activity 6.4" ||
        widget.chapter != "Activity 6" &&  widget.appBarTitle == "Activity 6.3" ||
        widget.chapter != "Activity 6" &&  widget.appBarTitle == "Activity 6.7") {
      Navigator.pop(context);
    }
    else if (widget.chapter == "7") {
      Navigator.pop(context);
    }else if(widget.chapter == "Activity 6" && widget.appBarTitle == "Activity 6.7"){
      CustomNavigators.pushNavigate(GoToPageNumberView(text:"In your exercise book draw a plate of vegetables with all the colours of the rainbow", color:MyColor.darkSky, appBarTitle:"Activity 6.5",textColor:MyColor.darkSky,), context);

    }
  }*/
}

FoodRecipeModel recipeModel = FoodRecipeModel();

FoodRecipeModel sweetLassiData() {
  recipeModel = FoodRecipeModel(
    title: "Recipe: Sweet Lassi",
    description: "",
    image: AssetsPath.sweetLassi,
    // Replace with actual image path
    tools: [
      AssetsPath.cutterBoard, // Example tools
      AssetsPath.knife, // Example tools
      AssetsPath.cups3d, // Example tools
      AssetsPath.bowlImg,
      AssetsPath.scoop,
    ],
    ingredients: [
      "3 cups of natural yogurt (chilled)",
      "3/4 cup milk (chilled)",
      "1/2 cup water",
      "Pitted dates 10-12",
      "Honey 2 tsp.",
      "5-7 Pistachios (optional)",
      "Green cardamom powder – ½ tbsp.",
      "Dried rose petals 1 tbsp. (optional)",
    ],
    steps: [
      "Chop the dates and soak in a bowl of warm water for 10-15 minutes.",
      "Whisk the yogurt, milk, water, ½ tbsp. of ground cardamom, and honey (or blend them).",
      "Ask an adult to help. Pull dates out of water, put them in a grinder, and make a paste.",
      "Add the date paste to the yogurt mix and whisk it (or mix it in a blender).",
      "Pour into glasses and garnish with a pinch of cardamom, chopped pistachios, and rose petals. Serve chilled.",
    ],
  );
  return recipeModel;
}

FoodRecipeModel fruitCupsData() {
  recipeModel = FoodRecipeModel(
    title: "Recipe: Happy Belly Berry Jelly Fruit Cups",
    description: "",
    image: AssetsPath.fruitCups,
    // Replace with actual image path
    tools: [
      AssetsPath.cutterBoard, // Example tools
      AssetsPath.scoop,
      AssetsPath.cups3d,
      AssetsPath.bowlImg,
      AssetsPath.spoon,
    ],
    ingredients: [
      "2x250g punnets strawberries",
      "1/2 cup blueberries",
      "1/2 cup water",
      "2 tbsp. Agar Agar (8 gm)",
      "2 cups clear unsweetened apple juice",
      "1/4 cup caster sugar",
    ],
    steps: [
      "Wash 1 punnet of strawberries. Hull, and roughly chop. Place into a food processor or blender and blend until smooth. Strain the juice into a jug and set aside. Discard the strawberry pulp.",
      "Combine the water and apple juice in a medium saucepan. Then ask an adult to help place on medium heat. Cook, stirring for 2-3 minutes or until liquid is warm. Add the strawberry juice, blueberries, and sugar. Heat over medium heat for 5 minutes until the liquid just comes to a simmer.",
      "Add 2 tbsp. of Agar Agar to the mixture. Cook, stirring constantly for 15 minutes, or until the liquid is slightly thickened.",
      "Wash blueberries and remaining strawberries. Hull and dice the strawberries. Place a few berries into clear serving cups. Pour jelly over berries. Cover and refrigerate for a further 4 hours or until completely set.",
    ],
  );
  return recipeModel;
}

FoodRecipeModel tropoJellyData() {
  recipeModel = FoodRecipeModel(
    title: "Recipe: Going Tropo for Jelly!",
    description: "",
    image: AssetsPath.tropoJelly,
    // Replace with actual image path
    tools: [
      AssetsPath.scoop, // Example tools
      AssetsPath.cutterBoard,
      AssetsPath.knife,
      AssetsPath.bowlImg,
    ],
    ingredients: [
      "3-4 strawberries",
      "!/2 cup blueberries",
      "1/2 cup water",
      "2 tbsp. Agar Agar ( 8 gm)",
      "2 cups clear unsweetened apple juice",
      "1/4 cup caster sugar",
    ],
    steps: [
      "Wash 1 punnet of strawberries. Hull, and roughly chop. Place into a food processor or blender, and blend until smooth. Strain the juice into a jug and set aside. Discard the strawberry pulp.",
      "Combine the water and gelatine in a medium saucepan then ask an adult to help place over medium heat. Cook, stirring for 2-3 minutes or until the liquid is warm. Add the strawberry juice, apple juice and sugar. Heat over medium heat for 5 minutes until the liquid just comes to the simmer.",
      "Ask an adult to help transfer the mixture to a bowl. Set aside to cool for 30 minutes. Cover and refrigerate for 15 minutes or until jelly is cold.",
      "Wash blueberries and remaining strawberries. Hull and slice the strawberries. Place berries into the base of six glasses. Pour jelly over berries. Cover and refrigerate for a further 4 hours or until completely set. Serve.",
    ],
  );
  return recipeModel;
}

basilPestoData() {
  recipeModel = FoodRecipeModel(
    title: "Recipe: Basil Pesto",
    description:
        "You can mix this with your favourite pasta or serve as a dip.",
    image: AssetsPath.basilPesto,
    // Replace with actual image path
    tools: [
      AssetsPath.pestle, // Example tools
    ],
    ingredients: [
      "1 clove of garlic, peeled",
      "Salt",
      "Freshly ground black pepper",
      "A large bunch of fresh basil (leaves only)",
      "50g pine nuts",
      "3 tbsp. extra virgin olive oil",
      "50 g Parmesan cheese, finely grated",
    ],
    steps: [
      "Mash the garlic in a pestle and mortar with a pinch of salt.",
      "Add the basil leaves and pine nuts and pound to a paste.",
      "Pound in the extra virgin olive oil and stir in the Parmesan cheese until smooth.",
      " Have a taste and season with salt and pepper.",
    ],
  );
}

FoodRecipeModel greekHoriatikiSalataData() {
  recipeModel = FoodRecipeModel(
    title: "Recipe: Greek Horiatiki Salata",
    description: "",
    image: AssetsPath.greekHoriatikiSalataImg,
    // Replace with actual image path
    tools: [
      AssetsPath.spoon, // Example tools
      AssetsPath.knife, // Example tools
      AssetsPath.tallGlass, // Example tools
    ],
    ingredients: [
      "olive oil",
      "wine vinegar",
      "½ red onion sliced finely",
      "1 cucumber",
      "2 large tomatoes",
      "10 Greek Kalamata olives",
      "120 grams Feta",
      "1 long yellow Pepper mild",
      "Greek oregano for garnish",
      "salt",
      "pepper"
    ],
    steps: [
      "Cut each tomato into 8 wedges",
      "Peel the cucumber and cut into 5 cm thick slices",
      "Dice Feta into cubes",
      "Slice pepper into thin strips",
      "Place all ingredients (except Fetta) in a large bowl",
      "Mix olive oil and vinegar salt and pepper to make dressing",
      "Add dressing to mix.",
      "Gently combine tomato, cucumber, tomato onions olives and chilli pepper",
      "Toss Feta over salad",
      "Sprinkle with Greek oregano",
      "Serve with fresh crusty bread"
    ],
  );
  return recipeModel;
}

FoodRecipeModel brusChettaAlPomodoroData() {
  recipeModel = FoodRecipeModel(
    title: "Recipe: Bruschetta al Pomodoro",
    description: "",
    image: AssetsPath.bruschettaAlPomodoroImg,
    // Replace with actual image path
    tools: [
      AssetsPath.spoon, // Example tools
      AssetsPath.knife, // Example tools
      AssetsPath.bowlImg, // Example tools
      AssetsPath.cutterBoard, // Example tools
    ],
    ingredients: [
      "10-12 cherry tomatoes",
      "1 garlic clove peeled",
      "5-6 extra virgin olive oil",
      "Salt and black pepper",
      "about 6 basil leaves torn by hand",
      "1 French baguette or ciabatta"
    ],
    steps: [
      "Chop the tomatoes in small dices and place them in a bowl.Season with salt and pepper, add torn basil and drizzle with 4 tbsp. olive oil. Keep aside to enhance the flavour.",
      "Meanwhile, diagonally slice four 1 cm thick slices of bread. Heat a grill pan and toast the bread on both sides until nicely toasted. The slices need to be slightly golden on both sides.",
      "Rub toast lightly on one side with the clove of garlic.",
      "Spoon the chopped tomato mixture on top and garnish with a couple of torn basil leaves, drizzle a little olive oil and serve."
    ],
  );
  return recipeModel;
}

FoodRecipeModel courgettePappardelleNapoliSauceData() {
  recipeModel = FoodRecipeModel(
    title: "Courgette ‘Pappardelle’ with Napoli sauce",
    description: "",
    image: AssetsPath.bruschettaAlPomodoroImg,
    tools: [
      AssetsPath.cutterBoard,
      AssetsPath.knife,
      AssetsPath.cups3d,
      AssetsPath.bowlImg,
      AssetsPath.excelsiorImg,
      AssetsPath.spoon3D,
      AssetsPath.scoop,
      AssetsPath.colander2,

    ],
    ingredients: [
      "2 cloves garlic, peeled and finely sliced",
      "1 small bunch of fresh basil, leaves picked",
      "400 g ripe tomatoes or good-quality tinned chopped tomatoes",
      "Salt and freshly ground black pepper",
      "4 courgettes ( zucchini long variety)",
      "4 tbsp. olive oil"
          "Parmesan cheese , freshly grated, to serve"
    ],
    steps: [
      "Heat a large frying pan over a low heat.",
      "Add olive oil, garlic and warm until fragrant. Do not burn!",
      "Drop in most of the basil leaves in the oil and add the tomatoes.",
      "Bring to the boil and simmer for about 10 minutes."
          "Mash tomatoes with a potato masher until smooth."
          "Season with salt and pepper."
          "While sauce is cooking use your peeler to slice the courgettes lengthwise in shape of ribbons (pappardelle) then put them in a colander with a splash of oil and a pinch of salt."
          "When the sauce is cooked gently mix the courgette pappardelle into the sauce, serve with grated parmesan."
    ],
  );
  return recipeModel;
}

FoodRecipeModel fruitKebabsData() {
  recipeModel = FoodRecipeModel(
    title: "Recipe: Fruit Kebabs",
    description: "",
    image: AssetsPath.fruitKebabsImg,
    tools: [
      AssetsPath.sticksImg,
      AssetsPath.knife,
      AssetsPath.excelsiorImg,
      AssetsPath.cutterBoard,
    ],
    ingredients: [
      "2 Kiwi fruit peeled and sliced",
      "1 Banana",
      "4 strawberries washed",
      "1 Mango",
      "1 tsp lemon juice (If using toothpicks use 3 fruit instead of 4)",
    ],
    steps: [
      "Cooking Champs note: - Make sure that all the fruit is cut in equal sizes.",
      "Peel and cut the fruit in your choice of shape.",
      "Cut the water melon (ask an adult to help), kiwi fruit and papaya into equal size shapes of about 2 cm",
      "Peel the banana and slice in 1 cm pieces. Sprinkle the lemon juice on the sliced banana so that they don’t brown.",
      "Hull the strawberry but do not cut it.",
      "Now, take one skewer and thread one of each fruit and seal the top with the strawberry.",
      "These are yummy at room temperature and even yummier chilled!"
    ],
  );
  return recipeModel;
}

FoodRecipeModel fruitIcyPolesData() {
  recipeModel = FoodRecipeModel(
    title: "Recipe: Fruit Icy Poles",
    description: "",
    image: AssetsPath.fruitIcyPolesImg,
    tools: [
      AssetsPath.sticksImg,
      AssetsPath.knife,
      AssetsPath.excelsiorImg,
      AssetsPath.cutterBoard,
      AssetsPath.iceCream,
    ],
    ingredients: [
      "3 kiwi fruit, peeled and sliced",
      "8-10 fresh strawberries hulled and sliced",
      "4 strawberries washed",
      "2-3 peaches , peeled and sliced",
      "480 ml coconut water or other fruit juice of your choice (80 ml for each mould)",
    ],
    steps: [
      "Add cut up fruit to the popsicle moulds",
      "our your choice of liquid into the moulds",
      "Freeze filled mould for 6-8 hours or until solid.",
      "Remove from mould and gobble up (If they don’t come out easily, just run the moulds under hot water for 4-6 seconds to get them to release.)"
    ],
  );
  return recipeModel;
}

FoodRecipeModel fruitArtData() {
  recipeModel = FoodRecipeModel(
    title: "Recipe: Fruit Art – Banana Palm tree",
    description: "",
    image: AssetsPath.bananaPalmTreeImg,
    tools: [
      AssetsPath.knife,
      AssetsPath.cutterBoard,
    ],
    ingredients: [
      "2 bananas",
      "5-8 pieces black / red grapes - halved",
      "2 Kiwi fruit– peeled and sliced in long wedges",
    ],
    steps: [
      "Peel the banana and cut it down the centre lengthways. On a chopping board cut each half into 1.5 cm slices. Slide your knife underneath the banana slices and place them onto the plate. Arrange them as two tree trunks.",
      "Place kiwi fruit wedges above the banana ‘tree trunks’ to look like palm leaves.",
      "Place the halved grapes at the bottom of the banana to look like and island or ground. Eat immediately!",
    ],
  );
  return recipeModel;
}

FoodRecipeModel yummyHoneyedBabyCarrotsData() {
  recipeModel = FoodRecipeModel(
    title: "Recipe: Yummy honeyed baby carrots",
    description: "",
    image: AssetsPath.honeyedBabyCarrot,
    tools: [
      AssetsPath.pot,
      AssetsPath.sticksImg,
      AssetsPath.spoon,
    ],
    ingredients: [
      "*Adult to help with draining boiling water and cooking on the stove top",
      "2 bunches baby carrots, peeled, trimmed, leave 1.5cm stalk intact",
      "2 tablespoons honey",
      "15g butter (or ghee)",
      "Two tablespoons chopped parsley (replace with coriander if not available)",
      "Salt and pepper LESP NOTE: The time you cook carrots will depend on how big the carrots are – very little ones may need even less time than this.",
    ],
    steps: [
      "Cook carrots in a saucepan of boiling, salted water for 5 minutes or until just tender. Drain.",
      "Add honey and butter to pan over medium heat. When it is starting to froth add the honey and stir to combine.",
      "Add carrots and gently toss to coat with butter and honey sauce for 2 minutes or until the honey becomes a lovely dark brown.",
      "Add a squeeze of lemon and season with salt and pepper",
      "Stir through the chopped parsley and serve straight away.",
    ],
  );
  return recipeModel;
}

FoodRecipeModel honeyChocolateChipWalnutCookiesData() {
  recipeModel = FoodRecipeModel(
    title: "Recipe: Honey chocolate chip walnut cookies",
    description: "",
    image: AssetsPath.walnutCookiesImg,
    tools: [
      AssetsPath.spoon,
      AssetsPath.knife,
      AssetsPath.bowlImg,
      AssetsPath.cutterBoard,
    ],
    ingredients: [
      "1 1⁄4 cups flour",
      "1⁄2 cup butter",
      "1 teaspoon baking soda",
      "1 pinch salt",
      "3⁄4 cup honey",
      "1 teaspoon vanilla",
      "1⁄2 cup chocolate chips",
      "1⁄2 cup chopped walnuts",
      "Makes 25-30 yummy cookies",
    ],
    steps: [
      "Preheat oven to 160 Celsius and line baking tray with baking paper.",
      "Mix flour, baking soda and salt in a separate bowl.",
      "Beat honey, vanilla, and butter together until smooth.",
      "Add flour mixture and beat until just smooth. Do not overbeat or the cookies will be too soft. Add chocolate chips and walnuts.",
      "Drop tablespoons of mixture on tray about 2 inches apart. Bake for 12-15 minutes. LESP Leave to cool on baking tray for 5 minutes {they are quite soft when they are warm), and then transfer on racks to cool completely.",
    ],
  );
  return recipeModel;
}

FoodRecipeModel yummyHoneyIceCreamData() {
  recipeModel = FoodRecipeModel(
    title: "Recipe: Yummy Honey ice cream",
    description: "This no churn recipe doesn’t need an ice cream maker!",
    image: AssetsPath.yummyHoneyIceCream,
    tools: [
      AssetsPath.spoon,
      AssetsPath.knife,
      AssetsPath.bowlImg,
      AssetsPath.cutterBoard,
      AssetsPath.scoop,
    ],
    ingredients: [
      "*An adult to help cook mixture on stovetop. This recipe is a little tricky.",
      "125mls full cream milk",
      "250ml thickened cream, chilled",
      "2tbsp. corn starch /cornflour",
      "150ml honey + 2 Tbsp. for garnish",
      "11/4 Tsp Vanilla extract",
      "Small Pinch salt",
      "Optional extras - chopped nuts, berries mixed chopped fruit",
    ],
    steps: [
      "To make custard mix milk and corn starch until there are no lumps in a mixing bowl.",
      "Pour the milk and cornflour mix into a saucepan and whisk over low heat until the mixture is smooth thick custard and coats the back of a spoon.",
      "Add vanilla and salt and continue cooking for about 4-5 minutes then pour into a medium bowl and refrigerate for 10-15 minutes.",
      "Pour the custard into mixing bowl; add chilled cream and honey. With an electric whisk, mix everything well for 4-5 minutes until the mixture is light and airy.",
      "Pour the ice cream into an air tight container and freeze for 7-9 hours. LESP NOTE: Before serving, let the ice-cream sit at room temperature for 3-4 minutes, scoop and serve topped with a swirl of honey chopped nuts or fruit of your choice.",
    ],
  );
  return recipeModel;
}

FoodRecipeModel nutBallsData() {
  recipeModel = FoodRecipeModel(
    title: "Recipe: Nut balls",
    description: "Makes 10-12",
    image: AssetsPath.nutsBallImg,
    tools: [
      AssetsPath.spoon,
    ],
    ingredients: [
      "1 cup pitted dates ( roughly chopped)",
      "1/4 cup sesame seeds",
      "2 tsp. cocoa powder",
      "2tbsp. corn starch /cornflour",
      "1 cup mixed nuts ( almonds, cashews, pistachios )",
      "2 tsp. coconut oil (melted)",
      "A small pinch of sea salt",
    ],
    steps: [
      "Under adult supervision, place all the ingredients into the food  blender and blend until all ingredients are combined.",
      "Form into small balls and store in a container with lid up to 1 month.",
      "Or you can scoop some loose mix into patty pans and enjoy as a nut crumble. LESP NOTE: You may use nuts and seeds of your choice. Coconut oil can be substituted with ghee.",
    ],
  );
  return recipeModel;
}

FoodRecipeModel walnutCorianderDipData() {
  recipeModel = FoodRecipeModel(
    title: "Recipe: Walnut Coriander Dip",
    description: "Makes 10-12",
    image: AssetsPath.walnutCorianderDipImg,
    tools: [
      AssetsPath.blender,
      AssetsPath.mug,
      AssetsPath.spoon,
      AssetsPath.cutterBoard,
      AssetsPath.knife,
    ],
    ingredients: [
      "1/4 cup Dried Apricots",
      "1/4 cup shelled walnuts",
      "2 garlic cloves , peeled",
      "1 lemon juiced",
      "1 bunch of coriander, washed and roughly chopped",
      "1 tsp salt",
      "1/2 tsp. ground black pepper",
      "4 tbsp. olive oil",
      "1 cup hot water",
    ],
    steps: [
      "Soak the apricots in the hot water for 30 minutes. Drain, reserve the soaking liquid.",
      "Blend the garlic, walnuts, salt and pepper until well combined. Add the soaked apricots. Blend well.",
      "SAdd the coriander and blend in a smooth paste. Add the oil and 2-3 tbsp. of the soaking liquid. Give a pulse in the blender.",
      "Pour in a bowl and set aside for 15-20 minutes for the flavours to develop. Serve with crackers or vegetable sticks.",
    ],
  );
  return recipeModel;
}

FoodRecipeModel smoothieList() {
  recipeModel = FoodRecipeModel(
    title: "Recipe: Healthy Fruity Breakfast Smoothie",
    description:
        "Smoothies are great for a boost of energy and here’s one to start your day",
    image: AssetsPath.smoothie,
    // Example image path
    tools: [
      AssetsPath.blender,
      AssetsPath.spoon,
      AssetsPath.mug,
      AssetsPath.tallGlass
    ],
    ingredients: [
      "1 Frozen Banana ( Peel and slice the banana before freezing)",
      "5 frozen strawberries ( Hull the strawberries before freezing)",
      "1 cup milk",
      "1 tsp. Cocoa Powder",
      "1 tsp Honey",
    ],
    steps: [
      "Place the banana and strawberries into the blender.",
      "Pour in milk, cocoa powder and honey.",
      "Place the lid on the blender and mix using a high-speed setting.",
      "Pour in a tall glass and enjoy!",
    ],
  );
  return recipeModel;
}

FoodRecipeModel trailMix() {
  recipeModel = FoodRecipeModel(
    title: "Recipe: Cooking Champs energy sustaining Carry to school Trail Mix",
    description: "",
    image: AssetsPath.mixNuts,
    // Example image path
    tools: [
      AssetsPath.bowlImg,
      AssetsPath.spoon,
      AssetsPath.mug,
      AssetsPath.pot
    ],
    ingredients: [
      "1/2 cup raw cashews",
      "3/4 cup raw almonds",
      "1/2 cup raw sunflower seeds",
      "1/2 cup raw pumpkin seeds",
      "1/2 cup unsweetened raisins",
      "1/3 cup shaved dried coconut",
      "1/2 cup chopped dried apples or apricots",
      "1/2 cup chopped dark chocolate (70% or greater)",
      "1/2 tsp cinnamon",
      "Pinch of nutmeg",
      "Makes 4-5 cups",
    ],
    steps: [
      "Combine all ingredients in a large bowl and mix well.",
      "Store in an air-tight jar. Or you can store 1/4 cup of the trail mix in small air-tight containers and take as a snack pouch in your bag.",
      "Will keep for up to 1 month.",
    ],
  );
  return recipeModel;
}

FoodRecipeModel rainbowSoup() {
  recipeModel = FoodRecipeModel(
    title: "Recipe: Nonna’s Minestrone Soup - A Rainbow in a Bowl",
    description: "",
    image: AssetsPath.rainbowSoup,
    // Example image path
    tools: [
      AssetsPath.cutterBoard,
      AssetsPath.knife,
      AssetsPath.excelsiorImg,
      AssetsPath.bottleOpener,
      AssetsPath.sieve,
      AssetsPath.mug,
      AssetsPath.cups3d,
      AssetsPath.spoon3D,
      AssetsPath.scoop,
    ],
    ingredients: [
      "1/4 cup olive oil",
      "2 large cloves of garlic, minced",
      "1 onions diced",
      "2 carrots, cleaned and diced/sliced",
      "1 stalk celery plus leaves, cleaned and diced/sliced to 1½ cups total",
      "1 cups fresh green beans,",
      "1 can tomatoes OR use the same amount of fresh tomatoes, if available",
      "1 potato medium size,",
      "2 zucchini, diced with skin left on",
      "1 cup fresh spinach chopped",
      "1 cups fresh cabbage, chopped",
      "1 can cannellini beans, drained and rinsed well",
      "1 can dark red kidney beans, drained and rinsed well",
      "1/2 bunch fresh continental parsley, stems removed and chopped (makes about 1/2 cup)",
      "5 fresh sage leaves chopped",
      "1 chunk of parmesan rind about 2 cm x 2 cm piece (scrape rind)",
      "1 litre water",
      "Salt",
      "Pepper",
      "1/2 cups small dry pasta",
      "1 teaspoon dried thyme",
      "freshly grated Parmesan cheese for serving"
    ],
    steps: [
      "Dice onions, carrot, celery, potato, zucchini",
      "Chop spinach, cabbage, parsley, sage, garlic",
      "Cut fresh green beans in centimetre pieces.",
      "Drain and rinse Cannellini and kidney beans",
      "Pour the olive oil into the pot",
      "Add the chopped onions and minced garlic and dry thyme, cook until clear (careful not to burn the garlic!)",
      "Add the carrots, celery, potatoes, chopped zucchini, the green beans, spinach and cabbage.",
      "Stir all ingredients well",
      "Add the tomatoes and water.",
      "Add the cannellini, and kidney beans",
      "Add a chunk of parmesan cheese",
      "Pour over water"
          "When the soup begins to boil add dry pasta season with salt and pepper"
          "Simmer until all the vegetables are soft .",
      "Serve with fresh bread and sprinkle with freshly grated parmesan cheese .",
    ],
  );
  return recipeModel;
}
