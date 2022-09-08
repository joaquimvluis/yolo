import { Controller } from "@hotwired/stimulus"
import { createConsumer } from "@rails/actioncable"

export default class extends Controller {
  static values = { userId: Number }
  static targets = ['body','close']

  connect() {
    this.channel = createConsumer().subscriptions.create(
      { channel: "NotificationChannel", id: this.userIdValue },
      { received: data => {
        this.bodyTarget.innerHTML=data
        this.closeTarget.classList.remove("d-none")
      }
    }
    )
  }

  clear() {
    this.bodyTarget.innerHTML=""
    this.closeTarget.classList.add("d-none")
  }
}
