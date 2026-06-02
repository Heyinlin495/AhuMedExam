import { router } from '@kit.ArkUI'

@Entry
@Component
struct LoginPage {
  @State username: string = 'heyinlin'
  @State password: string = '123456'
  @State showPassword: boolean = false

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
        .fontColor('#FF6B00')
        .fontWeight(FontWeight.Bold)
        .margin({ top: 40 })

      // 用户名输入框
      TextInput({ placeholder: '请输入用户名', text: this.username })
        .width('80%')
        .height(50)
        .margin({ top: 40 })
        .borderRadius(25)
        .backgroundColor('#F5F5F5')
        .onChange((value: string) => {
          this.username = value
        })

      // 密码输入框
      TextInput({ placeholder: '请输入密码', text: this.password })
        .width('80%')
        .height(50)
        .type(InputType.Password)
        .margin({ top: 20 })
        .borderRadius(25)
        .backgroundColor('#F5F5F5')
        .onChange((value: string) => {
          this.password = value
        })

      // 短信验证码登录和忘记密码
      Row() {
        Text('短信验证码登录')
          .fontSize(14)
          .fontColor('#666666')
          .onClick(() => {
            // 跳转到短信验证码登录页面
            router.pushUrl({ url: 'pages/SmsLoginPage' })
          })

        Blank()

        Text('忘记密码')
          .fontSize(14)
          .fontColor('#666666')
          .onClick(() => {
            // 跳转到忘记密码页面
            router.pushUrl({ url: 'pages/ForgotPasswordPage' })
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
        .backgroundColor('#2196F3')
        .fontColor('#FFFFFF')
        .fontSize(18)
        .onClick(() => {
          // 登录逻辑 - 验证用户名和密码
          if (this.username === 'heyinlin' && this.password === '123456') {
            // 登录成功，跳转到首页
            router.pushUrl({
              url: 'pages/HomePage',
              params: { username: this.username }
            })
          } else {
            // 登录失败，提示用户
            console.error('用户名或密码错误')
          }
        })

      // 切换登录方式
      Text('切换登录方式')
        .fontSize(14)
        .fontColor('#666666')
        .margin({ top: 20 })
        .onClick(() => {
          // 跳转到切换登录方式页面
          router.pushUrl({ url: 'pages/SwitchLoginPage' })
        })
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#FFFFFF')
  }
}
