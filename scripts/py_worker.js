// webworker.js

// Setup your project to serve `py-worker.js`. You should also serve
// `pyodide.js`, and all its associated `.asm.js`, `.data`, `.json`,
// and `.wasm` files as well:
importScripts("https://cdn.jsdelivr.net/pyodide/v0.18.1/full/pyodide.js");

async function loadPyodideAndPackages() {
  console.log('LOAD Pyodide')
  let start = Date.now()
  if (!self.pyodide) {
    self.pyodide = await loadPyodide({
      indexURL: "https://cdn.jsdelivr.net/pyodide/v0.18.1/full/",
    });
  }
  console.log(`LOAD Mircopip after ${Date.now() - start}ms`)
  await self.pyodide.loadPackage(["micropip"]);
  console.log(`DONE after ${Date.now() - start}ms`)
}
const pyodideReadyPromise = loadPyodideAndPackages();

self.onmessage = async (event) => {
  await pyodideReadyPromise;
  const { python, ...context } = event.data;
  for (const key of Object.keys(context)) {
    self.pyodide.globals.set(key, context[key]);
  }
  try {
    await self.pyodide.loadPackagesFromImports(python);
    let results = await self.pyodide.runPythonAsync(python);
    self.postMessage({ results });
  } catch (error) {
    self.postMessage({ error: error.message });
  }
};