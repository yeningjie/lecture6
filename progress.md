# 进度报告6（第8周·基础组件与布局系统）

## 一、任务理解

本次作业围绕"常用基础组件 + 布局系统"展开，要求完成三件事并给出可核查的证据：

1. **案例复现**：按指南步骤复现课堂案例 `profile_card`（个人名片页），依次完成"骨架与对齐 → 容器美化与层叠徽标 → 设计稿对照验收"三步，每步一次 Git 提交，代码可运行；
2. **自主实践四项 + AI 标注**：① 六种对齐场景逐一实现并标注参数；② 三栏 2:1:1 弹性分配，并记录一栏内容超长时的表现；③ 层叠角标两个场景（头像徽标、图片浮层文字）；④ 容器美化至少两处（圆角/阴影/留白/剪裁）；⑤ 标注 AI 使用方式并验证；
3. **提交物**：本报告十节全文复制到雨课堂，同一内容存入仓库 `lecture6/progress.md`；代码推送独立仓库 `lecture6`（3 次以上提交、含 README）。

验收标准：① 页面与设计稿一致，主要间距误差控制在 ±4px 内；② 运行无 RenderFlex 溢出告警；③ 能口头解释统计条为什么用 `Expanded`；④ 提供设计稿对照截图与 Widget Inspector 检查截图；⑤ Git 提交信息清晰、仓库结构完整。

## 二、环境与工具

- 操作系统：Windows 11（64 位）
- Flutter 3.47.4（stable）/ Dart 3.13.3 / DevTools 2.60.0
- 运行目标：Chrome（Web）为主，Windows 桌面亦可（`flutter run -d chrome` / `-d windows`）
- 编辑器与终端：Trae CN + PowerShell
- AI 工具：TraeCode（DeepSeek-V4.1-Flash），用于骨架生成、装饰方案、演示页编写与溢出问题排查
- 版本控制：git 2.55.0，远端为 GitHub 独立仓库 `lecture6`（github.com/yeningjie/lecture6）
- 素材：头像与封面由 Python/Pillow 本地生成（`assets/images/avatar.png`、`cover.png`），不使用来路不明的网络图片

## 三、过程记录

2026-10-25，按时间线：

1. `flutter --version` 确认环境（3.47.4）；
2. `flutter create --project-name profile_card --platforms=android,web,windows` 生成工程，确认入口 `main() → runApp(const ProfileCardApp())`；
3. 提交 1：`chore: flutter create profile_card 初始工程`；
4. 按指南步骤一搭骨架：`Scaffold + Column`，头像 `CircleAvatar`、姓名与签名两行 `Text`、统计条三个 `Expanded` 数字块、标签云 `Wrap`；此时不做装饰，只核对结构与对齐；
5. 提交 2：`feat: profile skeleton with alignment`；
6. 用 Python/Pillow 生成头像与封面素材，在 `pubspec.yaml` 声明 `assets/images/`，执行 `flutter pub get`；
7. 按指南步骤二做装饰：420 宽白卡片（圆角 24、阴影、内边距 24）、头像渐变描边、`Stack + Positioned` 在线徽标、统计条浅色容器、`Wrap` 彩色标签、胶囊按钮；同时完成步骤三的间距核对（主要间距：卡片内 24、区块间 18、标签 8）；
8. 提交 3：`feat: card decoration & status badge`；
9. 自主实践：新增演示目录页，逐页实现六种对齐（2 列卡片，宽屏一屏可见）、三栏 2:1:1 与超长溢出对照、两个层叠角标场景、三个容器美化例子；
10. 提交 4：`feat: alignment, flex, stack and container demos`；
11. 验证：`dart analyze lib test` 输出 `No issues found!`，`flutter test` 两个用例通过，`flutter build web` 构建成功；
12. 提交 5：`docs: README and progress report`；按截图清单运行各页面并截取证据存入 `docs/screenshots/`，提交 6 后推送 GitHub。

## 四、关键代码

### 代码段 1：卡片套路（TraeCode 辅助生成，逐行核对并用 Inspector 验证）

```dart
Container(
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
  child: Column(children: [ /* 头像、姓名、统计条、标签、按钮 */ ]),
)
```

逐行解释：

- `width: 420`：名片卡固定宽度，桌面/平板截图中比例稳定；窄屏由父级 `Center` 的松约束自动收缩，不会横向溢出；
- `padding: EdgeInsets.all(24)`：`Container` 内边距，负责卡片内容与边缘的留白；
- `color` 与 `decoration` 不能同时写，因此底色放进 `BoxDecoration.color`，避免编译报错；
- `borderRadius: BorderRadius.circular(24)`：iOS 风格大圆角；
- `boxShadow`：`color: 0x14000000` 是约 8% 透明黑，`blurRadius: 24` 控制柔和度，`offset: (0, 10)` 让阴影向下偏移，卡片有悬浮感；
- `child` 用 `Column` 组织纵向信息层级。

验证：Widget Inspector 选中该 `Container`，看到实际尺寸约 420×430、`borderRadius` 24、padding 24，与对照参数一致；截图为 `docs/screenshots/profile_card.png`。

### 代码段 2：Stack + Positioned 在线徽标（TraeCode 辅助生成，运行截图验证）

```dart
Stack(
  clipBehavior: Clip.none,
  children: [
    Container(
      padding: const EdgeInsets.all(4),
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        gradient: LinearGradient(colors: [Color(0xFF6C8CFF), Color(0xFF9B6CFF)]),
      ),
      child: const CircleAvatar(
        radius: 46,
        backgroundImage: AssetImage('assets/images/avatar.png'),
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
)
```

逐行解释：

- `Stack` 的子项按书写顺序从底到顶绘制，后写的徽标压住头像；
- 非 `Positioned` 的头像决定 `Stack` 尺寸（约 100×100），`Positioned` 子项不参与尺寸计算；
- `right: 6, bottom: 6` 相对 `Stack` 右下角定位，把徽标压在头像边缘；
- `shape: BoxShape.circle` + 白色 3px 边框，让绿点与头像之间出现一圈"镂空"分隔；
- `clipBehavior: Clip.none` 允许徽标越出 `Stack` 边界仍可见。

验证：运行截图 `docs/screenshots/stack.png` 中徽标位于头像右下角；将 `bottom` 改为 `-8` 时徽标会越出头像外，证明 `Clip.none` 生效。

### 代码段 3：Expanded 比例分配与超长内容修复（TraeCode 辅助生成，测试与 Inspector 验证）

```dart
Row(
  crossAxisAlignment: CrossAxisAlignment.stretch,
  children: const [
    Expanded(flex: 2, child: _Block(label: 'flex: 2', sub: '50%')),
    Expanded(flex: 1, child: _Block(label: 'flex: 1', sub: '25%')),
    Expanded(flex: 1, child: _Block(label: 'flex: 1', sub: '25%')),
  ],
)

// 超长栏的修复写法
Row(
  children: [
    const Icon(Icons.check_circle_outline, size: 16),
    const SizedBox(width: 6),
    Flexible(
      child: Text(
        'Flutter布局系统进阶实战训练营第二期报名中',
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
    ),
  ],
)
```

逐行解释：

- `Row` 把主轴（水平）可用宽度作为约束传给子项；三个 `Expanded` 先把剩余空间按 `flex` 权重 2:1:1 分成 4 份，分别拿到 50% / 25% / 25% 的**紧约束**；
- `crossAxisAlignment: stretch`：交叉轴（垂直）方向拉伸，三个色块等高；
- `Flexible` 与 `Expanded` 的区别：`Expanded` 强制子项撑满分到的空间，`Flexible` 允许子项**小于**分配空间，因此适合文本按内容收缩；
- `maxLines: 1` + `overflow: TextOverflow.ellipsis`：超长文本只占一行，末尾省略号，不再向外溢出。

验证：第②组不加保护时控制台报 `A RenderFlex overflowed by 174 pixels on the right.`（用临时 widget 测试捕获到同一数值）；改用 `Flexible + ellipsis` 后复测零告警，截图见 `flex_overflow.png` 与 `flex_fix.png`。

## 五、检查点结果

1. **与设计稿一致**：名片卡宽 420、内边距 24、圆角 24、阴影模糊 24/偏移 (0,10)；头像半径 46、渐变描边 4、徽标 18；统计条容器圆角 16、底色 `#F7F9FF`；标签间距 8、圆角 20；按钮高 44、胶囊圆角。主要间距误差均在 ±4px 内（设计稿未标注的细节按指南"卡片套路"取值）。证据：`profile_card.png` 运行截图 + `inspector.png` 中 Inspector 显示的实际尺寸与约束。
2. **运行无 RenderFlex 溢出告警**：个人名片页在 800×600 与 1280×800 两种窗口下均无黄黑条；`flutter test` 中名片页用例通过。演示页第②组是**故意**复现溢出（174px），第③组为修复对照，已在截图中标注。
3. **口头解释统计条为什么用 Expanded**：`Row` 的宽度有限，三个数字块若写固定宽度，屏幕变宽会留下大片空白、变窄又会溢出；`Expanded` 把剩余宽度等分（默认 `flex: 1`）并以紧约束交给子项，三个块随屏幕宽度同步伸缩。若希望突出某一项，只需改 `flex`（如 2:1:1），不用改任何尺寸常量。

## 六、问题与调试

**问题 1（真实发生）**：弹性实验第②组运行后右侧出现黄黑条，控制台打印 `A RenderFlex overflowed by 174 pixels on the right.`

- 定位过程：先读源码——第三栏由 `Expanded(flex: 1)` 分到约 (420-32)÷4 ≈ 97px 的紧约束；栏内是一个普通 `Row`，其中图标 16px + 间距 6px + 不换行文本的固有宽度约 249px，合计 271px，超出约 174px。再用 Widget Inspector 选中内层 `Row`，Layout Explorer 显示 `maxWidth ≈ 97`、`size.width ≈ 271`，与手算一致，确认是"内层 Row 的内容宽度超过紧约束"而非外层比例算错。
- 解决方案：把超长文本改为 `Flexible` + `maxLines: 1` + `TextOverflow.ellipsis`，让文本在可用宽度内截断；复测第③组无任何告警。另用临时 widget 测试捕获同一错误文本确认数值为 174，验证后删除该临时测试。

**问题 2（真实发生）**：为了统一卡片样式，最初在演示卡片的 `_Card` 包装层加了 `ClipRRect`，结果第②组的黄黑条被裁掉，看不到溢出实验现象。

- 定位过程：对比"正常卡片可见圆角、异常卡片无黄黑条"，检查包装层发现 `ClipRRect` 会裁剪子项绘制区域，溢出条纹属于子项绘制内容，因此被一起裁掉。
- 解决方案：移除 `_Card` 的 `ClipRRect`（圆角由各色块自身 `borderRadius` 提供），保留溢出区域可见；重新运行第②组，黄黑条与告警均恢复。

**问题 3（指南预警的规避记录）**：指南提示 `Container` 同时设置 `color` 与 `decoration` 会编译报错。本次所有卡片均把底色写在 `BoxDecoration.color` 中，`dart analyze` 零告警，未触发该错误。

## 七、AI 使用记录

| 用途 | 指令摘要 | 输出 | 本人验证方式 |
| --- | --- | --- | --- |
| 骨架生成 | "按指南步骤一搭 profile_card 骨架：头像、姓名签名、三个 Expanded 统计块、Wrap 标签，不做装饰" | `profile_card_page.dart` 骨架 | `dart analyze` 零告警；`flutter test` 通过；运行核对结构与对齐 |
| 装饰与徽标 | "用卡片套路加圆角/阴影/留白，头像右下用 Stack+Positioned 加在线徽标" | 卡片 `BoxDecoration` 与 `Stack` 代码 | Inspector 读取实际尺寸；截图对照参数 |
| 自主实践页面 | "实现六种 mainAxisAlignment 场景、三栏 2:1:1、两个 Stack 场景、三个容器美化例子" | 四个演示页 + 演示目录 | 逐页运行截图；`flutter build web` 成功 |
| 溢出排查 | "RenderFlex overflowed by 174 pixels 的原因与最小修复" | `Flexible + ellipsis` 方案与原因分析 | 改后复测无告警；Inspector 对比约束与尺寸 |

**先猜后比（与 TraeCode 方案的对照差异）**：

1. 统计条：我先猜"三个数字块各写 `width: 120`"，TraeCode 方案用 `Expanded` 等分。差异原因：固定宽度无法适配不同窗口，窄屏会直接溢出；采纳 `Expanded` 后拖动窗口宽度，统计条始终等分且无告警。
2. 在线徽标：我先猜"用 `Align` 把绿点放在头像外层右下"，TraeCode 用 `Stack + Positioned`。差异原因：`Align` 只能相对父容器对齐，无法压住头像边缘，`Positioned` 的 `right/bottom` 更直接；采纳后者。
3. 溢出修复：我先猜"把字号调小"，TraeCode 用 `Flexible + maxLines + ellipsis`。差异原因：缩字号只是拖延问题，换更长的文案仍会溢出；采纳弹性截断，语义与稳定性更好。

## 八、证据截图

（截图统一存放于仓库 `docs/screenshots/`，每图配一句话说明）

1. `profile_card.png` —— 个人名片页最终效果：渐变头像环 + 在线徽标、三个 Expanded 统计块、Wrap 标签云、胶囊按钮；
2. `alignment.png` —— 对齐任务卡：六种 `mainAxisAlignment` 场景同屏对照，每张卡标注参数；
3. `flex_ratio.png` —— 三栏 2:1:1 正常效果：50% / 25% / 25% 色块按 flex 分配；
4. `flex_overflow.png` —— 第三栏内容超长：浏览器右侧黄黑条 + 终端 `RenderFlex overflowed by 174 pixels` 告警同框；
5. `flex_fix.png` —— 同一内容改用 `Flexible + ellipsis` 后截断显示，无黄黑条；
6. `stack.png` —— 两个层叠场景：头像右下角在线徽标、封面图底部浮层文字；
7. `container.png` —— 容器美化：白底圆角阴影卡片、渐变卡片、ClipOval/ClipRRect 剪裁；
8. `inspector.png` —— DevTools Widget Inspector：选中统计条/超长栏查看 constraints 与 size，核对 97px 紧约束与 271px 实际尺寸；
9. `flutter_doctor.png` —— `flutter doctor` 输出：Flutter 3.47.4 与目标平台状态；
10. `git_log.png` —— `git log --oneline --graph`：各步骤提交记录与远程同步情况。

## 九、自评

- 案例复现 `profile_card`（代码可运行、按步骤提交）——已完成，三步对应 3 次提交；
- 检查点：与设计稿一致——已完成，参数逐项核对 + Inspector 截图；
- 检查点：无 RenderFlex 溢出告警——已完成（名片页零告警；演示页②为故意实验并已标注）；
- 检查点：能口头解释统计条为什么用 Expanded——已完成（见第五节第 3 条）；
- 对齐任务卡（六种场景 + 参数标注）——已完成（`alignment_page.dart`）；
- 弹性分配实验（2:1:1 + 超长表现记录）——已完成，含 174px 溢出与修复对照；
- 层叠角标（头像徽标 + 图片浮层文字）——已完成（`stack_page.dart`）；
- 容器美化（圆角/阴影/留白/渐变/剪裁）——已完成，三个例子；
- AI 使用标注（用途、指令、输出、验证 + 对照差异）——已完成（见第七节）；
- Git 规范（3 次以上提交、README、独立仓库 lecture6）——已完成；
- 独立研究任务（选做）——部分完成：约束传递与 Inspector 读数结合检查点完成；FittedBox 三种缩放策略、ClipPath 异形剪裁未做，计划课后补。

## 十、一句话收获与下一步计划

**一句话收获**：布局是"约束的传递游戏"——父组件给约束、子组件报尺寸、父组件定位置；`Expanded` 只负责分配份额，栏内内容超长仍要自己用 `Flexible` / `ellipsis` 处理。

**遗留问题**：FittedBox 的 contain / fill / scaleDown 三种策略还缺实测对比；`ClipPath` 自定义异形头图未动手；DevTools Layout Explorer 中 flex 参数的更多组合还需熟练。

**下次预习要点**：下一课的表单与校验（`TextField` 完整校验流程、控制器与焦点）以及路由导航基础；复习 `Wrap` 与 `ListView` 的选型差异。
