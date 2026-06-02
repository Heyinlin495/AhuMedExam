import { router } from '@kit.ArkUI'

@Entry
@Component
struct Index {
  @State message: string = 'Hello World';

  aboutToAppear() {
    // 应用启动时跳转到登录页面
    router.pushUrl({ url: 'pages/LoginPage' })
  }

  build() {
    RelativeContainer() {
      Text(this.message)
        .id('HelloWorld')
        .fontSize($r('app.float.page_text_font_size'))
        .fontWeight(FontWeight.Bold)
        .alignRules({
          center: { anchor: '__container__', align: VerticalAlign.Center },
          middle: { anchor: '__container__', align: HorizontalAlign.Center }
        })
        .onClick(() => {
          this.message = 'Welcome';
        })
    }
    .height('100%')
    .width('100%')
  }
}
