import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="insert-message"
export default class extends Controller {
  static targets = ["form", "messages"]
  connect() {
   // this.messagesTarget.scrollTo(0, this.messagesTarget.scrollHeight)
    this.messagesTarget.scroll({top: this.messagesTarget.scrollHeight, behaviour: "smooth"})
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
        console.log(data.inserted_item)
        this.messagesTarget.scrollTo(0, this.messagesTarget.scrollHeight)
        this.formTarget.outerHTML = data.form
      })
  }
}

// window.scrollTo(0, document.querySelector('.messagebox').querySelector(".allmessages").scrollHeight)
