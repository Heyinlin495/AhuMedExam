import { router } from '@kit.ArkUI'
import { http } from '@kit.NetworkKit'
import { AppColors } from '../constants/AppConstants'
import { ApiConfig } from '../config/ApiConfig'
import { BottomNavBar } from '../components/BottomNavBar'

@Observed
class ChatMessage {
  id: number
  content: string
  isAI: boolean

  constructor(id: number, content: string, isAI: boolean) {
    this.id = id
    this.content = content
    this.isAI = isAI
  }
}

interface ApiMessage {
  role: string
  content: string
}

interface ApiRequestBody {
  model: string
  messages: ApiMessage[]
}

@Entry
@Component
struct AIAssistantPage {
  @State messageList: ChatMessage[] = []
  @State inputText: string = ''
  @State isLoading: boolean = false
  @State currentIndex: number = 1
  @State isInputFocused: boolean = true

  private nextId: number = 1

  private scroller: Scroller = new Scroller()

  build() {
    Column() {
      // 标题区域
      Column() {
        Text('我的AI小助手')
          .fontSize(26)
          .fontColor(AppColors.BG_WHITE)
          .fontWeight(FontWeight.Bold)

        Text('使用阿里通义千问API进行智能问答')
          .fontSize(14)
          .fontColor('#E0E0FF')
          .margin({ top: 6 })
      }
      .width('100%')
      .padding({ top: 20, bottom: 16 })
      .backgroundColor(AppColors.PRIMARY_PURPLE)
      .alignItems(HorizontalAlign.Center)

      // 聊天区域
      List({ scroller: this.scroller, space: 16 }) {
        if (this.messageList.length === 0) {
          ListItem() {
            Column() {
              Circle()
                .width(60)
                .height(60)
                .fill('#E8E8FF')
              Text('有什么想问的？')
                .fontSize(16)
                .fontColor(AppColors.TEXT_HINT)
                .margin({ top: 16 })
            }
            .width('100%')
            .height(300)
            .justifyContent(FlexAlign.Center)
            .alignItems(HorizontalAlign.Center)
          }
        } else {
          ForEach(this.messageList, (item: ChatMessage) => {
            ListItem() {
              if (item.isAI) {
                Row() {
                  Circle()
                    .width(32)
                    .height(32)
                    .fill(AppColors.PRIMARY_PURPLE)
                  Column() {
                    Text('通义千问')
                      .fontSize(12)
                      .fontColor(AppColors.TEXT_TERTIARY)
                      .margin({ bottom: 4 })
                    Text(item.content)
                      .fontSize(15)
                      .fontColor(AppColors.TEXT_PRIMARY)
                      .lineHeight(24)
                  }
                  .layoutWeight(1)
                  .alignItems(HorizontalAlign.Start)
                  .padding(12)
                  .backgroundColor(AppColors.BG_GRAY)
                  .borderRadius({ topLeft: 4, topRight: 12, bottomLeft: 12, bottomRight: 12 })
                }
                .width('100%')
                .alignItems(VerticalAlign.Top)
              } else {
                Row() {
                  Blank()
                  Column() {
                    Text(item.content)
                      .fontSize(15)
                      .fontColor(AppColors.BG_WHITE)
                      .lineHeight(24)
                  }
                  .backgroundColor(AppColors.PRIMARY_PURPLE)
                  .padding(12)
                  .borderRadius({ topLeft: 12, topRight: 4, bottomLeft: 12, bottomRight: 12 })
                  .constraintSize({ maxWidth: '80%' })
                }
                .width('100%')
              }
            }
            .padding({ left: 14, right: 14 })
          }, (item: ChatMessage) => item.id.toString())
        }
      }
      .layoutWeight(1)
      .width('100%')
      .scrollBar(BarState.Off)
      .edgeEffect(EdgeEffect.Spring)
      .backgroundColor(AppColors.BG_WHITE)

      // 输入区域
      Row() {
        TextArea({ placeholder: '请输入你的问题', text: this.inputText })
          .layoutWeight(1)
          .height(72)
          .fontSize(15)
          .fontColor(AppColors.TEXT_PRIMARY)
          .placeholderColor(AppColors.TEXT_HINT)
          .backgroundColor(AppColors.BG_WHITE)
          .borderRadius(8)
          .border({ width: 1, color: AppColors.BORDER_INPUT })
          .padding(12)
          .focusable(this.isInputFocused)
          .onChange((value: string) => {
            this.inputText = value
          })

        Column() {
          Text('➤')
            .fontSize(20)
            .fontColor(AppColors.BG_WHITE)
          Text('发送')
            .fontSize(12)
            .fontColor(AppColors.BG_WHITE)
            .margin({ top: 2 })
        }
        .width(56)
        .height(72)
        .backgroundColor(this.inputText.length > 0 ? AppColors.PRIMARY_PURPLE : '#B0B0E0')
        .borderRadius(8)
        .justifyContent(FlexAlign.Center)
        .alignItems(HorizontalAlign.Center)
        .margin({ left: 8 })
        .onClick(() => {
          if (!this.isLoading && this.inputText.length > 0) {
            this.sendMessage()
          }
        })
      }
      .width('100%')
      .padding({ left: 14, right: 14, top: 8, bottom: 8 })
      .alignItems(VerticalAlign.Bottom)
      .backgroundColor(AppColors.BG_WHITE)

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
    .backgroundColor(AppColors.BG_WHITE)
  }

  private async sendMessage() {
    if (this.inputText === '') {
      return
    }

    const userMessage = new ChatMessage(this.nextId++, this.inputText, false)
    this.messageList = [...this.messageList, userMessage]

    const userQuestion: string = this.inputText
    this.inputText = ''
    this.isLoading = true

    this.isInputFocused = false
    setTimeout(() => {
      this.isInputFocused = true
    }, 300)

    const loadingId: number = this.nextId++
    const loadingMsg = new ChatMessage(loadingId, '请稍等，AI正在思考...', true)
    this.messageList = [...this.messageList, loadingMsg]

    this.scroller.scrollEdge(Edge.Bottom)

    try {
      const httpRequest = http.createHttp()
      const apiMsg: ApiMessage = { role: 'user', content: userQuestion }
      const apiMessages: ApiMessage[] = [apiMsg]
      const reqBody: ApiRequestBody = { model: ApiConfig.MODEL, messages: apiMessages }
      const requestBody: string = JSON.stringify(reqBody)

      console.info('AI助手', '请求地址: ' + ApiConfig.API_URL)
      console.info('AI助手', '请求体: ' + requestBody)

      const response = await httpRequest.request(ApiConfig.API_URL, {
        method: http.RequestMethod.POST,
        header: {
          'Authorization': `Bearer ${ApiConfig.API_KEY}`,
          'Content-Type': 'application/json'
        },
        extraData: requestBody,
        connectTimeout: 10000,
        readTimeout: 30000
      })

      console.info('AI助手', '响应码: ' + response.responseCode)
      console.info('AI助手', '响应内容: ' + (response.result as string))

      if (response.responseCode === 200) {
        const result: Record<string, Object> = JSON.parse(response.result as string) as Record<string, Object>
        console.info('AI助手', '解析result成功')
        const choices = result['choices'] as Array<Record<string, Object>>
        console.info('AI助手', 'choices类型: ' + typeof choices + ', 长度: ' + choices.length)
        if (choices && choices.length > 0) {
          const choiceObj: Record<string, Object> = choices[0] as Record<string, Object>
          const messageObj: Record<string, Object> = choiceObj['message'] as Record<string, Object>
          const aiContent: string = messageObj['content'] as string
          console.info('AI助手', 'AI回复: ' + aiContent)
          // 使用setTimeout确保在UI线程上更新状态
          const aiMsg = new ChatMessage(this.nextId++, aiContent, true)
          const newList: ChatMessage[] = this.messageList.filter((item: ChatMessage) => item.id !== loadingId)
          newList.push(aiMsg)
          setTimeout(() => {
            this.messageList = newList
            console.info('AI助手', '消息列表更新完成, 长度: ' + this.messageList.length)
            this.scroller.scrollEdge(Edge.Bottom)
          }, 0)
        } else {
          const newList: ChatMessage[] = this.messageList.filter((item: ChatMessage) => item.id !== loadingId)
          newList.push(new ChatMessage(this.nextId++, '未获取到回复内容', true))
          setTimeout(() => {
            this.messageList = newList
          }, 0)
        }
      } else {
        const rawResult: string = response.result as string
        console.error('AI助手', '请求失败: ' + rawResult)
        const newList: ChatMessage[] = this.messageList.filter((item: ChatMessage) => item.id !== loadingId)
        newList.push(new ChatMessage(this.nextId++, '请求失败(' + response.responseCode + ')', true))
        setTimeout(() => {
          this.messageList = newList
        }, 0)
      }
      httpRequest.destroy()
    } catch (error) {
      const errStr: string = String(error)
      console.error('AI助手', '异常: ' + errStr)
      const newList: ChatMessage[] = this.messageList.filter((item: ChatMessage) => item.id !== loadingId)
      newList.push(new ChatMessage(this.nextId++, '网络异常: ' + errStr, true))
      setTimeout(() => {
        this.messageList = newList
      }, 0)
    } finally {
      this.isLoading = false
    }

    this.scroller.scrollEdge(Edge.Bottom)
  }
}
