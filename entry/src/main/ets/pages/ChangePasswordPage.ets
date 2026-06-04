import { router } from '@kit.ArkUI'
import { AppColors } from '../constants/AppConstants'

@Entry
@Component
struct ChangePasswordPage {
  @State oldPassword: string = ''
  @State newPassword: string = ''
  @State confirmPassword: string = ''
  @State showOldPassword: boolean = false
  @State showNewPassword: boolean = false
  @State showConfirmPassword: boolean = false

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

        Text('修改密码')
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
        // 原密码
        Column() {
          Text('原密码')
            .fontSize(14)
            .fontColor(AppColors.TEXT_PRIMARY)
            .width('100%')
            .margin({ bottom: 8 })

          Row() {
            TextInput({ placeholder: '请输入原密码' })
              .type(InputType.Password)
              .layoutWeight(1)
              .height(45)
              .fontSize(15)
              .backgroundColor(AppColors.BG_INPUT)
              .borderRadius(8)
              .padding({ left: 12, right: 12 })
              .onChange((value: string) => {
                this.oldPassword = value
              })
          }
          .width('100%')
        }
        .width('90%')
        .margin({ top: 30 })

        // 新密码
        Column() {
          Text('新密码')
            .fontSize(14)
            .fontColor(AppColors.TEXT_PRIMARY)
            .width('100%')
            .margin({ bottom: 8 })

          Row() {
            TextInput({ placeholder: '请输入新密码' })
              .type(InputType.Password)
              .layoutWeight(1)
              .height(45)
              .fontSize(15)
              .backgroundColor(AppColors.BG_INPUT)
              .borderRadius(8)
              .padding({ left: 12, right: 12 })
              .onChange((value: string) => {
                this.newPassword = value
              })
          }
          .width('100%')
        }
        .width('90%')
        .margin({ top: 20 })

        // 确认新密码
        Column() {
          Text('确认新密码')
            .fontSize(14)
            .fontColor(AppColors.TEXT_PRIMARY)
            .width('100%')
            .margin({ bottom: 8 })

          Row() {
            TextInput({ placeholder: '请再次输入新密码' })
              .type(InputType.Password)
              .layoutWeight(1)
              .height(45)
              .fontSize(15)
              .backgroundColor(AppColors.BG_INPUT)
              .borderRadius(8)
              .padding({ left: 12, right: 12 })
              .onChange((value: string) => {
                this.confirmPassword = value
              })
          }
          .width('100%')
        }
        .width('90%')
        .margin({ top: 20 })

        // 密码要求提示
        Text('密码要求：8-20位，包含字母和数字')
          .fontSize(12)
          .fontColor(AppColors.TEXT_TERTIARY)
          .width('90%')
          .margin({ top: 15 })

        // 确认修改按钮
        Text('确认修改')
          .fontSize(16)
          .fontColor(AppColors.BG_WHITE)
          .width('90%')
          .height(45)
          .textAlign(TextAlign.Center)
          .backgroundColor(AppColors.PRIMARY_ORANGE)
          .borderRadius(8)
          .margin({ top: 40 })
          .onClick(() => {
            if (this.newPassword !== this.confirmPassword) {
              // TODO: 提示两次密码不一致
              return
            }
            // TODO: 调用修改密码接口
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
