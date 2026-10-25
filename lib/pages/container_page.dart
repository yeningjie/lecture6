import 'package:flutter/material.dart';

/// 自主实践 4：容器美化。
///
/// 三个例子：白底圆角阴影卡片、渐变卡片、ClipOval / ClipRRect 剪裁。
class ContainerPage extends StatelessWidget {
  const ContainerPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('容器美化')),
      body: Container(
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
            // 例一：白底 + 圆角 + 阴影 + 留白
            Container(
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: const [
                  BoxShadow(
                    color: Color(0x14000000),
                    blurRadius: 18,
                    offset: Offset(0, 8),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        width: 44,
                        height: 44,
                        decoration: BoxDecoration(
                          color: const Color(0xFFEDF2FF),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Icon(
                          Icons.menu_book_outlined,
                          color: Color(0xFF4F7DF3),
                        ),
                      ),
                      const SizedBox(width: 12),
                      const Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '本周学习进度',
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w600,
                                color: Color(0xFF1F2430),
                              ),
                            ),
                            SizedBox(height: 4),
                            Text(
                              '基础组件与布局系统 · 第 8 周',
                              style: TextStyle(
                                fontSize: 12,
                                color: Color(0xFF8A90A2),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const Text(
                        '68%',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w700,
                          color: Color(0xFF4F7DF3),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 14),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: const LinearProgressIndicator(
                      value: 0.68,
                      minHeight: 8,
                      backgroundColor: Color(0xFFEDF1FA),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),
            // 例二：渐变背景 + 圆角 + 内边距
            Container(
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                gradient: const LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [Color(0xFF4F7DF3), Color(0xFF8A6CFF)],
                ),
                boxShadow: const [
                  BoxShadow(
                    color: Color(0x334F7DF3),
                    blurRadius: 20,
                    offset: Offset(0, 8),
                  ),
                ],
              ),
              child: const Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '连续学习 12 天',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          '保持手感，布局规则会越用越熟',
                          style: TextStyle(color: Colors.white70, fontSize: 12),
                        ),
                      ],
                    ),
                  ),
                  Icon(Icons.local_fire_department, color: Colors.white, size: 34),
                ],
              ),
            ),
            const SizedBox(height: 12),
            // 例三：剪裁（圆 / 圆角）
            Container(
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: const [
                  BoxShadow(
                    color: Color(0x14000000),
                    blurRadius: 18,
                    offset: Offset(0, 8),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    '剪裁：ClipOval 与 ClipRRect',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF1F2430),
                    ),
                  ),
                  const SizedBox(height: 14),
                  Row(
                    children: [
                      ClipOval(
                        child: Image.asset(
                          'assets/images/avatar.png',
                          width: 64,
                          height: 64,
                          fit: BoxFit.cover,
                        ),
                      ),
                      const SizedBox(width: 14),
                      Expanded(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(14),
                          child: Image.asset(
                            'assets/images/cover.png',
                            height: 64,
                            width: double.infinity,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    '同一张图，ClipOval 裁成圆形，ClipRRect 裁成 14 圆角矩形，'
                    '形状不同、像素内容一致。',
                    style: TextStyle(
                      fontSize: 12,
                      height: 1.6,
                      color: Color(0xFF8A90A2),
                    ),
                  ),
                ],
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
                '避坑记录：Container 同时写 color 与 decoration 会编译报错'
                '（color 必须放进 decoration）；嵌套三层以上就应抽成独立组件。',
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
    );
  }
}
