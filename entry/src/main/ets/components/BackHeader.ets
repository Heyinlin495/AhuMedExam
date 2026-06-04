import { router } from '@kit.ArkUI'
import { AppColors } from '../constants/AppConstants'

@Component
export struct BackHeader {
  @Prop title: string = ''

  build() {
    Row() {
      Text('< 返回')
        .fontSize(16)
        .fontColor(AppColors.PRIMARY_BLUE)
        .onClick(() => {
          router.back()
        })
      Blank()
    }
    .width('100%')
    .height(50)
    .padding({ left: 15, right: 15 })
    .alignItems(VerticalAlign.Center)
  }
}
