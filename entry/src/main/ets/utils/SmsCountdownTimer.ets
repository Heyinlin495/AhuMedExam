// 短信验证码倒计时管理器
export class SmsCountdownTimer {
  private countdown: number = 0
  private timer: number = -1
  private onUpdate: (countdown: number, buttonText: string) => void
  private onComplete: () => void

  constructor(onUpdate: (countdown: number, buttonText: string) => void, onComplete: () => void) {
    this.onUpdate = onUpdate
    this.onComplete = onComplete
  }

  // 开始倒计时，返回是否成功启动
  start(phoneNumber: string): boolean {
    if (phoneNumber.length !== 11) {
      return false
    }

    // 如果已有定时器，先清除
    this.destroy()

    this.countdown = 60
    this.onUpdate(this.countdown, `${this.countdown}s后重试`)

    this.timer = setInterval(() => {
      this.countdown--
      if (this.countdown <= 0) {
        this.destroy()
        this.onComplete()
      } else {
        this.onUpdate(this.countdown, `${this.countdown}s后重试`)
      }
    }, 1000)

    return true
  }

  // 清除定时器
  destroy(): void {
    if (this.timer >= 0) {
      clearInterval(this.timer)
      this.timer = -1
    }
  }

  getCountdown(): number {
    return this.countdown
  }
}
