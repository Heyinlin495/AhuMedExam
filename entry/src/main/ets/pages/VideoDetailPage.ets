import { router } from '@kit.ArkUI'
import { AppColors } from '../constants/AppConstants'
import { CourseDataService, CourseDetail } from '../service/CourseDataService'

@Entry
@Component
struct VideoDetailPage {
  @State title: string = ''
  @State description: string = ''
  @State videoIndex: number = -1
  @State hasError: boolean = false
  @State isLoading: boolean = true
  @State currentCourse: CourseDetail | null = null

  private controller: VideoController = new VideoController()

  aboutToAppear() {
    const params = router.getParams() as Record<string, Object>
    this.title = (params?.title as string) ?? ''
    this.description = (params?.description as string) ?? ''
    this.videoIndex = (params?.videoIndex as number) ?? -1
    this.currentCourse = CourseDataService.getCourseByIndex(this.videoIndex)
  }

  getVideoSrc(): Resource | string {
    const course = CourseDataService.getCourseByIndex(this.videoIndex)
    if (course) {
      return $rawfile(course.videoPath)
    }
    return ''
  }

  // 标签组件
  @Builder
  SectionTitle(text: string) {
    Row() {
      Text('')
        .width(4)
        .height(16)
        .backgroundColor(AppColors.PRIMARY_ORANGE)
        .borderRadius(2)
      Text(text)
        .fontSize(16)
        .fontWeight(FontWeight.Bold)
        .fontColor(AppColors.TEXT_PRIMARY)
        .margin({ left: 8 })
    }
    .width('100%')
    .alignItems(VerticalAlign.Center)
    .margin({ top: 20, bottom: 10 })
  }

  // 学习目标项
  @Builder
  GoalItem(text: string, index: number) {
    Row() {
      Text(`${index + 1}`)
        .fontSize(12)
        .fontColor(AppColors.BG_WHITE)
        .backgroundColor(AppColors.PRIMARY_ORANGE)
        .width(20)
        .height(20)
        .borderRadius(10)
        .textAlign(TextAlign.Center)

      Text(text)
        .fontSize(14)
        .fontColor('#555555')
        .lineHeight(20)
        .margin({ left: 10 })
        .layoutWeight(1)
    }
    .width('100%')
    .alignItems(VerticalAlign.Top)
    .margin({ bottom: 10 })
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

        Text(this.title)
          .fontSize(17)
          .fontColor(AppColors.TEXT_PRIMARY)
          .maxLines(1)
          .textOverflow({ overflow: TextOverflow.Ellipsis })
          .layoutWeight(1)

        Text('↗')
          .fontSize(20)
          .fontColor(AppColors.TEXT_PRIMARY)
          .width(40)
          .height(40)
          .textAlign(TextAlign.Center)
      }
      .width('100%')
      .height(48)
      .padding({ left: 4, right: 12 })
      .alignItems(VerticalAlign.Center)
      .backgroundColor(AppColors.BG_WHITE)

      // 视频播放区域
      Stack({ alignContent: Alignment.Bottom }) {
        Video({
          src: this.getVideoSrc(),
          controller: this.controller
        })
          .width('100%')
          .height('100%')
          .autoPlay(true)
          .objectFit(ImageFit.Contain)
          .controls(true)
          .onPrepared((info: PreparedInfo) => {
            this.isLoading = false
            this.hasError = false
            this.controller.start()
          })
          .onError(() => {
            this.hasError = true
            this.isLoading = false
          })

        if (this.isLoading) {
          Column() {
            LoadingProgress()
              .width(50)
              .height(50)
              .color(AppColors.BG_WHITE)
            Text('加载中...')
              .fontSize(14)
              .fontColor(AppColors.BG_WHITE)
              .margin({ top: 10 })
          }
          .width('100%')
          .height('100%')
          .backgroundColor('#000000')
          .justifyContent(FlexAlign.Center)
          .alignItems(HorizontalAlign.Center)
        }

        if (this.hasError) {
          Column() {
            Text('✕')
              .fontSize(40)
              .fontColor(AppColors.ERROR_RED)
            Text('播放失败')
              .fontSize(16)
              .fontColor(AppColors.BG_WHITE)
              .margin({ top: 10 })
            Text('点击重试')
              .fontSize(12)
              .fontColor(AppColors.TEXT_TERTIARY)
              .margin({ top: 5 })
          }
          .width('100%')
          .height('100%')
          .backgroundColor('#000000')
          .justifyContent(FlexAlign.Center)
          .alignItems(HorizontalAlign.Center)
        }
      }
      .width('100%')
      .height(220)
      .backgroundColor('#000000')
      .onClick(() => {
        if (this.hasError) {
          this.hasError = false
          this.isLoading = true
          this.videoIndex = -1
          setTimeout(() => {
            const params = router.getParams() as Record<string, Object>
            this.videoIndex = (params?.videoIndex as number) ?? -1
            this.currentCourse = CourseDataService.getCourseByIndex(this.videoIndex)
          }, 100)
        }
      })

      // 课程介绍区域（可滚动）
      Scroll() {
        Column() {
          // 课程标题
          Text(this.title)
            .fontSize(20)
            .fontWeight(FontWeight.Bold)
            .fontColor(AppColors.TEXT_PRIMARY)
            .width('100%')
            .margin({ top: 16, bottom: 4 })

          // 作者信息
          Row() {
            Circle()
              .width(28)
              .height(28)
              .fill('#FFD4B8')
            Text('医考宝典')
              .fontSize(13)
              .fontColor(AppColors.TEXT_TERTIARY)
              .margin({ left: 8 })
          }
          .width('100%')
          .alignItems(VerticalAlign.Center)
          .margin({ bottom: 12 })

          // 课程简介
          if (this.currentCourse !== null) {
            this.SectionTitle('课程简介')
            Text(this.currentCourse!.intro)
              .fontSize(14)
              .fontColor('#555555')
              .lineHeight(22)
              .width('100%')

            // 学习目标
            this.SectionTitle('学习目标')
            ForEach(this.currentCourse!.goals, (goal: string, index: number) => {
              this.GoalItem(goal, index)
            }, (goal: string, index: number) => `goal_${index}`)

            // 适合人群
            this.SectionTitle('适合人群')
            Row() {
              Text('👤')
                .fontSize(14)
                .margin({ right: 8 })
              Text(this.currentCourse!.audience)
                .fontSize(14)
                .fontColor('#555555')
                .lineHeight(20)
                .layoutWeight(1)
            }
            .width('100%')
            .alignItems(VerticalAlign.Top)
            .margin({ top: 4 })

            // 底部留白
            Blank()
              .height(30)
          }
        }
        .width('100%')
        .padding({ left: 16, right: 16, bottom: 20 })
        .backgroundColor(AppColors.BG_WHITE)
      }
      .layoutWeight(1)
      .scrollBar(BarState.Off)
      .backgroundColor(AppColors.BG_WHITE)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppColors.BG_WHITE)
  }
}
