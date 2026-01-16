import { Controller } from "@hotwired/stimulus"
import { application } from "./application"
import { eagerLoadControllersFrom } from "@hotwired/stimulus-loading"
eagerLoadControllersFrom("controllers", application)


export default class extends Controller {
  static targets = ["list", "template"]

  add() {
    const content = this.templateTarget.innerHTML.replace(/NEW_RECORD/g, Date.now())
    this.listTarget.insertAdjacentHTML("beforeend", content)
  }

  remove(event) {
    const item = event.target.closest("[data-quote-items-target='item']")
    item.querySelector("input[name*='_destroy']").value = 1
    item.style.display = "none"
  }
}
