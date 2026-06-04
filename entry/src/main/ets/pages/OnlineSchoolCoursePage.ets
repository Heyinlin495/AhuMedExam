import { router } from '@kit.ArkUI'
import { AppColors } from '../constants/AppConstants'
import { SearchBar } from '../components/SearchBar'
import { CategoryTabs } from '../components/CategoryTabs'

interface CourseItem {
  id: number
  title: string
  category: string
  teacher: string
  duration: string
  students: number
  rating: number
  price: string
  imageRes: Resource
  description: string
  isFree: boolean
}

@Entry
@Component
struct OnlineSchoolCoursePage {
  @State searchText: string = ''
  @State selectedCategoryIndex: number = 0

  private tabs: string[] = ['全部', '热门班型', '精品课程', '备考图书', '高端面授']

  private courseList: CourseItem[] = [
    {
      id: 1, title: '临床执业医师核心考点精讲', category: '热门班型',
      teacher: '张教授', duration: '120课时', students: 3256, rating: 4.9,
      price: '¥2980', imageRes: $r('app.media.course1'),
      description: '覆盖临床执业医师考试全部核心考点，由三甲医院资深专家授课，帮助学员高效备考。',
      isFree: false
    },
    {
      id: 2, title: '中医基础理论系统课程', category: '精品课程',
      teacher: '李教授', duration: '80课时', students: 2180, rating: 4.8,
      price: '¥1980', imageRes: $r('app.media.course2'),
      description: '系统讲解中医基础理论，从阴阳五行到脏腑经络，全面掌握中医理论基础。',
      isFree: false
    },
    {
      id: 3, title: '执业医师考试真题解析班', category: '热门班型',
      teacher: '王主任', duration: '60课时', students: 4521, rating: 4.7,
      price: '¥1580', imageRes: $r('app.media.course3'),
      description: '精选历年真题，深入解析每道题目的考点和解题思路，举一反三。',
      isFree: false
    },
    {
      id: 8, title: '临床助理医师通关协议班', category: '热门班型',
      teacher: '周教授', duration: '100课时', students: 2890, rating: 4.8,
      price: '¥3680', imageRes: $r('app.media.course1'),
      description: '签订协议，不过退费，全程名师带教，配套专属学习计划和答疑服务。',
      isFree: false
    },
    {
      id: 9, title: '临床执业医师技能实操班', category: '热门班型',
      teacher: '吴主任', duration: '40课时', students: 1856, rating: 4.6,
      price: '¥1280', imageRes: $r('app.media.course3'),
      description: '针对实践技能考试三站内容，手把手教学，模拟考场实操演练。',
      isFree: false
    },
    {
      id: 10, title: '内科主治医师精讲班', category: '热门班型',
      teacher: '郑教授', duration: '90课时', students: 2134, rating: 4.9,
      price: '¥2580', imageRes: $r('app.media.course2'),
      description: '内科主治医师考试全科精讲，涵盖基础知识、相关专业知识、专业知识和专业实践能力。',
      isFree: false
    },
    {
      id: 4, title: '口腔颌面外科考点精讲', category: '精品课程',
      teacher: '陈教授', duration: '45课时', students: 987, rating: 4.9,
      price: '¥1280', imageRes: $r('app.media.course4'),
      description: '聚焦口腔颌面外科高频考点，配合临床案例分析，深入浅出讲解。',
      isFree: false
    },
    {
      id: 5, title: '预防医学基础导学课', category: '备考图书',
      teacher: '刘教授', duration: '30课时', students: 1540, rating: 4.6,
      price: '免费', imageRes: $r('app.media.course5'),
      description: '公共卫生方向入门导学课程，帮助学员快速建立预防医学知识框架。',
      isFree: true
    },
    {
      id: 6, title: '药理学高频考点冲刺班', category: '备考图书',
      teacher: '赵教授', duration: '50课时', students: 1820, rating: 4.8,
      price: '¥1680', imageRes: $r('app.media.course6'),
      description: '考前冲刺专用课程，聚焦药理学高频考点，快速提分。',
      isFree: false
    },
    {
      id: 7, title: '中医临床实践技能实训', category: '高端面授',
      teacher: '孙主任', duration: '40课时', students: 876, rating: 4.7,
      price: '¥1380', imageRes: $r('app.media.course7'),
      description: '中医临床实践操作视频教学，涵盖望闻问切、针灸推拿等核心技能。',
      isFree: false
    }
  ]

  // 根据分类和搜索关键词过滤课程
  private getFilteredCourses(): CourseItem[] {
    let filtered = this.courseList
    // 按分类过滤（"全部"显示所有）
    if (this.selectedCategoryIndex > 0) {
      const category = this.tabs[this.selectedCategoryIndex]
      filtered = filtered.filter((item: CourseItem) => item.category === category)
    }
    // 按搜索关键词过滤
    if (this.searchText.trim().length > 0) {
      const keyword = this.searchText.trim()
      filtered = filtered.filter((item: CourseItem) =>
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

        Text('网校课程')
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
        placeholder: '搜索课程名称、讲师',
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

      // 课程列表
      List({ space: 0 }) {
        ForEach(this.getFilteredCourses(), (item: CourseItem) => {
          ListItem() {
            Row() {
              // 左侧图片区域 - 带选课按钮
              Stack({ alignContent: Alignment.BottomEnd }) {
                Image(item.imageRes)
                  .width(105)
                  .height(80)
                  .borderRadius(6)
                  .objectFit(ImageFit.Contain)

                // 选课按钮
                Text('选课')
                  .fontSize(11)
                  .fontColor(AppColors.BG_WHITE)
                  .backgroundColor(AppColors.ERROR_RED)
                  .padding({ left: 10, right: 10, top: 3, bottom: 3 })
                  .borderRadius({ bottomLeft: 4, bottomRight: 6, topLeft: 0, topRight: 0 })
              }

              // 右侧信息
              Column() {
                // 课程标题
                Text(item.title)
                  .fontSize(15)
                  .fontWeight(FontWeight.Bold)
                  .fontColor(AppColors.TEXT_PRIMARY)
                  .maxLines(1)
                  .textOverflow({ overflow: TextOverflow.Ellipsis })
                  .width('100%')

                // 教师头像 + 姓名
                Row() {
                  Circle()
                    .width(20)
                    .height(20)
                    .fill('#FFD4B8')
                  Text(item.teacher)
                    .fontSize(12)
                    .fontColor(AppColors.TEXT_TERTIARY)
                    .margin({ left: 6 })
                }
                .margin({ top: 8 })
                .alignItems(VerticalAlign.Center)

                // 价格 + 学习人数 + 报名按钮
                Row() {
                  Column() {
                    Row() {
                      if (item.isFree) {
                        Text('免费')
                          .fontSize(14)
                          .fontColor(AppColors.SUCCESS_GREEN)
                          .fontWeight(FontWeight.Bold)
                      } else {
                        Text(item.price)
                          .fontSize(14)
                          .fontColor(AppColors.ERROR_RED)
                          .fontWeight(FontWeight.Bold)
                      }
                    }

                    Text(`${item.students}人购买`)
                      .fontSize(11)
                      .fontColor(AppColors.TEXT_TERTIARY)
                      .margin({ top: 2 })
                  }
                  .alignItems(HorizontalAlign.Start)

                  Blank()

                  Text('购买')
                    .fontSize(13)
                    .fontColor(AppColors.BG_WHITE)
                    .backgroundColor(AppColors.ERROR_RED)
                    .padding({ left: 16, right: 16, top: 6, bottom: 6 })
                    .borderRadius(16)
                }
                .margin({ top: 8 })
                .width('100%')
                .alignItems(VerticalAlign.Center)
              }
              .layoutWeight(1)
              .margin({ left: 12 })
              .alignItems(HorizontalAlign.Start)
              .justifyContent(FlexAlign.SpaceBetween)
            }
            .width('90%')
            .padding({ left: 0, right: 12, top: 12, bottom: 12 })
            .backgroundColor(AppColors.BG_WHITE)
            .borderRadius(8)
            .margin({ left: '5%', right: '5%', bottom: 8 })
          }
        }, (item: CourseItem) => item.id.toString())

        // 空状态提示
        if (this.getFilteredCourses().length === 0) {
          ListItem() {
            Column() {
              Text('暂无课程数据')
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
