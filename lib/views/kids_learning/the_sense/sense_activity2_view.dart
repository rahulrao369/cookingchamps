import 'package:cooking_champs/constant/assets_path.dart';
import 'package:cooking_champs/constant/dimen.dart';
import 'package:cooking_champs/constant/my_color.dart';
import 'package:cooking_champs/constant/my_fonts_style.dart';
import 'package:cooking_champs/constant/sized_box.dart';
import 'package:cooking_champs/constant/stringfile.dart/language.dart';
import 'package:cooking_champs/model/static_model/food_model.dart';
import 'package:cooking_champs/utils/ui_utils.dart';
import 'package:cooking_champs/widgets/global_button.dart';
import 'package:flutter/material.dart';

class SenseActivity2View extends StatefulWidget {
  final bool isTaste;
  const SenseActivity2View({super.key,required this.isTaste});

  @override
  State<SenseActivity2View> createState() => _SenseActivity2ViewState();
}

int currentPage = 0;

class _SenseActivity2ViewState extends State<SenseActivity2View> {
  TextEditingController controller1 = TextEditingController();
  TextEditingController controller2 = TextEditingController();
  TextEditingController controller3 = TextEditingController();
   List<FoodModel> foodList = [];
   List<TasteModel> tasteList = [];
  bool answersSubmitted = false;
   @override
  void initState() {
  setState(() {
    foodList = foodModels();
    tasteList = tastesList();
  });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          children: [
            hsized35,
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                UiUtils.hygieneAppBar(() => Navigator.pop(context),
                    text: "Activity 5.2", color: MyColor.black),
                UiUtils.bookReadGirl(MyColor.red1, AssetsPath.senseAppbarImage, true)
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                UiUtils.buildBoldText("Taste Test",
                    color: MyColor.red1, fontSize: 23.0),
                UiUtils.buildMediumText(
                  "${widget.isTaste?2:1}/2",
                  color: MyColor.black,
                ),
              ],
            ),
            Expanded(
              child:  !widget.isTaste?buildPage1():
              buildPage2(),
            ),
          ],
        ),
      ),
    );
  }


  void onPageChanged(int value) {
    setState(() {
      currentPage = value;
    });
  }

  buildPage1() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        UiUtils.buildNormalText("You will work in pairs"),
        hsized2,
        UiUtils.buildParagraph("", "You will need : ",
            "1 lemon peeled and cut into segments, honey (placed on teaspoons), salt, orange segmented, apple cut into slices, banana (cut in 2cm pieces), 70-85% dark chocolate small pieces blind fold (1 per pair), teaspoons, paper plates (1 per pair)",
            color: MyColor.darkSky),
        hsized10,
        UiUtils.buildSemiBoldText("Experiment",
            color: MyColor.darkSky, fontSize: 16.0),
        UiUtils.buildSteps([
          "Each group collect 2 pieces of each sample foods.",
          "One partner is blindfolded.",
          "Person without blindfold carefully feeds blindfolded person.",
          "Blindfolded person describes flavour of each sample and which senses they are using.",
          "Partner without blindfold ticks box with flavours and senses used.",
          "When you have tried all samples swap and do the experiment again."
        ]),
      ],
    );
  }

  buildPage2() {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          hsized20,

          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                ConstrainedBox(
                  constraints: BoxConstraints(minWidth: MediaQuery.of(context).size.width),
                child: Table(
                  border: TableBorder.all(color: Colors.red),
                  columnWidths: {
                    0: FixedColumnWidth(70), // Fixed width for the first column
                    1: FixedColumnWidth(70), // Fixed width for the first column
                    2: FixedColumnWidth(70), // Fixed width for the first column
                    3: FixedColumnWidth(70), // Fixed width for the first column
                    4: FixedColumnWidth(70), // Fixed width for the first column
                    5: FixedColumnWidth(70), // Fixed width for the first column
                    6: FixedColumnWidth(70), // Fixed width for the first column
                    7: FixedColumnWidth(70), // Fixed width for the first column
                    8: FixedColumnWidth(70), // Fixed width for the first column
                    9: FixedColumnWidth(79), // Fixed width for the first column
                  },
                  children: [
                    _buildHeaderRow(),
                    ...foodList.map((food) => _buildFoodRow(food)).toList(),
                  ],
                ),
              ),
            ],
          ),
        ),

          hsized10,
          UiUtils.buildBoldText("Did you get any surprises? YES/NO", fontSize: 16.0),
          hsized10,
          UiUtils().fillInTheBlanks("If yes what were they?", controller1),
          hsized3,
          UiUtils().fillInTheBlanks("If yes what were they?", controller2),
          hsized3,
          UiUtils().fillInTheBlanks("If yes what were they?", controller3),
          hsized30,
          GlobalButton(
            Languages.of(context)!.submit,
            MyColor.red1,
            MyColor.red1,
            btnSize55,
            double.infinity,
            submitAnswers,
            55,
            0,
            0,
            mediumTextStyle(fontSize: 18.0, color: MyColor.white),
          ),
          hsized50,
        ],
      ),
    );
  }




  TableRow _buildHeaderRow() {
    return TableRow(
      children:
    //   List.generate(tasteList.length, (int index){
    //     return _buildTableHeader(tasteList[index].name, tasteList[index].displayColor);
    // })

      [
        _buildTableHeader('SAMPLE', MyColor.red1),
        _buildTableHeader('BITTER', MyColor.sky),
        _buildTableHeader('SOUR', MyColor.pink),
        _buildTableHeader('SWEET', MyColor.purple),
        _buildTableHeader('SALTY', MyColor.sky),
        _buildTableHeader('SIGHT', MyColor.darkGreen),
        _buildTableHeader('SMELL', MyColor.darkOrange),
        _buildTableHeader('TASTE', MyColor.darkSky),
        _buildTableHeader('TOUCH', MyColor.liteGray),
        _buildTableHeader('HEARING', MyColor.brownColor),
      ],
    );
  }


  TableRow _buildFoodRow(FoodModel food) {
    return TableRow(
      children: [
        _buildImageCell(food),
        _buildCheckboxCell(food, 'isBitter'),
        _buildCheckboxCell(food, 'isSour'),
        _buildCheckboxCell(food, 'isSweet'),
        _buildCheckboxCell(food, 'isSalty'),
        _buildCheckboxCell(food, 'isSight'),
        _buildCheckboxCell(food, 'isSmell'),
        _buildCheckboxCell(food, 'isTaste'),
        _buildCheckboxCell(food, 'isTouch'),
        _buildCheckboxCell(food, 'isHearing'),
      ],
    );
  }

  Widget _buildImageCell(FoodModel food) {
    return Column(
      children: [
        Image.asset(food.imagePath, height: 50, width: 50),
        Text(food.name, textAlign: TextAlign.center),
      ],
    );
  }


  Map<String, String> correctAnswers = {
    'Lemon': 'isSour',        // Lemon is typically sour
    'Honey': 'isSweet',       // Honey is sweet
    'Orange': 'isSour',       // Orange is sour (with some sweetness)
    'Apple': 'isSweet',       // Apple is sweet (most varieties)
    'Milk': 'isNeutral',      // Milk is neutral, could consider adding 'isNeutral'
    'Banana': 'isSweet',      // Banana is sweet
    'Chocolate': 'isSweet',   // Chocolate is sweet (most common varieties)
  };

  bool isAnswerCorrect(FoodModel food, String selectedTaste) {
    // Check if the selected taste matches the correct one for this food
    return correctAnswers[food.name] == selectedTaste;
  }
  void setValue(FoodModel food,String property, bool value) {
    // Reset all properties to false first
    food.isBitter = false;
    food.isSour = false;
    food.isSweet = false;
    food.isSalty = false;
    food.isSight = false;
    food.isSmell = false;
    food.isTaste = false;
    food.isTouch = false;
    food.isHearing = false;

    // Set the selected property to true
    switch (property) {
      case 'isBitter':
        food.isBitter = value;
        break;
      case 'isSour':
        food.isSour = value;
        break;
      case 'isSweet':
        food.isSweet = value;
        break;
      case 'isSalty':
        food.isSalty = value;
        break;
      case 'isSight':
        food.isSight = value;
        break;
      case 'isSmell':
        food.isSmell = value;
        break;
      case 'isTaste':
        food.isTaste = value;
        break;
      case 'isTouch':
        food.isTouch = value;
        break;
      case 'isHearing':
        food.isHearing = value;
        break;
    }
  }

  Widget _buildCheckboxCell(FoodModel food, String property) {
    bool getValue(String property) {
      switch (property) {
        case 'isBitter':
          return food.isBitter;
        case 'isSour':
          return food.isSour;
        case 'isSweet':
          return food.isSweet;
        case 'isSalty':
          return food.isSalty;
        case 'isSight':
          return food.isSight;
        case 'isSmell':
          return food.isSmell;
        case 'isTaste':
          return food.isTaste;
        case 'isTouch':
          return food.isTouch;
        case 'isHearing':
          return food.isHearing;
        default:
          return false;
      }
    }

    return InkWell(
      radius: 60,
      onTap: () {
        answersSubmitted = false;
        if (!answersSubmitted) { // Allow selection only before submission
          setState(() {
            bool currentValue = getValue(property);
            setValue(food, property, !currentValue); // Toggle the selected taste
          });
        }
      },
      child: Container(
        height: 70,
        alignment: Alignment.center,
        child: Icon(
          Icons.check,
          color: !answersSubmitted
              ? (getValue(property) ? MyColor.sky : Colors.transparent) // Before submission
              : (getValue(property) // After submission
              ? (isAnswerCorrect(food, property) ? Colors.green : Colors.red)
              : Colors.transparent),
          size: 24,
        ),
      ),
    );

  }


  void submitAnswers() {
    setState(() {
      answersSubmitted = true; // Mark that answers have been submitted
      for (var food in foodList) {
        String correctTaste = correctAnswers[food.name] ?? '';
        food.isCorrect = correctTaste.isNotEmpty && food.isSelectedTaste(correctTaste);
      }
    });
  }



  Widget _buildTableHeader(String text, Color color) {
    return Container(
      height:40, // Increase height if needed
      color: color,
      padding: const EdgeInsets.symmetric(horizontal:6.0, vertical: 6.0), // Reduce padding
      child: Center(
        child: FittedBox(
          fit: BoxFit.scaleDown, // Ensures the text fits within the available space
          child: UiUtils.buildMediumText(
            text,
            color: MyColor.white,
            fontSize: 16.0, // Adjust font size for better fit
          ),
        ),
      ),
    );
  }
}


