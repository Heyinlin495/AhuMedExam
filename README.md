# 阿虎医考 (Ahu Med Exam)

基于 HarmonyOS 的医疗考试备考应用，为医学生和医疗从业者提供全面的学习工具。

## 项目简介

阿虎医考是一款 HarmonyOS 原生应用，采用 ArkTS 语言开发，使用 Stage 应用模型。应用提供在线课程、题库练习、考试资料、直播大厅和 AI 助手等功能，帮助用户高效备考医学考试。

## 技术栈

- **开发语言**: ArkTS (Ark TypeScript)
- **应用模型**: Stage 模型
- **目标平台**: HarmonyOS (API 19, SDK 5.1.1)
- **构建工具**: Hvigor
- **数据库**: @ohos.data.relationalStore (SQLite)
- **AI 集成**: 通义千问 (qwen-turbo) via DashScope API

## 功能特性

### 用户认证系统
- 用户名/密码登录
- 短信验证码登录
- 用户注册
- 忘记密码/重置密码
- 微信/QQ 登录入口

### 核心学习模块
- **在线课程**: 分类浏览、搜索、课程详情、视频播放
- **题库练习**: 临床、中医、口腔、公卫、药学等分类，含错题本、收藏、学习报告
- **考试资料**: 核心考点、历年真题、模拟试卷、思维导图、速记手册
- **直播大厅**: 正在直播、即将开始、往期回放

### 个人中心
- 个人信息编辑（头像、邮箱、性别、生日、地址）
- 修改密码
- 绑定/更换手机号
- 绑定/解绑微信

### AI 智能助手
- 基于通义千问大模型的智能问答
- 医学知识咨询
- 学习问题解答

## 项目结构

```
MyApplication/
├── AppScope/                    # 应用级配置
│   ├── app.json5               # 应用身份信息
│   └── resources/              # 应用级资源
├── entry/                      # 主模块
│   └── src/main/
│       ├── ets/                # 源代码
│       │   ├── pages/          # 18个页面
│       │   ├── components/     # 4个可复用组件
│       │   ├── model/          # 数据模型
│       │   ├── service/        # 数据服务
│       │   ├── config/         # API配置
│       │   ├── constants/      # 常量定义
│       │   ├── utils/          # 工具类
│       │   ├── entryability/   # 入口能力
│       │   └── entrybackupability/ # 备份能力
│       ├── resources/          # 模块资源
│       └── module.json5        # 模块配置
├── build-profile.json5         # 构建配置
├── oh-package.json5            # 包管理配置
└── hvigorfile.ts               # 构建脚本
```

## 主要页面

| 页面 | 功能 |
|------|------|
| LoginPage | 用户登录 |
| RegisterPage | 用户注册 |
| HomePage | 首页（轮播图、功能入口、热门视频） |
| OnlineSchoolCoursePage | 在线课程列表 |
| QuestionBankPage | 题库浏览 |
| ExamMaterialPage | 考试资料 |
| LiveHallPage | 直播大厅 |
| VideoDetailPage | 视频播放详情 |
| AIAssistantPage | AI智能助手 |
| PersonalInfoPage | 个人信息 |
| ChangePasswordPage | 修改密码 |
| BindPhonePage | 绑定手机 |
| BindWechatPage | 绑定微信 |

## 快速开始

### 环境要求

- DevEco Studio 5.0+
- HarmonyOS SDK 5.1.1 (API 19)
- Node.js 16+

### 安装运行

1. 克隆项目
```bash
git clone https://github.com/Heyinlin495/AhuMedExam.git
```

2. 使用 DevEco Studio 打开项目

3. 等待依赖安装完成

4. 连接 HarmonyOS 设备或启动模拟器

5. 点击运行按钮或使用快捷键 `Ctrl+F5`

### 测试账号

- 用户名: `heyinlin`
- 密码: `123456`

## 权限说明

- `ohos.permission.INTERNET` - 用于 AI 助手 API 调用和网络功能

## 开发工具

- **IDE**: DevEco Studio
- **版本控制**: Git
- **包管理**: ohpm (OpenHarmony Package Manager)

## 贡献指南

1. Fork 本仓库
2. 创建功能分支 (`git checkout -b feature/AmazingFeature`)
3. 提交更改 (`git commit -m 'Add some AmazingFeature'`)
4. 推送到分支 (`git push origin feature/AmazingFeature`)
5. 创建 Pull Request

## 许可证

本项目仅供学习交流使用。

## 联系方式

- 作者: Heyinlin
- 项目地址: https://github.com/Heyinlin495/AhuMedExam

## 致谢

- 感谢 HarmonyOS 提供的开发平台
- 感谢阿里云通义千问提供的 AI 能力支持
