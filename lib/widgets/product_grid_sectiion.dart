import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import '../utils/responsive_layout.dart';

class ProductGridSection extends StatelessWidget {
  final List<dynamic> products;

  ProductGridSection({required this.products});

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
      mobile: 0.75,
      tablet: 0.8,
      desktop: 0.85,
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

    return GridView.builder(
      itemCount: products.length,
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
        final product = products[index];
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
                    product['image'],
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
                      product['title'],
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: titleFontSize,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: 4),
                    Text(
                      "\$${product['price']}",
                      style: TextStyle(fontSize: priceFontSize),
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
