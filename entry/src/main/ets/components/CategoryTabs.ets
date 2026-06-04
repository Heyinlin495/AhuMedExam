import { AppColors } from '../constants/AppConstants'

@Component
export struct CategoryTabs {
  @Prop tabs: string[] = []
  @Prop selectedIndex: number = 0
  onTabChange: (index: number) => void = () => {}

  build() {
    Scroll() {
      Flex({ wrap: FlexWrap.NoWrap, justifyContent: FlexAlign.Start }) {
        ForEach(this.tabs, (tab: string, index: number) => {
          Text(tab)
            .fontSize(14)
            .fontColor(this.selectedIndex === index ? AppColors.BG_WHITE : AppColors.TEXT_SECONDARY)
            .fontWeight(this.selectedIndex === index ? FontWeight.Bold : FontWeight.Normal)
            .padding({ left: 14, right: 14, top: 6, bottom: 6 })
            .borderRadius(16)
            .backgroundColor(this.selectedIndex === index ? AppColors.PRIMARY_ORANGE : AppColors.BG_CHIP_NORMAL)
            .margin({ right: 8 })
            .onClick(() => {
              this.onTabChange(index)
            })
        }, (tab: string, index: number) => `${tab}_${index}`)
      }
    }
    .scrollBar(BarState.Off)
    .scrollable(ScrollDirection.Horizontal)
    .width('100%')
    .padding({ left: 15, right: 15 })
    .margin({ bottom: 10 })
  }
}
