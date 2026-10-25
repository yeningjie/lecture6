import 'package:flutter/material.dart';

/// 自主实践 2：弹性分配实验。
///
/// 第一组：三栏 2:1:1，Expanded 按 flex 比例分配主轴剩余空间；
/// 第二组：第三栏放一段不换行的超长内容，观察内层 Row 的溢出（黄黑条）；
/// 第三组：用 Flexible + ellipsis 修复，截断而不溢出。
class FlexPage extends StatelessWidget {
  const FlexPage({super.key});

  static const _longText = 'Flutter布局系统进阶实战训练营第二期报名中';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('弹性分配实验')),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 760),
          child: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Color(0xFFF4F6FB), Color(0xFFE9EEFB)],
              ),
            ),
            child: ListView(
              padding: const EdgeInsets.fromLTRB(20, 8, 20, 24),
              children: [
                _Card(
                  title: '① 三栏 2:1:1（正常）',
                  subtitle: 'Expanded(flex: 2) 占两份，其余各占一份 → 50% / 25% / 25%',
                  child: SizedBox(
                    width: 688,
                    height: 88,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: const [
                        Expanded(
                          flex: 2,
                          child: _Block(
                            color: Color(0xFF4F7DF3),
                            label: 'flex: 2',
                            sub: '50%',
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: _Block(
                            color: Color(0xFF3DD68C),
                            label: 'flex: 1',
                            sub: '25%',
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: _Block(
                            color: Color(0xFFFFB84D),
                            label: 'flex: 1',
                            sub: '25%',
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                _Card(
                  title: '② 一栏内容超长（不加保护）',
                  subtitle: '内层 Row 不做弹性处理，文本宽度超过所在栏 → RenderFlex 溢出',
                  child: SizedBox(
                    width: 688,
                    height: 64,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        const Expanded(
                          flex: 2,
                          child: _Block(
                            color: Color(0xFF4F7DF3),
                            label: 'flex: 2',
                            sub: '50%',
                          ),
                        ),
                        const Expanded(
                          flex: 1,
                          child: _Block(
                            color: Color(0xFF3DD68C),
                            label: 'flex: 1',
                            sub: '25%',
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Container(
                            decoration: const BoxDecoration(
                              color: Color(0xFFFFECEF),
                            ),
                            padding: const EdgeInsets.symmetric(horizontal: 8),
                            child: Row(
                              children: [
                                const Icon(
                                  Icons.local_offer_outlined,
                                  size: 16,
                                  color: Color(0xFFE2556F),
                                ),
                                const SizedBox(width: 6),
                                SizedBox(
                                  width: 308,
                                  child: Text(
                                    _longText,
                                    softWrap: false,
                                    style: const TextStyle(
                                      fontSize: 13,
                                      color: Color(0xFFE2556F),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                _Card(
                  title: '③ 修复：Flexible + 省略号',
                  subtitle: '把超长文本交给 Flexible，maxLines: 1 + ellipsis → 截断不溢出',
                  child: SizedBox(
                    width: 688,
                    height: 64,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        const Expanded(
                          flex: 2,
                          child: _Block(
                            color: Color(0xFF4F7DF3),
                            label: 'flex: 2',
                            sub: '50%',
                          ),
                        ),
                        const Expanded(
                          flex: 1,
                          child: _Block(
                            color: Color(0xFF3DD68C),
                            label: 'flex: 1',
                            sub: '25%',
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Container(
                            decoration: const BoxDecoration(
                              color: Color(0xFFEAF7F0),
                            ),
                            padding: const EdgeInsets.symmetric(horizontal: 8),
                            child: Row(
                              children: [
                                const Icon(
                                  Icons.check_circle_outline,
                                  size: 16,
                                  color: Color(0xFF2E9E68),
                                ),
                                const SizedBox(width: 6),
                                Flexible(
                                  child: Text(
                                    _longText,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(
                                      fontSize: 13,
                                      color: Color(0xFF2E9E68),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                Container(
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: const Color(0xFFFFF7E6),
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: const Text(
                    '实验记录：图②在调试模式下右侧出现黄黑条，控制台打印 '
                    '“A RenderFlex overflowed by … pixels on the right.”；'
                    '图③同样内容改用 Flexible + ellipsis 后无告警。'
                    '结论：Expanded 只负责分配“份额”，栏内内容仍需自己处理约束。',
                    style: TextStyle(
                      fontSize: 12,
                      height: 1.6,
                      color: Color(0xFF8A6A1F),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _Card extends StatelessWidget {
  const _Card({
    required this.title,
    required this.subtitle,
    required this.child,
  });

  final String title;
  final String subtitle;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: const [
          BoxShadow(
            color: Color(0x0F000000),
            blurRadius: 16,
            offset: Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w600,
              color: Color(0xFF1F2430),
            ),
          ),
          const SizedBox(height: 4),
          Text(
            subtitle,
            style: const TextStyle(
              fontSize: 12,
              height: 1.4,
              color: Color(0xFF8A90A2),
            ),
          ),
          const SizedBox(height: 12),
          // 注意：此处不使用 ClipRRect，否则会把②的溢出黄黑条裁掉，看不到实验现象。
          child,
        ],
      ),
    );
  }
}

class _Block extends StatelessWidget {
  const _Block({required this.color, required this.label, required this.sub});

  final Color color;
  final String label;
  final String sub;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 4),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              label,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 13,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 2),
            Text(
              sub,
              style: const TextStyle(color: Colors.white70, fontSize: 11),
            ),
          ],
        ),
      ),
    );
  }
}
