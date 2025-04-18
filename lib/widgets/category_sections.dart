import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import '../utils/responsive_layout.dart';

class CategoriesSection extends StatelessWidget {
  final List<dynamic> categories;

  CategoriesSection({super.key, required this.categories});

  @override
  Widget build(BuildContext context) {
    final height = ResponsiveLayout.getResponsiveValue(
      context,
      mobile: 100,
      tablet: 120,
      desktop: 140,
    );

    final itemSize = ResponsiveLayout.getResponsiveValue(
      context,
      mobile: 60,
      tablet: 80,
      desktop: 100,
    );

    final padding = ResponsiveLayout.getResponsiveValue(
      context,
      mobile: 8,
      tablet: 16,
      desktop: 58,
    );

    final fontSize = ResponsiveLayout.getResponsiveValue(
      context,
      mobile: 12,
      tablet: 13,
      desktop: 14,
    );

    return SizedBox(
      height: height,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        itemBuilder: (context, index) {
          final category = categories[index];
          return Container(
            padding: EdgeInsets.symmetric(horizontal: padding),
            child: Column(
              children: [
                Container(
                  width: itemSize,
                  height: itemSize,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(category['image']),
                      fit: BoxFit.cover,
                    ),
                    shape: BoxShape.circle,
                  ),
                ),
                SizedBox(height: 4),
                Text(category['name'], style: TextStyle(fontSize: fontSize)),
              ],
            ),
          );
        },
      ),
    );
  }
}
