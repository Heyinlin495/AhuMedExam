import { router } from '@kit.ArkUI'
import { common } from '@kit.AbilityKit'
import { AppColors, PageRoutes } from '../constants/AppConstants'
import { db } from '../utils/DatabaseHelper'

@Entry
@Component
struct LoginPage {
  @State username: string = ''
  @State password: string = ''
  @State errorMsg: string = ''

  async aboutToAppear() {
    const context = getContext(this) as common.UIAbilityContext
    await db.init(context)
  }

  build() {
    Column() {
      // 顶部Banner
      Image($r('app.media.logo'))
        .width('100%')
        .height(180)
        .objectFit(ImageFit.Contain)

      // 阿虎医考标题
      Text('阿虎医考')
        .fontSize(32)
        .fontColor(AppColors.PRIMARY_ORANGE)
        .fontWeight(FontWeight.Bold)
        .margin({ top: 40 })

      // 用户名输入框
      TextInput({ placeholder: '请输入用户名', text: this.username })
        .width('80%')
        .height(50)
        .margin({ top: 40 })
        .borderRadius(25)
        .backgroundColor(AppColors.BG_INPUT)
        .onChange((value: string) => {
          this.username = value
          this.errorMsg = ''
        })

      // 密码输入框
      TextInput({ placeholder: '请输入密码', text: this.password })
        .width('80%')
        .height(50)
        .type(InputType.Password)
        .margin({ top: 20 })
        .borderRadius(25)
        .backgroundColor(AppColors.BG_INPUT)
        .onChange((value: string) => {
          this.password = value
          this.errorMsg = ''
        })

      // 错误提示
      if (this.errorMsg.length > 0) {
        Text(this.errorMsg)
          .fontSize(13)
          .fontColor(AppColors.ERROR_RED)
          .width('80%')
          .margin({ top: 8 })
      }

      // 短信验证码登录和忘记密码
      Row() {
        Text('短信验证码登录')
          .fontSize(14)
          .fontColor(AppColors.PRIMARY_BLUE)
          .onClick(() => {
            router.pushUrl({ url: PageRoutes.SMS_LOGIN })
          })

        Blank()

        Text('忘记密码')
          .fontSize(14)
          .fontColor(AppColors.PRIMARY_BLUE)
          .onClick(() => {
            router.pushUrl({ url: PageRoutes.FORGOT_PASSWORD })
          })
      }
      .width('80%')
      .margin({ top: 15 })

      // 登录按钮
      Button('登录')
        .width('80%')
        .height(50)
        .margin({ top: 30 })
        .borderRadius(25)
        .backgroundColor(AppColors.PRIMARY_BLUE)
        .fontColor(AppColors.BG_WHITE)
        .fontSize(18)
        .onClick(() => {
          this.login()
        })

      // 注册账户和切换登录方式
      Row() {
        Text('注册账户')
          .fontSize(14)
          .fontColor(AppColors.TEXT_PRIMARY)
          .onClick(() => {
            router.pushUrl({ url: PageRoutes.REGISTER })
          })

        Text(' | ')
          .fontSize(14)
          .fontColor(AppColors.TEXT_TERTIARY)

        Text('切换登录方式')
          .fontSize(14)
          .fontColor(AppColors.TEXT_PRIMARY)
          .onClick(() => {
            router.pushUrl({ url: PageRoutes.SWITCH_LOGIN })
          })
      }
      .margin({ top: 20 })
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppColors.BG_WHITE)
  }

  private async login() {
    this.errorMsg = ''

    if (this.username.length === 0 || this.password.length === 0) {
      this.errorMsg = '请输入用户名和密码'
      return
    }

    // 内置测试账户
    if (this.username === 'heyinlin' && this.password === '123456') {
      router.pushUrl({
        url: PageRoutes.HOME,
        params: { username: this.username }
      })
      return
    }

    try {
      // 查数据库
      const exists = await db.userExists(this.username)
      if (!exists) {
        this.errorMsg = '该用户未注册'
        return
      }

      const ok = await db.checkPassword(this.username, this.password)
      if (!ok) {
        this.errorMsg = '密码错误'
        return
      }

      router.pushUrl({
        url: PageRoutes.HOME,
        params: { username: this.username }
      })
    } catch (err) {
      this.errorMsg = '登录失败: ' + String(err)
    }
  }
}
