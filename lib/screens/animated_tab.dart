import 'package:flutter/material.dart';

class AnimatedTabBar extends StatefulWidget {
  @override
  _AnimatedTabBarState createState() => _AnimatedTabBarState();
}

class _AnimatedTabBarState extends State<AnimatedTabBar>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
        length: 3,
        vsync: this,
        animationDuration: Duration(milliseconds: 1000));
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        bottom: TabBar(
          controller: _tabController,
          indicator: CustomTabIndicator(),
          indicatorColor: Colors.white,
          labelColor: Colors.white,
          unselectedLabelColor: Colors.white60,
          tabs: [
            Tab(icon: Icon(Icons.home)),
            Tab(icon: Icon(Icons.search)),
            Tab(icon: Icon(Icons.settings)),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          Container(
            color: Colors.red[100],
            child: Center(child: Text('Home')),
          ),
          Container(
            color: Colors.green[100],
            child: Center(child: Text('Search')),
          ),
          Container(
            color: Colors.blue[100],
            child: Center(child: Text('Settings')),
          ),
        ],
      ),
    );
  }
}

class CustomTabIndicator extends Decoration {
  @override
  BoxPainter createBoxPainter([VoidCallback? onChanged]) {
    return _CustomTabIndicatorPainter(this, onChanged);
  }
}

class _CustomTabIndicatorPainter extends BoxPainter {
  final CustomTabIndicator decoration;

  _CustomTabIndicatorPainter(this.decoration, VoidCallback? onChanged)
      : super(onChanged);

  @override
  void paint(Canvas canvas, Offset offset, ImageConfiguration configuration) {
    final Paint paint = Paint()
      ..color = Colors.blue
      ..style = PaintingStyle.fill;

    final Rect tabRect = offset & configuration.size!;
    final double indicatorHeight = 6.0;
    final double indicatorWidth = tabRect.width;

    final double dx = tabRect.left + (tabRect.width - indicatorWidth);
    final Rect indicator = Rect.fromLTWH(
        dx, tabRect.bottom - indicatorHeight, indicatorWidth, indicatorHeight);
    canvas.drawRRect(
      RRect.fromRectAndRadius(indicator, Radius.circular(2)),
      paint,
    );
  }
}
