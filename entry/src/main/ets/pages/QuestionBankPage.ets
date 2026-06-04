import { router } from '@kit.ArkUI'
import { AppColors } from '../constants/AppConstants'
import { SearchBar } from '../components/SearchBar'
import { CategoryTabs } from '../components/CategoryTabs'

interface QuestionBankItem {
  id: number
  title: string
  category: string
  totalQuestions: number
  difficulty: string
  participants: number
  passRate: number
  lastUpdate: string
  description: string
  imageRes: Resource
}

interface RecommendModule {
  icon: string
  title: string
  count: string
}

@Entry
@Component
struct QuestionBankPage {
  @State searchText: string = ''
  @State selectedCategoryIndex: number = 0

  private tabs: string[] = ['全部', '临床执业', '中医执业', '口腔执业', '公共卫生', '执业药师']

  private questionBanks: QuestionBankItem[] = [
    {
      id: 1, title: '临床执业医师历年真题精选', category: '临床执业',
      totalQuestions: 3560, difficulty: '中等', participants: 12580,
      passRate: 78, lastUpdate: '2026-05-15', imageRes: $r('app.media.course1'),
      description: '精选近10年临床执业医师考试真题，涵盖基础医学、临床医学、预防医学等全部科目。'
    },
    {
      id: 2, title: '中医基础理论题库', category: '中医执业',
      totalQuestions: 1850, difficulty: '较易', participants: 6320,
      passRate: 82, lastUpdate: '2026-05-20', imageRes: $r('app.media.course2'),
      description: '中医基础理论全章节题库，包括阴阳五行、藏象、经络、病因病机等核心内容。'
    },
    {
      id: 3, title: '临床执业医师冲刺卷', category: '临床执业',
      totalQuestions: 800, difficulty: '较难', participants: 8940,
      passRate: 65, lastUpdate: '2026-05-18', imageRes: $r('app.media.course3'),
      description: '考前冲刺专用模拟卷，难度略高于真题，帮助学员查漏补缺。'
    },
    {
      id: 4, title: '口腔执业医师技能模拟', category: '口腔执业',
      totalQuestions: 960, difficulty: '中等', participants: 3280,
      passRate: 75, lastUpdate: '2026-05-22', imageRes: $r('app.media.course4'),
      description: '口腔实践技能操作模拟题库，配合视频解析，提升实操能力。'
    },
    {
      id: 5, title: '公共卫生综合题库', category: '公共卫生',
      totalQuestions: 2200, difficulty: '中等', participants: 4150,
      passRate: 80, lastUpdate: '2026-05-10', imageRes: $r('app.media.course5'),
      description: '公共卫生执业医师全科目题库，涵盖流行病学、卫生统计学、环境卫生等。'
    },
    {
      id: 6, title: '执业药师西药学题库', category: '执业药师',
      totalQuestions: 2800, difficulty: '中等', participants: 7650,
      passRate: 72, lastUpdate: '2026-05-25', imageRes: $r('app.media.course6'),
      description: '执业药师西药学全章节题库，包含药理学、药剂学、药物化学等重点内容。'
    },
    {
      id: 7, title: '中医临床实践真题', category: '中医执业',
      totalQuestions: 1500, difficulty: '较难', participants: 2890,
      passRate: 68, lastUpdate: '2026-05-12', imageRes: $r('app.media.course7'),
      description: '中医临床实践技能真题精选，涵盖内科、外科、妇科、儿科等临床科目。'
    }
  ]

  // 首页推荐模块数据
  private recommendModules: RecommendModule[] = [
    { icon: '📝', title: '错题本', count: '128题' },
    { icon: '⭐', title: '收藏夹', count: '56题' },
    { icon: '📊', title: '学习报告', count: '本月' },
    { icon: '🏆', title: '排行榜', count: '第38名' }
  ]

  // 根据分类和搜索关键词过滤题库
  private getFilteredBanks(): QuestionBankItem[] {
    let filtered = this.questionBanks
    if (this.selectedCategoryIndex > 0) {
      const category = this.tabs[this.selectedCategoryIndex]
      filtered = filtered.filter((item: QuestionBankItem) => item.category === category)
    }
    if (this.searchText.trim().length > 0) {
      const keyword = this.searchText.trim()
      filtered = filtered.filter((item: QuestionBankItem) =>
        item.title.indexOf(keyword) >= 0
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

        Text('精选题库')
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
        placeholder: '搜索题库名称',
        onSearch: (text: string) => {
          this.searchText = text
        }
      })

      // 快捷功能入口
      Row() {
        ForEach(this.recommendModules, (item: RecommendModule) => {
          Column() {
            Text(item.icon)
              .fontSize(24)
            Text(item.title)
              .fontSize(13)
              .fontColor(AppColors.TEXT_PRIMARY)
              .margin({ top: 4 })
            Text(item.count)
              .fontSize(11)
              .fontColor(AppColors.TEXT_TERTIARY)
              .margin({ top: 2 })
          }
          .layoutWeight(1)
          .alignItems(HorizontalAlign.Center)
        }, (item: RecommendModule) => item.title)
      }
      .width('92%')
      .padding(12)
      .backgroundColor(AppColors.BG_WHITE)
      .borderRadius(10)
      .margin({ bottom: 10 })

      // 分类标签
      CategoryTabs({
        tabs: this.tabs,
        selectedIndex: this.selectedCategoryIndex,
        onTabChange: (index: number) => {
          this.selectedCategoryIndex = index
        }
      })

      // 题库列表
      List({ space: 0 }) {
        ForEach(this.getFilteredBanks(), (item: QuestionBankItem) => {
          ListItem() {
            Column() {
              Row() {
                // 左侧图标
                Image(item.imageRes)
                  .width(70)
                  .height(70)
                  .borderRadius(8)

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
                    Text(item.category)
                      .fontSize(11)
                      .fontColor(AppColors.BG_WHITE)
                      .backgroundColor(AppColors.PRIMARY_ORANGE)
                      .padding({ left: 6, right: 6, top: 2, bottom: 2 })
                      .borderRadius(4)

                    Text(item.difficulty)
                      .fontSize(11)
                      .fontColor(item.difficulty === '较难' ? AppColors.ERROR_RED :
                        (item.difficulty === '较易' ? AppColors.SUCCESS_GREEN : AppColors.WARNING_ORANGE))
                      .margin({ left: 8 })
                  }
                  .margin({ top: 6 })

                  Row() {
                    Text(`${item.totalQuestions}题`)
                      .fontSize(12)
                      .fontColor(AppColors.TEXT_SECONDARY)
                    Text('  |  ')
                      .fontSize(12)
                      .fontColor(AppColors.DIVIDER)
                    Text(`${item.participants}人刷题`)
                      .fontSize(12)
                      .fontColor(AppColors.TEXT_SECONDARY)
                  }
                  .margin({ top: 6 })

                  Row() {
                    Text('通过率')
                      .fontSize(11)
                      .fontColor(AppColors.TEXT_TERTIARY)
                    Text(` ${item.passRate}%`)
                      .fontSize(11)
                      .fontColor(item.passRate >= 75 ? AppColors.SUCCESS_GREEN : AppColors.PRIMARY_ORANGE)
                      .fontWeight(FontWeight.Bold)
                    Blank()
                    Text('开始刷题')
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
              .width('100%')

              Text(item.description)
                .fontSize(12)
                .fontColor(AppColors.TEXT_TERTIARY)
                .maxLines(2)
                .textOverflow({ overflow: TextOverflow.Ellipsis })
                .margin({ top: 10 })
                .lineHeight(18)

              Row() {
                Text(`更新：${item.lastUpdate}`)
                  .fontSize(11)
                  .fontColor('#CCCCCC')
                Blank()
              }
              .width('100%')
              .margin({ top: 6 })
            }
            .width('90%')
            .padding(14)
            .backgroundColor(AppColors.BG_WHITE)
            .borderRadius(10)
            .margin({ left: '5%', right: '5%', bottom: 10 })
          }
        }, (item: QuestionBankItem) => item.id.toString())

        if (this.getFilteredBanks().length === 0) {
          ListItem() {
            Column() {
              Text('暂无题库数据')
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
