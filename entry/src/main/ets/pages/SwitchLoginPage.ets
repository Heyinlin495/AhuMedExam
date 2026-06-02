import { router } from '@kit.ArkUI'

@Entry
@Component
struct SwitchLoginPage {
  @State selectedIndex: number = 0

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
      Text('切换登录方式')
        .fontSize(24)
        .fontColor('#333333')
        .fontWeight(FontWeight.Bold)
        .margin({ top: 40 })

      // 登录方式选项
      Column() {
        // 密码登录选项
        Row() {
          Text('密码登录')
            .fontSize(16)
            .fontColor('#333333')
            .layoutWeight(1)

          if (this.selectedIndex === 0) {
            Text('✓')
              .fontSize(20)
              .fontColor('#2196F3')
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
          .color('#EEEEEE')

        // 短信验证码登录选项
        Row() {
          Text('短信验证码登录')
            .fontSize(16)
            .fontColor('#333333')
            .layoutWeight(1)

          if (this.selectedIndex === 1) {
            Text('✓')
              .fontSize(20)
              .fontColor('#2196F3')
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
          .color('#EEEEEE')

        // 微信登录选项
        Row() {
          Text('微信登录')
            .fontSize(16)
            .fontColor('#333333')
            .layoutWeight(1)

          if (this.selectedIndex === 2) {
            Text('✓')
              .fontSize(20)
              .fontColor('#2196F3')
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
          .color('#EEEEEE')

        // QQ登录选项
        Row() {
          Text('QQ登录')
            .fontSize(16)
            .fontColor('#333333')
            .layoutWeight(1)

          if (this.selectedIndex === 3) {
            Text('✓')
              .fontSize(20)
              .fontColor('#2196F3')
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
      .backgroundColor('#FFFFFF')

      // 确认按钮
      Button('确认')
        .width('80%')
        .height(50)
        .margin({ top: 40 })
        .borderRadius(25)
        .backgroundColor('#2196F3')
        .fontColor('#FFFFFF')
        .fontSize(18)
        .onClick(() => {
          this.confirm()
        })
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#F5F5F5')
  }

  // 确认选择的登录方式
  private confirm() {
    switch (this.selectedIndex) {
      case 0:
        // 密码登录
        router.back()
        break
      case 1:
        // 短信验证码登录
        router.pushUrl({ url: 'pages/SmsLoginPage' })
        break
      case 2:
        // 微信登录
        console.log('微信登录功能开发中')
        break
      case 3:
        // QQ登录
        console.log('QQ登录功能开发中')
        break
    }
  }
}
