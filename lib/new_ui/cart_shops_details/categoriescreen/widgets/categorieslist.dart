import 'package:cooking_champs/constant/assets_path.dart';
import 'package:cooking_champs/constant/my_color.dart';
import 'package:flutter/material.dart';

import '../../common/defaulttext.dart';


class Categorieslist extends StatelessWidget {
  const Categorieslist({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final screenWidth = size.width;

    final spacing = screenWidth * 0.03;
    final imageRadius = screenWidth * 0.07;

    int crossAxisCount = 4;
    double childAspectRatio = screenWidth < 350 ? 0.75 : 0.85;
    double horizontalPadding = spacing;

    final List<Map<String, String>> categories = [
      {'name': 'Aprons', 'image': AssetsPath.cookies},
      {'name': 'Plates', 'image': AssetsPath.pan},
      {'name': 'Cleaning', 'image': AssetsPath.listImage},
      {'name': 'Cookware', 'image': AssetsPath.imagesList},
      {'name': 'Glassware', 'image': AssetsPath.cookies},
      {'name': 'Utensils', 'image': AssetsPath.pan},

    ];

    final List<Color> bgColors = [
      Color(0xFFFFF0F0),
      Color(0xFFFFF5E5),
      Color(0xFFF0F3FF),
      Color(0xFFE5FFE8),
      Color(0xFFFFFBE5),
      Color(0xFFFFE5F0),
      Color(0xFFF0FFFF),
      Color(0xFFE8E5FF),
    ];

    return SafeArea(
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: horizontalPadding,
          vertical: spacing,
        ),
        child: GridView.builder(
          physics: BouncingScrollPhysics(),
          itemCount: 30,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: crossAxisCount,
            crossAxisSpacing: spacing,
            mainAxisSpacing: spacing,
            childAspectRatio: childAspectRatio,
          ),
          itemBuilder: (context, index) {
            final item = categories[index % categories.length];
            final bgColor = bgColors[index % bgColors.length];

            return GestureDetector(
              onTap: () {
                print('Tapped on ${item['name']}');
              },
              child: LayoutBuilder(
                builder: (context, constraints) {
                  return Container(
                    decoration: BoxDecoration(
                      color: bgColor,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.08),
                          blurRadius: 8,
                          offset: Offset(0, 2),
                        ),
                      ],
                    ),
                    padding: EdgeInsets.symmetric(
                      vertical: spacing * 0.6,
                      horizontal: spacing * 0.5,
                    ),
                    child: Column(
                      children: [
                        Container(
                          width: imageRadius * 2,
                          height: imageRadius * 2,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.1),
                                blurRadius: 4,
                                offset: Offset(0, 2),
                              ),
                            ],
                          ),
                          child: ClipOval(
                            child: Image.asset(
                              item['image']!,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) {
                                return Container(
                                  color: Colors.grey[200],
                                  child: Icon(
                                    Icons.image_not_supported,
                                    color: Colors.grey[400],
                                    size: imageRadius,
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                        SizedBox(height: spacing * 0.6),
                        FittedBox(
                          fit: BoxFit.scaleDown,
                          child: Text(
                            item['name']!,
                            style: mediumTextStyle(
                              fontSize: 11.0,
                              color: MyColor.color000000,
                            ),
                            maxLines: 1,
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
