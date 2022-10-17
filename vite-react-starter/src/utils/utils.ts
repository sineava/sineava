const tempature = {
  // 华氏度->摄氏度
  toCelsius(fahrenheit: number) {
    return fahrenheit ? Math.round(((fahrenheit - 32) * 5 / 9) * 1000) / 1000 : ''
  },
  // 摄氏度->华氏度
  toFahrenheit(celsius: number) {
    return celsius ? Math.round(((celsius * 9 / 5) + 32) * 1000) / 1000 : ''
  }
}

export {
  // 天气相关工具
  tempature
}