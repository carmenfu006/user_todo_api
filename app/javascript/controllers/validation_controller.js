import { Controller } from "stimulus"

export default class extends Controller {
  static targets = [ 'field', 'message' ]

  submit(event) {
    event.preventDefault()
    console.log(this.element)
    if (this.fieldTarget.value == '') {
      this.messageTarget.innerHTML = 'Please fill in the required field.'
    } else {
      this.element.submit()
    }
  }
}