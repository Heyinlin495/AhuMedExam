import { router } from '@kit.ArkUI'
import { common } from '@kit.AbilityKit'
import { AppColors } from '../constants/AppConstants'
import { db } from '../utils/DatabaseHelper'

@Entry
@Component
struct RegisterPage {
  @State username: string = ''
  @State phone: string = ''
  @State password: string = ''
  @State confirmPassword: string = ''
  @State smsCode: string = ''
  @State countdown: number = 0
  @State agreeTerms: boolean = false
  @State expectedCode: string = ''
  @State showCodeDialog: boolean = false
  @State errorMsg: string = ''

  private timer: number = -1

  async aboutToAppear() {
    const context = getContext(this) as common.UIAbilityContext
    await db.init(context)
  }

  aboutToDisappear() {
    if (this.timer >= 0) {
      clearInterval(this.timer)
    }
  }

  build() {
    Stack({ alignContent: Alignment.Bottom }) {
    Column() {
      // 顶部导航栏
      Row() {
        Text('<')
          .fontSize(22)
          .fontColor(AppColors.TEXT_PRIMARY)
          .width(40)
          .height(40)
          .textAlign(TextAlign.Center)
          .onClick(() => {
            router.back()
          })
      }
      .width('100%')
      .height(50)
      .padding({ left: 5 })
      .alignItems(VerticalAlign.Center)
      .backgroundColor(AppColors.BG_WHITE)

      Scroll() {
        Column() {
          // 标题
          Text('注册账户')
            .fontSize(28)
            .fontColor(AppColors.PRIMARY_ORANGE)
            .fontWeight(FontWeight.Bold)
            .width('100%')
            .margin({ top: 20, bottom: 30 })

          // 错误提示
          if (this.errorMsg.length > 0) {
            Text(this.errorMsg)
              .fontSize(14)
              .fontColor(AppColors.ERROR_RED)
              .width('90%')
              .margin({ bottom: 10 })
          }

          // 用户名输入框
          TextInput({ placeholder: '请输入用户名' })
            .width('90%')
            .height(50)
            .borderRadius(25)
            .backgroundColor(AppColors.BG_INPUT)
            .onChange((value: string) => {
              this.username = value
              this.errorMsg = ''
            })

          // 手机号输入框
          TextInput({ placeholder: '请输入手机号' })
            .width('90%')
            .height(50)
            .type(InputType.PhoneNumber)
            .margin({ top: 16 })
            .borderRadius(25)
            .backgroundColor(AppColors.BG_INPUT)
            .onChange((value: string) => {
              this.phone = value
              this.errorMsg = ''
            })

          // 验证码输入框
          Row() {
            TextInput({ placeholder: '请输入验证码' })
              .layoutWeight(1)
              .height(50)
              .backgroundColor(AppColors.BG_INPUT)
              .borderRadius(25)
              .onChange((value: string) => {
                this.smsCode = value
                this.errorMsg = ''
              })

            Button(this.countdown > 0 ? `${this.countdown}s` : '获取验证码')
              .width(120)
              .height(40)
              .margin({ left: 10 })
              .borderRadius(20)
              .backgroundColor(this.countdown > 0 ? '#CCCCCC' : AppColors.PRIMARY_BLUE)
              .fontColor(AppColors.BG_WHITE)
              .fontSize(14)
              .enabled(this.countdown === 0)
              .onClick(() => {
                if (this.phone.length !== 11) {
                  this.errorMsg = '请输入正确的手机号'
                  return
                }
                this.sendCode()
              })
          }
          .width('90%')
          .margin({ top: 16 })

          // 密码输入框
          TextInput({ placeholder: '请设置密码（8-20位，含字母和数字）' })
            .width('90%')
            .height(50)
            .type(InputType.Password)
            .margin({ top: 16 })
            .borderRadius(25)
            .backgroundColor(AppColors.BG_INPUT)
            .onChange((value: string) => {
              this.password = value
              this.errorMsg = ''
            })

          // 确认密码输入框
          TextInput({ placeholder: '请再次输入密码' })
            .width('90%')
            .height(50)
            .type(InputType.Password)
            .margin({ top: 16 })
            .borderRadius(25)
            .backgroundColor(AppColors.BG_INPUT)
            .onChange((value: string) => {
              this.confirmPassword = value
              this.errorMsg = ''
            })

          // 用户协议
          Row() {
            Text(this.agreeTerms ? '☑' : '☐')
              .fontSize(18)
              .fontColor(this.agreeTerms ? AppColors.PRIMARY_BLUE : AppColors.TEXT_TERTIARY)
              .onClick(() => {
                this.agreeTerms = !this.agreeTerms
              })

            Text('我已阅读并同意')
              .fontSize(12)
              .fontColor(AppColors.TEXT_TERTIARY)
              .margin({ left: 6 })

            Text('《用户协议》')
              .fontSize(12)
              .fontColor(AppColors.PRIMARY_BLUE)

            Text('和')
              .fontSize(12)
              .fontColor(AppColors.TEXT_TERTIARY)

            Text('《隐私政策》')
              .fontSize(12)
              .fontColor(AppColors.PRIMARY_BLUE)
          }
          .width('90%')
          .margin({ top: 20 })
          .alignItems(VerticalAlign.Center)

          // 注册按钮
          Button('注册')
            .width('90%')
            .height(50)
            .margin({ top: 25 })
            .borderRadius(25)
            .backgroundColor(AppColors.PRIMARY_ORANGE)
            .fontColor(AppColors.BG_WHITE)
            .fontSize(18)
            .onClick(() => {
              this.register()
            })

          // 已有账户去登录
          Row() {
            Text('已有账户？')
              .fontSize(14)
              .fontColor(AppColors.TEXT_TERTIARY)

            Text('去登录')
              .fontSize(14)
              .fontColor(AppColors.PRIMARY_BLUE)
              .margin({ left: 4 })
              .onClick(() => {
                router.back()
              })
          }
          .margin({ top: 20, bottom: 40 })
        }
        .width('100%')
        .alignItems(HorizontalAlign.Center)
      }
      .layoutWeight(1)
      .scrollBar(BarState.Off)
      .backgroundColor(AppColors.BG_WHITE)
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

  // 生成随机验证码并弹窗展示
  private sendCode() {
    let code = ''
    for (let i = 0; i < 6; i++) {
      code += Math.floor(Math.random() * 10).toString()
    }
    this.expectedCode = code
    this.showCodeDialog = true
    this.startCountdown()
    console.info(`验证码已发送: ${code}`)
  }

  // 开始倒计时
  private startCountdown() {
    this.countdown = 60
    this.timer = setInterval(() => {
      this.countdown--
      if (this.countdown <= 0) {
        clearInterval(this.timer)
        this.timer = -1
      }
    }, 1000)
  }

  // 注册逻辑
  private async register() {
    this.errorMsg = ''

    if (this.username.length < 3) {
      this.errorMsg = '用户名至少3个字符'
      return
    }

    if (this.phone.length !== 11) {
      this.errorMsg = '请输入正确的手机号'
      return
    }

    if (this.expectedCode.length === 0) {
      this.errorMsg = '请先获取验证码'
      return
    }

    if (this.smsCode !== this.expectedCode) {
      this.errorMsg = '验证码错误'
      return
    }

    if (this.password.length < 8 || this.password.length > 20) {
      this.errorMsg = '密码长度需为8-20位'
      return
    }

    if (this.password !== this.confirmPassword) {
      this.errorMsg = '两次密码不一致'
      return
    }

    if (!this.agreeTerms) {
      this.errorMsg = '请阅读并同意用户协议'
      return
    }

    try {
      const exists = await db.hasUser(this.username)
      if (exists) {
        this.errorMsg = '该用户名已被注册'
        return
      }

      const ok = await db.addUser(this.username, this.password, this.phone)
      if (ok) {
        console.info('注册成功')
        router.back()
      } else {
        this.errorMsg = '注册失败，请重试'
      }
    } catch (err) {
      this.errorMsg = '注册失败: ' + String(err)
    }
  }
}
