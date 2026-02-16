import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="share"
export default class extends Controller {
  static targets = ["buttonText", "feedback"]
  static values = { url: String }

  copy() {
    // Copiar URL para o clipboard
    navigator.clipboard.writeText(this.urlValue).then(() => {
      this.showFeedback()
    }).catch(err => {
      console.error('Erro ao copiar:', err)
      // Fallback para navegadores antigos
      this.fallbackCopy()
    })
  }

  showFeedback() {
    // Alterar texto do botão temporariamente
    const originalText = this.buttonTextTarget.textContent
    this.buttonTextTarget.textContent = "Transmitted!"
    
    // Mostrar feedback se existir
    if (this.hasFeedbackTarget) {
      this.feedbackTarget.classList.remove("hidden")
      this.feedbackTarget.classList.add("block")
    }
    
    // Voltar ao normal depois de 2 segundos
    setTimeout(() => {
      this.buttonTextTarget.textContent = originalText
      if (this.hasFeedbackTarget) {
        this.feedbackTarget.classList.add("hidden")
        this.feedbackTarget.classList.remove("block")
      }
    }, 2000)
  }

  fallbackCopy() {
    // Método alternativo para navegadores que não suportam clipboard API
    const textArea = document.createElement("textarea")
    textArea.value = this.urlValue
    textArea.style.position = "fixed"
    textArea.style.left = "-999999px"
    document.body.appendChild(textArea)
    textArea.select()
    
    try {
      document.execCommand('copy')
      this.showFeedback()
    } catch (err) {
      console.error('Fallback copy failed:', err)
      alert('Link: ' + this.urlValue)
    }
    
    document.body.removeChild(textArea)
  }
}


