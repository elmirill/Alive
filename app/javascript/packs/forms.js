const toggleInputIcon = (e) => {
  let icon = e.target
  let button = icon.closest("label").querySelector("input")

  radioIcons.forEach(radio => {
    radio.querySelector("i").classList.remove("toggled")
  })
  icon.classList.add("toggled")
  button.checked = true
}

const checkInputIcons = () => {
  radioButtons.forEach(button => {
    if (button.checked) {
      icon = button.closest("label").querySelector("i")
      icon.classList.add("toggled")
    }
  })
}

const radioIcons = document.querySelectorAll(".radio-icons span")
const radioButtons = document.querySelectorAll(".radio-icons input")

window.addEventListener('load', checkInputIcons)
radioIcons.forEach(radio => radio.addEventListener("mouseup", toggleInputIcon))