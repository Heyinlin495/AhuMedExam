import { AppColors } from '../constants/AppConstants'

@Component
export struct SearchBar {
  @Prop placeholder: string = '搜索'
  onSearch: (text: string) => void = () => {}

  build() {
    Row() {
      Text('🔍')
        .fontSize(14)
        .margin({ right: 8 })
      TextInput({ placeholder: this.placeholder })
        .layoutWeight(1)
        .height(36)
        .fontSize(14)
        .backgroundColor('transparent')
        .borderRadius(18)
        .onChange((value: string) => {
          this.onSearch(value)
        })
    }
    .width('90%')
    .height(42)
    .padding({ left: 15, right: 15 })
    .backgroundColor(AppColors.BG_INPUT)
    .borderRadius(20)
    .margin({ top: 8, bottom: 10 })
    .alignItems(VerticalAlign.Center)
  }
}
