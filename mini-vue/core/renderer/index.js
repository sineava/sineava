// vdom -> dom
export function mountElement(vnode, container) {
  const { tag, props, children } = vnode
  // tag
  const el = vnode.el = document.createElement(tag)
  // props
  if (props) {
    for (const key in props) {
      el.setAttribute(key, props[key])
    }
  }
  // children
  if (typeof children === 'string') {
    const textNode = document.createTextNode(children)
    el.appendChild(textNode)
  } else if (Array.isArray(children)) {
    children.forEach(v => mountElement(v, el))
  }
  container.append(el)
}

// diff n1(old) n2(new)
export function diff(n1, n2) {
  if (n1.tag !== n2.tag) {
    n1.el.replaceWidth(document.createElement(n2.tag))
  } else {
    const el = (n2.el = n1.el)
    const { props: oldProps } = n1
    const { props: newProps } = n2
    if (newProps && oldProps) {
      Object.keys(newProps).forEach(key => {
        const newVal = newProps[key]
        const oldVal = oldProps[key]
        if (newVal !== oldVal) {
          el.setAttribute(key, newVal)
        }
      })
    }
    if (oldProps) {
      Object.keys(oldProps).forEach(key => {
        if (!newProps[key]) {
          el.removeAttribute(key)
        }
      })
    }

    const { children: oldChildren } = n1
    const { children: newChildren } = n2

    if (typeof newChildren === 'string') {
      if (typeof oldChildren === 'string') {
        if (newChildren !== oldChildren) {
          el.textContent = newChildren
        }
      } else if (Array.isArray(oldChildren)) {
        el.textContent = newChildren
      }
    } else if (Array.isArray(newChildren)) {
      if (typeof oldChildren === 'string') {
        el.textContent = ''
        mountElement(n2, el)
      } else if (Array.isArray(newChildren)) {
        const length = Math.min(newChildren.length, oldChildren.length)
        for(let i = 0; i < length;i++) {
          const newVnode = newChildren[i]
          const oldVnode = oldChildren[i]
          diff(oldVnode, newVnode)
        }

        if (newChildren.length > length) {
          // 创建节点
          for (let index = length; index < newChildren.length; index++) {
            const newVnode = newChildren[index]
            mountElement(newVnode)
          }
        }
        
        if (oldChildren.length > length) {
          // 删除节点
          for (let index = length; index < oldChildren.length; index++) {
            const oldVnode = oldChildren[index]
            oldVnode.el.parent.removeChild(oldVnode.el)
          }
        }
      }
    }
  }
}