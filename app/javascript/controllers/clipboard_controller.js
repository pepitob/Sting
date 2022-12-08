import { Controller } from "@hotwired/stimulus"
import Clipboard from 'stimulus-clipboard'

export default class extends Clipboard {
  connect() {
    // super.connect()
    this.element = console.log('Do what you want here.')
  }

  // Function to override on copy.
  copy() {}

  // Function to override when to input is copied.
  copied() {
    //
  }
}
