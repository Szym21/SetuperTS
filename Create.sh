#!/bin/bash

echo 'Hi! Lets create new CLI Typescript project'
echo '------------------------------------------'

#directory
read -p "Enter directory name: " dirname

if [ ! -d "$dirname" ]
then
    echo "Directory doesn't exist. Creating now"
    mkdir ../$dirname
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


#1st build of project
echo '(11/x) initial build...'
npm run build

#addition of README
echo '(12/x) Creating README.MD...'
touch README.MD

#git initialization
echo '(13/x) preparing git repository...'
git init
echo '# Dependency directories
node_modules/
jspm_packages/

# Snowpack dependency directory (https://snowpack.dev/)
web_modules/

# TypeScript cache
*.tsbuildinfo\' >> .gitignore

git add .
git commit -am "initial commit - scaffolded"

#adding remote
echo '(14/x) preparing github remote repository...'
gh repo create $dirname --public
git remote add origin https://github.com/Szym21/$dirname.git
git branch -M main
git push -u origin main

