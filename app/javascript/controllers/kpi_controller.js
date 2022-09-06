import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="kpi"
export default class extends Controller {
  connect() {
    console.log("KPI Controller connected")
  }

  adjustNumber(){
    const url = "/user_tasks/completed"
    // this.element.innerText = parseInt(this.element.innerText)++
    fetch(url, {headers: {"Accept": "application/json"}})
      .then(response => response.json())
      .then((data) => {
        this.element.innerHTML = data[:completed]
  })
  }

  // decrementNumber(){
  //   // this.element.innerText = parseInt(this.element.innerText)--
  //   console.log("decrementing")
  //   console.log(this.element.innerText)
  //   console.log(parseInt(this.element.innerText))
  // }

}
