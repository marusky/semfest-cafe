import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="alert-close"
export default class extends Controller {
  connect() {
    setTimeout(() => {
      this.element.click()
    }, 5000)
  }
}
