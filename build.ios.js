const fs = require('fs-extra');
const path = require('path');
const findRemoveSync = require('find-remove');
const archiver = require('archiver');

const quickjsPath = path.join(
  __dirname,
  './packages/kraken-0.11.0/ios/quickjs.xcframework',
);

const krakenBridgePath = path.join(
  __dirname,
  './packages/kraken-0.11.0/ios/kraken_bridge.xcframework',
);

const types = ['Debug', 'Release', 'Profile'];
fs.copySync(
  path.join(__dirname, './build/ios/framework/'),
  path.join(__dirname, './assets/ios/framework/'),
);

for (const key in types) {
  zipAssets(types[key]);
}

function zipAssets(type) {
  return new Promise((resolve, reject) => {
    const quickjsSavePath = path.join(
      __dirname,
      `./assets/ios/framework/${type}/quickjs.xcframework`,
    );
    fs.copySync(quickjsPath, quickjsSavePath);
    const krakenBridgeSavePath = path.join(
      __dirname,
      `./assets/ios/framework/${type}/kraken_bridge.xcframework`,
    );
    fs.copySync(krakenBridgePath, krakenBridgeSavePath);
    const output = fs.createWriteStream(
      path.join(__dirname, `./assets/ios/framework/${type}.zip`),
    );
    const archive = archiver('zip', {
      zlib: {level: 9}, // Sets the compression level.
    });
    archive.pipe(output);
    archive.on('warning', function (err) {
      console.error(err);
      if (err.code === 'ENOENT') {
        // log warning
      } else {
        // throw error
        throw err;
      }
    });
    // good practice to catch this error explicitly
    archive.on('error', function (err) {
      console.error(err);
      throw err;
    });
    archive.on('end', function () {
      console.log('end', type);
      findRemoveSync(path.join(__dirname, `./assets/ios/framework/${type}`), {
        dir: 'xcframework$',
        regex: true,
      });
      resolve('ok');
    });

    archive.directory(
      path.join(__dirname, `./assets/ios/framework/${type}`),
      type,
    );
    console.log('start', type);
    archive.finalize();
  });
}
