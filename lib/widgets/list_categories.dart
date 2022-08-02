import 'package:flutter/material.dart';
import 'package:waijudi/models/category.dart';
import 'package:waijudi/util/colors.dart';

class ListCategories extends StatelessWidget {
  final List<Category> categories;
  final Category selectedCategory;
  final Function(Category) onSelectCategory;

  const ListCategories({Key? key, required this.categories, required this.selectedCategory, required this.onSelectCategory}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: categories.length,
      child: TabBar(
        splashFactory: NoSplash.splashFactory,
        enableFeedback: false,
        isScrollable: true,
        indicator: CustomTabIndicator(
          color: AppColors.LIGHT_GREEN,
          indicatorHeight: 3,
          radius: 3,
        ),
        indicatorSize: TabBarIndicatorSize.label,
        onTap: (idx) => onSelectCategory(categories.elementAt(idx)),
        labelPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        labelColor: AppColors.LIGHT_GREEN,
        unselectedLabelColor: AppColors.DARK.withOpacity(0.3),
        labelStyle: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
        tabs: [
          for (final category in categories)
            Text(
              category.name,
            ),
        ],
      )
    );
  }
}

class CustomTabIndicator extends Decoration {
  final double radius;
  final Color color;
  final double indicatorHeight;

  const CustomTabIndicator({
    this.radius = 8,
    this.indicatorHeight = 4,
    this.color = Colors.blue,
  });

  @override
  _CustomPainter createBoxPainter([VoidCallback? onChanged]) {
    return _CustomPainter(
      this,
      onChanged,
      radius,
      color,
      indicatorHeight,
    );
  }
}

class _CustomPainter extends BoxPainter {
  final CustomTabIndicator decoration;
  final double radius;
  final Color color;
  final double indicatorHeight;

  _CustomPainter(
    this.decoration,
    VoidCallback? onChanged,
    this.radius,
    this.color,
    this.indicatorHeight,
  ) : super(onChanged);

  @override
  void paint(Canvas canvas, Offset offset, ImageConfiguration configuration) {
    assert(configuration.size != null);

    final Paint paint = Paint();
    double xAxisPos = offset.dx + configuration.size!.width / 2;
    double yAxisPos = offset.dy + configuration.size!.height - indicatorHeight/2;
    paint.color = color;

    RRect fullRect = RRect.fromRectAndCorners(
      Rect.fromCenter(
        center: Offset(xAxisPos, yAxisPos),
        width: configuration.size!.width + 5,
        height: indicatorHeight,
      ),
     topLeft: Radius.circular(radius),
     topRight: Radius.circular(radius),
     bottomLeft: Radius.circular(radius),
     bottomRight: Radius.circular(radius),
    );

    canvas.drawRRect(fullRect, paint);
  }
}