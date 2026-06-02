import { router } from '@kit.ArkUI'

@Entry
@Component
struct SmsLoginPage {
  @State phone: string = ''
  @State smsCode: string = ''
  @State countdown: number = 0
  @State buttonText: string = '获取验证码'

  build() {
    Column() {
      // 顶部返回按钮
      Row() {
        Text('< 返回')
          .fontSize(16)
          .fontColor('#2196F3')
          .onClick(() => {
            router.back()
          })
        Blank()
      }
      .width('100%')
      .height(50)
      .padding({ left: 15, right: 15 })
      .alignItems(VerticalAlign.Center)

      // 标题
      Text('短信验证码登录')
        .fontSize(24)
        .fontColor('#333333')
        .fontWeight(FontWeight.Bold)
        .margin({ top: 40 })

      // 手机号输入框
      TextInput({ placeholder: '请输入手机号', text: this.phone })
        .width('80%')
        .height(50)
        .margin({ top: 40 })
        .borderRadius(25)
        .backgroundColor('#F5F5F5')
        .type(InputType.PhoneNumber)
        .onChange((value: string) => {
          this.phone = value
        })

      // 验证码输入框和获取验证码按钮
      Row() {
        TextInput({ placeholder: '请输入验证码', text: this.smsCode })
          .layoutWeight(1)
          .height(50)
          .backgroundColor('#F5F5F5')
          .borderRadius(25)
          .onChange((value: string) => {
            this.smsCode = value
          })

        Button(this.buttonText)
          .width(120)
          .height(40)
          .margin({ left: 10 })
          .borderRadius(20)
          .backgroundColor(this.countdown > 0 ? '#CCCCCC' : '#2196F3')
          .fontColor('#FFFFFF')
          .fontSize(14)
          .enabled(this.countdown === 0)
          .onClick(() => {
            this.getSmsCode()
          })
      }
      .width('80%')
      .height(50)
      .margin({ top: 20 })
      .padding({ left: 15, right: 15 })

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
          this.login()
        })

      // 返回密码登录
      Text('返回密码登录')
        .fontSize(14)
        .fontColor('#666666')
        .margin({ top: 20 })
        .onClick(() => {
          router.back()
        })
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#FFFFFF')
  }

  // 获取验证码
  private getSmsCode() {
    if (this.phone.length !== 11) {
      console.error('请输入正确的手机号')
      return
    }

    // 模拟发送验证码
    this.countdown = 60
    this.buttonText = `${this.countdown}s后重试`

    // 倒计时
    const timer = setInterval(() => {
      this.countdown--
      if (this.countdown <= 0) {
        clearInterval(timer)
        this.buttonText = '获取验证码'
      } else {
        this.buttonText = `${this.countdown}s后重试`
      }
    }, 1000)
  }

  // 登录
  private login() {
    if (this.phone.length !== 11) {
      console.error('请输入正确的手机号')
      return
    }

    if (this.smsCode.length !== 6) {
      console.error('请输入6位验证码')
      return
    }

    // 模拟验证码验证（实际项目中需要调用后端接口验证）
    // 这里简单判断验证码为123456即可登录
    if (this.smsCode === '123456') {
      router.pushUrl({
        url: 'pages/HomePage',
        params: { username: '何胤霖' }
      })
    } else {
      console.error('验证码错误')
    }
  }
}
