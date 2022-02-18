import Rails from "@rails/ujs"

// Send check boxes (and text areas) on change
const sendForm = (e) => {
  let form = e.target.closest("form")
  Rails.fire(form, 'submit')
}

const checkFields = document.querySelectorAll(".day-entry [type='checkbox']")
checkFields.forEach(field => field.addEventListener("change", sendForm))

// TODO: optimize with local storage and input change
const textFields = document.querySelectorAll(".day-entry .trix-content, .day-entry [type='text']")
textFields.forEach(field => field.addEventListener("keyup", sendForm))
textFields.forEach(field => field.addEventListener("blur", sendForm))

