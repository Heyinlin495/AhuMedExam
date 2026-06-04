import { router } from '@kit.ArkUI'
import { AppColors, PageRoutes } from '../constants/AppConstants'

@Component
export struct BottomNavBar {
  @Prop currentIndex: number = 0
  onTabChange: (index: number) => void = () => {}

  build() {
    Row() {
      // 首页
      Column() {
        if (this.currentIndex === 0) {
          Image($r('app.media.home_green'))
            .width(24)
            .height(24)
        } else {
          Image($r('app.media.home_gray'))
            .width(24)
            .height(24)
        }
        Text('首页')
          .fontSize(12)
          .fontColor(this.currentIndex === 0 ? AppColors.SUCCESS_GREEN : AppColors.TEXT_TERTIARY)
          .margin({ top: 4 })
      }
      .layoutWeight(1)
      .alignItems(HorizontalAlign.Center)
      .justifyContent(FlexAlign.Center)
      .onClick(() => {
        this.onTabChange(0)
        if (this.currentIndex === 1) {
          router.back()
        }
      })

      // AI 助手
      Column() {
        if (this.currentIndex === 1) {
          Image($r('app.media.ai_green'))
            .width(24)
            .height(24)
        } else {
          Image($r('app.media.ai_gray'))
            .width(24)
            .height(24)
        }
        Text('AI')
          .fontSize(12)
          .fontColor(this.currentIndex === 1 ? AppColors.SUCCESS_GREEN : AppColors.TEXT_TERTIARY)
          .margin({ top: 4 })
      }
      .layoutWeight(1)
      .alignItems(HorizontalAlign.Center)
      .justifyContent(FlexAlign.Center)
      .onClick(() => {
        this.onTabChange(1)
        if (this.currentIndex === 0) {
          router.pushUrl({ url: PageRoutes.AI_ASSISTANT })
        }
      })
    }
    .width('100%')
    .height(56)
    .backgroundColor(AppColors.BG_WHITE)
    .border({ width: { top: 0.5 }, color: AppColors.BORDER_LIGHT })
  }
}
