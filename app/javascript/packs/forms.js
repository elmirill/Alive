import Rails from "@rails/ujs"

// Toggle radio button icons
// TODO: redo in CSS only
const toggleInputIcon = (e) => {
  let icon = e.target.closest("span")
  let button = icon.closest("label").querySelector("input")
  radioIcons.forEach(radio => {
    radio.classList.remove("toggled")
  })
  icon.classList.add("toggled")
  button.checked = true
}

const radioIcons = document.querySelectorAll(".radio-icons span")
radioIcons.forEach(radio => radio.addEventListener("mouseup", toggleInputIcon))


// Send check boxes (and text areas) on change
const sendForm = (e) => {
  let form = e.target.closest("form")
  // form.submit()
  Rails.fire(form, 'submit')
}

const checkFields = document.querySelectorAll(".day-entry [type='checkbox']")
checkFields.forEach(field => field.addEventListener("change", sendForm))

// TODO: optimize with local storage and input change
const textFields = document.querySelectorAll(".day-entry .trix-content")
textFields.forEach(field => field.addEventListener("keyup", sendForm))

