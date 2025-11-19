module.exports = {
  root: true,
  parser: '@typescript-eslint/parser',
  extends: [
    'standard-with-typescript'
  ],
  parserOptions: {
    ecmaVersion: 2021,
    sourceType: 'module',
    project: './tsconfig.json'

  }
} 
