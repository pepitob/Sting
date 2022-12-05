import { Controller } from "@hotwired/stimulus"
import CircleProgress from 'js-circle-progress'

// Connects to data-controller="CircleProgress"
export default class extends Controller {
  static targets =["graph", "progress"]

  connect() {
    this.chart = new CircleProgress(this.graphTarget, this.data, )
  }
  // { value: 20, max: 100, }

  get data() {
    let data = { value: this.progressTarget.dataset.value, max:100, textFormat:'percent' }
    return data
  }
}
