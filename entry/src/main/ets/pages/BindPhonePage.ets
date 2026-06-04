import { router } from '@kit.ArkUI'
import { AppColors } from '../constants/AppConstants'

@Entry
@Component
struct BindPhonePage {
  @State phoneNumber: string = ''
  @State verifyCode: string = ''
  @State countdown: number = 0
  @State isBound: boolean = true
  @State currentPhone: string = '138****8888'

  build() {
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

        Text(this.isBound ? '更换手机号' : '绑定手机号')
          .fontSize(18)
          .fontColor(AppColors.TEXT_PRIMARY)
          .fontWeight(FontWeight.Bold)

        Blank()
      }
      .width('100%')
      .height(50)
      .padding({ left: 5, right: 15 })
      .alignItems(VerticalAlign.Center)
      .backgroundColor(AppColors.BG_WHITE)

      Column() {
        if (this.isBound) {
          // 当前绑定的手机号
          Row() {
            Text('当前手机号')
              .fontSize(14)
              .fontColor(AppColors.TEXT_PRIMARY)

            Blank()

            Text(this.currentPhone)
              .fontSize(14)
              .fontColor(AppColors.TEXT_SECONDARY)
          }
          .width('90%')
          .height(50)
          .margin({ top: 20 })
        }

        // 新手机号
        Column() {
          Text(this.isBound ? '新手机号' : '手机号')
            .fontSize(14)
            .fontColor(AppColors.TEXT_PRIMARY)
            .width('100%')
            .margin({ bottom: 8 })

          Row() {
            Text('+86')
              .fontSize(15)
              .fontColor(AppColors.TEXT_PRIMARY)
              .margin({ right: 10 })

            TextInput({ placeholder: '请输入手机号' })
              .type(InputType.PhoneNumber)
              .layoutWeight(1)
              .height(45)
              .fontSize(15)
              .backgroundColor(AppColors.BG_INPUT)
              .borderRadius(8)
              .padding({ left: 12, right: 12 })
              .onChange((value: string) => {
                this.phoneNumber = value
              })
          }
          .width('100%')
        }
        .width('90%')
        .margin({ top: 20 })

        // 验证码
        Column() {
          Text('验证码')
            .fontSize(14)
            .fontColor(AppColors.TEXT_PRIMARY)
            .width('100%')
            .margin({ bottom: 8 })

          Row() {
            TextInput({ placeholder: '请输入验证码' })
              .type(InputType.Number)
              .layoutWeight(1)
              .height(45)
              .fontSize(15)
              .backgroundColor(AppColors.BG_INPUT)
              .borderRadius(8)
              .padding({ left: 12, right: 12 })
              .onChange((value: string) => {
                this.verifyCode = value
              })

            Text(this.countdown > 0 ? `${this.countdown}s` : '获取验证码')
              .fontSize(14)
              .fontColor(this.countdown > 0 ? AppColors.TEXT_TERTIARY : AppColors.PRIMARY_ORANGE)
              .margin({ left: 12 })
              .onClick(() => {
                if (this.countdown === 0) {
                  // TODO: 调用发送验证码接口
                  this.countdown = 60
                  // 倒计时逻辑
                }
              })
          }
          .width('100%')
        }
        .width('90%')
        .margin({ top: 20 })

        // 确认按钮
        Text(this.isBound ? '确认更换' : '确认绑定')
          .fontSize(16)
          .fontColor(AppColors.BG_WHITE)
          .width('90%')
          .height(45)
          .textAlign(TextAlign.Center)
          .backgroundColor(AppColors.PRIMARY_ORANGE)
          .borderRadius(8)
          .margin({ top: 40 })
          .onClick(() => {
            // TODO: 调用绑定/更换手机号接口
            router.back()
          })
      }
      .layoutWeight(1)
      .alignItems(HorizontalAlign.Center)
      .backgroundColor(AppColors.BG_GRAY)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppColors.BG_GRAY)
  }
}
