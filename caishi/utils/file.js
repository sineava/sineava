export const pathToBase64 = (path) => {
  return new Promise((resolve, reject) => {
    plus.io.resolveLocalFileSystemURL(path, entry => {
      entry.file(file => {
        const fileReader = new plus.io.FileReader()
        fileReader.readAsDataURL(file)
        fileReader.onload = data => resolve(data.target.result)
        fileReader.onerror = error => reject(error)
      })
    })
  })
  
}