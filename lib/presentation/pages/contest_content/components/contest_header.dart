import 'package:flutter/material.dart';
import 'package:newsphone_competitions/data/models/image.dart';
import 'package:transparent_image/transparent_image.dart';

class ContestHeader extends StatefulWidget {
  final List<ImageModel>? images;

  const ContestHeader({super.key, this.images});

  @override
  State<ContestHeader> createState() => _ContestHeaderState();
}

class _ContestHeaderState extends State<ContestHeader> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.images == null || widget.images!.isEmpty) {
      return SliverToBoxAdapter(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Container(
            color: Colors.grey[300],
            child: const Icon(Icons.image, size: 50, color: Colors.white),
          ),
        ),
      );
    }

    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              decoration: BoxDecoration(
                color: const Color(0xFFF5F5F7),
                borderRadius: BorderRadius.circular(15.0),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: AspectRatio(
                  aspectRatio: 16 / 13,
                  child: PageView.builder(
                    controller: _pageController,
                    itemCount: widget.images!.length,
                    onPageChanged: (index) {
                      setState(() {
                        _currentPage = index;
                      });
                    },
                    itemBuilder: (context, index) {
                      return FadeInImage.memoryNetwork(
                        placeholder: kTransparentImage,
                        image: widget.images![index].imageUrl,
                        fit: BoxFit.cover,
                        width: double.infinity,
                        fadeInDuration: const Duration(milliseconds: 500),
                        fadeInCurve: Curves.easeIn,
                      );
                    },
                  ),
                ),
              ),
            ),
            if (widget.images!.length > 1) ...[
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  widget.images!.length,
                  (index) => AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    margin: const EdgeInsets.symmetric(horizontal: 4),
                    width: _currentPage == index ? 12 : 8,
                    height: _currentPage == index ? 12 : 8,
                    decoration: BoxDecoration(
                      color:
                          _currentPage == index
                              ? Color(0xFF0765CB)
                              : Colors.grey[400],
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
