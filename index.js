// main index.js

import { NativeModules, requireNativeComponent } from 'react-native';
const { MiniAppEngines } = NativeModules;


export const MiniAppEnginesView = requireNativeComponent('RCTMiniAppEnginesView');

export default MiniAppEngines;
