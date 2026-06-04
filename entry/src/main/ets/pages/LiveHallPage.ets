import { router } from '@kit.ArkUI'
import { AppColors } from '../constants/AppConstants'
import { SearchBar } from '../components/SearchBar'
import { CategoryTabs } from '../components/CategoryTabs'

interface LiveRoomItem {
  id: number
  title: string
  teacher: string
  startTime: string
  viewers: number
  status: string  // '直播中', '即将开始', '已结束'
  category: string
  description: string
  imageRes: Resource
}

@Entry
@Component
struct LiveHallPage {
  @State searchText: string = ''
  @State selectedCategoryIndex: number = 0

  private tabs: string[] = ['全部', '直播中', '即将开始', '往期回放']

  private liveRooms: LiveRoomItem[] = [
    {
      id: 1, title: '临床执业医师考点精讲：心血管系统', teacher: '张教授',
      startTime: '20:00-22:00', viewers: 2568, status: '直播中',
      category: '临床医学', description: '深入讲解心血管系统高频考点，包含真题解析和互动答疑环节。',
      imageRes: $r('app.media.course1')
    },
    {
      id: 2, title: '中医基础理论：阴阳学说精讲', teacher: '李教授',
      startTime: '19:30-21:30', viewers: 1890, status: '直播中',
      category: '中医基础', description: '系统讲解阴阳学说的核心概念及其在中医临床中的应用。',
      imageRes: $r('app.media.course2')
    },
    {
      id: 3, title: '执业医师考试冲刺备考策略', teacher: '王主任',
      startTime: '明天 20:00', viewers: 0, status: '即将开始',
      category: '备考指导', description: '考前30天冲刺备考全攻略，时间规划、重点突破、心态调整一网打尽。',
      imageRes: $r('app.media.course3')
    },
    {
      id: 4, title: '口腔颌面外科真题解析', teacher: '陈教授',
      startTime: '后天 19:00', viewers: 0, status: '即将开始',
      category: '口腔医学', description: '口腔颌面外科历年真题逐题解析，掌握出题规律和答题技巧。',
      imageRes: $r('app.media.course4')
    },
    {
      id: 5, title: '预防医学：流行病学专题', teacher: '刘教授',
      startTime: '05-28 20:00', viewers: 0, status: '即将开始',
      category: '公共卫生', description: '流行病学核心考点串讲，配合典型例题分析。',
      imageRes: $r('app.media.course5')
    },
    {
      id: 6, title: '药理学高频考点直播课', teacher: '赵教授',
      startTime: '05-27 19:30', viewers: 3420, status: '已结束',
      category: '药学', description: '药理学必考知识点全面梳理，往期直播回放已上线。',
      imageRes: $r('app.media.course6')
    },
    {
      id: 7, title: '消化系统疾病诊疗要点', teacher: '孙主任',
      startTime: '05-25 20:00', viewers: 2890, status: '已结束',
      category: '临床医学', description: '消化系统常见疾病诊疗要点串讲，结合临床案例深入解析。',
      imageRes: $r('app.media.course7')
    }
  ]

  @Builder
  StatusBadge(status: string) {
    if (status === '直播中') {
      Row() {
        Circle()
          .width(8)
          .height(8)
          .fill(AppColors.ERROR_RED)
        Text('直播中')
          .fontSize(11)
          .fontColor(AppColors.BG_WHITE)
          .margin({ left: 4 })
      }
      .padding({ left: 8, right: 8, top: 3, bottom: 3 })
      .backgroundColor(AppColors.ERROR_RED)
      .borderRadius(4)
    } else if (status === '即将开始') {
      Row() {
        Text('即将开始')
          .fontSize(11)
          .fontColor(AppColors.BG_WHITE)
      }
      .padding({ left: 8, right: 8, top: 3, bottom: 3 })
      .backgroundColor(AppColors.WARNING_ORANGE)
      .borderRadius(4)
    } else {
      Row() {
        Text('已结束')
          .fontSize(11)
          .fontColor(AppColors.BG_WHITE)
      }
      .padding({ left: 8, right: 8, top: 3, bottom: 3 })
      .backgroundColor(AppColors.TEXT_TERTIARY)
      .borderRadius(4)
    }
  }

  // 根据状态和搜索关键词过滤直播
  private getFilteredLives(): LiveRoomItem[] {
    let filtered = this.liveRooms
    if (this.selectedCategoryIndex > 0) {
      const tab = this.tabs[this.selectedCategoryIndex]
      if (tab === '往期回放') {
        filtered = filtered.filter((item: LiveRoomItem) => item.status === '已结束')
      } else {
        filtered = filtered.filter((item: LiveRoomItem) => item.status === tab)
      }
    }
    if (this.searchText.trim().length > 0) {
      const keyword = this.searchText.trim()
      filtered = filtered.filter((item: LiveRoomItem) =>
        item.title.indexOf(keyword) >= 0 || item.teacher.indexOf(keyword) >= 0
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

        Text('直播大厅')
          .fontSize(18)
          .fontColor(AppColors.TEXT_PRIMARY)
          .fontWeight(FontWeight.Bold)

        Blank()

        // 直播预告图标
        Text('🔔')
          .fontSize(18)
          .margin({ right: 10 })
      }
      .width('100%')
      .height(50)
      .padding({ left: 5, right: 15 })
      .alignItems(VerticalAlign.Center)
      .backgroundColor(AppColors.BG_WHITE)

      // 搜索栏
      SearchBar({
        placeholder: '搜索直播课程、讲师',
        onSearch: (text: string) => {
          this.searchText = text
        }
      })

      // 分类标签
      CategoryTabs({
        tabs: this.tabs,
        selectedIndex: this.selectedCategoryIndex,
        onTabChange: (index: number) => {
          this.selectedCategoryIndex = index
        }
      })

      // 直播列表
      List({ space: 0 }) {
        ForEach(this.getFilteredLives(), (item: LiveRoomItem) => {
          ListItem() {
            Column() {
              // 直播卡片 - 图片区域
              Stack({ alignContent: Alignment.TopStart }) {
                Image(item.imageRes)
                  .width('100%')
                  .height(160)
                  .borderRadius({ topLeft: 10, topRight: 10 })
                  .objectFit(ImageFit.Cover)

                // 状态标签
                this.StatusBadge(item.status)

                // 在线人数
                if (item.status === '直播中') {
                  Row() {
                    Text('👁')
                      .fontSize(12)
                    Text(`${item.viewers}人观看`)
                      .fontSize(11)
                      .fontColor(AppColors.BG_WHITE)
                      .margin({ left: 4 })
                  }
                  .padding({ left: 8, right: 8, top: 3, bottom: 3 })
                  .backgroundColor(AppColors.OVERLAY_SEMI)
                  .borderRadius(4)
                  .position({ x: '65%', y: 8 })
                }

                // 底部渐变遮罩
                Column() {
                  Blank()
                }
                .width('100%')
                .height(60)
                .linearGradient({
                  direction: GradientDirection.Bottom,
                  colors: [['#00000000', 0], ['#66000000', 1]]
                })
                .position({ x: 0, y: 100 })
              }
              .width('100%')
              .clip(true)

              // 直播信息区域
              Column() {
                Text(item.title)
                  .fontSize(15)
                  .fontWeight(FontWeight.Bold)
                  .fontColor(AppColors.TEXT_PRIMARY)
                  .maxLines(1)
                  .textOverflow({ overflow: TextOverflow.Ellipsis })
                  .width('100%')

                Text(item.description)
                  .fontSize(12)
                  .fontColor(AppColors.TEXT_PLACEHOLDER)
                  .maxLines(2)
                  .textOverflow({ overflow: TextOverflow.Ellipsis })
                  .lineHeight(18)
                  .margin({ top: 6 })
                  .width('100%')

                Row() {
                  // 讲师信息
                  Row() {
                    Circle()
                      .width(24)
                      .height(24)
                      .fill('#FFD4B8')
                    Text(item.teacher)
                      .fontSize(12)
                      .fontColor(AppColors.TEXT_SECONDARY)
                      .margin({ left: 6 })
                  }

                  Blank()

                  // 时间
                  Text(`⏰ ${item.startTime}`)
                    .fontSize(12)
                    .fontColor(AppColors.TEXT_TERTIARY)

                  // 分类
                  Text(`  📂 ${item.category}`)
                    .fontSize(11)
                    .fontColor(AppColors.TEXT_HINT)
                }
                .margin({ top: 10 })
                .width('100%')
                .alignItems(VerticalAlign.Center)

                // 操作按钮
                Row() {
                  if (item.status === '直播中') {
                    Text('🔴 进入直播')
                      .fontSize(13)
                      .fontColor(AppColors.BG_WHITE)
                      .backgroundColor(AppColors.ERROR_RED)
                      .padding({ left: 16, right: 16, top: 6, bottom: 6 })
                      .borderRadius(16)
                  } else if (item.status === '即将开始') {
                    Text('⏰ 预约提醒')
                      .fontSize(13)
                      .fontColor(AppColors.BG_WHITE)
                      .backgroundColor(AppColors.WARNING_ORANGE)
                      .padding({ left: 16, right: 16, top: 6, bottom: 6 })
                      .borderRadius(16)
                  } else {
                    Text('▶ 观看回放')
                      .fontSize(13)
                      .fontColor(AppColors.BG_WHITE)
                      .backgroundColor(AppColors.PRIMARY_BLUE)
                      .padding({ left: 16, right: 16, top: 6, bottom: 6 })
                      .borderRadius(16)
                  }

                  Blank()

                  Text('分享')
                    .fontSize(12)
                    .fontColor(AppColors.TEXT_TERTIARY)
                    .margin({ right: 4 })
                }
                .margin({ top: 12 })
                .width('100%')
                .alignItems(VerticalAlign.Center)
              }
              .padding({ left: 14, right: 14, top: 12, bottom: 14 })
            }
            .width('90%')
            .backgroundColor(AppColors.BG_WHITE)
            .borderRadius(10)
            .margin({ left: '5%', right: '5%', bottom: 12 })
            .shadow({
              radius: 6,
              color: '#1A000000',
              offsetX: 0,
              offsetY: 2
            })
          }
        }, (item: LiveRoomItem) => item.id.toString())

        if (this.getFilteredLives().length === 0) {
          ListItem() {
            Column() {
              Text('暂无直播数据')
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
