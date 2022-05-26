module.exports = {
  env: {
    browser: true,
    es2021: true,
    jest: true,
  },
  extends: ['plugin:cypress/recommended', 'plugin:import/typescript', 'airbnb'],
  parser: '@typescript-eslint/parser',
  parserOptions: {
    ecmaFeatures: {
      jsx: true,
    },
    ecmaVersion: 'latest',
    sourceType: 'module',
  },
  plugins: ['@typescript-eslint'],
  rules: {
    '@typescript-eslint/explicit-function-return-type': 'off',
    '@typescript-eslint/explicit-module-boundary-types': 'off',
    '@typescript-eslint/no-explicit-any': 'warn',
    '@typescript-eslint/no-unused-vars': 'warn',
    eqeqeq: 'warn',
    'import/extensions': 'off',
    'import/jsx-one-expression-per-line': 'off',
    'import/no-extraneous-dependencies': 'off',
    'import/no-unresolved': 'warn',
    'import/prefer-default-export': 'off',
    'import/react-in-jsx-scope': 'off',
    'jsx-a11y/click-events-have-key-events': 'warn',
    'jsx-a11y/no-static-element-interactions': 'warn',
    'cypress/no-assigning-return-values': 'off',
    'max-len': [
      'warn',
      {
        code: 180,
      },
    ],
    'no-console': 'warn',
    'sort-keys': ['off'],
    'lines-between-class-members': 'off',
    'class-methods-use-this': 'off',
  },
  settings: {
    'import/resolver': {
      node: {
        extensions: ['.js', '.jsx', '.ts', '.tsx'],
      },
    },
  },
};
