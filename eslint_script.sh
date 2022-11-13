#!/bin/bash

yes="${@}"

function yes_or_no {
  if [[ $yes == "-y" ]]; then
    echo "🛑👍🛑 !!! пропускаем вопрос !!! 🛑👍🛑"
  else
    while true; do
      read -p "$* [y/n]: " yn
      case $yn in
        [Yy]*) return 0 ;;
        [Nn]*) echo "👍 install aborted" ; return  1 ;;
      esac
    done
  fi
}

echo "🛑🛑🛑 !!!аккуратно, реактивность на пределе!!! 🛑🛑🛑,
💡 желательно закоммиттесь перед запуском скрипта"

yes_or_no "Я выполнил коммит и хочу продолжить." || exit 1

function editorconfig {
echo "👍 .editorconfig добавлен"

echo "root = true
[*]
charset = utf-8
end_of_line = lf
max_line_length=80
indent_size = 2
indent_style = space
trim_trailing_whitespace = true
insert_final_newline = true
quote_type = double
[*.md]
trim_trailing_whitespace = false
" > .editorconfig
}

editorconfig

function eslintrc {
echo "👍 .eslintrc добавлен"

echo '{
    "env":{
        "browser":true,
        "es2021":true,
        "node":true
    },
    "extends":[
        "plugin:react/recommended",
        "airbnb"
    ],
    "parserOptions":{
        "ecmaFeatures":{
            "jsx":true
        },
        "ecmaVersion":"latest",
        "sourceType":"module"
    },
    "plugins":[
        "react"
    ],
    "rules":{
        "react/jsx-filename-extension":0,
        "jsx-a11y/click-events-have-key-events":0,
        "react/prop-types":0,
        "react/react-in-jsx-scope":0,
        "no-unused-vars":0,
        "react/no-array-index-key":0,
        "jsx-a11y/anchor-is-valid":0,
        "jsx-a11y/label-has-associated-control":0,
        "jsx-a11y/no-static-element-interactions":0,
        "react/jsx-no-constructed-context-values":0,
        "default-param-last":0,
        "new-cap":[
            2,
            {
                "capIsNewExceptions":[
                    "List",
                    "Map",
                    "Set"
                ]
            }
        ],
        "react/no-multi-comp":0,
        "import/default":0,
        "import/no-duplicates":0,
        "import/named":0,
        "import/namespace":0,
        "import/no-unresolved":0,
        "import/no-named-as-default":2,
        "comma-dangle":0,
        "no-console":0,
        "no-alert":0,
        "linebreak-style":0,
        "eslint-disable-next-line":0,
        "react/jsx-props-no-spreading":0,
        "camelcase":"off"
    }
}
' > .eslintrc
}

if [ ! -f ".eslintrc" ]; then
  eslintrc
else
  yes_or_no "💡 .eslintrc уже существует, желаете перезаписать его ?" && eslintrc
fi

function eslintignore {
echo "👍 .eslintignore добавлен"
echo "flow-typed/npm/**
coverage/**
dist/**
.history/**
.next/**
.vscode/**
.idea/**
" > .eslintignore
}

if [ ! -f .eslintignore ]; then
  eslintignore
else
  yes_or_no "💡 .eslintignore уже существует, желаете перезаписать его ?" && eslintignore
fi


function prettierrc {
echo "👍 .prettierrc добавлен"
echo "trailingComma: all
bracketSpacing: false
" > .prettierrc
}

if [ ! -f .prettierrc ]; then
  prettierrc
else
  yes_or_no "💡 .prettierrc уже существует, желаете перезаписать его" && prettierrc
fi

function prettierignore {
echo "👍 .prettierignore добавлен"
echo "package.json
package-lock.json
flow-typed/npm/**
" > .prettierignore
}

if [ ! -f .prettierignore ]; then
  prettierignore
else
  yes_or_no "💡 .prettierignore уже существует, желаете перезаписать его" && prettierignore
fi

FILE=package.json
if [ -f "$FILE" ]; then
    echo 'УСТАНАВЛИВАЮ eslint prettier eslint-plugin-react'
    npm i -D eslint prettier eslint-plugin-react
    echo 'установлены eslint prettier eslint-plugin-react'
else
    echo "$FILE не существует, отмена установки."
fi

echo "🏁 спасибо за запуск скрипта, приятного кодинга :D"
