module.exports = () => new Promise((resolve, reject) => {
  process.env.DEBUG = 'yes'
  resolve()
})
