/** @type {import('tailwindcss').Config} */
module.exports = {
  content: [
    './src/**/*.{js,jsx,ts,tsx}'
  ],
  theme: {
    extend: {
      backgroundImage: {
        'bg-1': "url('/img/bg-1.png')",
        'bg-2': "url('/img/bg-2.png')",
        'bg-3': "url('/img/bg-3.png')",
        'bg-4': "url('/img/bg-4.png')",
        'bg-5': "url('/img/bg-5.png')",
        'bg-6': "url('/img/bg-6.png')"
      }
    },
  },
  plugins: [],
  variants: {
    extend: {
      backgroundColor: ['checked'],
      borderColor: ['checked']
    }
  }
}
