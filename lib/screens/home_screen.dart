import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../provider/section_provider.dart';
import '../widgets/home_content.dart';
import '../widgets/shimmer_file.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<SectionProvider>(context, listen: false).fetchSections();
    });
  }

  bool get isMobile => MediaQuery.of(context).size.width < 600;
  bool get isTablet =>
      MediaQuery.of(context).size.width >= 600 &&
      MediaQuery.of(context).size.width < 1000;
  bool get isDesktop => MediaQuery.of(context).size.width >= 1000;

  @override
  Widget build(BuildContext context) {
    final sectionProvider = Provider.of<SectionProvider>(context);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(''),
        elevation: isMobile ? 4.0 : 0.0,
      ),
      body: sectionProvider.isLoading
              ? ShimmerLoader(isMobile: true, isTablet: false)
              : sectionProvider.error.isNotEmpty
              ? Center(child: Text(sectionProvider.error))
              : HomeContent(sections: sectionProvider.sections),
    );
  }
}
