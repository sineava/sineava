import { effectWatch } from './reactivity'
import { mountElement } from './renderer/index'

export function createApp(rootComponent) {
  return {
    mount(rootContainer) {
      const context = rootComponent.setup()
      let isMounted = false
      let prevSubTree
      effectWatch(() => {
        // const element = rootComponent.render(context)
        // rootContainer.append(element)
        const subTree = rootComponent.render(context)
        if (!isMounted) {
          isMounted = true
          rootContainer.innerHTML = ''
          mountElement(subTree, rootContainer)
        } else {
          diff(prevSubTree, context)
        }
        prevSubTree = subTree
      })
    }
  }
}