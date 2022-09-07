import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="refresh-users-list"
export default class extends Controller {
  static values = {
    task: String
  }

  static targets = ["form", "list", "searchInput"]

  connect() {
    console.log(this.taskValue);
  }

  update(){
    const url = `${this.formTarget.action}?query=${this.searchInputTarget.value}`
    fetch(url, { headers: { 'Accept': 'text/plain' } })
    .then(response => response.text())
    .then((data => {
      this.listTarget.innerHTML = data;
    }))
  }

  sendTask(event) {
    event.preventDefault()
    const url = event.currentTarget.href + `?task_id=${this.taskValue}`
    console.log(url)
    window.location = url
  }
}
