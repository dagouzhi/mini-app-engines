const fs = require('fs-extra');
const path = require('path');

const inputPath = path.join(__dirname, './build/host/outputs/repo');

const outPath = path.join(__dirname, './assets/android/repo');

fs.copySync(inputPath, outPath);
