'strict on'

const env = process.env
const exit = process.exit

module.exports = (whitelist = {}) => {
  process.env = new Proxy(env, {
    get (obj, prop) {
      if (isAllowed(whitelist, prop, 'read')) {
        return obj[prop]
      } else {
        return ''
      }
    },
    set (obj, prop, value) {
      if (isAllowed(whitelist, prop, 'write')) {
        obj[prop] = value
      }
    }
  })
}

function captureModule () {
  const { stack } = new Error()
  const frames = (stack || '').split(/\n/)

  for (const frame of frames) {
    if (frame.includes(__filename)) continue
    if (/\/node_modules\//.test(frame)) {
      return frame.split(/\/node_modules\//)[1].split(/\//)[0]
    }
  }
}

function isAllowed (whitelist, prop, type) {
  const module = captureModule()
  const policy = (whitelist[module] || { [type]: [] })[type] || []
  const allowed =
    !module ||
    policy === '*' ||
    policy.includes(prop) ||
    policy.filter(x => x instanceof RegExp).find(x => x.test(prop))
  if (!allowed) {
    try {
      process.stdout.write(
        `\n${module} does not have ${type} access to process.env.${prop}\n`
      )
    } catch (e) {}
    exit(1)
  } else {
    return true
  }
}
