// app/javascript/controllers/dropdown_controller.js
import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["menu"]

  connect() {
    // Bind the hide method once when controller connects
    this.boundHide = this.hide.bind(this)
  }

  toggle(event) {
    event.stopPropagation() // Prevent event from bubbling
    
    if (this.menuTarget.classList.contains("hidden")) {
      this.open()
    } else {
      this.close()
    }
  }

  open() {
    this.menuTarget.classList.remove("hidden")
    // Add click listener to document to close when clicking outside
    setTimeout(() => {
      document.addEventListener("click", this.boundHide)
    }, 0)
  }

  close() {
    this.menuTarget.classList.add("hidden")
    document.removeEventListener("click", this.boundHide)
  }

  hide(event) {
    // Don't hide if clicking inside the dropdown
    if (!this.element.contains(event.target)) {
      this.close()
    }
  }

  disconnect() {
    // Clean up event listener when controller disconnects
    document.removeEventListener("click", this.boundHide)
  }
}