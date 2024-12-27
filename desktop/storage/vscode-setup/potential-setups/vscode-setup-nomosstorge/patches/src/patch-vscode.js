const sidebar = document.querySelector('.sidebar')
const sidebarTitle = document.querySelector('.sidebar .composite.title h2')

const observer = new MutationObserver(mutations => {
  mutations.forEach(mutation => {
    const { target } = mutation

    if (target.nodeType !== 1) {
      return
    }

    if (target === sidebarTitle) {
      target.textContent = sidebarTitle.textContent.replace(/^Explorer:\s/, '')

      return
    }

    if (!target.classList.contains('actions-container')) {
      return
    }

    const titleActions = target.closest('.title-actions')

    if (!titleActions) {
      return
    }

    const noChild = target.childNodes.length === 0

    titleActions.classList.toggle('pl_custom_hidden', noChild)

    const firstP = titleActions.closest('.sidebar').querySelector('.welcome-view-content p')

    if (!firstP) {
      return
    }

    firstP.classList.toggle('pl_custom_no_margin_top', noChild)
  })
})

observer.observe(sidebar, { subtree: true, childList: true })