import 'package:flutter/material.dart';

class DashboardScreen extends StatelessWidget {
  final List<_CategoryInfo> categories = const [
    _CategoryInfo('Security & Safety', Icons.security),
    _CategoryInfo('Crowd Management', Icons.groups),
    _CategoryInfo('Passenger Safety', Icons.accessibility_new),
    _CategoryInfo('Platform Ops', Icons.train),
    _CategoryInfo('Disaster Monitoring', Icons.warning),
    _CategoryInfo('Law & Compliance', Icons.gavel),
  ];

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Container(
            height: screenHeight * 0.85,
            decoration: BoxDecoration(
              color: Colors.cyan.shade100,
              borderRadius: BorderRadius.circular(32),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.08),
                  blurRadius: 12,
                  offset: Offset(0, 6),
                ),
              ],
            ),
            padding: const EdgeInsets.all(32.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildRow(categories.sublist(0, 3)),
                _buildRow(categories.sublist(3, 6)),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildRow(List<_CategoryInfo> rowItems) {
    return Expanded(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: rowItems
            .map((item) => Expanded(
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: DashboardCard(category: item),
          ),
        ))
            .toList(),
      ),
    );
  }
}

class DashboardCard extends StatelessWidget {
  final _CategoryInfo category;

  const DashboardCard({required this.category});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      elevation: 2,
      borderRadius: BorderRadius.circular(24),
      child: InkWell(
        borderRadius: BorderRadius.circular(24),
        onTap: () {
          // Navigate or show dialog etc.
        },
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(category.icon, size: 40, color: Colors.cyan[700]),
              const SizedBox(height: 16),
              Text(
                category.title,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _CategoryInfo {
  final String title;
  final IconData icon;

  const _CategoryInfo(this.title, this.icon);
}
