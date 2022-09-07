import { Controller } from "@hotwired/stimulus"
// import { LibManifestPlugin } from "webpack";

// Connects to data-controller="complete-task"
export default class extends Controller {
  static targets = ["form", "celebrate"]

  connect() {
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

    if (value == true) {
      this.#displayCelebration(this.celebrateTarget)
    }

    const updateEvent = new CustomEvent("adjust-kpi")
    window.dispatchEvent(updateEvent)
  }

  #displayCelebration(target) {
    target.classList.remove("d-none")
    setTimeout(() => {
      target.classList.add("d-none")
    }, 2000);
  }

}
