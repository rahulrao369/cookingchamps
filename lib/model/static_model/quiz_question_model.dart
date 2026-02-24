import 'package:flutter/material.dart';

class QuizQuestionModel {
  final String questionNumber;
  final String questionText;
  final List<String>? options; // Optional for MCQ questions
  final String correctAnswer;
  final TextEditingController? controller; // Optional for input-based questions
 final int? maxLine;
 final String? trueFalse;

  QuizQuestionModel({
    required this.questionNumber,
    required this.questionText,
    this.options,
    required this.correctAnswer,
    this.controller,
    this.maxLine,
    this.trueFalse,
  });
}


final List<QuizQuestionModel> foodQuizQuestions = [
  QuizQuestionModel(
    questionNumber: "1",
    questionText: "Why do we need food?",
    correctAnswer: "For energy to stay alive",
    controller: TextEditingController(),
  ),
  QuizQuestionModel(
    questionNumber: "2",
    questionText: "What should we eat every day?",
    correctAnswer: "A rainbow. 2 pieces of fruit and five vegetables",
    controller: TextEditingController(),
  ),
  QuizQuestionModel(
    questionNumber: "3",
    questionText: "We should eat fast food",
    options: ["a) every day?", "b) occasionally", "c) weekly"],
    correctAnswer: "b) Occasionally and in small amounts",
  ),
  QuizQuestionModel(
    questionNumber: "4",
    questionText: "Our body needs food to:",
    options: ["a) stay alive", "b) sleep", "c) run", "d) all of the above"],
    correctAnswer: "d) all of the above",
  ),
  QuizQuestionModel(
    questionNumber: "5",
    questionText: "Nutrients are locked inside the food we eat? True or False?",
    correctAnswer: "True",
    controller: TextEditingController(),
  ),
  QuizQuestionModel(
    questionNumber: "6",
    questionText: "We get energy from the sun? True or False?",
    correctAnswer: "True",
    controller: TextEditingController(),
  ),
];

final List<QuizQuestionModel> safetyQuizQuestions = [
  QuizQuestionModel(
    questionNumber: "1",
    questionText: "What should you never do in the kitchen?",
    correctAnswer: "Run and play",
    controller: TextEditingController(),
  ),
  QuizQuestionModel(
    questionNumber: "2",
    questionText: "Where should handles of pots and pans point?",
    correctAnswer: "Inward",
    controller: TextEditingController(),
  ),
  QuizQuestionModel(
    questionNumber: "3",
    questionText: "How should you carry a knife?",
    correctAnswer: "Facing down",
    controller: TextEditingController(),
  ),
  QuizQuestionModel(
    questionNumber: "4",
    questionText: "What should you keep kitchen electrical appliances away from?",
    correctAnswer: "Water",
    controller: TextEditingController(),
  ),
  QuizQuestionModel(
    questionNumber: "5",
    questionText: "What is the first thing Cooking Champs must do before they start cooking?",
    correctAnswer: "Ask an adult before they start.",
    controller: TextEditingController(),
  ),
];

// List of hygiene quiz questions
final List<QuizQuestionModel> hygieneQuizQuestions = [
  QuizQuestionModel(
    questionNumber: "1",
    questionText: "What is Hygiene another word for?",
    correctAnswer: "Keeping clean",
    controller: TextEditingController(),
    maxLine: 2,
  ),
  QuizQuestionModel(
    questionNumber: "2",
    questionText: "Why is it important to wash your hands with soapy water?",
    correctAnswer: "To kill germs",
    controller: TextEditingController(),
  ),
  QuizQuestionModel(
    questionNumber: "3",
    questionText: "How must you wear your hair when in the kitchen cooking?",
    correctAnswer: "Tied up.",
    controller: TextEditingController(),
  ),
  QuizQuestionModel(
    questionNumber: "4",
    questionText: "What can germs do?",
    correctAnswer: "Make you sick",
    controller: TextEditingController(),
  ),
  QuizQuestionModel(
    questionNumber: "5",
    questionText: "What is a germ's least favorite TV show?",
    correctAnswer: "Soap Operas",
    controller: TextEditingController(),
  ),
  QuizQuestionModel(
    questionNumber: "6",
    questionText: "The Immune system is made up of:",
    options: ["a) every day?", "b) occasionally", "c) weekly", "d) all of the above"],
    correctAnswer: "d) all of the above",
  ),
];

// List of basic quiz questions
final List<QuizQuestionModel> basicQuizQuestions = [
  QuizQuestionModel(
    questionNumber: "1",
    questionText: "What do we use Tongs for?",
    correctAnswer: "Used for picking food up, turning and flipping.",
    controller: TextEditingController(),
  ),
  QuizQuestionModel(
    questionNumber: "2",
    questionText: "Which tool do we use to beat eggs?",
    correctAnswer: "Whisk",
    controller: TextEditingController(),
  ),
  QuizQuestionModel(
    questionNumber: "3",
    questionText: "What do we use to measure ingredients with?",
    correctAnswer: "Measuring cup, measuring spoons and measuring jug.",
    controller: TextEditingController(),
  ),
  QuizQuestionModel(
    questionNumber: "4",
    questionText: "What do we use to weigh our ingredients?",
    correctAnswer: "Kitchen scales",
    controller: TextEditingController(),
  ),
  QuizQuestionModel(
    questionNumber: "5",
    questionText: "How many millimetres in 1 centimetre?",
    correctAnswer: "10",
    controller: TextEditingController(),
  ),
];

// List of sense quiz questions
final List<QuizQuestionModel> senseQuizQuestions = [
  QuizQuestionModel(
    questionNumber: "1",
    questionText: "How many senses do we have?",
    correctAnswer: "5",
    controller: TextEditingController(),
  ),
  QuizQuestionModel(
    questionNumber: "2",
    questionText: "Which sense do we use our tongue for?",
    correctAnswer: "Taste",
    controller: TextEditingController(),
  ),
  QuizQuestionModel(
    questionNumber: "3",
    questionText: "Our sense of smell can warn us if there is a fire in the kitchen.",
    correctAnswer: "True",
    controller: TextEditingController(),
    trueFalse:"True/False",
  ),
  QuizQuestionModel(
    questionNumber: "4",
    questionText: "We should use all of our senses when we are in the kitchen.",
    correctAnswer: "True",
    controller: TextEditingController(),
    trueFalse:"True/False",
  ),
  QuizQuestionModel(
    questionNumber: "5",
    questionText: "Chocolate has a bitter flavour.",
    correctAnswer: "True",
    controller: TextEditingController(),
    trueFalse:"True/False",
  ),
];

// List of vegetable quiz questions
final List<QuizQuestionModel> vegetableQuizQuestions = [
  QuizQuestionModel(
    questionNumber: "1",
    questionText: "Name three vegetables that start with the letter C?",
    correctAnswer: "Cauliflower, cucumber, carrots",
    controller: TextEditingController(),
  ),
  QuizQuestionModel(
    questionNumber: "2",
    questionText: "What word starting with Z means courgette?",
    correctAnswer: "Zucchini",
    controller: TextEditingController(),
  ),
  QuizQuestionModel(
    questionNumber: "3",
    questionText: "If you eat too many carrots and pumpkin you can turn yellow.",
    correctAnswer: "True",
    controller: TextEditingController(),
  ),
  QuizQuestionModel(
    questionNumber: "4",
    questionText: "The part of broccoli you eat is actually baby flowers that haven’t opened yet.",
    correctAnswer: "True",
    controller: TextEditingController(),
  ),
  QuizQuestionModel(
    questionNumber: "5",
    questionText: "Feta comes from:",
    options: ["a) Italy", "b) France", "c) Greece", "d) Spain"],
    correctAnswer: "c) Greece",
  ),
];

// List of fruit quiz questions
final List<QuizQuestionModel> fruitQuizQuestions = [
  QuizQuestionModel(
    questionNumber: "1",
    questionText: "Name two fruits that start with P.",
    correctAnswer: "Pineapple, Pear",
    controller: TextEditingController(),
    maxLine: 2
  ),
  QuizQuestionModel(
    questionNumber: "2",
    questionText: "What fruit name starts with O and ends with e?",
    correctAnswer: "Orange",
    controller: TextEditingController(),
      maxLine: 2
  ),
  QuizQuestionModel(
    questionNumber: "3",
    questionText: "Agar Agar makes liquids turn to jelly.",
    correctAnswer: "True",
    controller: TextEditingController(),
      trueFalse:"True/False",
      maxLine: 1
  ),
  QuizQuestionModel(
    questionNumber: "4",
    questionText: "Strawberries have more vitamin C than oranges.",
    correctAnswer: "True",
    controller: TextEditingController(),
      trueFalse:"True/False",
      maxLine: 1
  ),
  QuizQuestionModel(
    questionNumber: "5",
    questionText: "Apples float because they are 25% air?",
    correctAnswer: "True",
    controller: TextEditingController(),
      trueFalse:"True/False",
      maxLine: 1
  ),
];

// List of bee quiz questions
final List<QuizQuestionModel> beeHoneyQuizQuestions = [
  QuizQuestionModel(
    questionNumber: "1",
    questionText: "Which bees are the workers?",
    correctAnswer: "The female or girl bees",
    controller: TextEditingController(),
    maxLine: 1,
  ),
  QuizQuestionModel(
    questionNumber: "2",
    questionText: "What do honey bees take from the flower?",
    correctAnswer: "Nectar",
    controller: TextEditingController(),
    maxLine: 1,
  ),
  QuizQuestionModel(
    questionNumber: "3",
    questionText: "Which honey bee doesn’t have a stinger?",
    options: ["a) The workers or girl honey bee", "b) The queen bee", "c) The drones or boy bees"],
    correctAnswer: "c) The drones or boy bees",
    maxLine: 1,
  ),
  QuizQuestionModel(
    questionNumber: "4",
    questionText: "Bees are important because:",
    options: ["a) They make honey", "b) They pollinate plants", "c) all of the above"],
    correctAnswer: "c) all of the above",
    maxLine: 1,
  ),
  QuizQuestionModel(
    questionNumber: "5",
    questionText: "The Queen bee lays one hundred eggs a day?",
    correctAnswer: "False",
    controller: TextEditingController(),
    trueFalse: "True/False",
    maxLine: 1,
  ),
  QuizQuestionModel(
    questionNumber: "6",
    questionText: "Bees have a special language called the waggle dance?",
    correctAnswer: "True",
    controller: TextEditingController(),
    trueFalse: "True/False",
    maxLine: 1,
  ),
];

// List of nuts quiz questions
final List<QuizQuestionModel> nutsQuizQuestions = [
  QuizQuestionModel(
    questionNumber: "1",
    questionText: "Where do nuts grow?",
    correctAnswer: "Trees",
    controller: TextEditingController(),
    maxLine: 1,
  ),
  QuizQuestionModel(
    questionNumber: "2",
    questionText: "Nuts have hard shells.",
    correctAnswer: "True",
    controller: TextEditingController(),
    trueFalse: "True/False",
    maxLine: 1,
  ),
  QuizQuestionModel(
    questionNumber: "3",
    questionText: "Circle the nut that is not a nut at all?",
    options: ["a) Pecan", "b) Peanut", "c) Pine nut"],
    correctAnswer: "b) Peanut",
    maxLine: 1,
  ),
  QuizQuestionModel(
    questionNumber: "4",
    questionText: "Bees are important because",
    options: ["a) They make honey", "b) They pollinate plants", "c) all of the above"],
    correctAnswer: "c) all of the above",
    maxLine: 1,
  ),
  QuizQuestionModel(
    questionNumber: "5",
    questionText: "You should eat 30 grams of nuts a day?",
    correctAnswer: "True",
    controller: TextEditingController(),
    trueFalse: "True/False",
    maxLine: 1,
  ),
  QuizQuestionModel(
    questionNumber: "6",
    questionText: "Name three types of nuts not already mentioned in the Quiz?",
    correctAnswer: "Walnut, Almond, Hazelnut",
    controller: TextEditingController(),
    maxLine: 1,
  ),
];

// List of nuts quiz questions
final List<QuizQuestionModel> celebrationQuizQuestions = [
  QuizQuestionModel(
    questionNumber: "1",
    questionText: "What is the first thing Cooking Champs must do before they start cooking?",
    correctAnswer: "Ask an adult",
    controller: TextEditingController(),
    maxLine: 1,
  ),
  QuizQuestionModel(
    questionNumber: "2",
    questionText: "Why do we need food?",
    correctAnswer: "For energy and to live",
    controller: TextEditingController(),
    maxLine: 1,
  ),
  QuizQuestionModel(
    questionNumber: "3",
    questionText: "What should we eat every day?",
    correctAnswer: "A rainbow",
    controller: TextEditingController(),
    maxLine: 1,
  ),
  QuizQuestionModel(
    questionNumber: "4",
    questionText: "We should eat fast food",
    options: ["a) Every day? ", "b) Occasionally", "c) Weekly"],
    correctAnswer: "b) Occasionally",
    maxLine: 1,
  ),
  QuizQuestionModel(
    questionNumber: "5",
    questionText: "Why is it important to wash your hands with soapy water?",
    correctAnswer: "To kill germs",
    controller: TextEditingController(),
    maxLine: 1,
  ),
  QuizQuestionModel(
    questionNumber: "6",
    questionText: "How many millimetres in a centimetre?",
    correctAnswer: "10",
    controller: TextEditingController(),
    maxLine: 1,
  ),
  QuizQuestionModel(
    questionNumber: "7",
    questionText: "How many senses do we have?",
    correctAnswer: "Five (5)",
    controller: TextEditingController(),
    maxLine: 1,
  ),
  QuizQuestionModel(
    questionNumber: "8",
    questionText: "Name three vegetables that start with the letters A, B and C.",
    correctAnswer: "Asparagus, Artichokes, Beans, Beetroot, Broccoli Carrots, Cucumber, Chives",
    controller: TextEditingController(),
    maxLine: 1,
  ),
QuizQuestionModel(
    questionNumber: "9",
    questionText: "Name two fruit that start with P and two that start with A.",
    correctAnswer: "Plum, pear, Apricot, apple",
    controller: TextEditingController(),
    maxLine: 1,
  ),
  QuizQuestionModel(
    questionNumber: "10",
    questionText: "Bees are important because:",
    options: ["a) They make honey ", "b) They pollinate plants", "c) All of the above"],
    correctAnswer: "c) all of the above",
    maxLine: 1,
  ),
  QuizQuestionModel(
    questionNumber: "11",
    questionText: "30 grams of nuts a day is the healthy way?",
    correctAnswer: "True",
    trueFalse:"True or False",
    controller: TextEditingController(),
    maxLine: 1,
  ),
];




