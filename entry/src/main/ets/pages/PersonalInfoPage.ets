import { router } from '@kit.ArkUI'
import { preferences } from '@kit.ArkData'
import { common } from '@kit.AbilityKit'
import { AppColors, PageRoutes } from '../constants/AppConstants'
import { db } from '../utils/DatabaseHelper'

@Entry
@Component
struct PersonalInfoPage {
  @State username: string = ''
  @State phone: string = ''
  @State email: string = ''
  @State gender: string = '男'
  @State birthday: string = '1995-06-15'
  @State address: string = ''
  @State avatarIndex: number = 0
  @State showActionSheet: boolean = false

  private context: common.UIAbilityContext | null = null

  // 预设头像列表
  private avatarList: Resource[] = [
    $r('app.media.logo'),
    $r('app.media.tiger'),
    $r('app.media.classIcon')
  ]

  async aboutToAppear() {
    const params = router.getParams() as Record<string, Object>
    if (params && params['username']) {
      this.username = params['username'] as string
    }

    this.context = getContext(this) as common.UIAbilityContext

    // 从数据库读取手机号
    try {
      await db.init(this.context)
      const phone: string = await db.getPhone(this.username)
      if (phone.length > 0) {
        this.phone = phone
      }
    } catch (err) {
      console.error('Failed to load phone:', err)
    }

    // 从 preferences 读取其他个人信息
    try {
      const prefs = await preferences.getPreferences(this.context, `profile_${this.username}`)
      this.email = await prefs.get('email', '') as string
      this.gender = await prefs.get('gender', '男') as string
      this.birthday = await prefs.get('birthday', '1995-06-15') as string
      this.address = await prefs.get('address', '') as string
      this.avatarIndex = await prefs.get('avatarIndex', 0) as number
    } catch (err) {
      console.error('Failed to load profile:', err)
    }
  }

  // 保存个人信息
  async saveProfile() {
    if (!this.context) {
      return
    }
    try {
      const prefs = await preferences.getPreferences(this.context, `profile_${this.username}`)
      await prefs.put('email', this.email)
      await prefs.put('gender', this.gender)
      await prefs.put('birthday', this.birthday)
      await prefs.put('address', this.address)
      await prefs.put('avatarIndex', this.avatarIndex)
      await prefs.flush()
      console.info('保存成功')
    } catch (err) {
      console.error('Failed to save profile:', err)
    }
  }

  build() {
    Stack({ alignContent: Alignment.Bottom }) {
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

          Text('个人信息')
            .fontSize(18)
            .fontColor(AppColors.TEXT_PRIMARY)
            .fontWeight(FontWeight.Bold)

          Blank()

          Text('保存')
            .fontSize(16)
            .fontColor(AppColors.PRIMARY_ORANGE)
            .onClick(async () => {
              await this.saveProfile()
              router.back()
            })
        }
        .width('100%')
        .height(50)
        .padding({ left: 5, right: 15 })
        .alignItems(VerticalAlign.Center)
        .backgroundColor(AppColors.BG_WHITE)

        Scroll() {
          Column() {
            // 头像区域
            Column() {
              Image(this.avatarList[this.avatarIndex])
                .width(80)
                .height(80)
                .borderRadius(40)
                .objectFit(ImageFit.Cover)

              Text('点击修改头像')
                .fontSize(14)
                .fontColor(AppColors.PRIMARY_BLUE)
                .margin({ top: 10 })
            }
            .width('100%')
            .padding(20)
            .alignItems(HorizontalAlign.Center)
            .backgroundColor(AppColors.BG_WHITE)
            .onClick(() => {
              this.showActionSheet = true
            })

            // 基本信息
            Column() {
              Text('基本信息')
                .fontSize(16)
                .fontWeight(FontWeight.Bold)
                .fontColor(AppColors.TEXT_PRIMARY)
                .width('100%')
                .padding({ left: 15, top: 15, bottom: 10 })

              this.InfoItem('用户名', this.username, false, (value: string) => {
                this.username = value
              })

              this.InfoItem('手机号', this.phone, false, (value: string) => {
                this.phone = value
              })

              this.InfoItem('邮箱', this.email, true, (value: string) => {
                this.email = value
              })

              this.InfoItem('性别', this.gender, true, (value: string) => {
                this.gender = value
              })

              this.InfoItem('生日', this.birthday, true, (value: string) => {
                this.birthday = value
              })

              this.InfoItem('地址', this.address, true, (value: string) => {
                this.address = value
              })
            }
            .width('100%')
            .backgroundColor(AppColors.BG_WHITE)
            .margin({ top: 10 })

            // 账号安全
            Column() {
              Text('账号安全')
                .fontSize(16)
                .fontWeight(FontWeight.Bold)
                .fontColor(AppColors.TEXT_PRIMARY)
                .width('100%')
                .padding({ left: 15, top: 15, bottom: 10 })

              this.SecurityItem('修改密码', () => {
                router.pushUrl({ url: PageRoutes.CHANGE_PASSWORD })
              })

              this.SecurityItem('绑定手机', () => {
                router.pushUrl({ url: PageRoutes.BIND_PHONE })
              })

              this.SecurityItem('绑定微信', () => {
                router.pushUrl({ url: PageRoutes.BIND_WECHAT })
              })
            }
            .width('100%')
            .backgroundColor(AppColors.BG_WHITE)
            .margin({ top: 10 })

            // 退出登录按钮
            Text('退出登录')
              .fontSize(16)
              .fontColor(AppColors.ERROR_RED)
              .width('90%')
              .height(45)
              .textAlign(TextAlign.Center)
              .backgroundColor(AppColors.BG_WHITE)
              .borderRadius(8)
              .margin({ top: 30 })
              .onClick(() => {
                router.pushUrl({ url: PageRoutes.LOGIN })
              })
          }
          .width('100%')
        }
        .layoutWeight(1)
        .scrollBar(BarState.Off)
        .backgroundColor(AppColors.BG_GRAY)
      }
      .width('100%')
      .height('100%')

      // 底部弹出选择框
      if (this.showActionSheet) {
        Column() {
          Column()
            .width('100%')
            .layoutWeight(1)
            .backgroundColor(AppColors.OVERLAY_SEMI)
            .onClick(() => {
              this.showActionSheet = false
            })

          Column() {
            Text('选择头像')
              .fontSize(18)
              .fontWeight(FontWeight.Bold)
              .fontColor(AppColors.TEXT_PRIMARY)
              .width('100%')
              .textAlign(TextAlign.Center)
              .padding({ top: 20, bottom: 15 })

            Grid() {
              ForEach(this.avatarList, (item: Resource, index: number) => {
                GridItem() {
                  Image(item)
                    .width(60)
                    .height(60)
                    .borderRadius(30)
                    .objectFit(ImageFit.Cover)
                    .border({
                      width: this.avatarIndex === index ? 2 : 0,
                      color: AppColors.PRIMARY_ORANGE
                    })
                }
                .onClick(() => {
                  this.avatarIndex = index
                  this.showActionSheet = false
                })
              }, (item: Resource, index: number) => `avatar_${index}`)
            }
            .columnsTemplate('1fr 1fr 1fr')
            .rowsGap(15)
            .columnsGap(15)
            .width('90%')
            .padding({ bottom: 20 })

            Text('取消')
              .fontSize(16)
              .fontColor(AppColors.TEXT_PRIMARY)
              .width('100%')
              .height(50)
              .textAlign(TextAlign.Center)
              .backgroundColor(AppColors.BG_WHITE)
              .onClick(() => {
                this.showActionSheet = false
              })
          }
          .width('100%')
          .backgroundColor(AppColors.BG_WHITE)
          .borderRadius({ topLeft: 12, topRight: 12 })
        }
        .width('100%')
        .height('100%')
      }
    }
    .width('100%')
    .height('100%')
  }

  @Builder
  InfoItem(label: string, value: string, editable: boolean, onChange: (value: string) => void) {
    Row() {
      Text(label)
        .fontSize(15)
        .fontColor(AppColors.TEXT_PRIMARY)
        .width(80)

      TextInput({ text: value, placeholder: `请输入${label}` })
        .layoutWeight(1)
        .fontSize(15)
        .fontColor(editable ? AppColors.TEXT_SECONDARY : AppColors.TEXT_TERTIARY)
        .backgroundColor('transparent')
        .enabled(editable)
        .onChange(onChange)
    }
    .width('100%')
    .height(50)
    .padding({ left: 15, right: 15 })
    .border({ width: { bottom: 1 }, color: AppColors.BORDER_LIGHT })
  }

  @Builder
  SecurityItem(label: string, onClick: () => void) {
    Row() {
      Text(label)
        .fontSize(15)
        .fontColor(AppColors.TEXT_PRIMARY)

      Blank()

      Text('>')
        .fontSize(16)
        .fontColor(AppColors.TEXT_TERTIARY)
    }
    .width('100%')
    .height(50)
    .padding({ left: 15, right: 15 })
    .border({ width: { bottom: 1 }, color: AppColors.BORDER_LIGHT })
    .onClick(onClick)
  }
}
