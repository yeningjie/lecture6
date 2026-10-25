import 'package:flutter/material.dart';

/// 课堂案例：个人名片页（步骤二～三：容器美化与设计稿对照）。
///
/// 结构：头像区（Stack + Positioned 在线徽标）→ 姓名与签名 → 统计条
/// （三个 Expanded 等分）→ 标签云（Wrap）→ 操作按钮。
class ProfileCardPage extends StatelessWidget {
  const ProfileCardPage({super.key});

  static const _tagColors = [
    Color(0xFFE8F0FF),
    Color(0xFFEAF7F0),
    Color(0xFFFFF3E0),
    Color(0xFFF3E8FF),
    Color(0xFFE7F7F9),
    Color(0xFFFFECEF),
  ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    const tags = ['Flutter', 'Dart', 'UI 设计', '阅读', '咖啡', '摄影'];

    return Scaffold(
      appBar: AppBar(
        title: const Text('个人名片'),
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
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(20, 8, 20, 24),
            child: Container(
              width: 420,
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(24),
                boxShadow: const [
                  BoxShadow(
                    color: Color(0x14000000),
                    blurRadius: 24,
                    offset: Offset(0, 10),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // 头像区：外层渐变描边 + 右下角在线徽标（Stack 层叠）
                  Center(
                    child: Stack(
                      clipBehavior: Clip.none,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(4),
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            gradient: LinearGradient(
                              colors: [Color(0xFF6C8CFF), Color(0xFF9B6CFF)],
                            ),
                          ),
                          child: const CircleAvatar(
                            radius: 46,
                            backgroundColor: Colors.white,
                            backgroundImage: AssetImage(
                              'assets/images/avatar.png',
                            ),
                          ),
                        ),
                        Positioned(
                          right: 6,
                          bottom: 6,
                          child: Container(
                            width: 18,
                            height: 18,
                            decoration: BoxDecoration(
                              color: const Color(0xFF3DD68C),
                              shape: BoxShape.circle,
                              border: Border.all(color: Colors.white, width: 3),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 14),
                  // 姓名与签名
                  const Text(
                    '叶宁杰',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF1F2430),
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    '移动应用开发 2401 · 爱写代码也爱摄影',
                    textAlign: TextAlign.center,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: const Color(0xFF8A90A2),
                    ),
                  ),
                  const SizedBox(height: 18),
                  // 统计条：三个 Expanded 与装饰容器
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF7F9FF),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: const Row(
                      children: [
                        Expanded(child: _StatItem(value: '128', label: '关注')),
                        Expanded(child: _StatItem(value: '3.2k', label: '粉丝')),
                        Expanded(child: _StatItem(value: '1.8w', label: '获赞')),
                      ],
                    ),
                  ),
                  const SizedBox(height: 18),
                  // 标签云：Wrap 流式排列，两种行内间距由 spacing / runSpacing 控制
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    alignment: WrapAlignment.center,
                    children: [
                      for (var i = 0; i < tags.length; i++)
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 6,
                          ),
                          decoration: BoxDecoration(
                            color: _tagColors[i % _tagColors.length],
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            tags[i],
                            style: const TextStyle(
                              fontSize: 12,
                              color: Color(0xFF4A5065),
                            ),
                          ),
                        ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  // 操作按钮：胶囊圆角
                  Row(
                    children: [
                      Expanded(
                        child: FilledButton(
                          onPressed: () {},
                          style: FilledButton.styleFrom(
                            minimumSize: const Size.fromHeight(44),
                            shape: const StadiumBorder(),
                          ),
                          child: const Text('关注'),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: OutlinedButton(
                          onPressed: () {},
                          style: OutlinedButton.styleFrom(
                            minimumSize: const Size.fromHeight(44),
                            shape: const StadiumBorder(),
                          ),
                          child: const Text('私信'),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

/// 统计条中的单个数字块：数字在上、说明在下。
class _StatItem extends StatelessWidget {
  const _StatItem({required this.value, required this.label});

  final String value;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          value,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w700,
            color: Color(0xFF1F2430),
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: const TextStyle(fontSize: 12, color: Color(0xFF8A90A2)),
        ),
      ],
    );
  }
}
