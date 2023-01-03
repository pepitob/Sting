import { Controller } from "@hotwired/stimulus"
import CircleProgress from 'js-circle-progress'

// Connects to data-controller="CircleProgress"
export default class extends Controller {

  connect() {
    if (this.element.hasChildNodes()) {
      this.element.innerHTML = '';
    }
    new CircleProgress(this.element, this.data)
  }
  // { value: 20, max: 100, }

  get data() {
    let data = { value: this.element.dataset.value, max:100, textFormat:'percent' }
    return data
  }
}
