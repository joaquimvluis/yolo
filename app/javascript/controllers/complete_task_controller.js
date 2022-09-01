import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="complete-task"
export default class extends Controller {
  static targets = ["form"]
  connect() {
    console.log("CONNECTED")
  }

  update(event) {
    event.preventDefault();
    event.stopPropagation();

    const csrfToken = document.querySelector("[name='csrf-token']").content

    const url = this.formTarget.action
    // const data = new FormData(this.formTarget)
    const value = event.target.checked

    // //Rails.fire(this.element, 'change')
    fetch(url, {
      method: "PATCH",
      headers: {
        "X-CSRF-Token": csrfToken,
        "Content-Type": "application/json"
      },
      body: JSON.stringify({ user_task: { completed: value }})
    })
}
}
