import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="spotlight"
export default class extends Controller {
  connect() {
    this.element.classList.add('first-show-number')

    const bell = document.getElementById('bell')
    const bellAudio = new Audio(bell.src)
    bellAudio.play()

    setTimeout(() => {
      this.element.remove()
    }, 5000)
  }
}
