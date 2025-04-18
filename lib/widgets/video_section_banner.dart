import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:shimmer/shimmer.dart';
import '../utils/responsive_layout.dart';

class VideoBannerSection extends StatefulWidget {
  final List<dynamic> videos;

  const VideoBannerSection({required this.videos});

  @override
  _VideoBannerSectionState createState() => _VideoBannerSectionState();
}

class _VideoBannerSectionState extends State<VideoBannerSection> {
  late VideoPlayerController controller;
  bool isInitialized = false;

  @override
  void initState() {
    super.initState();
    controller = VideoPlayerController.network(widget.videos[0]['video_url'])
      ..initialize()
          .then((_) {
            if (mounted) {
              setState(() {
                controller.setVolume(0);
                controller.setLooping(true);
                controller.play();
                isInitialized = true;
              });
            }
          })
          .catchError((error) {
            if (mounted) {
              setState(() {
                isInitialized = false;
              });
            }
          });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Reduced height values
    final height = ResponsiveLayout.getResponsiveValue(
      context,
      mobile: 180, // Reduced from 200
      tablet: 230, // Reduced from 300
      desktop: 350, // Reduced from 400
    );

    final borderRadius = BorderRadius.circular(
      ResponsiveLayout.getResponsiveValue(
        context,
        mobile: 12,
        tablet: 16,
        desktop: 20,
      ),
    );

    final horizontalPadding = ResponsiveLayout.getResponsiveValue(
      context,
      mobile: 8,
      tablet: 12,
      desktop: 16,
    );

    if (!isInitialized) {
      return Shimmer.fromColors(
        baseColor: Colors.grey[300]!,
        highlightColor: Colors.grey[100]!,
        child: ClipRRect(
          borderRadius: borderRadius,
          child: Container(height: height, color: Colors.white),
        ),
      );
    }

    return Container(
      margin: EdgeInsets.only(bottom: 16.0), // Reduced bottom margin
      padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
      child: ClipRRect(
        borderRadius: borderRadius,
        child: Container(
          height: height, // Set the reduced height
          decoration: BoxDecoration(
            borderRadius: borderRadius,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2),
                blurRadius: 8,
                offset: Offset(0, 4),
              ),
            ],
          ),
          child: Stack(
            children: [
              SizedBox.expand(
                child: FittedBox(
                  fit: BoxFit.cover,
                  child: SizedBox(
                    width: controller.value.size.width,
                    height: controller.value.size.height,
                    child: VideoPlayer(controller),
                  ),
                ),
              ),
              Positioned.fill(
                child: Center(
                  child: IconButton(
                    icon: Icon(
                      controller.value.isPlaying
                          ? Icons.pause
                          : Icons.play_arrow,
                      color: Colors.white.withOpacity(0.8),
                      size: ResponsiveLayout.getResponsiveValue(
                        context,
                        mobile: 40,
                        tablet: 45,
                        desktop: 50,
                      ),
                    ),
                    onPressed: () {
                      setState(() {
                        controller.value.isPlaying
                            ? controller.pause()
                            : controller.play();
                      });
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
