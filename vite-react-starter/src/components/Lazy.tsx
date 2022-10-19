import { lazy, Component, Suspense } from "react"

const Loading = lazy(() => import('./Loading'))
console.log(Loading)

export default class extends Component {
  render() {
    return (
      <Suspense fallback={<div>...loading</div>}>
        <Loading />
      </Suspense>
    )
  }
}