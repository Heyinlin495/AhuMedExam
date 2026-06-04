import { router } from '@kit.ArkUI'
import { AppColors } from '../constants/AppConstants'

@Entry
@Component
struct BindWechatPage {
  @State isBound: boolean = false
  @State wechatName: string = ''

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

        Text('绑定微信')
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
          // 已绑定状态
          Column() {
            Image($r('app.media.wechat1'))
              .width(80)
              .height(80)
              .margin({ top: 40 })

            Text('已绑定微信')
              .fontSize(16)
              .fontColor(AppColors.TEXT_PRIMARY)
              .margin({ top: 15 })

            Text(`微信号：${this.wechatName}`)
              .fontSize(14)
              .fontColor(AppColors.TEXT_SECONDARY)
              .margin({ top: 8 })

            // 解绑按钮
            Text('解除绑定')
              .fontSize(16)
              .fontColor(AppColors.ERROR_RED)
              .width('90%')
              .height(45)
              .textAlign(TextAlign.Center)
              .backgroundColor(AppColors.BG_WHITE)
              .borderRadius(8)
              .margin({ top: 40 })
              .onClick(() => {
                // TODO: 调用解绑接口
                this.isBound = false
              })
          }
          .width('100%')
          .alignItems(HorizontalAlign.Center)
        } else {
          // 未绑定状态
          Column() {
            Image($r('app.media.wechat2'))
              .width(100)
              .height(100)
              .margin({ top: 60 })

            Text('绑定微信后可使用微信快捷登录')
              .fontSize(14)
              .fontColor(AppColors.TEXT_SECONDARY)
              .margin({ top: 20 })

            // 绑定按钮
            Text('立即绑定')
              .fontSize(16)
              .fontColor(AppColors.BG_WHITE)
              .width('90%')
              .height(45)
              .textAlign(TextAlign.Center)
              .backgroundColor('#07C160')
              .borderRadius(8)
              .margin({ top: 40 })
              .onClick(() => {
                // TODO: 调用微信绑定接口
                this.isBound = true
                this.wechatName = '微信用户'
              })

            Text('绑定即表示同意《用户协议》和《隐私政策》')
              .fontSize(12)
              .fontColor(AppColors.TEXT_TERTIARY)
              .margin({ top: 15 })
          }
          .width('100%')
          .alignItems(HorizontalAlign.Center)
        }
      }
      .layoutWeight(1)
      .backgroundColor(AppColors.BG_GRAY)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppColors.BG_GRAY)
  }
}
