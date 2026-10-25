import 'package:flutter/material.dart';

import 'alignment_page.dart';
import 'container_page.dart';
import 'flex_page.dart';
import 'profile_card_page.dart';
import 'stack_page.dart';

/// 演示目录：集中入口，便于逐页截图与验收。
class DemoIndexPage extends StatelessWidget {
  const DemoIndexPage({super.key});

  @override
  Widget build(BuildContext context) {
    final demos = <_DemoItem>[
      _DemoItem(
        icon: Icons.badge_outlined,
        title: '个人名片（课堂案例）',
        subtitle: 'CircleAvatar / Expanded / Wrap / Stack 徽标 / 卡片装饰',
        tag: '案例复现',
        builder: (_) => const ProfileCardPage(),
      ),
      _DemoItem(
        icon: Icons.align_horizontal_left,
        title: '对齐任务卡（六种场景）',
        subtitle: 'mainAxisAlignment 的 start / center / end / spaceBetween / spaceAround / spaceEvenly',
        tag: '自主实践 1',
        builder: (_) => const AlignmentPage(),
      ),
      _DemoItem(
        icon: Icons.view_column_outlined,
        title: '弹性分配实验',
        subtitle: '三栏 2:1:1 布局，以及一栏内容超长时的溢出与修复对照',
        tag: '自主实践 2',
        builder: (_) => const FlexPage(),
      ),
      _DemoItem(
        icon: Icons.layers_outlined,
        title: '层叠角标',
        subtitle: '头像在线徽标 + 图片浮层文字（Stack + Positioned）',
        tag: '自主实践 3',
        builder: (_) => const StackPage(),
      ),
      _DemoItem(
        icon: Icons.style_outlined,
        title: '容器美化',
        subtitle: '圆角、阴影、留白、渐变与 ClipRRect 剪裁',
        tag: '自主实践 4',
        builder: (_) => const ContainerPage(),
      ),
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('第 8 周 · 基础组件与布局'),
        backgroundColor: Colors.transparent,
        surfaceTintColor: Colors.transparent,
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFFF4F6FB), Color(0xFFE9EEFB)],
          ),
        ),
        child: ListView.separated(
          padding: const EdgeInsets.fromLTRB(20, 8, 20, 24),
          itemCount: demos.length,
          separatorBuilder: (_, _) => const SizedBox(height: 12),
          itemBuilder: (context, index) {
            final demo = demos[index];
            return _DemoCard(
              demo: demo,
              onTap: () => Navigator.of(
                context,
              ).push(MaterialPageRoute(builder: demo.builder)),
            );
          },
        ),
      ),
    );
  }
}

class _DemoItem {
  _DemoItem({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.tag,
    required this.builder,
  });

  final IconData icon;
  final String title;
  final String subtitle;
  final String tag;
  final WidgetBuilder builder;
}

class _DemoCard extends StatelessWidget {
  const _DemoCard({required this.demo, required this.onTap});

  final _DemoItem demo;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(18),
      elevation: 0,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(18),
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(18),
            boxShadow: const [
              BoxShadow(
                color: Color(0x0F000000),
                blurRadius: 16,
                offset: Offset(0, 6),
              ),
            ],
          ),
          child: Row(
            children: [
              Container(
                width: 46,
                height: 46,
                decoration: BoxDecoration(
                  color: const Color(0xFFEDF2FF),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Icon(demo.icon, color: const Color(0xFF4F7DF3)),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Flexible(
                          child: Text(
                            demo.title,
                            style: const TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                              color: Color(0xFF1F2430),
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 3,
                          ),
                          decoration: BoxDecoration(
                            color: const Color(0xFFEAF7F0),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Text(
                            demo.tag,
                            style: const TextStyle(
                              fontSize: 10,
                              color: Color(0xFF2E9E68),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 6),
                    Text(
                      demo.subtitle,
                      style: const TextStyle(
                        fontSize: 12,
                        height: 1.4,
                        color: Color(0xFF8A90A2),
                      ),
                    ),
                  ],
                ),
              ),
              const Icon(Icons.chevron_right, color: Color(0xFFB6BCCB)),
            ],
          ),
        ),
      ),
    );
  }
}
