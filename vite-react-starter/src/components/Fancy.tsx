export default (props: any) => {
  return (
    <div style={{ color: props.color }}>
      { props.children } --- { props.right }
    </div>
  )
}