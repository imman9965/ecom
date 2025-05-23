import 'dart:async';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../utils/responsive_layout.dart';

class BannerSection extends StatefulWidget {
  final List<dynamic> banners;

  const BannerSection({required this.banners, super.key});

  @override
  _BannerSectionState createState() => _BannerSectionState();
}

class _BannerSectionState extends State<BannerSection> {
  late PageController pageController;
  int currentPage = 0;
  Timer? timer;

  @override
  void initState() {
    super.initState();
    pageController = PageController(initialPage: 0);
    if (widget.banners.isNotEmpty) {
      startAutoScroll();
    }
  }

  void startAutoScroll() {
    timer = Timer.periodic(Duration(seconds: 3), (timer) {
      if (currentPage < widget.banners.length - 1) {
        currentPage++;
      } else {
        currentPage = 0;
      }
      pageController.animateToPage(
        currentPage,
        duration: Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    });
  }

  @override
  void dispose() {
    timer?.cancel();
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final height = ResponsiveLayout.getResponsiveValue(
      context,
      mobile: 180,
      tablet: 250,
      desktop: 300,
    );

    return Container(
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(8.0)),
      padding: EdgeInsets.symmetric(
        horizontal: ResponsiveLayout.getResponsiveValue(
          context,
          mobile: 8,
          tablet: 12,
          desktop: 16,
        ),
      ),
      height: height,
      child:
          widget.banners.isEmpty
              ? shimmer()
              : Column(
                children: [
                  Expanded(
                    child: PageView.builder(
                      controller: pageController,
                      itemCount: widget.banners.length,
                      onPageChanged: (index) {
                        setState(() {
                          currentPage = index;
                        });
                      },
                      itemBuilder: (context, index) {
                        return Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16.0),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.3),
                                blurRadius: 6.0,
                                offset: Offset(0, 3),
                              ),
                            ],
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(16.0),
                            child: Image.network(
                              widget.banners[index]['image_url'],
                              fit: BoxFit.cover,
                              loadingBuilder: (
                                context,
                                child,
                                loadingProgress,
                              ) {
                                if (loadingProgress == null) return child;
                                return Shimmer.fromColors(
                                  baseColor: Colors.grey[300]!,
                                  highlightColor: Colors.grey[100]!,
                                  child: Container(color: Colors.white),
                                );
                              },
                              errorBuilder: (context, error, stackTrace) {
                                return Container(
                                  color: Colors.grey[200],
                                  child: Center(child: Icon(Icons.error)),
                                );
                              },
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children:
                        widget.banners.asMap().entries.map((entry) {
                          return Container(
                            width: 8.0,
                            height: 8.0,
                            margin: EdgeInsets.symmetric(
                              vertical: 8.0,
                              horizontal: 4.0,
                            ),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: (Theme.of(context).brightness ==
                                          Brightness.dark
                                      ? Colors.white
                                      : Colors.black)
                                  .withOpacity(0.3),
                            ),
                          );
                        }).toList(),
                  ),
                ],
              ),
    );
  }

  Widget shimmer() {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16.0),
          color: Colors.white,
        ),
      ),
    );
  }
}
