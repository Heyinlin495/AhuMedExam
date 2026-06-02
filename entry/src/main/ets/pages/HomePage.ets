import { router } from '@kit.ArkUI'

interface VideoItem {
  title: string
  description: string
  imageResource: Resource
}

@Entry
@Component
struct HomePage {
  @State currentIndex: number = 0
  @State username: string = '何胤霖'

  // 轮播图数据
  private bannerList: Resource[] = [
    $r('app.media.info1'),
    $r('app.media.info2')
  ]

  // 热门视频数据
  private videoList: VideoItem[] = [
    {
      title: '医考宝典--脾脏触诊',
      description: '医考脾脏触诊学习视频：深入讲解关键内容。双手触诊时，检...',
      imageResource: $r('app.media.course1')
    },
    {
      title: '医考宝典-小儿急性阑尾炎',
      description: '小儿急性阑尾炎是小儿最常见的急腹症，也是医考中的重要内...',
      imageResource: $r('app.media.course2')
    },
    {
      title: '医考宝典-溶血性贫血',
      description: '医考学习视频之溶血性贫血：本视频全面深入讲解溶血性贫血...',
      imageResource: $r('app.media.course3')
    },
    {
      title: '医考宝典-心律失常',
      description: '医考学习视频之心律失常：该视频系统讲解心律失常这一常见...',
      imageResource: $r('app.media.course4')
    }
  ]

  build() {
    Column() {
      // 顶部导航栏
      Row() {
        Text('资讯')
          .fontSize(18)
          .fontColor('#333333')
          .fontWeight(FontWeight.Bold)

        Blank()

        Text(`欢迎您：${this.username}`)
          .fontSize(16)
          .fontColor('#FF6B00')

        Blank()

        Text('退出')
          .fontSize(16)
          .fontColor('#2196F3')
          .onClick(() => {
            router.pushUrl({ url: 'pages/LoginPage' })
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
            ForEach(this.bannerList, (item: Resource) => {
              Image(item)
                .width('90%')
                .height(130)
                .borderRadius(10)
                .objectFit(ImageFit.Fill)
            })
          }
          .width('90%')
          .height(130)
          .margin({ top: 10 })
          .autoPlay(true)
          .interval(3000)
          .indicator(Indicator.dot()
            .color('#FFFFFF')
            .selectedColor('#FF6B00'))
          .loop(true)

          // 功能图标区域
          Row() {
            this.FunctionIcon($r('app.media.select1'), '网校课程')
            this.FunctionIcon($r('app.media.select2'), '精选题库')
            this.FunctionIcon($r('app.media.select3'), '备考教材')
            this.FunctionIcon($r('app.media.select4'), '直播大厅')
          }
          .width('90%')
          .justifyContent(FlexAlign.SpaceAround)
          .margin({ top: 20 })

          // 热门视频标题
          Row() {
            // 使用Text模拟竖线，因为Divider不支持verticalAlign
            Text('')
              .width(4)
              .height(20)
              .backgroundColor('#FF6B00')
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
                    .fontColor('#333333')
                    .margin({ bottom: 8 })

                  Text(item.description)
                    .fontSize(14)
                    .fontColor('#666666')
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
              .backgroundColor('#FFFFFF')
              .borderRadius(10)
              .margin({ bottom: 10 })
            })
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
      Row() {
        this.TabItem($r('app.media.home2'), '首页', 0)
        this.TabItem($r('app.media.me1'), 'AI', 1)
      }
      .width('100%')
      .height(60)
      .backgroundColor('#FFFFFF')
      .border({ width: { top: 0.5 }, color: '#EEEEEE' })
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#F5F5F5')
  }

  @Builder
  FunctionIcon(imageResource: Resource, title: string) {
    Column() {
      Image(imageResource)
        .width(50)
        .height(50)

      Text(title)
        .fontSize(12)
        .fontColor('#333333')
        .margin({ top: 8 })
    }
    .alignItems(HorizontalAlign.Center)
  }

  @Builder
  TabItem(imageResource: Resource, title: string, index: number) {
    Column() {
      Image(imageResource)
        .width(24)
        .height(24)
        .fillColor(this.currentIndex === index ? '#FF6B00' : '#999999')

      Text(title)
        .fontSize(12)
        .fontColor(this.currentIndex === index ? '#FF6B00' : '#999999')
        .margin({ top: 4 })
    }
    .layoutWeight(1)
    .alignItems(HorizontalAlign.Center)
    .justifyContent(FlexAlign.Center)
    .onClick(() => {
      this.currentIndex = index
    })
  }
}
