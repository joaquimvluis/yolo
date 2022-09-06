import { Controller } from "@hotwired/stimulus"
import { afterMain } from "@popperjs/core"
import complete_task_controller from "./complete_task_controller"

// Connects to data-controller="kpi"
export default class extends Controller {

  static targets =["kpitext"]
  connect() {
    console.log("KPI Controller connected")
  }

  adjustNumber(){
    const url = "/user_tasks/completed"
    // this.element.innerText = parseInt(this.element.innerText)++
    fetch(url, {headers: {"Accept": "application/json"}})
      .then(response => response.json())
      .then((data) => {
        this.element.innerHTML = data["completed"]
      })
  }

  adjustNumberOpen(){
    const url = "/user_tasks/open"
    // this.element.innerText = parseInt(this.element.innerText)++
    fetch(url, {headers: {"Accept": "application/json"}})
      .then(response => response.json())
      .then((data) => {
        this.element.innerHTML = data["open"]
      })
  }

  adjustText(){
    // console.log("I will adjust text")
    const url = "/user_tasks/completed"
    // this.element.innerText = parseInt(this.element.innerText)++
    fetch(url, {headers: {"Accept": "application/json"}})
      .then(response => response.json())
      .then((data) => {
        this.kpitextTarget.innerHTML = ""
        this.#generateTextInHTML(data["completed"])
      })
    }

  #generateTextInHTML(number) {
    if (number == 0) {
      this.kpitextTarget.insertAdjacentHTML("afterbegin", '<p class="bio-text mt-4">Start working on your bucketlist</p>')
    } else if (number == 1) {
      this.kpitextTarget.insertAdjacentHTML("afterbegin", (
        `<p class="bio-text mt-4">
          <i class="fa-regular fa-party-horn"></i>
          Congrats! You have 1 adventure completed!
        </p>
        <div class="mb-5">
          <p class="bio-text mt-3 mb-1">Your score:</p>
          <h6 class="d-inline" >${number * 100}</h6>
          <p class="bio-text mt-3 d-inline">points</p>
        </div>`))
    } else {
      this.kpitextTarget.insertAdjacentHTML("afterbegin", (
        `<p class="bio-text mt-4">
          <i class="fa-regular fa-party-horn"></i>
          Congrats! You have ${number} adventures completed!
        </p>
        <div class="mb-5">
          <p class="bio-text mt-3 mb-1">Your score:</p>
          <h6 class="d-inline" >${number * 100}</h6>
          <p class="bio-text mt-3 d-inline">points</p>
        </div>`));
    }
  }


    // <% if @completed == 0 %>
    // <p class="bio-text mt-4">Start working on your bucketlist</p>
    // <% else %>
    //   <p class="bio-text mt-4"> <i class="fa-regular fa-party-horn"></i>Congrats! You have <%= pluralize @completed, "bucket-list-item" %> completed!</p>
    //   <div class="mb-5">
    //     <p class="bio-text mt-3 mb-1">Your score:</p>
    //     <h6 class="d-inline" ><%= @completed * 100 %></h6>
    //     <p class="bio-text mt-3 d-inline">points</p>
    //   </div>
    // <% end %>



}