import 'package:flutter/material.dart';

class RecipeStepsWidget extends StatelessWidget {
  final List<String> steps;

  const RecipeStepsWidget({
    Key? key,
    required this.steps,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: List.generate(steps.length, (index) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildStepTile(index, steps[index]),
            if (index != steps.length - 1)
              Image.asset(
                "assets/images/Frame 427321535.png",
                height: 48,
                width: 22,
                color: Colors.grey.shade600,
              ),
          ],
        );
      }),
    );
  }

  Widget _buildStepTile(int index, String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 28,
            height: 28,
            decoration: BoxDecoration(
              color: Colors.purple.withOpacity(0.6),
              shape: BoxShape.circle,
            ),
            alignment: Alignment.center,
            child: Text(
              '${index + 1}',
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 14,
                color: Colors.white,
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(
                fontSize: 15,
                height: 1.4,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
