import 'package:flutter/material.dart';

/// 自主实践 1：对齐任务卡。
///
/// Row 的主轴是水平方向，六张卡只改变 [mainAxisAlignment]，
/// 其余参数（三个 52×44 色块、卡片宽度）完全一致，便于逐项对照。
class AlignmentPage extends StatelessWidget {
  const AlignmentPage({super.key});

  static const _scenarios = <_Scenario>[
    _Scenario('01', 'MainAxisAlignment.start', MainAxisAlignment.start),
    _Scenario('02', 'MainAxisAlignment.center', MainAxisAlignment.center),
    _Scenario('03', 'MainAxisAlignment.end', MainAxisAlignment.end),
    _Scenario(
      '04',
      'MainAxisAlignment.spaceBetween',
      MainAxisAlignment.spaceBetween,
    ),
    _Scenario(
      '05',
      'MainAxisAlignment.spaceAround',
      MainAxisAlignment.spaceAround,
    ),
    _Scenario(
      '06',
      'MainAxisAlignment.spaceEvenly',
      MainAxisAlignment.spaceEvenly,
    ),
  ];

  static const _boxColors = [
    Color(0xFF6C8CFF),
    Color(0xFF3DD68C),
    Color(0xFFFFB84D),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('对齐任务卡')),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFFF4F6FB), Color(0xFFE9EEFB)],
          ),
        ),
        child: LayoutBuilder(
          builder: (context, constraints) {
            final columns = constraints.maxWidth >= 900 ? 2 : 1;
            final cardWidth = columns == 1
                ? constraints.maxWidth - 40
                : (constraints.maxWidth - 52) / 2;
            return SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(20, 8, 20, 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    '六种场景除 mainAxisAlignment 外参数一致；每张卡片下方标注所用参数。',
                    style: TextStyle(
                      fontSize: 12,
                      color: Color(0xFF8A90A2),
                      height: 1.4,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Wrap(
                    spacing: 12,
                    runSpacing: 12,
                    children: [
                      for (final scenario in _scenarios)
                        SizedBox(
                          width: cardWidth,
                          child: _AlignmentCard(
                            scenario: scenario,
                            colors: _boxColors,
                          ),
                        ),
                    ],
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

class _Scenario {
  const _Scenario(this.index, this.parameter, this.alignment);

  final String index;
  final String parameter;
  final MainAxisAlignment alignment;
}

class _AlignmentCard extends StatelessWidget {
  const _AlignmentCard({required this.scenario, required this.colors});

  final _Scenario scenario;
  final List<Color> colors;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [
          BoxShadow(
            color: Color(0x0F000000),
            blurRadius: 14,
            offset: Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                scenario.index,
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF4F7DF3),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  scenario.parameter,
                  style: const TextStyle(
                    fontSize: 12,
                    color: Color(0xFF1F2430),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Container(
            height: 84,
            padding: const EdgeInsets.symmetric(horizontal: 8),
            decoration: BoxDecoration(
              color: const Color(0xFFF7F9FF),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              mainAxisAlignment: scenario.alignment,
              children: [
                for (final color in colors)
                  Container(
                    width: 52,
                    height: 44,
                    margin: const EdgeInsets.symmetric(horizontal: 2),
                    decoration: BoxDecoration(
                      color: color,
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
              ],
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'mainAxis = 水平，三个 52×44 色块',
            style: TextStyle(
              fontSize: 11,
              color: Colors.grey.shade500,
            ),
          ),
        ],
      ),
    );
  }
}
