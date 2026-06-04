import { router } from '@kit.ArkUI'
import { AppColors } from '../constants/AppConstants'

@Entry
@Component
struct BannerDetailPage {
  @State imageRes: Resource = $r('app.media.information1')

  onPageShow() {
    const params = router.getParams() as Record<string, Resource>
    if (params && params.imageRes) {
      this.imageRes = params.imageRes
    }
  }

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

        Text('详情')
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

      // 图片展示区域
      Scroll() {
        Image(this.imageRes)
          .width('100%')
          .objectFit(ImageFit.Contain)
      }
      .layoutWeight(1)
      .scrollBar(BarState.Off)
      .backgroundColor(AppColors.BG_GRAY)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppColors.BG_GRAY)
  }
}
