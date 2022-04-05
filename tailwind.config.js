module.exports = {
  content: [
    "./index.html",
    "./src/**/*.{vue,js,ts,jsx,tsx}",
  ],
  theme: {

    extend: {
      colors: {
        themePrimary: '#FCF9FC',
        themeSecondary: '#111637',
        themeTertiary: '#FCC93C',
        themeQuaternary: '#3FA7D8',
        themeQuaternaryDarker: '#3fa7d866',
        themeSecondaryDarker: '#3fa7d81a'
      },
    },
  },
  plugins: [],
}
