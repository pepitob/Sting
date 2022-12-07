import { Controller } from "@hotwired/stimulus"
import flatpickr from "flatpickr";
import rangePlugin from "flatpickr/dist/plugins/rangePlugin";

// Connects to data-controller="flatpickr"
export default class extends Controller {
  connect() {
    flatpickr(this.element, {
        // altInput: true,
        plugins: [new rangePlugin({
          input: "#challenge_end_date"
        })]
    });
  }
}


//start_date.flatpickr({minDate: "today"})
