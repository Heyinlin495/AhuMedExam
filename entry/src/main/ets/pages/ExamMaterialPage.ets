import { router } from '@kit.ArkUI'
import { AppColors } from '../constants/AppConstants'
import { SearchBar } from '../components/SearchBar'
import { CategoryTabs } from '../components/CategoryTabs'

interface MaterialItem {
  id: number
  title: string
  author: string
  category: string
  edition: string
  pages: number
  rating: number
  downloads: number
  description: string
  imageRes: Resource
  isFree: boolean
  price: string
}

@Entry
@Component
struct ExamMaterialPage {
  @State searchText: string = ''
  @State selectedCategoryIndex: number = 0

  private tabs: string[] = ['全部', '核心考点', '历年真题', '模拟试卷', '思维导图', '速记手册']
  private hotTags: string[] = ['高频考点', '考前冲刺', '免费资料', '名师推荐', '新大纲']

  private materialList: MaterialItem[] = [
    {
      id: 1, title: '临床执业医师核心考点速记', author: '医考宝典编写组',
      category: '核心考点', edition: '2026版', pages: 680, rating: 4.9,
      downloads: 25680, imageRes: $r('app.media.course1'),
      description: '浓缩临床执业医师考试核心考点，采用图表结合方式，便于快速记忆和复习。',
      isFree: false, price: '¥89'
    },
    {
      id: 2, title: '中医执业医师历年真题汇编', author: '中医考试研究中心',
      category: '历年真题', edition: '2026版', pages: 520, rating: 4.8,
      downloads: 18960, imageRes: $r('app.media.course2'),
      description: '收录近10年中医执业医师考试真题，逐题精析，附详细考点解析和答题技巧。',
      isFree: false, price: '¥68'
    },
    {
      id: 3, title: '临床执业医师模拟试卷全真版', author: '医考宝典编写组',
      category: '模拟试卷', edition: '2026版', pages: 360, rating: 4.7,
      downloads: 15230, imageRes: $r('app.media.course3'),
      description: '按照最新考试大纲命制的全真模拟试卷，附详细答案解析和考点分布统计。',
      isFree: false, price: '¥58'
    },
    {
      id: 4, title: '口腔执业医师思维导图集', author: '口腔医学研究院',
      category: '思维导图', edition: '2026版', pages: 280, rating: 4.8,
      downloads: 9870, imageRes: $r('app.media.course4'),
      description: '全科目思维导图梳理，将繁杂知识点系统化、可视化，构建完整知识框架。',
      isFree: false, price: '¥78'
    },
    {
      id: 5, title: '预防医学速记手册', author: '公卫考试编写组',
      category: '速记手册', edition: '2026版', pages: 320, rating: 4.6,
      downloads: 7650, imageRes: $r('app.media.course5'),
      description: '预防医学高频考点速记手册，口袋书设计，随时随地翻阅复习。',
      isFree: true, price: '免费'
    },
    {
      id: 6, title: '执业药师药学综合速记', author: '药学考试研究中心',
      category: '速记手册', edition: '2026版', pages: 410, rating: 4.7,
      downloads: 11240, imageRes: $r('app.media.course6'),
      description: '执业药师全科目速记精华，重点突出，口诀助记，高效备考。',
      isFree: false, price: '¥49'
    },
    {
      id: 7, title: '中西医结合核心考点精析', author: '中西医结合编写组',
      category: '核心考点', edition: '2026版', pages: 560, rating: 4.8,
      downloads: 6540, imageRes: $r('app.media.course7'),
      description: '中西医结合执业医师考试核心考点深度解析，中西互参，重点突破。',
      isFree: false, price: '¥99'
    }
  ]

  // 根据分类和搜索关键词过滤教材
  private getFilteredMaterials(): MaterialItem[] {
    let filtered = this.materialList
    if (this.selectedCategoryIndex > 0) {
      const category = this.tabs[this.selectedCategoryIndex]
      filtered = filtered.filter((item: MaterialItem) => item.category === category)
    }
    if (this.searchText.trim().length > 0) {
      const keyword = this.searchText.trim()
      filtered = filtered.filter((item: MaterialItem) =>
        item.title.indexOf(keyword) >= 0 || item.author.indexOf(keyword) >= 0
      )
    }
    return filtered
  }

  build() {
    Column() {
      // 顶部导航
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

        Text('备考教材')
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

      // 搜索栏
      SearchBar({
        placeholder: '搜索教材名称、作者',
        onSearch: (text: string) => {
          this.searchText = text
        }
      })

      // 热门标签
      Scroll() {
        Flex({ wrap: FlexWrap.NoWrap, justifyContent: FlexAlign.Start }) {
          ForEach(this.hotTags, (tag: string) => {
            Text(tag)
              .fontSize(12)
              .fontColor(AppColors.PRIMARY_ORANGE)
              .backgroundColor('#FFF3E0')
              .padding({ left: 10, right: 10, top: 4, bottom: 4 })
              .borderRadius(12)
              .margin({ right: 8 })
          }, (tag: string) => tag)
        }
      }
      .scrollBar(BarState.Off)
      .scrollable(ScrollDirection.Horizontal)
      .width('100%')
      .padding({ left: 15, right: 15 })
      .margin({ bottom: 10 })

      // 分类标签
      CategoryTabs({
        tabs: this.tabs,
        selectedIndex: this.selectedCategoryIndex,
        onTabChange: (index: number) => {
          this.selectedCategoryIndex = index
        }
      })

      // 教材列表
      List({ space: 0 }) {
        ForEach(this.getFilteredMaterials(), (item: MaterialItem) => {
          ListItem() {
            Row() {
              // 左侧封面
              Image(item.imageRes)
                .width(90)
                .height(120)
                .borderRadius(6)
                .objectFit(ImageFit.Cover)

              // 右侧信息
              Column() {
                Text(item.title)
                  .fontSize(15)
                  .fontWeight(FontWeight.Bold)
                  .fontColor(AppColors.TEXT_PRIMARY)
                  .maxLines(1)
                  .textOverflow({ overflow: TextOverflow.Ellipsis })
                  .width('100%')

                Row() {
                  Text(item.author)
                    .fontSize(12)
                    .fontColor(AppColors.TEXT_TERTIARY)
                }
                .margin({ top: 4 })
                .width('100%')

                Row() {
                  Text(item.category)
                    .fontSize(11)
                    .fontColor(AppColors.BG_WHITE)
                    .backgroundColor(AppColors.PRIMARY_ORANGE)
                    .padding({ left: 6, right: 6, top: 2, bottom: 2 })
                    .borderRadius(4)

                  Text(item.edition)
                    .fontSize(11)
                    .fontColor(AppColors.PRIMARY_BLUE)
                    .margin({ left: 6 })

                  Text(`${item.pages}页`)
                    .fontSize(11)
                    .fontColor(AppColors.TEXT_TERTIARY)
                    .margin({ left: 6 })
                }
                .margin({ top: 6 })

                // 评分和下载量
                Row() {
                  Text('★')
                    .fontSize(12)
                    .fontColor(AppColors.RATING_STAR)
                  Text(`${item.rating}`)
                    .fontSize(12)
                    .fontColor(AppColors.RATING_STAR)
                    .margin({ left: 2 })

                  Text('  |  ')
                    .fontSize(12)
                    .fontColor(AppColors.DIVIDER)

                  Text(`${item.downloads}次下载`)
                    .fontSize(11)
                    .fontColor(AppColors.TEXT_TERTIARY)
                }
                .margin({ top: 6 })

                Text(item.description)
                  .fontSize(12)
                  .fontColor(AppColors.TEXT_PLACEHOLDER)
                  .maxLines(2)
                  .textOverflow({ overflow: TextOverflow.Ellipsis })
                  .lineHeight(18)
                  .margin({ top: 6 })
                  .width('100%')

                // 价格和操作
                Row() {
                  if (item.isFree) {
                    Text('免费')
                      .fontSize(14)
                      .fontColor(AppColors.SUCCESS_GREEN)
                      .fontWeight(FontWeight.Bold)
                  } else {
                    Text(item.price)
                      .fontSize(14)
                      .fontColor(AppColors.PRIMARY_ORANGE)
                      .fontWeight(FontWeight.Bold)
                  }

                  Blank()

                  Text('立即获取')
                    .fontSize(12)
                    .fontColor(AppColors.BG_WHITE)
                    .backgroundColor(AppColors.PRIMARY_ORANGE)
                    .padding({ left: 10, right: 10, top: 4, bottom: 4 })
                    .borderRadius(12)
                }
                .margin({ top: 6 })
                .width('100%')
                .alignItems(VerticalAlign.Center)
              }
              .layoutWeight(1)
              .margin({ left: 12 })
              .alignItems(HorizontalAlign.Start)
            }
            .width('90%')
            .padding(12)
            .backgroundColor(AppColors.BG_WHITE)
            .borderRadius(10)
            .margin({ left: '5%', right: '5%', bottom: 10 })
          }
        }, (item: MaterialItem) => item.id.toString())

        if (this.getFilteredMaterials().length === 0) {
          ListItem() {
            Column() {
              Text('暂无教材数据')
                .fontSize(16)
                .fontColor(AppColors.TEXT_HINT)
                .margin({ top: 80 })
            }
            .width('100%')
            .alignItems(HorizontalAlign.Center)
          }
        }
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
