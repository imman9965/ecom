import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../utils/responsive_layout.dart';

class DealsSection extends StatelessWidget {
  final List<dynamic> deals;

  DealsSection({super.key, required this.deals});

  @override
  Widget build(BuildContext context) {
    final padding = ResponsiveLayout.getResponsiveValue(
      context,
      mobile: 8,
      tablet: 12,
      desktop: 16,
    );

    final spacing = ResponsiveLayout.getResponsiveValue(
      context,
      mobile: 10,
      tablet: 15,
      desktop: 20,
    );

    final aspectRatio = ResponsiveLayout.getResponsiveValue(
      context,
      mobile: 0.7,
      tablet: 0.75,
      desktop: 0.8,
    );

    final titleFontSize = ResponsiveLayout.getResponsiveValue(
      context,
      mobile: 14,
      tablet: 15,
      desktop: 16,
    );

    final priceFontSize = ResponsiveLayout.getResponsiveValue(
      context,
      mobile: 14,
      tablet: 15,
      desktop: 16,
    );

    final discountFontSize = ResponsiveLayout.getResponsiveValue(
      context,
      mobile: 12,
      tablet: 13,
      desktop: 14,
    );

    return GridView.builder(
      itemCount: deals.length,
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      padding: EdgeInsets.all(padding),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: ResponsiveLayout.getGridCrossAxisCount(context),
        mainAxisSpacing: spacing,
        crossAxisSpacing: spacing,
        childAspectRatio: aspectRatio,
      ),
      itemBuilder: (context, index) {
        final deal = deals[index];
        return Card(
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: ClipRRect(
                  borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
                  child: Image.network(
                    deal['image'],
                    fit: BoxFit.cover,
                    width: double.infinity,
                    loadingBuilder: (context, child, loadingProgress) {
                      if (loadingProgress == null) return child;
                      return Shimmer.fromColors(
                        baseColor: Colors.grey[300]!,
                        highlightColor: Colors.grey[100]!,
                        child: Container(color: Colors.white),
                      );
                    },
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(padding),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      deal['title'],
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: titleFontSize,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: 4),
                    Text(
                      "\$${deal['price']}",
                      style: TextStyle(fontSize: priceFontSize),
                    ),
                    SizedBox(height: 4),
                    Text(
                      deal['discount'],
                      style: TextStyle(
                        color: Colors.red,
                        fontSize: discountFontSize,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
