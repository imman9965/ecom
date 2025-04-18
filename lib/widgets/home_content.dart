import 'package:ecommercepro/widgets/product_grid_sectiion.dart';
import 'package:ecommercepro/widgets/video_section_banner.dart';
import 'package:flutter/material.dart';
import '../models/section_model.dart';
import 'banner_section.dart';
import 'category_sections.dart';
import 'deals_sections.dart';
import '../utils/responsive_layout.dart';

class HomeContent extends StatelessWidget {
  final List<SectionModel> sections;

  const HomeContent({super.key, required this.sections});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: sections.length,
      itemBuilder: (context, index) {
        final section = sections[index];

        // Get the appropriate title for each section type
        final sectionTitle = getSectionTitle(section.type);

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (sectionTitle != null)
              Padding(
                padding: EdgeInsets.only(
                  left: ResponsiveLayout.getResponsiveValue(
                    context,
                    mobile: 16,
                    tablet: 24,
                    desktop: 32,
                  ),
                  top: 0,
                  bottom: 5,
                ),
                child: Text(
                  sectionTitle,
                  style: TextStyle(
                    fontSize: ResponsiveLayout.getResponsiveValue(
                      context,
                      mobile: 18,
                      tablet: 20,
                      desktop: 18,
                    ),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            sectionWidget(section),
          ],
        );
      },
    );
  }

  Widget sectionWidget(SectionModel section) {
    switch (section.type) {
      case 'banner':
        return BannerSection(banners: section.data);
      case 'video_banner':
        return VideoBannerSection(videos: section.data);
      case 'categories':
        return CategoriesSection(categories: section.data);
      case 'deals_of_the_day':
        return DealsSection(deals: section.data);
      case 'product_grid':
        return ProductGridSection(products: section.data);
      default:
        return SizedBox.shrink();
    }
  }

  String? getSectionTitle(String type) {
    switch (type) {
      case 'banner':
        return 'Banner';
      case 'video_banner':
        return 'Video';
      case 'categories':
        return 'Categories'; // No title for categories
      case 'deals_of_the_day':
        return 'Deals of the Day';
      case 'product_grid':
        return 'Popular Products';
      default:
        return null;
    }
  }
}
