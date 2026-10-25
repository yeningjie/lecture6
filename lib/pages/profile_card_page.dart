import 'package:flutter/material.dart';

/// 课堂案例：个人名片页（步骤一：骨架与对齐）。
///
/// 本步只搭结构与对齐，不做装饰：
/// 头像区 → 姓名与签名 → 统计条（三个 Expanded）→ 标签云（Wrap）→ 操作按钮。
class ProfileCardPage extends StatelessWidget {
  const ProfileCardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('个人名片')),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: SizedBox(
            width: 420,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // 头像区
                const Center(
                  child: CircleAvatar(
                    radius: 46,
                    child: Icon(Icons.person, size: 48),
                  ),
                ),
                const SizedBox(height: 12),
                // 姓名与签名
                const Text(
                  '林小满',
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 4),
                const Text(
                  '移动应用开发 2401 · 爱写代码也爱摄影',
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20),
                // 统计条：三个 Expanded 等分剩余宽度
                Row(
                  children: const [
                    Expanded(child: _StatItem(value: '128', label: '关注')),
                    Expanded(child: _StatItem(value: '3.2k', label: '粉丝')),
                    Expanded(child: _StatItem(value: '1.8w', label: '获赞')),
                  ],
                ),
                const SizedBox(height: 20),
                // 标签云：Wrap 按行流动
                const Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  alignment: WrapAlignment.center,
                  children: [
                    _Tag(text: 'Flutter'),
                    _Tag(text: 'Dart'),
                    _Tag(text: 'UI 设计'),
                    _Tag(text: '阅读'),
                    _Tag(text: '咖啡'),
                    _Tag(text: '摄影'),
                  ],
                ),
                const SizedBox(height: 20),
                // 操作按钮
                Row(
                  children: [
                    Expanded(
                      child: FilledButton(
                        onPressed: () {},
                        child: const Text('关注'),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () {},
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
    );
  }
}

/// 统计条中的单个数字块。
class _StatItem extends StatelessWidget {
  const _StatItem({required this.value, required this.label});

  final String value;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(value),
        const SizedBox(height: 4),
        Text(label),
      ],
    );
  }
}

/// 标签云中的单个标签。
class _Tag extends StatelessWidget {
  const _Tag({required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(text);
  }
}
