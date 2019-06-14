#!/usr/bin/env bash

set +e

node -e """
  require('../')()
  require('module-1')()
""" &> /dev/null

if [[ $? -ne 1 ]]; then
  echo "❌ module-1 should not have read access to process.env.SECRET."
  exit 1
else
  echo "✅ module-1 could not read process.env.SECRET when no policy was specified."
fi

echo

node -e """
  require('../')({
    'module-1': {
      read: ['SECRET']
    }
  })
  require('module-1')()
"""
#&> /dev/null

if [[ $? -ne 0 ]]; then
  echo "❌ module-1 should have read access to process.env.SECRET."
  exit 1
else
  echo "✅ module-1 was allowed to read process.env.SECRET when it's policy allows process.env.SECRET only."
fi

echo

node -e """
  require('../')({
    'module-1': {
      read: [/sdaasdasd/]
    }
  })
  require('module-1')()
""" &> /dev/null

if [[ $? -ne 1 ]]; then
  echo "❌ module-1 should not have read access to process.env.SECRET."
  exit 1
else
  echo "✅ module-1 could not read process.env.SECRET when no policy had no matching expression."
fi

echo

node -e """
  require('../')({
    'module-1': {
      read: '*'
    }
  })
  require('module-1')()
""" &> /dev/null

if [[ $? -ne 0 ]]; then
  echo "❌ module-1 should have read access to process.env.SECRET."
  exit 1
else
  echo "✅ module-1 was allowed to read process.env.SECRET when it's policy allows *."
fi

echo

node -e """
  require('../')({
    'module-1': {
      read: [/^sec..t/i]
    }
  })
  require('module-1')()
""" &> /dev/null

if [[ $? -ne 0 ]]; then
  echo "❌ module-1 should have read access to process.env.SECRET."
  exit 1
else
  echo "✅ module-1 was allowed to read process.env.SECRET when policy allows a matching regular expression."
fi

echo

node -e """
  require('../')()
  require('module-2')()
""" &> /dev/null

if [[ $? -ne 1 ]]; then
  echo "❌ module-2 should not have write access to process.env.DEBUG."
  exit 1
else
  echo "✅ module-2 could not write to process.env.DEBUG when no policy was specified."
fi

echo

node -e """
  require('../')({
    'module-2': {
      write: ['DEBUG']
    }
  })
  require('module-2')()
""" &> /dev/null

if [[ $? -ne 0 ]]; then
  echo "❌ module-2 should have write access to process.env.DEBUG."
  exit 1
else
  echo "✅ module-2 was allowed to write to process.env.DEBUG when it's policy allows process.env.DEBUG only."
fi

echo

node -e """
  require('../')({
    'module-2': {
      write: [/sdaasdasd/]
    }
  })
  require('module-2')()
""" &> /dev/null

if [[ $? -ne 1 ]]; then
  echo "❌ module-2 should not have write access to process.env.DEBUG."
  exit 1
else
  echo "✅ module-2 could not write to process.env.DEBUG when no policy had no matching expression."
fi

echo

node -e """
  require('../')({
    'module-2': {
      write: '*'
    }
  })
  require('module-2')()
""" &> /dev/null

if [[ $? -ne 0 ]]; then
  echo "❌ module-2 should have write access to process.env.DEBUG."
  exit 1
else
  echo "✅ module-2 was allowed to write to process.env.DEBUG when it's policy allows *."
fi

echo

node -e """
  require('../')({
    'module-2': {
      write: [/^debu.$/i]
    }
  })
  require('module-2')()
""" &> /dev/null

if [[ $? -ne 0 ]]; then
  echo "❌ module-2 should have write access to process.env.DEBUG."
  exit 1
else
  echo "✅ module-2 was allowed to write to process.env.DEBUG when policy allows a matching regular expression."
fi

echo

echo "✅ all tests passed."
