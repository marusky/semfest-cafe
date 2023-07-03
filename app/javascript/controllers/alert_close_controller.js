import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="alert-close"
export default class extends Controller {
  static values = { url: String, shouldDelete: Boolean }

  connect() {
    setTimeout(() => {
      this.element.click()

      if (this.shouldDeleteValue) {
        const csrfToken = document.querySelector('meta[name="csrf-token"]').content

        fetch(this.urlValue, {
          method: "DELETE",
          headers: {
            "X-CSRF-Token": csrfToken
          }
        })
          .then(response => {
            if (response.ok) {
              //  all ok
            } else {
              // throw new Error("Error: " + response.status);
            }
          })
          .catch(error => {
            // console.error(error);
        });
      }
    }, 5000)
  }
}
