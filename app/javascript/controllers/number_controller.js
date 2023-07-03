import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="number"
export default class extends Controller {
  connect() {
    this.element.classList.add('first-show-number')

    setTimeout(() => {
      this.element.classList.remove('first-show-number')
    }, 5000)
  }
}
