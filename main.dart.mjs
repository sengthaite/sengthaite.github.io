
// Compiles a dart2wasm-generated main module from `source` which can then
// instantiatable via the `instantiate` method.
//
// `source` needs to be a `Response` object (or promise thereof) e.g. created
// via the `fetch()` JS API.
export async function compileStreaming(source) {
  const builtins = {builtins: ['js-string']};
  return new CompiledApp(
      await WebAssembly.compileStreaming(source, builtins), builtins);
}

// Compiles a dart2wasm-generated wasm modules from `bytes` which is then
// instantiatable via the `instantiate` method.
export async function compile(bytes) {
  const builtins = {builtins: ['js-string']};
  return new CompiledApp(await WebAssembly.compile(bytes, builtins), builtins);
}

// DEPRECATED: Please use `compile` or `compileStreaming` to get a compiled app,
// use `instantiate` method to get an instantiated app and then call
// `invokeMain` to invoke the main function.
export async function instantiate(modulePromise, importObjectPromise) {
  var moduleOrCompiledApp = await modulePromise;
  if (!(moduleOrCompiledApp instanceof CompiledApp)) {
    moduleOrCompiledApp = new CompiledApp(moduleOrCompiledApp);
  }
  const instantiatedApp = await moduleOrCompiledApp.instantiate(await importObjectPromise);
  return instantiatedApp.instantiatedModule;
}

// DEPRECATED: Please use `compile` or `compileStreaming` to get a compiled app,
// use `instantiate` method to get an instantiated app and then call
// `invokeMain` to invoke the main function.
export const invoke = (moduleInstance, ...args) => {
  moduleInstance.exports.$invokeMain(args);
}

class CompiledApp {
  constructor(module, builtins) {
    this.module = module;
    this.builtins = builtins;
  }

  // The second argument is an options object containing:
  // `loadDeferredWasm` is a JS function that takes a module name matching a
  //   wasm file produced by the dart2wasm compiler and returns the bytes to
  //   load the module. These bytes can be in either a format supported by
  //   `WebAssembly.compile` or `WebAssembly.compileStreaming`.
  async instantiate(additionalImports, {loadDeferredWasm} = {}) {
    let dartInstance;

    // Prints to the console
    function printToConsole(value) {
      if (typeof dartPrint == "function") {
        dartPrint(value);
        return;
      }
      if (typeof console == "object" && typeof console.log != "undefined") {
        console.log(value);
        return;
      }
      if (typeof print == "function") {
        print(value);
        return;
      }

      throw "Unable to print message: " + js;
    }

    // Converts a Dart List to a JS array. Any Dart objects will be converted, but
    // this will be cheap for JSValues.
    function arrayFromDartList(constructor, list) {
      const exports = dartInstance.exports;
      const read = exports.$listRead;
      const length = exports.$listLength(list);
      const array = new constructor(length);
      for (let i = 0; i < length; i++) {
        array[i] = read(list, i);
      }
      return array;
    }

    // A special symbol attached to functions that wrap Dart functions.
    const jsWrappedDartFunctionSymbol = Symbol("JSWrappedDartFunction");

    function finalizeWrapper(dartFunction, wrapped) {
      wrapped.dartFunction = dartFunction;
      wrapped[jsWrappedDartFunctionSymbol] = true;
      return wrapped;
    }

    // Imports
    const dart2wasm = {

      _1: (x0,x1,x2) => x0.set(x1,x2),
      _2: (x0,x1,x2) => x0.set(x1,x2),
      _6: f => finalizeWrapper(f, function(x0) { return dartInstance.exports._6(f,arguments.length,x0) }),
      _7: x0 => new window.FinalizationRegistry(x0),
      _8: (x0,x1,x2,x3) => x0.register(x1,x2,x3),
      _9: (x0,x1) => x0.unregister(x1),
      _10: (x0,x1,x2) => x0.slice(x1,x2),
      _11: (x0,x1) => x0.decode(x1),
      _12: (x0,x1) => x0.segment(x1),
      _13: () => new TextDecoder(),
      _14: x0 => x0.buffer,
      _15: x0 => x0.wasmMemory,
      _16: () => globalThis.window._flutter_skwasmInstance,
      _17: x0 => x0.rasterStartMilliseconds,
      _18: x0 => x0.rasterEndMilliseconds,
      _19: x0 => x0.imageBitmaps,
      _192: x0 => x0.select(),
      _193: (x0,x1) => x0.append(x1),
      _194: x0 => x0.remove(),
      _197: x0 => x0.unlock(),
      _202: x0 => x0.getReader(),
      _211: x0 => new MutationObserver(x0),
      _222: (x0,x1,x2) => x0.addEventListener(x1,x2),
      _223: (x0,x1,x2) => x0.removeEventListener(x1,x2),
      _226: x0 => new ResizeObserver(x0),
      _229: (x0,x1) => new Intl.Segmenter(x0,x1),
      _230: x0 => x0.next(),
      _231: (x0,x1) => new Intl.v8BreakIterator(x0,x1),
      _308: x0 => x0.close(),
      _309: (x0,x1,x2,x3,x4) => ({type: x0,data: x1,premultiplyAlpha: x2,colorSpaceConversion: x3,preferAnimation: x4}),
      _310: x0 => new window.ImageDecoder(x0),
      _311: x0 => x0.close(),
      _312: x0 => ({frameIndex: x0}),
      _313: (x0,x1) => x0.decode(x1),
      _316: f => finalizeWrapper(f, function(x0) { return dartInstance.exports._316(f,arguments.length,x0) }),
      _317: f => finalizeWrapper(f, function(x0) { return dartInstance.exports._317(f,arguments.length,x0) }),
      _318: (x0,x1) => ({addView: x0,removeView: x1}),
      _319: f => finalizeWrapper(f, function(x0) { return dartInstance.exports._319(f,arguments.length,x0) }),
      _320: f => finalizeWrapper(f, function() { return dartInstance.exports._320(f,arguments.length) }),
      _321: (x0,x1) => ({initializeEngine: x0,autoStart: x1}),
      _322: f => finalizeWrapper(f, function(x0) { return dartInstance.exports._322(f,arguments.length,x0) }),
      _323: x0 => ({runApp: x0}),
      _324: x0 => new Uint8Array(x0),
      _326: x0 => x0.preventDefault(),
      _327: x0 => x0.stopPropagation(),
      _328: (x0,x1) => x0.addListener(x1),
      _329: (x0,x1) => x0.removeListener(x1),
      _330: (x0,x1) => x0.prepend(x1),
      _331: x0 => x0.remove(),
      _332: x0 => x0.disconnect(),
      _333: (x0,x1) => x0.addListener(x1),
      _334: (x0,x1) => x0.removeListener(x1),
      _335: x0 => x0.blur(),
      _336: (x0,x1) => x0.append(x1),
      _337: x0 => x0.remove(),
      _338: x0 => x0.stopPropagation(),
      _342: x0 => x0.preventDefault(),
      _343: (x0,x1) => x0.append(x1),
      _344: x0 => x0.remove(),
      _345: x0 => x0.preventDefault(),
      _350: (x0,x1) => x0.removeChild(x1),
      _351: (x0,x1) => x0.appendChild(x1),
      _352: (x0,x1,x2) => x0.insertBefore(x1,x2),
      _353: (x0,x1) => x0.appendChild(x1),
      _354: (x0,x1) => x0.transferFromImageBitmap(x1),
      _355: (x0,x1) => x0.appendChild(x1),
      _356: (x0,x1) => x0.append(x1),
      _357: (x0,x1) => x0.append(x1),
      _358: (x0,x1) => x0.append(x1),
      _359: x0 => x0.remove(),
      _360: x0 => x0.remove(),
      _361: x0 => x0.remove(),
      _362: (x0,x1) => x0.appendChild(x1),
      _363: (x0,x1) => x0.appendChild(x1),
      _364: x0 => x0.remove(),
      _365: (x0,x1) => x0.append(x1),
      _366: (x0,x1) => x0.append(x1),
      _367: x0 => x0.remove(),
      _368: (x0,x1) => x0.append(x1),
      _369: (x0,x1) => x0.append(x1),
      _370: (x0,x1,x2) => x0.insertBefore(x1,x2),
      _371: (x0,x1) => x0.append(x1),
      _372: (x0,x1,x2) => x0.insertBefore(x1,x2),
      _373: x0 => x0.remove(),
      _374: (x0,x1) => x0.append(x1),
      _375: x0 => x0.remove(),
      _376: (x0,x1) => x0.append(x1),
      _377: x0 => x0.remove(),
      _378: x0 => x0.remove(),
      _379: x0 => x0.getBoundingClientRect(),
      _380: x0 => x0.remove(),
      _393: (x0,x1) => x0.append(x1),
      _394: x0 => x0.remove(),
      _395: (x0,x1) => x0.append(x1),
      _396: (x0,x1,x2) => x0.insertBefore(x1,x2),
      _397: x0 => x0.preventDefault(),
      _398: x0 => x0.preventDefault(),
      _399: x0 => x0.preventDefault(),
      _400: x0 => x0.preventDefault(),
      _401: (x0,x1) => x0.observe(x1),
      _402: x0 => x0.disconnect(),
      _403: (x0,x1) => x0.appendChild(x1),
      _404: (x0,x1) => x0.appendChild(x1),
      _405: (x0,x1) => x0.appendChild(x1),
      _406: (x0,x1) => x0.append(x1),
      _407: x0 => x0.remove(),
      _408: (x0,x1) => x0.append(x1),
      _409: (x0,x1) => x0.append(x1),
      _410: (x0,x1) => x0.appendChild(x1),
      _411: (x0,x1) => x0.append(x1),
      _412: x0 => x0.remove(),
      _413: (x0,x1) => x0.append(x1),
      _414: x0 => x0.remove(),
      _418: (x0,x1) => x0.appendChild(x1),
      _419: x0 => x0.remove(),
      _975: () => globalThis.window.flutterConfiguration,
      _976: x0 => x0.assetBase,
      _981: x0 => x0.debugShowSemanticsNodes,
      _982: x0 => x0.hostElement,
      _983: x0 => x0.multiViewEnabled,
      _984: x0 => x0.nonce,
      _986: x0 => x0.fontFallbackBaseUrl,
      _991: x0 => x0.console,
      _992: x0 => x0.devicePixelRatio,
      _993: x0 => x0.document,
      _994: x0 => x0.history,
      _995: x0 => x0.innerHeight,
      _996: x0 => x0.innerWidth,
      _997: x0 => x0.location,
      _998: x0 => x0.navigator,
      _999: x0 => x0.visualViewport,
      _1000: x0 => x0.performance,
      _1003: (x0,x1) => x0.dispatchEvent(x1),
      _1004: (x0,x1) => x0.matchMedia(x1),
      _1006: (x0,x1) => x0.getComputedStyle(x1),
      _1007: x0 => x0.screen,
      _1009: (x0,x1) => x0.requestAnimationFrame(x1),
      _1010: f => finalizeWrapper(f, function(x0) { return dartInstance.exports._1010(f,arguments.length,x0) }),
      _1015: (x0,x1) => x0.warn(x1),
      _1017: (x0,x1) => x0.debug(x1),
      _1018: () => globalThis.window,
      _1019: () => globalThis.Intl,
      _1020: () => globalThis.Symbol,
      _1023: x0 => x0.clipboard,
      _1024: x0 => x0.maxTouchPoints,
      _1025: x0 => x0.vendor,
      _1026: x0 => x0.language,
      _1027: x0 => x0.platform,
      _1028: x0 => x0.userAgent,
      _1029: x0 => x0.languages,
      _1030: x0 => x0.documentElement,
      _1031: (x0,x1) => x0.querySelector(x1),
      _1035: (x0,x1) => x0.createElement(x1),
      _1036: (x0,x1) => x0.execCommand(x1),
      _1040: (x0,x1) => x0.createTextNode(x1),
      _1041: (x0,x1) => x0.createEvent(x1),
      _1045: x0 => x0.head,
      _1046: x0 => x0.body,
      _1047: (x0,x1) => x0.title = x1,
      _1050: x0 => x0.activeElement,
      _1053: x0 => x0.visibilityState,
      _1054: x0 => x0.hasFocus(),
      _1055: () => globalThis.document,
      _1056: (x0,x1,x2,x3) => x0.addEventListener(x1,x2,x3),
      _1058: (x0,x1,x2,x3) => x0.addEventListener(x1,x2,x3),
      _1061: f => finalizeWrapper(f, function(x0) { return dartInstance.exports._1061(f,arguments.length,x0) }),
      _1062: x0 => x0.target,
      _1064: x0 => x0.timeStamp,
      _1065: x0 => x0.type,
      _1067: x0 => x0.preventDefault(),
      _1069: (x0,x1,x2,x3) => x0.initEvent(x1,x2,x3),
      _1076: x0 => x0.firstChild,
      _1081: x0 => x0.parentElement,
      _1083: x0 => x0.parentNode,
      _1086: (x0,x1) => x0.removeChild(x1),
      _1087: (x0,x1) => x0.removeChild(x1),
      _1088: x0 => x0.isConnected,
      _1089: (x0,x1) => x0.textContent = x1,
      _1091: (x0,x1) => x0.contains(x1),
      _1096: x0 => x0.firstElementChild,
      _1098: x0 => x0.nextElementSibling,
      _1099: x0 => x0.clientHeight,
      _1100: x0 => x0.clientWidth,
      _1101: x0 => x0.offsetHeight,
      _1102: x0 => x0.offsetWidth,
      _1103: x0 => x0.id,
      _1104: (x0,x1) => x0.id = x1,
      _1107: (x0,x1) => x0.spellcheck = x1,
      _1108: x0 => x0.tagName,
      _1109: x0 => x0.style,
      _1110: (x0,x1) => x0.append(x1),
      _1111: (x0,x1) => x0.getAttribute(x1),
      _1112: x0 => x0.getBoundingClientRect(),
      _1117: (x0,x1) => x0.closest(x1),
      _1120: (x0,x1) => x0.querySelectorAll(x1),
      _1122: x0 => x0.remove(),
      _1123: (x0,x1,x2) => x0.setAttribute(x1,x2),
      _1124: (x0,x1) => x0.removeAttribute(x1),
      _1125: (x0,x1) => x0.tabIndex = x1,
      _1127: (x0,x1) => x0.focus(x1),
      _1128: x0 => x0.scrollTop,
      _1129: (x0,x1) => x0.scrollTop = x1,
      _1130: x0 => x0.scrollLeft,
      _1131: (x0,x1) => x0.scrollLeft = x1,
      _1132: x0 => x0.classList,
      _1133: (x0,x1) => x0.className = x1,
      _1140: (x0,x1) => x0.getElementsByClassName(x1),
      _1142: x0 => x0.click(),
      _1144: (x0,x1) => x0.hasAttribute(x1),
      _1147: (x0,x1) => x0.attachShadow(x1),
      _1151: (x0,x1) => x0.getPropertyValue(x1),
      _1153: (x0,x1,x2,x3) => x0.setProperty(x1,x2,x3),
      _1155: (x0,x1) => x0.removeProperty(x1),
      _1157: x0 => x0.offsetLeft,
      _1158: x0 => x0.offsetTop,
      _1159: x0 => x0.offsetParent,
      _1161: (x0,x1) => x0.name = x1,
      _1162: x0 => x0.content,
      _1163: (x0,x1) => x0.content = x1,
      _1181: (x0,x1) => x0.nonce = x1,
      _1186: x0 => x0.now(),
      _1188: (x0,x1) => x0.width = x1,
      _1190: (x0,x1) => x0.height = x1,
      _1195: (x0,x1) => x0.getContext(x1),
      _1275: (x0,x1) => x0.fetch(x1),
      _1276: x0 => x0.status,
      _1277: x0 => x0.headers,
      _1278: x0 => x0.body,
      _1280: x0 => x0.arrayBuffer(),
      _1283: (x0,x1) => x0.get(x1),
      _1285: x0 => x0.read(),
      _1286: x0 => x0.value,
      _1287: x0 => x0.done,
      _1289: x0 => x0.name,
      _1290: x0 => x0.x,
      _1291: x0 => x0.y,
      _1294: x0 => x0.top,
      _1295: x0 => x0.right,
      _1296: x0 => x0.bottom,
      _1297: x0 => x0.left,
      _1306: x0 => x0.height,
      _1307: x0 => x0.width,
      _1308: (x0,x1) => x0.value = x1,
      _1310: (x0,x1) => x0.placeholder = x1,
      _1311: (x0,x1) => x0.name = x1,
      _1312: x0 => x0.selectionDirection,
      _1313: x0 => x0.selectionStart,
      _1314: x0 => x0.selectionEnd,
      _1317: x0 => x0.value,
      _1319: (x0,x1,x2) => x0.setSelectionRange(x1,x2),
      _1323: x0 => x0.readText(),
      _1324: (x0,x1) => x0.writeText(x1),
      _1325: x0 => x0.altKey,
      _1326: x0 => x0.code,
      _1327: x0 => x0.ctrlKey,
      _1328: x0 => x0.key,
      _1329: x0 => x0.keyCode,
      _1330: x0 => x0.location,
      _1331: x0 => x0.metaKey,
      _1332: x0 => x0.repeat,
      _1333: x0 => x0.shiftKey,
      _1334: x0 => x0.isComposing,
      _1335: (x0,x1) => x0.getModifierState(x1),
      _1337: x0 => x0.state,
      _1338: (x0,x1) => x0.go(x1),
      _1341: (x0,x1,x2,x3) => x0.pushState(x1,x2,x3),
      _1342: (x0,x1,x2,x3) => x0.replaceState(x1,x2,x3),
      _1343: x0 => x0.pathname,
      _1344: x0 => x0.search,
      _1345: x0 => x0.hash,
      _1349: x0 => x0.state,
      _1356: f => finalizeWrapper(f, function(x0,x1) { return dartInstance.exports._1356(f,arguments.length,x0,x1) }),
      _1358: (x0,x1,x2) => x0.observe(x1,x2),
      _1361: x0 => x0.attributeName,
      _1362: x0 => x0.type,
      _1363: x0 => x0.matches,
      _1368: x0 => x0.matches,
      _1370: x0 => x0.relatedTarget,
      _1371: x0 => x0.clientX,
      _1372: x0 => x0.clientY,
      _1373: x0 => x0.offsetX,
      _1374: x0 => x0.offsetY,
      _1377: x0 => x0.button,
      _1378: x0 => x0.buttons,
      _1379: x0 => x0.ctrlKey,
      _1381: (x0,x1) => x0.getModifierState(x1),
      _1384: x0 => x0.pointerId,
      _1385: x0 => x0.pointerType,
      _1386: x0 => x0.pressure,
      _1387: x0 => x0.tiltX,
      _1388: x0 => x0.tiltY,
      _1390: x0 => x0.getCoalescedEvents(),
      _1392: x0 => x0.deltaX,
      _1393: x0 => x0.deltaY,
      _1394: x0 => x0.wheelDeltaX,
      _1395: x0 => x0.wheelDeltaY,
      _1396: x0 => x0.deltaMode,
      _1402: x0 => x0.changedTouches,
      _1404: x0 => x0.clientX,
      _1405: x0 => x0.clientY,
      _1407: x0 => x0.data,
      _1410: (x0,x1) => x0.disabled = x1,
      _1411: (x0,x1) => x0.type = x1,
      _1412: (x0,x1) => x0.max = x1,
      _1413: (x0,x1) => x0.min = x1,
      _1414: (x0,x1) => x0.value = x1,
      _1415: x0 => x0.value,
      _1416: x0 => x0.disabled,
      _1417: (x0,x1) => x0.disabled = x1,
      _1418: (x0,x1) => x0.placeholder = x1,
      _1419: (x0,x1) => x0.name = x1,
      _1420: (x0,x1) => x0.autocomplete = x1,
      _1421: x0 => x0.selectionDirection,
      _1422: x0 => x0.selectionStart,
      _1423: x0 => x0.selectionEnd,
      _1427: (x0,x1,x2) => x0.setSelectionRange(x1,x2),
      _1432: (x0,x1) => x0.add(x1),
      _1436: (x0,x1) => x0.noValidate = x1,
      _1437: (x0,x1) => x0.method = x1,
      _1438: (x0,x1) => x0.action = x1,
      _1463: x0 => x0.orientation,
      _1464: x0 => x0.width,
      _1465: x0 => x0.height,
      _1467: (x0,x1) => x0.lock(x1),
      _1484: f => finalizeWrapper(f, function(x0,x1) { return dartInstance.exports._1484(f,arguments.length,x0,x1) }),
      _1493: x0 => x0.length,
      _1494: (x0,x1) => x0.item(x1),
      _1495: x0 => x0.length,
      _1496: (x0,x1) => x0.item(x1),
      _1497: x0 => x0.iterator,
      _1498: x0 => x0.Segmenter,
      _1499: x0 => x0.v8BreakIterator,
      _1502: x0 => x0.done,
      _1503: x0 => x0.value,
      _1504: x0 => x0.index,
      _1508: (x0,x1) => x0.adoptText(x1),
      _1509: x0 => x0.first(),
      _1510: x0 => x0.next(),
      _1511: x0 => x0.current(),
      _1522: x0 => x0.hostElement,
      _1523: x0 => x0.viewConstraints,
      _1525: x0 => x0.maxHeight,
      _1526: x0 => x0.maxWidth,
      _1527: x0 => x0.minHeight,
      _1528: x0 => x0.minWidth,
      _1529: x0 => x0.loader,
      _1530: () => globalThis._flutter,
      _1532: (x0,x1) => x0.didCreateEngineInitializer(x1),
      _1533: (x0,x1,x2) => x0.call(x1,x2),
      _1534: f => finalizeWrapper(f, function(x0,x1) { return dartInstance.exports._1534(f,arguments.length,x0,x1) }),
      _1535: x0 => new Promise(x0),
      _1539: x0 => x0.length,
      _1541: x0 => x0.tracks,
      _1545: x0 => x0.image,
      _1552: x0 => x0.displayWidth,
      _1553: x0 => x0.displayHeight,
      _1554: x0 => x0.duration,
      _1558: x0 => x0.ready,
      _1559: x0 => x0.selectedTrack,
      _1560: x0 => x0.repetitionCount,
      _1561: x0 => x0.frameCount,
      _1605: x0 => x0.decode(),
      _1606: (x0,x1,x2,x3) => x0.open(x1,x2,x3),
      _1607: (x0,x1,x2) => x0.setRequestHeader(x1,x2),
      _1608: f => finalizeWrapper(f, function(x0) { return dartInstance.exports._1608(f,arguments.length,x0) }),
      _1609: (x0,x1,x2) => x0.addEventListener(x1,x2),
      _1610: f => finalizeWrapper(f, function(x0) { return dartInstance.exports._1610(f,arguments.length,x0) }),
      _1611: x0 => x0.send(),
      _1612: () => new XMLHttpRequest(),
      _1613: (x0,x1) => x0.createElement(x1),
      _1614: x0 => x0.createRange(),
      _1615: (x0,x1) => x0.selectNode(x1),
      _1616: x0 => x0.getSelection(),
      _1617: x0 => x0.removeAllRanges(),
      _1618: (x0,x1) => x0.addRange(x1),
      _1619: (x0,x1) => x0.add(x1),
      _1620: (x0,x1) => x0.append(x1),
      _1621: (x0,x1,x2) => x0.insertRule(x1,x2),
      _1622: f => finalizeWrapper(f, function(x0) { return dartInstance.exports._1622(f,arguments.length,x0) }),
      _1623: (x0,x1) => x0.getUserMedia(x1),
      _1627: x0 => x0.getSupportedConstraints(),
      _1628: x0 => x0.getSettings(),
      _1629: x0 => x0.getCapabilities(),
      _1630: (x0,x1,x2) => x0.setProperty(x1,x2),
      _1631: (x0,x1) => x0.append(x1),
      _1632: (x0,x1,x2) => x0.setAttribute(x1,x2),
      _1633: x0 => x0.getVideoTracks(),
      _1634: x0 => x0.play(),
      _1636: x0 => x0.getVideoTracks(),
      _1637: x0 => x0.getTracks(),
      _1638: x0 => x0.stop(),
      _1639: (x0,x1,x2) => x0.translate(x1,x2),
      _1640: (x0,x1,x2) => x0.scale(x1,x2),
      _1641: f => finalizeWrapper(f, function(x0) { return dartInstance.exports._1641(f,arguments.length,x0) }),
      _1642: (x0,x1,x2) => x0.toBlob(x1,x2),
      _1643: x0 => globalThis.URL.createObjectURL(x0),
      _1644: x0 => x0.getVideoTracks(),
      _1645: x0 => x0.getSettings(),
      _1647: x0 => x0.getVideoTracks(),
      _1648: x0 => x0.getCapabilities(),
      _1649: x0 => ({torch: x0}),
      _1650: (x0,x1) => x0.applyConstraints(x1),
      _1652: x0 => x0.getVideoTracks(),
      _1653: x0 => x0.getSettings(),
      _1667: x0 => x0.load(),
      _1668: x0 => globalThis.MediaRecorder.isTypeSupported(x0),
      _1669: x0 => ({type: x0}),
      _1670: (x0,x1) => new Blob(x0,x1),
      _1671: x0 => x0.getVideoTracks(),
      _1672: x0 => x0.stop(),
      _1673: x0 => x0.enumerateDevices(),
      _1674: x0 => x0.getVideoTracks(),
      _1675: x0 => x0.stop(),
      _1676: x0 => new Event(x0),
      _1680: (x0,x1) => x0.append(x1),
      _1681: x0 => x0.click(),
      _1682: x0 => x0.remove(),
      _1683: x0 => x0.play(),
      _1684: x0 => x0.pause(),
      _1690: (x0,x1) => x0.removeAttribute(x1),
      _1691: x0 => x0.load(),
      _1692: (x0,x1) => x0.start(x1),
      _1693: (x0,x1) => x0.end(x1),
      _1694: x0 => x0.preventDefault(),
      _1695: (x0,x1,x2,x3) => x0.addEventListener(x1,x2,x3),
      _1696: (x0,x1,x2,x3) => x0.removeEventListener(x1,x2,x3),
      _1697: (x0,x1) => x0.createElement(x1),
      _1698: (x0,x1,x2) => x0.setAttribute(x1,x2),
      _1699: (x0,x1,x2) => x0.setAttribute(x1,x2),
      _1700: (x0,x1,x2) => x0.setAttribute(x1,x2),
      _1701: x0 => x0.preventDefault(),
      _1703: (x0,x1,x2) => x0.setAttribute(x1,x2),
      _1704: (x0,x1,x2) => x0.setAttribute(x1,x2),
      _1705: (x0,x1) => x0.getAttribute(x1),
      _1706: (x0,x1,x2) => x0.setAttribute(x1,x2),
      _1707: f => finalizeWrapper(f, function(x0) { return dartInstance.exports._1707(f,arguments.length,x0) }),
      _1708: f => finalizeWrapper(f, function(x0) { return dartInstance.exports._1708(f,arguments.length,x0) }),
      _1709: (x0,x1) => x0.closest(x1),
      _1710: (x0,x1) => x0.closest(x1),
      _1711: (x0,x1,x2,x3) => x0.open(x1,x2,x3),
      _1712: (x0,x1) => ({video: x0,audio: x1}),
      _1719: x0 => x0.read(),
      _1720: (x0,x1) => x0.getType(x1),
      _1721: x0 => x0.text(),
      _1742: x0 => new Array(x0),
      _1744: x0 => x0.length,
      _1746: (x0,x1) => x0[x1],
      _1747: (x0,x1,x2) => x0[x1] = x2,
      _1750: (x0,x1,x2) => new DataView(x0,x1,x2),
      _1752: x0 => new Int8Array(x0),
      _1753: (x0,x1,x2) => new Uint8Array(x0,x1,x2),
      _1754: x0 => new Uint8Array(x0),
      _1760: x0 => new Uint16Array(x0),
      _1762: x0 => new Int32Array(x0),
      _1764: x0 => new Uint32Array(x0),
      _1766: x0 => new Float32Array(x0),
      _1768: x0 => new Float64Array(x0),
      _1774: f => finalizeWrapper(f, function(x0) { return dartInstance.exports._1774(f,arguments.length,x0) }),
      _1775: f => finalizeWrapper(f, function(x0) { return dartInstance.exports._1775(f,arguments.length,x0) }),
      _1800: (decoder, codeUnits) => decoder.decode(codeUnits),
      _1801: () => new TextDecoder("utf-8", {fatal: true}),
      _1802: () => new TextDecoder("utf-8", {fatal: false}),
      _1803: x0 => new WeakRef(x0),
      _1804: x0 => x0.deref(),
      _1810: Date.now,
      _1812: s => new Date(s * 1000).getTimezoneOffset() * 60,
      _1813: s => {
        if (!/^\s*[+-]?(?:Infinity|NaN|(?:\.\d+|\d+(?:\.\d*)?)(?:[eE][+-]?\d+)?)\s*$/.test(s)) {
          return NaN;
        }
        return parseFloat(s);
      },
      _1814: () => {
        let stackString = new Error().stack.toString();
        let frames = stackString.split('\n');
        let drop = 2;
        if (frames[0] === 'Error') {
            drop += 1;
        }
        return frames.slice(drop).join('\n');
      },
      _1815: () => typeof dartUseDateNowForTicks !== "undefined",
      _1816: () => 1000 * performance.now(),
      _1817: () => Date.now(),
      _1818: () => {
        // On browsers return `globalThis.location.href`
        if (globalThis.location != null) {
          return globalThis.location.href;
        }
        return null;
      },
      _1819: () => {
        return typeof process != "undefined" &&
               Object.prototype.toString.call(process) == "[object process]" &&
               process.platform == "win32"
      },
      _1820: () => new WeakMap(),
      _1821: (map, o) => map.get(o),
      _1822: (map, o, v) => map.set(o, v),
      _1823: () => globalThis.WeakRef,
      _1835: s => JSON.stringify(s),
      _1836: s => printToConsole(s),
      _1837: a => a.join(''),
      _1838: (o, a, b) => o.replace(a, b),
      _1840: (s, t) => s.split(t),
      _1841: s => s.toLowerCase(),
      _1842: s => s.toUpperCase(),
      _1843: s => s.trim(),
      _1844: s => s.trimLeft(),
      _1845: s => s.trimRight(),
      _1846: (s, n) => s.repeat(n),
      _1847: (s, p, i) => s.indexOf(p, i),
      _1848: (s, p, i) => s.lastIndexOf(p, i),
      _1849: (s) => s.replace(/\$/g, "$$$$"),
      _1850: Object.is,
      _1851: s => s.toUpperCase(),
      _1852: s => s.toLowerCase(),
      _1853: (a, i) => a.push(i),
      _1854: (a, i) => a.splice(i, 1)[0],
      _1856: (a, l) => a.length = l,
      _1857: a => a.pop(),
      _1858: (a, i) => a.splice(i, 1),
      _1860: (a, s) => a.join(s),
      _1861: (a, s, e) => a.slice(s, e),
      _1862: (a, s, e) => a.splice(s, e),
      _1863: (a, b) => a == b ? 0 : (a > b ? 1 : -1),
      _1864: a => a.length,
      _1866: (a, i) => a[i],
      _1867: (a, i, v) => a[i] = v,
      _1869: (o, offsetInBytes, lengthInBytes) => {
        var dst = new ArrayBuffer(lengthInBytes);
        new Uint8Array(dst).set(new Uint8Array(o, offsetInBytes, lengthInBytes));
        return new DataView(dst);
      },
      _1870: (o, start, length) => new Uint8Array(o.buffer, o.byteOffset + start, length),
      _1871: (o, start, length) => new Int8Array(o.buffer, o.byteOffset + start, length),
      _1872: (o, start, length) => new Uint8ClampedArray(o.buffer, o.byteOffset + start, length),
      _1873: (o, start, length) => new Uint16Array(o.buffer, o.byteOffset + start, length),
      _1874: (o, start, length) => new Int16Array(o.buffer, o.byteOffset + start, length),
      _1875: (o, start, length) => new Uint32Array(o.buffer, o.byteOffset + start, length),
      _1876: (o, start, length) => new Int32Array(o.buffer, o.byteOffset + start, length),
      _1878: (o, start, length) => new BigInt64Array(o.buffer, o.byteOffset + start, length),
      _1879: (o, start, length) => new Float32Array(o.buffer, o.byteOffset + start, length),
      _1880: (o, start, length) => new Float64Array(o.buffer, o.byteOffset + start, length),
      _1881: (t, s) => t.set(s),
      _1882: l => new DataView(new ArrayBuffer(l)),
      _1883: (o) => new DataView(o.buffer, o.byteOffset, o.byteLength),
      _1885: o => o.buffer,
      _1886: o => o.byteOffset,
      _1887: Function.prototype.call.bind(Object.getOwnPropertyDescriptor(DataView.prototype, 'byteLength').get),
      _1888: (b, o) => new DataView(b, o),
      _1889: (b, o, l) => new DataView(b, o, l),
      _1890: Function.prototype.call.bind(DataView.prototype.getUint8),
      _1891: Function.prototype.call.bind(DataView.prototype.setUint8),
      _1892: Function.prototype.call.bind(DataView.prototype.getInt8),
      _1893: Function.prototype.call.bind(DataView.prototype.setInt8),
      _1894: Function.prototype.call.bind(DataView.prototype.getUint16),
      _1895: Function.prototype.call.bind(DataView.prototype.setUint16),
      _1896: Function.prototype.call.bind(DataView.prototype.getInt16),
      _1897: Function.prototype.call.bind(DataView.prototype.setInt16),
      _1898: Function.prototype.call.bind(DataView.prototype.getUint32),
      _1899: Function.prototype.call.bind(DataView.prototype.setUint32),
      _1900: Function.prototype.call.bind(DataView.prototype.getInt32),
      _1901: Function.prototype.call.bind(DataView.prototype.setInt32),
      _1904: Function.prototype.call.bind(DataView.prototype.getBigInt64),
      _1905: Function.prototype.call.bind(DataView.prototype.setBigInt64),
      _1906: Function.prototype.call.bind(DataView.prototype.getFloat32),
      _1907: Function.prototype.call.bind(DataView.prototype.setFloat32),
      _1908: Function.prototype.call.bind(DataView.prototype.getFloat64),
      _1909: Function.prototype.call.bind(DataView.prototype.setFloat64),
      _1922: () => new XMLHttpRequest(),
      _1923: (x0,x1,x2) => x0.open(x1,x2),
      _1924: (x0,x1,x2) => x0.setRequestHeader(x1,x2),
      _1925: (x0,x1,x2) => x0.setRequestHeader(x1,x2),
      _1926: x0 => x0.abort(),
      _1927: x0 => x0.abort(),
      _1928: x0 => x0.abort(),
      _1929: x0 => x0.abort(),
      _1930: (x0,x1) => x0.send(x1),
      _1931: x0 => x0.send(),
      _1933: x0 => x0.getAllResponseHeaders(),
      _1934: (o, t) => o instanceof t,
      _1936: f => finalizeWrapper(f, function(x0) { return dartInstance.exports._1936(f,arguments.length,x0) }),
      _1937: f => finalizeWrapper(f, function(x0) { return dartInstance.exports._1937(f,arguments.length,x0) }),
      _1938: o => Object.keys(o),
      _1939: (ms, c) =>
      setTimeout(() => dartInstance.exports.$invokeCallback(c),ms),
      _1940: (handle) => clearTimeout(handle),
      _1941: (ms, c) =>
      setInterval(() => dartInstance.exports.$invokeCallback(c), ms),
      _1942: (handle) => clearInterval(handle),
      _1943: (c) =>
      queueMicrotask(() => dartInstance.exports.$invokeCallback(c)),
      _1944: () => Date.now(),
      _1945: (x0,x1,x2,x3,x4,x5) => ({method: x0,headers: x1,body: x2,credentials: x3,redirect: x4,signal: x5}),
      _1946: (x0,x1,x2) => x0.fetch(x1,x2),
      _1947: (x0,x1) => x0.get(x1),
      _1948: f => finalizeWrapper(f, function(x0,x1,x2) { return dartInstance.exports._1948(f,arguments.length,x0,x1,x2) }),
      _1949: (x0,x1) => x0.forEach(x1),
      _1951: () => new AbortController(),
      _1952: x0 => x0.getReader(),
      _1953: x0 => x0.read(),
      _1954: x0 => x0.cancel(),
      _1958: () => new XMLHttpRequest(),
      _1959: (x0,x1,x2,x3) => x0.open(x1,x2,x3),
      _1961: () => new FileReader(),
      _1962: (x0,x1) => x0.readAsArrayBuffer(x1),
      _1970: f => finalizeWrapper(f, function(x0) { return dartInstance.exports._1970(f,arguments.length,x0) }),
      _1971: f => finalizeWrapper(f, function(x0) { return dartInstance.exports._1971(f,arguments.length,x0) }),
      _1988: x0 => x0.torch,
      _1989: x0 => x0.facingMode,
      _2004: (x0,x1) => x0.getContext(x1),
      _2008: (x0,x1,x2,x3,x4,x5) => x0.drawImage(x1,x2,x3,x4,x5),
      _2014: (s, m) => {
        try {
          return new RegExp(s, m);
        } catch (e) {
          return String(e);
        }
      },
      _2015: (x0,x1) => x0.exec(x1),
      _2016: (x0,x1) => x0.test(x1),
      _2017: (x0,x1) => x0.exec(x1),
      _2018: (x0,x1) => x0.exec(x1),
      _2019: x0 => x0.pop(),
      _2021: o => o === undefined,
      _2040: o => typeof o === 'function' && o[jsWrappedDartFunctionSymbol] === true,
      _2042: o => {
        const proto = Object.getPrototypeOf(o);
        return proto === Object.prototype || proto === null;
      },
      _2043: o => o instanceof RegExp,
      _2044: (l, r) => l === r,
      _2045: o => o,
      _2046: o => o,
      _2047: o => o,
      _2048: b => !!b,
      _2049: o => o.length,
      _2052: (o, i) => o[i],
      _2053: f => f.dartFunction,
      _2054: l => arrayFromDartList(Int8Array, l),
      _2055: l => arrayFromDartList(Uint8Array, l),
      _2056: l => arrayFromDartList(Uint8ClampedArray, l),
      _2057: l => arrayFromDartList(Int16Array, l),
      _2058: l => arrayFromDartList(Uint16Array, l),
      _2059: l => arrayFromDartList(Int32Array, l),
      _2060: l => arrayFromDartList(Uint32Array, l),
      _2061: l => arrayFromDartList(Float32Array, l),
      _2062: l => arrayFromDartList(Float64Array, l),
      _2063: x0 => new ArrayBuffer(x0),
      _2064: (data, length) => {
        const getValue = dartInstance.exports.$byteDataGetUint8;
        const view = new DataView(new ArrayBuffer(length));
        for (let i = 0; i < length; i++) {
          view.setUint8(i, getValue(data, i));
        }
        return view;
      },
      _2065: l => arrayFromDartList(Array, l),
      _2066: () => ({}),
      _2067: () => [],
      _2068: l => new Array(l),
      _2069: () => globalThis,
      _2070: (constructor, args) => {
        const factoryFunction = constructor.bind.apply(
            constructor, [null, ...args]);
        return new factoryFunction();
      },
      _2071: (o, p) => p in o,
      _2072: (o, p) => o[p],
      _2073: (o, p, v) => o[p] = v,
      _2074: (o, m, a) => o[m].apply(o, a),
      _2076: o => String(o),
      _2077: (p, s, f) => p.then(s, f),
      _2078: o => {
        if (o === undefined) return 1;
        var type = typeof o;
        if (type === 'boolean') return 2;
        if (type === 'number') return 3;
        if (type === 'string') return 4;
        if (o instanceof Array) return 5;
        if (ArrayBuffer.isView(o)) {
          if (o instanceof Int8Array) return 6;
          if (o instanceof Uint8Array) return 7;
          if (o instanceof Uint8ClampedArray) return 8;
          if (o instanceof Int16Array) return 9;
          if (o instanceof Uint16Array) return 10;
          if (o instanceof Int32Array) return 11;
          if (o instanceof Uint32Array) return 12;
          if (o instanceof Float32Array) return 13;
          if (o instanceof Float64Array) return 14;
          if (o instanceof DataView) return 15;
        }
        if (o instanceof ArrayBuffer) return 16;
        return 17;
      },
      _2079: (jsArray, jsArrayOffset, wasmArray, wasmArrayOffset, length) => {
        const getValue = dartInstance.exports.$wasmI8ArrayGet;
        for (let i = 0; i < length; i++) {
          jsArray[jsArrayOffset + i] = getValue(wasmArray, wasmArrayOffset + i);
        }
      },
      _2080: (jsArray, jsArrayOffset, wasmArray, wasmArrayOffset, length) => {
        const setValue = dartInstance.exports.$wasmI8ArraySet;
        for (let i = 0; i < length; i++) {
          setValue(wasmArray, wasmArrayOffset + i, jsArray[jsArrayOffset + i]);
        }
      },
      _2081: (jsArray, jsArrayOffset, wasmArray, wasmArrayOffset, length) => {
        const getValue = dartInstance.exports.$wasmI16ArrayGet;
        for (let i = 0; i < length; i++) {
          jsArray[jsArrayOffset + i] = getValue(wasmArray, wasmArrayOffset + i);
        }
      },
      _2082: (jsArray, jsArrayOffset, wasmArray, wasmArrayOffset, length) => {
        const setValue = dartInstance.exports.$wasmI16ArraySet;
        for (let i = 0; i < length; i++) {
          setValue(wasmArray, wasmArrayOffset + i, jsArray[jsArrayOffset + i]);
        }
      },
      _2083: (jsArray, jsArrayOffset, wasmArray, wasmArrayOffset, length) => {
        const getValue = dartInstance.exports.$wasmI32ArrayGet;
        for (let i = 0; i < length; i++) {
          jsArray[jsArrayOffset + i] = getValue(wasmArray, wasmArrayOffset + i);
        }
      },
      _2084: (jsArray, jsArrayOffset, wasmArray, wasmArrayOffset, length) => {
        const setValue = dartInstance.exports.$wasmI32ArraySet;
        for (let i = 0; i < length; i++) {
          setValue(wasmArray, wasmArrayOffset + i, jsArray[jsArrayOffset + i]);
        }
      },
      _2085: (jsArray, jsArrayOffset, wasmArray, wasmArrayOffset, length) => {
        const getValue = dartInstance.exports.$wasmF32ArrayGet;
        for (let i = 0; i < length; i++) {
          jsArray[jsArrayOffset + i] = getValue(wasmArray, wasmArrayOffset + i);
        }
      },
      _2086: (jsArray, jsArrayOffset, wasmArray, wasmArrayOffset, length) => {
        const setValue = dartInstance.exports.$wasmF32ArraySet;
        for (let i = 0; i < length; i++) {
          setValue(wasmArray, wasmArrayOffset + i, jsArray[jsArrayOffset + i]);
        }
      },
      _2087: (jsArray, jsArrayOffset, wasmArray, wasmArrayOffset, length) => {
        const getValue = dartInstance.exports.$wasmF64ArrayGet;
        for (let i = 0; i < length; i++) {
          jsArray[jsArrayOffset + i] = getValue(wasmArray, wasmArrayOffset + i);
        }
      },
      _2088: (jsArray, jsArrayOffset, wasmArray, wasmArrayOffset, length) => {
        const setValue = dartInstance.exports.$wasmF64ArraySet;
        for (let i = 0; i < length; i++) {
          setValue(wasmArray, wasmArrayOffset + i, jsArray[jsArrayOffset + i]);
        }
      },
      _2089: s => {
        if (/[[\]{}()*+?.\\^$|]/.test(s)) {
            s = s.replace(/[[\]{}()*+?.\\^$|]/g, '\\$&');
        }
        return s;
      },
      _2091: x0 => x0.input,
      _2092: x0 => x0.index,
      _2093: x0 => x0.groups,
      _2095: (x0,x1) => x0.exec(x1),
      _2097: x0 => x0.flags,
      _2098: x0 => x0.multiline,
      _2099: x0 => x0.ignoreCase,
      _2100: x0 => x0.unicode,
      _2101: x0 => x0.dotAll,
      _2102: (x0,x1) => x0.lastIndex = x1,
      _2103: (o, p) => p in o,
      _2104: (o, p) => o[p],
      _2105: (o, p, v) => o[p] = v,
      _2107: x0 => x0.random(),
      _2108: x0 => x0.random(),
      _2109: (x0,x1) => x0.getRandomValues(x1),
      _2110: () => globalThis.crypto,
      _2112: () => globalThis.Math,
      _2114: Function.prototype.call.bind(Number.prototype.toString),
      _2115: (d, digits) => d.toFixed(digits),
      _2119: () => globalThis.document,
      _2120: () => globalThis.window,
      _2125: (x0,x1) => x0.height = x1,
      _2127: (x0,x1) => x0.width = x1,
      _2131: x0 => x0.head,
      _2134: x0 => x0.classList,
      _2139: (x0,x1) => x0.innerText = x1,
      _2140: x0 => x0.style,
      _2142: x0 => x0.sheet,
      _2143: x0 => x0.src,
      _2144: (x0,x1) => x0.src = x1,
      _2145: x0 => x0.naturalWidth,
      _2146: x0 => x0.naturalHeight,
      _2154: x0 => x0.offsetX,
      _2155: x0 => x0.offsetY,
      _2156: x0 => x0.button,
      _2171: x0 => x0.status,
      _2172: (x0,x1) => x0.responseType = x1,
      _2174: x0 => x0.response,
      _2178: () => globalThis.window.flutterCanvasKit,
      _2179: () => globalThis.window._flutter_skwasmInstance,
      _2227: x0 => x0.readyState,
      _2229: (x0,x1) => x0.timeout = x1,
      _2231: (x0,x1) => x0.withCredentials = x1,
      _2232: x0 => x0.upload,
      _2233: x0 => x0.responseURL,
      _2234: x0 => x0.status,
      _2235: x0 => x0.statusText,
      _2237: (x0,x1) => x0.responseType = x1,
      _2238: x0 => x0.response,
      _2252: x0 => x0.loaded,
      _2253: x0 => x0.total,
      _2318: x0 => x0.style,
      _2675: (x0,x1) => x0.target = x1,
      _2677: (x0,x1) => x0.download = x1,
      _2891: x0 => x0.videoWidth,
      _2892: x0 => x0.videoHeight,
      _2896: (x0,x1) => x0.playsInline = x1,
      _2925: x0 => x0.error,
      _2927: (x0,x1) => x0.src = x1,
      _2928: x0 => x0.srcObject,
      _2929: (x0,x1) => x0.srcObject = x1,
      _2936: x0 => x0.buffered,
      _2939: x0 => x0.currentTime,
      _2940: (x0,x1) => x0.currentTime = x1,
      _2941: x0 => x0.duration,
      _2946: (x0,x1) => x0.playbackRate = x1,
      _2953: (x0,x1) => x0.autoplay = x1,
      _2955: (x0,x1) => x0.loop = x1,
      _2957: (x0,x1) => x0.controls = x1,
      _2959: (x0,x1) => x0.volume = x1,
      _2961: (x0,x1) => x0.muted = x1,
      _2976: x0 => x0.code,
      _2977: x0 => x0.message,
      _3053: x0 => x0.length,
      _3610: (x0,x1) => x0.width = x1,
      _3612: (x0,x1) => x0.height = x1,
      _4050: () => globalThis.window,
      _4114: x0 => x0.navigator,
      _4118: x0 => x0.screen,
      _4484: x0 => x0.clipboard,
      _4489: x0 => x0.mediaDevices,
      _4505: x0 => x0.userAgent,
      _4506: x0 => x0.vendor,
      _6709: x0 => x0.type,
      _6710: x0 => x0.target,
      _6752: x0 => x0.signal,
      _6831: () => globalThis.document,
      _6924: x0 => x0.body,
      _7273: x0 => x0.tagName,
      _7275: (x0,x1) => x0.id = x1,
      _7724: x0 => x0.ctrlKey,
      _7725: x0 => x0.shiftKey,
      _7726: x0 => x0.altKey,
      _7727: x0 => x0.metaKey,
      _8656: x0 => x0.value,
      _8658: x0 => x0.done,
      _8870: x0 => x0.result,
      _9378: x0 => x0.url,
      _9380: x0 => x0.status,
      _9382: x0 => x0.statusText,
      _9383: x0 => x0.headers,
      _9384: x0 => x0.body,
      _9463: x0 => x0.types,
      _9662: x0 => x0.type,
      _9694: x0 => x0.orientation,
      _10224: x0 => x0.facingMode,
      _10299: x0 => x0.facingMode,
      _10438: x0 => x0.width,
      _10440: x0 => x0.height,
      _10525: x0 => x0.deviceId,
      _10526: x0 => x0.kind,
      _10527: x0 => x0.label,
      _11539: (x0,x1) => x0.border = x1,
      _11807: (x0,x1) => x0.cursor = x1,
      _11817: (x0,x1) => x0.display = x1,
      _11981: (x0,x1) => x0.height = x1,
      _12175: (x0,x1) => x0.objectFit = x1,
      _12193: (x0,x1) => x0.opacity = x1,
      _12305: (x0,x1) => x0.pointerEvents = x1,
      _12603: (x0,x1) => x0.transform = x1,
      _12607: (x0,x1) => x0.transformOrigin = x1,
      _12671: (x0,x1) => x0.width = x1,
      _13048: x0 => x0.name,
      _13049: x0 => x0.message,

    };

    const baseImports = {
      dart2wasm: dart2wasm,


      Math: Math,
      Date: Date,
      Object: Object,
      Array: Array,
      Reflect: Reflect,
    };

    const jsStringPolyfill = {
      "charCodeAt": (s, i) => s.charCodeAt(i),
      "compare": (s1, s2) => {
        if (s1 < s2) return -1;
        if (s1 > s2) return 1;
        return 0;
      },
      "concat": (s1, s2) => s1 + s2,
      "equals": (s1, s2) => s1 === s2,
      "fromCharCode": (i) => String.fromCharCode(i),
      "length": (s) => s.length,
      "substring": (s, a, b) => s.substring(a, b),
      "fromCharCodeArray": (a, start, end) => {
        if (end <= start) return '';

        const read = dartInstance.exports.$wasmI16ArrayGet;
        let result = '';
        let index = start;
        const chunkLength = Math.min(end - index, 500);
        let array = new Array(chunkLength);
        while (index < end) {
          const newChunkLength = Math.min(end - index, 500);
          for (let i = 0; i < newChunkLength; i++) {
            array[i] = read(a, index++);
          }
          if (newChunkLength < chunkLength) {
            array = array.slice(0, newChunkLength);
          }
          result += String.fromCharCode(...array);
        }
        return result;
      },
    };

    const deferredLibraryHelper = {
      "loadModule": async (moduleName) => {
        if (!loadDeferredWasm) {
          throw "No implementation of loadDeferredWasm provided.";
        }
        const source = await Promise.resolve(loadDeferredWasm(moduleName));
        const module = await ((source instanceof Response)
            ? WebAssembly.compileStreaming(source, this.builtins)
            : WebAssembly.compile(source, this.builtins));
        return await WebAssembly.instantiate(module, {
          ...baseImports,
          ...additionalImports,
          "wasm:js-string": jsStringPolyfill,
          "module0": dartInstance.exports,
        });
      },
    };

    dartInstance = await WebAssembly.instantiate(this.module, {
      ...baseImports,
      ...additionalImports,
      "deferredLibraryHelper": deferredLibraryHelper,
      "wasm:js-string": jsStringPolyfill,
    });

    return new InstantiatedApp(this, dartInstance);
  }
}

class InstantiatedApp {
  constructor(compiledApp, instantiatedModule) {
    this.compiledApp = compiledApp;
    this.instantiatedModule = instantiatedModule;
  }

  // Call the main function with the given arguments.
  invokeMain(...args) {
    this.instantiatedModule.exports.$invokeMain(args);
  }
}

