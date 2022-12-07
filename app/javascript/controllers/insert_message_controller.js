import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="insert-message"
export default class extends Controller {
  static targets = ["form", "messages"]
  connect() {
    console.log(this.formTarget)
    console.log(this.messagesTarget)
  }

  send(event) {
    event.preventDefault()

    fetch(this.formTarget.action, {
      method: "POST",
      headers: { "Accept": "application/json" },
      body: new FormData(this.formTarget)
    })
      .then(response => response.json())
      .then((data) => {
        this.messagesTarget.insertAdjacentHTML("beforeend", data.inserted_item)
        this.formTarget.outerHTML = data.form
        window.scrollTo(0, document.body.scrollHeight)
      })
  }
}
