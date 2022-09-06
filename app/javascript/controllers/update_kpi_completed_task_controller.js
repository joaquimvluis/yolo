import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="update-kpi-completed-task"
export default class extends Controller {
  static targets = ["count"]

  connect() {
    console.log("CONNECTED")
  }

  update(event){
    // event.preventDefault();
    // setCount() {
    //   if (this.hasCountTarget) {
    //     const count = this.selectedCheckboxes.length;
    //     this.countTarget.innerHTML = `${count} selected`;
    //   }
    // }
  }
}
