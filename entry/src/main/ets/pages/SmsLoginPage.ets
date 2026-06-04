import { router } from '@kit.ArkUI'
import { AppColors, PageRoutes } from '../constants/AppConstants'
import { BackHeader } from '../components/BackHeader'
import { SmsCountdownTimer } from '../utils/SmsCountdownTimer'

@Entry
@Component
struct SmsLoginPage {
  @State phone: string = ''
  @State smsCode: string = ''
  @State countdown: number = 0
  @State buttonText: string = '获取验证码'
  @State expectedCode: string = ''
  @State showCodeDialog: boolean = false

  private timer: SmsCountdownTimer = new SmsCountdownTimer(
    (countdown: number, buttonText: string) => {
      this.countdown = countdown
      this.buttonText = buttonText
    },
    () => {
      this.buttonText = '获取验证码'
    }
  )

  aboutToDisappear() {
    this.timer.destroy()
  }

  build() {
    Stack({ alignContent: Alignment.Bottom }) {
    Column() {
      BackHeader({ title: '' })

      // 标题
      Text('短信验证码登录')
        .fontSize(24)
        .fontColor(AppColors.TEXT_PRIMARY)
        .fontWeight(FontWeight.Bold)
        .margin({ top: 40 })

      // 手机号输入框
      TextInput({ placeholder: '请输入手机号', text: this.phone })
        .width('80%')
        .height(50)
        .margin({ top: 40 })
        .borderRadius(25)
        .backgroundColor(AppColors.BG_INPUT)
        .type(InputType.PhoneNumber)
        .onChange((value: string) => {
          this.phone = value
        })

      // 验证码输入框和获取验证码按钮
      Row() {
        TextInput({ placeholder: '请输入验证码', text: this.smsCode })
          .layoutWeight(1)
          .height(50)
          .backgroundColor(AppColors.BG_INPUT)
          .borderRadius(25)
          .onChange((value: string) => {
            this.smsCode = value
          })

        Button(this.buttonText)
          .width(120)
          .height(40)
          .margin({ left: 10 })
          .borderRadius(20)
          .backgroundColor(this.countdown > 0 ? '#CCCCCC' : AppColors.PRIMARY_BLUE)
          .fontColor(AppColors.BG_WHITE)
          .fontSize(14)
          .enabled(this.countdown === 0)
          .onClick(() => {
            this.sendCode()
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
        .backgroundColor(AppColors.PRIMARY_BLUE)
        .fontColor(AppColors.BG_WHITE)
        .fontSize(18)
        .onClick(() => {
          this.login()
        })

      // 返回密码登录
      Text('返回密码登录')
        .fontSize(14)
        .fontColor(AppColors.TEXT_SECONDARY)
        .margin({ top: 20 })
        .onClick(() => {
          router.back()
        })
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppColors.BG_WHITE)

    // 验证码弹窗
    if (this.showCodeDialog) {
      Column() {
        Column()
          .width('100%')
          .layoutWeight(1)
          .backgroundColor(AppColors.OVERLAY_SEMI)
          .onClick(() => {
            this.showCodeDialog = false
          })

        Column() {
          Text('验证码已发送')
            .fontSize(18)
            .fontWeight(FontWeight.Bold)
            .fontColor(AppColors.TEXT_PRIMARY)
            .margin({ top: 24 })

          Text(`验证码已发送至 ${this.phone}`)
            .fontSize(14)
            .fontColor(AppColors.TEXT_SECONDARY)
            .margin({ top: 12 })

          Text(this.expectedCode)
            .fontSize(36)
            .fontWeight(FontWeight.Bold)
            .fontColor(AppColors.PRIMARY_ORANGE)
            .letterSpacing(8)
            .margin({ top: 20 })

          Text('（模拟短信，验证码直接展示）')
            .fontSize(12)
            .fontColor(AppColors.TEXT_TERTIARY)
            .margin({ top: 8 })

          Button('知道了')
            .width('80%')
            .height(44)
            .margin({ top: 24, bottom: 24 })
            .borderRadius(22)
            .backgroundColor(AppColors.PRIMARY_BLUE)
            .fontColor(AppColors.BG_WHITE)
            .fontSize(16)
            .onClick(() => {
              this.showCodeDialog = false
            })
        }
        .width('100%')
        .backgroundColor(AppColors.BG_WHITE)
        .borderRadius({ topLeft: 16, topRight: 16 })
        .alignItems(HorizontalAlign.Center)
      }
      .width('100%')
      .height('100%')
    }
    }
    .width('100%')
    .height('100%')
  }

  // 发送验证码
  private sendCode() {
    if (!this.timer.start(this.phone)) {
      console.error('请输入正确的手机号')
      return
    }
    let code = ''
    for (let i = 0; i < 6; i++) {
      code += Math.floor(Math.random() * 10).toString()
    }
    this.expectedCode = code
    this.showCodeDialog = true
    console.info(`验证码已发送: ${code}`)
  }

  // 登录
  private login() {
    if (this.phone.length !== 11) {
      console.error('请输入正确的手机号')
      return
    }

    if (this.smsCode !== this.expectedCode) {
      console.error('验证码错误')
      return
    }

    router.pushUrl({
      url: PageRoutes.HOME,
      params: { username: '用户' }
    })
  }
}
