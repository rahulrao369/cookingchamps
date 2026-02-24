import 'package:cooking_champs/model/dynamic_models/my_story_model.dart';
import 'package:cooking_champs/model/dynamic_models/recipe_model.dart';
import 'package:cooking_champs/model/dynamic_models/school_stories_model.dart';

import 'growingactivity.dart';
import 'monthlychallengebanner.dart';

class HomeModel {
  RecipeModel? recipeOfTheWeek;
  List<RecipeModel>? popularRecipes;
  List<StoryModel>? featuredStories;
  List<SchoolStoryData>? schoolStories;
  MonthlyChallengeBannerModel? monthlyChallengeBanner;
  GrowingActivityModel? growingActivity;

  HomeModel({this.recipeOfTheWeek, this.popularRecipes, this.featuredStories,this.monthlyChallengeBanner,
    this.growingActivity, this.schoolStories
  });

  HomeModel.fromJson(Map<String, dynamic> json) {
    recipeOfTheWeek = json['recipe_of_the_week'] != null
        ? RecipeModel.fromJson(json['recipe_of_the_week'])
        : null;

    if (json['popular_recipes'] != null) {
      popularRecipes = <RecipeModel>[];
      json['popular_recipes'].forEach((v) {
        popularRecipes!.add(RecipeModel.fromJson(v));
      });
    }

    if (json['featured_stories'] != null) {
      featuredStories = <StoryModel>[];
      json['featured_stories'].forEach((v) {
        featuredStories!.add(StoryModel.fromJson(v));
      });
    }

    /// 🔍 SCHOOL STORIES DEBUG
    if (json['school_stories'] != null) {
      print('🟡 school_stories key FOUND');
      schoolStories = <SchoolStoryData>[];

      json['school_stories'].forEach((v) {
        final story = SchoolStoryData.fromJson(v);
        schoolStories!.add(story);
      });

      print('🟢 schoolStories parsed count = ${schoolStories!.length}');
      print('🟢 schoolStories data = $schoolStories');
    } else {
      print('🔴 school_stories key is NULL or MISSING');
    }

    monthlyChallengeBanner = json['monthly_challenge_banner'] != null
        ? MonthlyChallengeBannerModel.fromJson(json['monthly_challenge_banner'])
        : null;

    growingActivity = json['growing_activity'] != null
        ? GrowingActivityModel.fromJson(json['growing_activity'])
        : null;
  }



  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (recipeOfTheWeek != null) {
      data['recipe_of_the_week'] = recipeOfTheWeek!.toJson();
    }
    if (popularRecipes != null) {
      data['popular_recipes'] =
          popularRecipes!.map((v) => v.toJson()).toList();
    }
    if (featuredStories != null) {
      data['featured_stories'] =
          featuredStories!.map((v) => v.toJson()).toList();
    }
    if (schoolStories != null) {
      data['school_stories'] =
          schoolStories!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}


