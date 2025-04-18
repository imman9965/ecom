import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerLoader extends StatelessWidget {
  final bool isMobile;
  final bool isTablet;

  const ShimmerLoader({
    Key? key,
    required this.isMobile,
    required this.isTablet,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        // Banner shimmer
        Shimmer.fromColors(
          baseColor: Colors.grey[300]!,
          highlightColor: Colors.grey[100]!,
          child: Container(height: isMobile ? 180 : 300, color: Colors.white),
        ),
        SizedBox(height: 20),

        // Horizontal list shimmer
        Shimmer.fromColors(
          baseColor: Colors.grey[300]!,
          highlightColor: Colors.grey[100]!,
          child: SizedBox(
            height: isMobile ? 100 : 120,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: 5,
              itemBuilder:
                  (_, __) => Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: isMobile ? 8.0 : 16.0,
                    ),
                    child: Column(
                      children: [
                        Container(
                          width: isMobile ? 60 : 80,
                          height: isMobile ? 60 : 80,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(height: 8),
                        Container(width: 60, height: 10, color: Colors.white),
                      ],
                    ),
                  ),
            ),
          ),
        ),
        SizedBox(height: 20),

        // Grid shimmer
        Shimmer.fromColors(
          baseColor: Colors.grey[300]!,
          highlightColor: Colors.grey[100]!,
          child: GridView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: isMobile ? 2 : (isTablet ? 3 : 4),
              childAspectRatio: isMobile ? 0.7 : 0.8,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
            ),
            itemCount: 4,
            itemBuilder:
                (_, __) => Card(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(child: Container(color: Colors.white)),
                      Padding(
                        padding: EdgeInsets.all(isMobile ? 8.0 : 12.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: double.infinity,
                              height: 8,
                              color: Colors.white,
                            ),
                            SizedBox(height: 5),
                            Container(
                              width: 100,
                              height: 8,
                              color: Colors.white,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
          ),
        ),
      ],
    );
  }
}
