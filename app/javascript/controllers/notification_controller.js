import { Controller } from "@hotwired/stimulus"
import { createConsumer } from "@rails/actioncable"

export default class extends Controller {
  static values = { userId: Number }
  static targets = ["notification"]

  connect() {
    console.log(`connected bitch`)
  }
}
