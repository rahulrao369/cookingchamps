import 'package:cooking_champs/constant/my_color.dart';
import 'package:cooking_champs/constant/sized_box.dart';
import 'package:cooking_champs/model/static_model/quiz_question_model.dart';
import 'package:cooking_champs/utils/ui_utils.dart';
import 'package:cooking_champs/utils/utility.dart';
import 'package:cooking_champs/widgets/global_button.dart';
import 'package:flutter/material.dart';
import 'package:cooking_champs/constant/assets_path.dart';
import 'package:cooking_champs/constant/my_fonts_style.dart';
import 'package:cooking_champs/constant/stringfile.dart/language.dart';
import 'package:mobkit_dashed_border/mobkit_dashed_border.dart';


class QuizPage extends StatefulWidget {
  final Color bgColor;
  final Color btnColor;
  final Color btnTextColor;
  final String chapter;
 final List<QuizQuestionModel> quizQuestions;
  const QuizPage({super.key,required this.quizQuestions,required this.bgColor,this.btnColor = MyColor.appTheme,this.btnTextColor = MyColor.white,required this.chapter});

  @override
  State<QuizPage> createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  // Track answers and filled status
  final Map<String, String> userAnswers = {};
  bool _showCorrectAnswers = false;
  final Map<String, String> selectedOptions = {};

  @override
  void initState() {
    if(widget.quizQuestions != null){
      for(var c in widget.quizQuestions!){
        if(c.controller != null) {
          c.controller!.clear();
          setState(() {});
        }
      }
    }

    super.initState();
  }




  // Helper to check if all fields and options are filled
  bool _allFieldsFilled() {
    // Check if all text controllers are filled
    bool areControllersFilled = widget.quizQuestions!
        .where((q) => q.controller != null)
        .every((q) => q.controller!.text.trim().isNotEmpty);

    // Check if all questions with options have a selected option
    bool areOptionsSelected = widget.quizQuestions!
        .where((q) => q.options != null)
        .every((q) => selectedOptions.containsKey(q.questionNumber));

    return areControllersFilled && areOptionsSelected;
  }

// Submit and validate answers
  void _submitAnswers() {
    setState(() {
      if (_allFieldsFilled()) {
        _showCorrectAnswers = true; // Show correct answers
      } else {
        _showCorrectAnswers = false;
        Utility.customToast(context, 'Please fill all fields and select an option for each question before submitting');

      }
    });
  }

  Widget _buildOptions(String questionNumber, List<String> options) {
    return Wrap(
      children: options.map((option) {
        bool isSelected = selectedOptions[questionNumber] == option;
        return GestureDetector(
          onTap: () {
            setState(() {
              selectedOptions[questionNumber] = option; // Update selection
            });
          },
          child: Container(
            margin: const EdgeInsets.only(right: 12, top:2, bottom: 5),
            child: UiUtils.buildRegularText(option,
                color:isSelected ? MyColor.darkOrange : MyColor.black),
          ),
        );
      }).toList(),
    );
  }



  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context);
    return Scaffold(
      backgroundColor:widget.bgColor,
      appBar: PreferredSize(
        preferredSize:Size.zero,
        child: AppBar(
          backgroundColor:widget.bgColor,
          automaticallyImplyLeading: false,
        ),
      ),
      bottomNavigationBar:  Column(
        children: [
          Expanded(
            child: Container(
              margin: EdgeInsets.only(bottom:20),
              child: Stack(
                children: [


                  Container(
                    padding: EdgeInsets.only(left:8,right:8,bottom:22),
                    margin: EdgeInsets.only(top:size.size.height * 0.07),
                    //
                    // width: double.infinity,
                    child: Column(
                      children: [
                        Expanded(
                          child: CustomPaint(
                            painter: ExactCurvePainter(),
                            child:  Container(
                              margin: EdgeInsets.only(top:size.size.height * 0.05,bottom:size.size.height * 0.2),
                              child: SingleChildScrollView(
                                child: Container(
                                  padding: EdgeInsets.symmetric(horizontal:25),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      // Title
                                      Row(
                                        children: [
                                          UiUtils.buildBoldText("Quiz time!",color:widget.bgColor,fontSize:23.0),

                                          SizedBox(width: 8),
                                          Icon(Icons.school, color: Colors.amber, size: 32),
                                          Icon(Icons.cloud, color: Colors.blue.shade400, size: 32),
                                        ],
                                      ),
                                      SizedBox(height: 12),
                                      widget.quizQuestions.isNotEmpty?
                                      Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children:widget.quizQuestions.map((question) {
                                            return Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                // Render question
                                                if (question.controller != null)
                                                  QuizQuestion(
                                                    questionNumber: question.questionNumber,
                                                    questionText: question.questionText,
                                                    controller: question.controller!,
                                                    trueFalse: question.trueFalse??"",
                                                    maxLine: question.maxLine ?? 2, // Default to 1 if not specified
                                                  )
                                                else
                                                  Padding(
                                                    padding: const EdgeInsets.only(top:5.0),
                                                    child: UiUtils.buildMediumText(
                                                      "${question.questionNumber}. ${question.questionText}",
                                                      fontSize: 15.0,
                                                    ),
                                                  ),

                                                // Render options (if any)
                                                if (question.options != null) Padding(
                                                  padding: const EdgeInsets.only(bottom: 8.0),
                                                  child: _buildOptions(question.questionNumber, question.options!),
                                                ),

                                                // Render correct answer (conditionally)
                                                if (_showCorrectAnswers)
                                                  UiUtils.quizAnswerUI(question.correctAnswer),

                                                const SizedBox(height: 10),
                                              ],
                                            );
                                          }).toList()
                                      ):SizedBox.shrink(),

                                      hsized45
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(padding: EdgeInsets.only(left: 20,right: 20,top: 55),
                      child: UiUtils.hygieneAppBar(()=> Navigator.pop(context),text: "")),

                  Align(
                      alignment: Alignment.topRight,
                      child: Image.asset(AssetsPath.twoEmoji,height: size.size.height * 0.2,width: 157,)),
                  Align(
                      alignment: Alignment.bottomCenter,
                      child: Image.asset(AssetsPath.girlBoyBottomImg)),
                ],
              ),
            ),
          ),


          Container(
              color:widget.bgColor,
              padding: EdgeInsets.only(left:20,right:20,bottom:20,top: 0),
              child:GlobalButton(Languages.of(context)!.submit,widget.btnColor,widget.btnColor, 55,double.infinity,_submitAnswers,55,0,0,mediumTextStyle(fontSize:16.0, color:widget.btnTextColor))
          ),
        ],
      ),
    );
  }

  void submitOnTap() {


    Navigator.pop(context);
  }


}
// Widget for displaying a question and input field
class QuizQuestion extends StatelessWidget {
  final String questionNumber;
  final String questionText;
  final String trueFalse;
  final TextEditingController? controller;
  final int maxLine;

  const QuizQuestion({super.key, required this.questionNumber, required this.questionText, this.trueFalse = "",this.controller,this.maxLine = 2 });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical:4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "$questionNumber. $questionText",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: Colors.black87,
            ),
          ),
          trueFalse.isNotEmpty? UiUtils.buildNormalText(trueFalse):SizedBox.shrink(),

          //SizedBox(height:2),

          textField(),
          SizedBox(height:5),
        ],
      ),
    );
  }

  textField(){
    return Stack(
      children: [
        for (int i = 0; i < maxLine; i++)
          Container(
            margin: EdgeInsets.only(
              top: 4 + (i + 1) * 25,
            ),
            decoration: const BoxDecoration(
              border: DashedBorder(
                dashLength:2,
                left: BorderSide.none,
                top: BorderSide.none,
                right: BorderSide.none,
                bottom: BorderSide(color: Colors.black, width: 1),
              ),
            ),
          ),
         TextField(
           controller:controller,
           scrollPhysics: NeverScrollableScrollPhysics(),
           decoration: InputDecoration(border: InputBorder.none),
           cursorHeight:maxLine == 1? 16: 18,
           onTapOutside: (v){
             FocusManager.instance.primaryFocus!.unfocus();
           },
           style: TextStyle(
             fontSize: 15.0,
           ),
           keyboardType: TextInputType.multiline,
          // expands: true,
           maxLines: maxLine,
           minLines:1,
         ),
      ],
    );
  }
}

class ExactCurvePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white // White background
      ..style = PaintingStyle.fill;

    final path = Path();

    // Start at top left corner
    path.moveTo(size.height * 0.0, size.height * 0.10);

    // Top edge with wavy curve
    path.quadraticBezierTo(
        size.width * 0.01, 0, size.width * 0.2, size.height * 0.04);
    path.quadraticBezierTo(
        size.width * 0.5, size.height * 0.06, size.width * 0.7, size.height * 0.02);
    path.quadraticBezierTo(size.width * 0.9, 0, size.width, size.height * 0.06);

    // Right side
    path.lineTo(size.width, size.height * 0.95);

    // Bottom edge with wavy curve
    path.quadraticBezierTo(
        size.width * 0.9, size.height, size.width * 0.8, size.height * 0.98);
    path.quadraticBezierTo(
        size.width * 0.4, size.height * 0.95, size.width * 0.2, size.height * 0.98);
    path.quadraticBezierTo(
        size.width * 0, size.height, 0, size.height * 0.95);

    // Close the path (left side)
    path.lineTo(0, size.height * 0.05);

    // Draw the path
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}