#!/bin/bash

echo 'Hi! Lets create new CLI Typescript project'
echo '------------------------------------------'

#directory
read -p "Enter directory name: " dirname

if [ ! -d "$dirname" ]
then
    echo "Directory doesn't exist. Creating now"
    mkdir ./$dirname
    echo "(1/x) Directory created"
else
    echo "(1/x) Directory exists"
fi

echo '(2/x) Changing directory...'
cd $dirname

#initialize ts
echo '(3/x) Initializing npm...'
npm init -y

#add ts
echo '(4/x) Installing TypeScript...'
npm install @types/node typescript --save-dev

#add tsconfig
echo '(5/x) Creating tsconfig...'
echo '{
  "compilerOptions": {
    "rootDir": "src",
    "outDir": "dist",
    "strict": true,
    "target": "es6",
    "module": "commonjs",
    "sourceMap": true,
    "esModuleInterop": true,
    "moduleResolution": "node",
    "forceConsistentCasingInFileNames": true
  }
}' >> tsconfig.json

#add scaffolded folders
echo '(8/x) creating neccessary folders...'
mkdir src

#create main entry point
echo '(9/x) creating index.ts...'
echo 'console.log("hello world!")' >> ./src/index.ts

#edit build script in package.json
echo '(10/x) adding build script...'
jq '.scripts += {build: "npx tsc"}' package.json > tmp.$$.json && mv tmp.$$.json package.json
jq '.main = "dist/index.js"' package.json > tmp.$$.json && mv tmp.$$.json package.json
