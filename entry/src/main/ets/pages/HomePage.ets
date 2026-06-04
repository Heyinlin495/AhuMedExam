import { router } from '@kit.ArkUI'
import { AppColors, PageRoutes } from '../constants/AppConstants'
import { VideoItem } from '../model/VideoItem'
import { CourseDataService } from '../service/CourseDataService'
import { BottomNavBar } from '../components/BottomNavBar'

interface BannerItem {
  image: Resource
  detailImage: Resource
  route?: string
}

@Entry
@Component
struct HomePage {
  @State currentIndex: number = 0
  @State username: string = ''

  aboutToAppear() {
    const params = router.getParams() as Record<string, Object>
    if (params && params['username']) {
      this.username = params['username'] as string
    }
  }

  onPageShow() {
    this.currentIndex = 0
  }

  // 轮播图数据（支持点击跳转）
  private bannerList: BannerItem[] = [
    { image: $r('app.media.info1'), detailImage: $r('app.media.information1'), route: PageRoutes.BANNER_DETAIL } as BannerItem,
    { image: $r('app.media.info2'), detailImage: $r('app.media.information2'), route: PageRoutes.BANNER_DETAIL } as BannerItem
  ]

  // 热门视频数据 - 从数据服务获取
  private videoList: VideoItem[] = CourseDataService.getVideoItems()

  build() {
    Stack({ alignContent: Alignment.BottomEnd }) {
      Column() {
        // 顶部导航栏
        Row() {
          Text('资讯')
            .fontSize(18)
            .fontColor(AppColors.TEXT_PRIMARY)
            .fontWeight(FontWeight.Bold)

          Blank()

          Text(`欢迎您：${this.username}`)
            .fontSize(16)
            .fontColor(AppColors.PRIMARY_ORANGE)
            .onClick(() => {
              router.pushUrl({ url: PageRoutes.PERSONAL_INFO, params: { username: this.username } })
            })

          Blank()

          Text('退出')
            .fontSize(16)
            .fontColor(AppColors.PRIMARY_BLUE)
            .onClick(() => {
              router.pushUrl({ url: PageRoutes.LOGIN })
            })
        }
        .width('100%')
        .height(50)
        .padding({ left: 15, right: 15 })
        .alignItems(VerticalAlign.Center)

        // 内容区域
        Scroll() {
          Column() {
            // 轮播图Banner
            Swiper() {
              ForEach(this.bannerList, (item: BannerItem, index: number) => {
                Image(item.image)
                  .width('90%')
                  .height(130)
                  .borderRadius(10)
                  .objectFit(ImageFit.Fill)
                  .onClick(() => {
                    if (item.route) {
                      router.pushUrl({
                        url: item.route,
                        params: { imageRes: item.detailImage }
                      })
                    }
                  })
              }, (item: BannerItem, index: number) => `banner_${index}`)
            }
            .width('90%')
            .height(130)
            .margin({ top: 10 })
            .autoPlay(true)
            .interval(3000)
            .indicator(Indicator.dot()
              .color(AppColors.BG_WHITE)
              .selectedColor(AppColors.PRIMARY_ORANGE))
            .loop(true)

            // 功能图标区域
            Row() {
              this.FunctionIcon($r('app.media.select1'), '网校课程', () => {
                router.pushUrl({ url: PageRoutes.ONLINE_SCHOOL_COURSE })
              })
              this.FunctionIcon($r('app.media.select2'), '精选题库', () => {
                router.pushUrl({ url: PageRoutes.QUESTION_BANK })
              })
              this.FunctionIcon($r('app.media.select3'), '备考教材', () => {
                router.pushUrl({ url: PageRoutes.EXAM_MATERIAL })
              })
              this.FunctionIcon($r('app.media.select4'), '直播大厅', () => {
                router.pushUrl({ url: PageRoutes.LIVE_HALL })
              })
            }
            .width('90%')
            .justifyContent(FlexAlign.SpaceAround)
            .margin({ top: 20 })

            // 热门视频标题
            Row() {
              Text('')
                .width(4)
                .height(20)
                .backgroundColor(AppColors.PRIMARY_ORANGE)
                .borderRadius(2)

              Text('热门视频')
                .fontSize(18)
                .fontWeight(FontWeight.Bold)
                .margin({ left: 10 })
            }
            .width('90%')
            .margin({ top: 30 })
            .alignItems(VerticalAlign.Center)

            // 热门视频列表
            Column() {
              ForEach(this.videoList, (item: VideoItem, index: number) => {
                Row() {
                  Column() {
                    Text(item.title)
                      .fontSize(16)
                      .fontWeight(FontWeight.Bold)
                      .fontColor(AppColors.TEXT_PRIMARY)
                      .margin({ bottom: 8 })

                    Text(item.description)
                      .fontSize(14)
                      .fontColor(AppColors.TEXT_SECONDARY)
                      .maxLines(2)
                      .textOverflow({ overflow: TextOverflow.Ellipsis })
                  }
                  .layoutWeight(1)
                  .alignItems(HorizontalAlign.Start)

                  Image(item.imageResource)
                    .width(100)
                    .height(70)
                    .borderRadius(5)
                    .margin({ left: 10 })
                }
                .width('100%')
                .padding(15)
                .backgroundColor(AppColors.BG_WHITE)
                .borderRadius(10)
                .margin({ bottom: 10 })
                .onClick(() => {
                  router.pushUrl({
                    url: PageRoutes.VIDEO_DETAIL,
                    params: {
                      title: item.title,
                      description: item.description,
                      videoIndex: index
                    }
                  })
                })
              }, (item: VideoItem, index: number) => `video_${index}`)
            }
            .width('90%')
            .margin({ top: 15 })
          }
          .width('100%')
          .alignItems(HorizontalAlign.Center)
        }
        .layoutWeight(1)
        .scrollBar(BarState.Off)

        // 底部导航栏
        BottomNavBar({
          currentIndex: this.currentIndex,
          onTabChange: (index: number) => {
            this.currentIndex = index
          }
        })
      }
      .width('100%')
      .height('100%')
      .backgroundColor(AppColors.BG_GRAY)

    }
    .width('100%')
    .height('100%')
  }

  @Builder
  FunctionIcon(imageResource: Resource, title: string, onClick?: () => void) {
    Column() {
      Image(imageResource)
        .width(50)
        .height(50)

      Text(title)
        .fontSize(12)
        .fontColor(AppColors.TEXT_PRIMARY)
        .margin({ top: 8 })
    }
    .alignItems(HorizontalAlign.Center)
    .onClick(() => {
      if (onClick) {
        onClick()
      }
    })
  }
}
