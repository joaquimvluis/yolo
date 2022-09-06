import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="refresh-users-list"
export default class extends Controller {
  static targets = ["form", "list", "searchInput"]

  connect() {
    console.log("refresh users list controller running!")
  }

  update(){
    const url = `${this.formTarget.action}?query=${this.searchInputTarget.value}`
    console.log(url)
    fetch(url, { headers: { 'Accept': 'text/plain' } })
    .then(response => response.text())
    .then((data => {
      console.log(data)
     this.listTarget.innerHTML = data;
    }))
  }
}
