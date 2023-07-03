import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="spotlight"
export default class extends Controller {
  connect() {
    this.element.classList.add('first-show-number')

    setTimeout(() => {
      this.element.remove()
    }, 5000)
  }
}
