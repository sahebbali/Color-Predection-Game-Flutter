import 'package:flutter/material.dart';

class StatsScreen extends StatefulWidget {
  const StatsScreen({super.key});

  @override
  State<StatsScreen> createState() => _StatsScreenState();
}

class _StatsScreenState extends State<StatsScreen>
    with SingleTickerProviderStateMixin {
  bool _isExpanded = false;

  late final AnimationController _animationController;
  late final Animation<double> _rotationAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );
    _rotationAnimation = Tween(begin: 0.0, end: 0.5).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _toggleExpanded() {
    setState(() {
      _isExpanded = !_isExpanded;
      if (_isExpanded) {
        _animationController.forward();
      } else {
        _animationController.reverse();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [_buildHeader(theme), _buildStatsContent(theme)],
    );
  }

  Widget _buildHeader(ThemeData theme) {
    return InkWell(
      onTap: _toggleExpanded,
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Row(
            children: [
              Icon(
                Icons.bar_chart_outlined,
                size: 28,
                color: theme.colorScheme.primary,
              ),
              const SizedBox(width: 16),
              Text(
                'Stats',
                style: theme.textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Spacer(),
              RotationTransition(
                turns: _rotationAnimation,
                child: Icon(
                  Icons.arrow_drop_down,
                  size: 32,
                  color: theme.iconTheme.color,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatsContent(ThemeData theme) {
    return AnimatedCrossFade(
      duration: const Duration(milliseconds: 300),
      crossFadeState: _isExpanded
          ? CrossFadeState.showSecond
          : CrossFadeState.showFirst,
      firstChild: const SizedBox.shrink(),
      secondChild: Padding(
        padding: const EdgeInsets.only(top: 8),
        child: Column(
          children: [
            _StatCard(
              title: 'Overall Performance',
              icon: Icons.pie_chart_outline,
              iconColor: theme.colorScheme.primary,
              content: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _PerformanceStat(
                        label: 'Wins',
                        value: '128',
                        color: Colors.green.shade400,
                        textStyle: theme.textTheme.bodyMedium,
                      ),
                      _PerformanceStat(
                        label: 'Losses',
                        value: '74',
                        color: Colors.red.shade400,
                        textStyle: theme.textTheme.bodyMedium,
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Text('63.4% Win Rate', style: theme.textTheme.titleLarge),
                ],
              ),
            ),
            const SizedBox(height: 12),
            _StatCard(
              title: 'Streaks & Records',
              icon: Icons.star_border,
              iconColor: theme.colorScheme.primary,
              content: Column(
                children: [
                  ListTile(
                    leading: Icon(
                      Icons.whatshot,
                      color: Colors.orange.shade400,
                    ),
                    title: const Text('Current Streak'),
                    trailing: Text(
                      '4 Wins',
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const Divider(),
                  ListTile(
                    leading: Icon(
                      Icons.emoji_events_outlined,
                      color: Colors.amber,
                    ),
                    title: const Text('Longest Win Streak'),
                    trailing: Text(
                      '11 Wins',
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 5),
            _StatCard(
              title: 'Prediction History',
              icon: Icons.history,
              iconColor: theme.colorScheme.primary,
              content: Column(
                children: const [
                  _PredictionHistoryRow(
                    pickedColor: Colors.red,
                    resultColor: Colors.red,
                    isWin: true,
                  ),
                  _PredictionHistoryRow(
                    pickedColor: Colors.blue,
                    resultColor: Colors.green,
                    isWin: false,
                  ),
                  _PredictionHistoryRow(
                    pickedColor: Colors.yellow,
                    resultColor: Colors.red,
                    isWin: false,
                  ),
                  _PredictionHistoryRow(
                    pickedColor: Colors.green,
                    resultColor: Colors.green,
                    isWin: true,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _StatCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final Color iconColor;
  final Widget content;

  const _StatCard({
    required this.title,
    required this.icon,
    required this.iconColor,
    required this.content,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon, color: iconColor),
                const SizedBox(width: 8),
                Text(
                  title,
                  style: theme.textTheme.titleLarge?.copyWith(fontSize: 18),
                ),
              ],
            ),
            const Divider(height: 24),
            content,
          ],
        ),
      ),
    );
  }
}

class _PerformanceStat extends StatelessWidget {
  final String label;
  final String value;
  final Color color;
  final TextStyle? textStyle;

  const _PerformanceStat({
    required this.label,
    required this.value,
    required this.color,
    this.textStyle,
  });

  @override
  Widget build(BuildContext context) {
    final ts = textStyle ?? Theme.of(context).textTheme.bodyMedium;

    return Column(
      children: [
        Text(label, style: ts?.copyWith(fontSize: 16)),
        const SizedBox(height: 4),
        Text(
          value,
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
      ],
    );
  }
}

class _PredictionHistoryRow extends StatelessWidget {
  final Color pickedColor;
  final Color resultColor;
  final bool isWin;

  const _PredictionHistoryRow({
    required this.pickedColor,
    required this.resultColor,
    required this.isWin,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              const Text('You Picked: '),
              Container(
                width: 16,
                height: 16,
                decoration: BoxDecoration(
                  color: pickedColor,
                  shape: BoxShape.circle,
                ),
              ),
            ],
          ),
          Row(
            children: [
              const Text('Result: '),
              Container(
                width: 16,
                height: 16,
                decoration: BoxDecoration(
                  color: resultColor,
                  shape: BoxShape.circle,
                ),
              ),
            ],
          ),
          Icon(
            isWin ? Icons.check_circle : Icons.cancel,
            color: isWin ? Colors.green.shade400 : Colors.red.shade400,
          ),
        ],
      ),
    );
  }
}
