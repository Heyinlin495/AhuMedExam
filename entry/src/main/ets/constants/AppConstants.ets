// 页面路由接口
interface PageRoutesType {
  INDEX: string
  LOGIN: string
  HOME: string
  SMS_LOGIN: string
  FORGOT_PASSWORD: string
  SWITCH_LOGIN: string
  ONLINE_SCHOOL_COURSE: string
  QUESTION_BANK: string
  EXAM_MATERIAL: string
  LIVE_HALL: string
  VIDEO_DETAIL: string
  AI_ASSISTANT: string
  BANNER_DETAIL: string
  PERSONAL_INFO: string
  CHANGE_PASSWORD: string
  BIND_PHONE: string
  BIND_WECHAT: string
  REGISTER: string
}

// 页面路由常量
export const PageRoutes: PageRoutesType = {
  INDEX: 'pages/Index',
  LOGIN: 'pages/LoginPage',
  HOME: 'pages/HomePage',
  SMS_LOGIN: 'pages/SmsLoginPage',
  FORGOT_PASSWORD: 'pages/ForgotPasswordPage',
  SWITCH_LOGIN: 'pages/SwitchLoginPage',
  ONLINE_SCHOOL_COURSE: 'pages/OnlineSchoolCoursePage',
  QUESTION_BANK: 'pages/QuestionBankPage',
  EXAM_MATERIAL: 'pages/ExamMaterialPage',
  LIVE_HALL: 'pages/LiveHallPage',
  VIDEO_DETAIL: 'pages/VideoDetailPage',
  AI_ASSISTANT: 'pages/AIAssistantPage',
  BANNER_DETAIL: 'pages/BannerDetailPage',
  PERSONAL_INFO: 'pages/PersonalInfoPage',
  CHANGE_PASSWORD: 'pages/ChangePasswordPage',
  BIND_PHONE: 'pages/BindPhonePage',
  BIND_WECHAT: 'pages/BindWechatPage',
  REGISTER: 'pages/RegisterPage'
}

// 应用颜色接口
interface AppColorsType {
  PRIMARY_ORANGE: string
  PRIMARY_BLUE: string
  PRIMARY_PURPLE: string
  TEXT_PRIMARY: string
  TEXT_SECONDARY: string
  TEXT_TERTIARY: string
  TEXT_HINT: string
  TEXT_PLACEHOLDER: string
  SUCCESS_GREEN: string
  ERROR_RED: string
  WARNING_ORANGE: string
  LIVE_RED: string
  BG_GRAY: string
  BG_WHITE: string
  BG_CHIP_NORMAL: string
  BG_INPUT: string
  BORDER_LIGHT: string
  BORDER_INPUT: string
  DIVIDER: string
  OVERLAY_SEMI: string
  RATING_STAR: string
}

// 应用颜色常量
export const AppColors: AppColorsType = {
  // 主题色
  PRIMARY_ORANGE: '#FF6B00',
  PRIMARY_BLUE: '#2196F3',
  PRIMARY_PURPLE: '#726DFF',

  // 文本颜色
  TEXT_PRIMARY: '#333333',
  TEXT_SECONDARY: '#666666',
  TEXT_TERTIARY: '#999999',
  TEXT_HINT: '#BBBBBB',
  TEXT_PLACEHOLDER: '#888888',

  // 状态颜色
  SUCCESS_GREEN: '#00CC00',
  ERROR_RED: '#FF4444',
  WARNING_ORANGE: '#FF9800',
  LIVE_RED: '#FF4444',

  // 背景颜色
  BG_GRAY: '#F5F5F5',
  BG_WHITE: '#FFFFFF',
  BG_CHIP_NORMAL: '#F0F0F0',
  BG_INPUT: '#F5F5F5',

  // 边框颜色
  BORDER_LIGHT: '#EEEEEE',
  BORDER_INPUT: '#E0E0E0',

  // 分割线
  DIVIDER: '#DDDDDD',

  // 其他
  OVERLAY_SEMI: '#66000000',
  RATING_STAR: '#FF9800'
}
