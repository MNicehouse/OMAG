import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="result"
export default class extends Controller {
  static targets = [ "hideable" ]
  connect() {
    this.toggleTargets();
    }
    toggleTargets () {
        setTimeout(() =>
        this.hideableTargets.forEach((el) => {
          el.hidden = !el.hidden
        }), 2000)
    }
  }
