#!/bin/bash

echo 'Hi! Lets create new CLI Typescript project'
echo '------------------------------------------'

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

echo '(3/x) Initializing npm...'
npm init -y

echo '(4/x) Installing TypeScript...'
npm install @types/node typescript --save-dev

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