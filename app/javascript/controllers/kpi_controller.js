import { Controller } from "@hotwired/stimulus"
import { afterMain } from "@popperjs/core"
import complete_task_controller from "./complete_task_controller"

// Connects to data-controller="kpi"
export default class extends Controller {

  static targets =["kpitext", "badge"]
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

  adjustBadge(){
    console.log("I will adjust badge")
    const url = "/user_tasks/completed"
    // this.element.innerText = parseInt(this.element.innerText)++
    fetch(url, {headers: {"Accept": "application/json"}})
      .then(response => response.json())
      .then((data) => {
        this.badgeTarget.innerHTML = ""
        this.#generateTextForBadgeInHTML(data["completed"])
      })
  }

  #generateTextInHTML(number) {
    if (number == 0) {
      this.kpitextTarget.insertAdjacentHTML("afterbegin", (
        `<h4 class="text-center mt-2 mb-5">
        No tasks completed yet!</h4>
        <div class="mb-2 text-center card">
          <h3 class="mt-3 mb-1">Your score:</h3>
          <h6 class="d-inline text-center" >${number * 100}</h6>
          <h3 class="mt-3 d-inline">points</h3>
        </div>`))
    } else if (number == 1) {
      this.kpitextTarget.insertAdjacentHTML("afterbegin", (
        `<h4 class="text-center mt-2 mb-5">
          Congrats! You have 1 adventure completed!
        </h4>
        <div class="mb-2 text-center card">
          <h3 class="mt-3 mb-1">Your score:</h3>
          <h6 class="d-inline text-center" >${number * 100}</h6>
          <h3 class="mt-3 d-inline">points</h3>
        </div>`))
    } else {
      this.kpitextTarget.insertAdjacentHTML("afterbegin", (
        `<h4 class="text-center mt-2 mb-5">
          Congrats! You have ${number} adventures completed!
        </h4>
        <div class="mb-2 text-center card">
          <h3 class="mt-3 mb-1">Your score:</h3>
          <h6 class="d-inline text-center" >${number * 100}</h6>
          <h3 class="mt-3 d-inline">points</h3>
        </div>`));
    }
  }

  #generateTextForBadgeInHTML(number) {
    if (number == 0) {
      this.badgeTarget.insertAdjacentHTML("afterbegin", (
        `<div style="height:150px d-flex justify-content-center">
          <i class="fa-regular fa-circle-play ms-4 mt-3" style="font-size: 7em"></i>
          <h3 class="text-center mt-2 ">Let's get started!</h3>
          </div>`))
      } else if (number > 4) {
      this.badgeTarget.insertAdjacentHTML("afterbegin", (
        `<div style="height:160px">
          <img src="https://res.cloudinary.com/elmette/image/upload/v1662562895/0794B1B6-58D0-44E2-A522-1135E53B3BEC_1_105_c_re5kll.jpg" alt="trophy", width: 180, class="img-center">
          </div>
          <h3 class="text-center">You're a real adventurer!</h3>`))
    } else {
      this.badgeTarget.insertAdjacentHTML("afterbegin", (
        `<div style="height:160px">
          <img src="https://res.cloudinary.com/elmette/image/upload/v1662561898/firststep_dl2eak.png" alt="firststep", width: 150, class="img-center-steps">
        </div>
        <h3 class="text-center m-0">Nice Job!</h3>`));
    }
  }
}
