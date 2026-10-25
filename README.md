# profile_card

第 8 周·第 6 课《基础组件与布局系统》课堂案例复现与自主实践仓库（远端 `lecture6`）。

## 页面清单

| 入口 | 文件 | 内容 |
| --- | --- | --- |
| 个人名片（课堂案例） | `lib/pages/profile_card_page.dart` | 头像 + 在线徽标、姓名签名、三个 `Expanded` 统计条、`Wrap` 标签云、胶囊按钮 |
| 对齐任务卡（六种场景） | `lib/pages/alignment_page.dart` | `mainAxisAlignment` 的 start / center / end / spaceBetween / spaceAround / spaceEvenly |
| 弹性分配实验 | `lib/pages/flex_page.dart` | 三栏 2:1:1；第三栏超长内容的溢出（黄黑条）与 `Flexible` + 省略号修复对照 |
| 层叠角标 | `lib/pages/stack_page.dart` | 头像在线徽标 + 图片浮层文字（`Stack` + `Positioned`） |
| 容器美化 | `lib/pages/container_page.dart` | 圆角、阴影、留白、渐变、`ClipOval` / `ClipRRect` 剪裁 |

## 运行

```bash
flutter pub get
flutter run -d chrome      # 或 -d windows
```

调试模式下打开「弹性分配实验」第②组，可观察到 `A RenderFlex overflowed by 174 pixels on the right.`；第③组为修复对照，无告警。

## 目录说明

- `lib/main.dart` —— 应用入口与主题
- `lib/pages/` —— 五个演示页面
- `assets/images/` —— 自制头像与封面素材（`avatar.png`、`cover.png`）
- `docs/screenshots/` —— 运行、Inspector、`flutter doctor`、Git 记录截图
- `progress.md` —— 进度报告六（与提交到雨课堂的 docx 内容一致）

## Git 提交记录

```
chore: flutter create profile_card 初始工程
feat: profile skeleton with alignment
feat: card decoration & status badge
feat: alignment, flex, stack and container demos
docs: README and progress report
```
