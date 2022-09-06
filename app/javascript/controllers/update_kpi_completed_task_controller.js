import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="update-kpi-completed-task"
export default class extends Controller {
  static targets = ["items"]

  connect() {
  }
}
