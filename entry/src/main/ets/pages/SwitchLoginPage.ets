import { router } from '@kit.ArkUI'
import { AppColors, PageRoutes } from '../constants/AppConstants'
import { BackHeader } from '../components/BackHeader'

@Entry
@Component
struct SwitchLoginPage {
  @State selectedIndex: number = 0

  build() {
    Column() {
      BackHeader({ title: '' })

      // 标题
      Text('切换登录方式')
        .fontSize(24)
        .fontColor(AppColors.TEXT_PRIMARY)
        .fontWeight(FontWeight.Bold)
        .margin({ top: 40 })

      // 登录方式选项
      Column() {
        // 密码登录选项
        Row() {
          Text('密码登录')
            .fontSize(16)
            .fontColor(AppColors.TEXT_PRIMARY)
            .layoutWeight(1)

          if (this.selectedIndex === 0) {
            Text('✓')
              .fontSize(20)
              .fontColor(AppColors.PRIMARY_BLUE)
          }
        }
        .width('100%')
        .height(60)
        .padding({ left: 15, right: 15 })
        .onClick(() => {
          this.selectedIndex = 0
        })

        Divider()
          .width('100%')
          .color(AppColors.BORDER_LIGHT)

        // 短信验证码登录选项
        Row() {
          Text('短信验证码登录')
            .fontSize(16)
            .fontColor(AppColors.TEXT_PRIMARY)
            .layoutWeight(1)

          if (this.selectedIndex === 1) {
            Text('✓')
              .fontSize(20)
              .fontColor(AppColors.PRIMARY_BLUE)
          }
        }
        .width('100%')
        .height(60)
        .padding({ left: 15, right: 15 })
        .onClick(() => {
          this.selectedIndex = 1
        })

        Divider()
          .width('100%')
          .color(AppColors.BORDER_LIGHT)

        // 微信登录选项
        Row() {
          Text('微信登录')
            .fontSize(16)
            .fontColor(AppColors.TEXT_PRIMARY)
            .layoutWeight(1)

          if (this.selectedIndex === 2) {
            Text('✓')
              .fontSize(20)
              .fontColor(AppColors.PRIMARY_BLUE)
          }
        }
        .width('100%')
        .height(60)
        .padding({ left: 15, right: 15 })
        .onClick(() => {
          this.selectedIndex = 2
        })

        Divider()
          .width('100%')
          .color(AppColors.BORDER_LIGHT)

        // QQ登录选项
        Row() {
          Text('QQ登录')
            .fontSize(16)
            .fontColor(AppColors.TEXT_PRIMARY)
            .layoutWeight(1)

          if (this.selectedIndex === 3) {
            Text('✓')
              .fontSize(20)
              .fontColor(AppColors.PRIMARY_BLUE)
          }
        }
        .width('100%')
        .height(60)
        .padding({ left: 15, right: 15 })
        .onClick(() => {
          this.selectedIndex = 3
        })
      }
      .width('90%')
      .margin({ top: 30 })
      .borderRadius(10)
      .backgroundColor(AppColors.BG_WHITE)

      // 确认按钮
      Button('确认')
        .width('80%')
        .height(50)
        .margin({ top: 40 })
        .borderRadius(25)
        .backgroundColor(AppColors.PRIMARY_BLUE)
        .fontColor(AppColors.BG_WHITE)
        .fontSize(18)
        .onClick(() => {
          this.confirm()
        })
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppColors.BG_GRAY)
  }

  // 确认选择的登录方式
  private confirm() {
    switch (this.selectedIndex) {
      case 0:
        router.back()
        break
      case 1:
        router.pushUrl({ url: PageRoutes.SMS_LOGIN })
        break
      case 2:
        console.log('微信登录功能开发中')
        break
      case 3:
        console.log('QQ登录功能开发中')
        break
    }
  }
}
