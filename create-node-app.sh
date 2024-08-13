#!/usr/bin/env sh

if [ -z "$1" ]; then
    echo "Project name is empty \n";
    echo "Usage: create-node-app <project name>"
    exit
fi

if [ -e "$1" ]; then
  echo "Error: $1 already exists"
  exit
fi

mkdir "$1"
cd "$1" || exit
tsc --init --target esnext --module esnext --rootDir ./src --outDir ./dist --sourceMap true --useUnknownInCatchVariables false
mkdir src
cat <<EOF > "src/main.ts"
// This is the main entry point for the TypeScript application
console.log("Hello DEP!");
EOF
cat <<EOF > "package.json"
{
  "name": "$1",
  "version": "1.0.0",
  "main": "dist/main.js",
  "type": "module",
  "scripts": {
    "clean": "rm -rf dist",
    "start": "tsc && nodemon --enable-source-maps dist/main.js",
    "compile": "tsc --watch",
    "build": "tsc",
    "cleanBuild": "rm -rf dist && tsc"
  },
  "author": "Direct Entry Program <dep@ijse.lk> (https://ijse.lk)",
  "license": "MIT",
  "devDependencies": {
    "nodemon": "latest",
    "@types/node": "latest"
  }
}
EOF
npm i
echo ""
echo "Project created successfully, happy hacking!"
