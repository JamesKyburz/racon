# racon-env

Resource Access Control for `process.env`

[![js-standard-style](https://img.shields.io/badge/code_style-standard-brightgreen.svg)](https://github.com/feross/standard)
[![build status](https://api.travis-ci.org/JamesKyburz/racon.svg)](https://travis-ci.org/JamesKyburz/racon)
[![downloads](https://img.shields.io/npm/dm/racon-env.svg)](https://npmjs.org/package/racon-env)
[![Greenkeeper badge](https://badges.greenkeeper.io/JamesKyburz/racon.svg)](https://greenkeeper.io/)

## usage

```javascript
require('racon-env')({
  'aws-sdk': {
    read: [
      /^AWS/,
      'HOME',
      /^AMAZON/
    ],
    write: []
  }
})
```

# license

[Apache License, Version 2.0](LICENSE)
