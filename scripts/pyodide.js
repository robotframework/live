const fileList = ['TestObject.py']
var folderName = 'Example'

const output = document.getElementById("output");
const editorElements = document.getElementsByTagName("monaco-editor");
const logFrame = document.getElementById('iframe');
const ansi_up = new AnsiUp;
var pythonProgram = '';
var libDoc = '';
var pyodideWorker = null;
var fileCatalog = {};


function updateFolder(el){
    updateEditors(el.value);
}

function updateEditors(folder){
    folderName = folder
    for (let editorElement of editorElements) {
        loadFileToValue(folder, editorElement);
    }
    initializeFileCatalog(folder);
}

function updateEditorsFromURL(){
    initializeFileCatalog('Example');
    urlCatalog = LZString.decompressFromEncodedURIComponent((new URL(document.location)).searchParams.get('fileCatalog'));
    //console.log(urlCatalog)
    if (urlCatalog !== "") {
        fileCatalog = JSON.parse(urlCatalog);
    }
    for (let editorElement of editorElements) {
        console.log(`Loading ${editorElement.getAttribute('file')} to element ${editorElement.id}`);
        editorElement.setAttribute("value", fileCatalog[editorElement.getAttribute('file')]);
        //console.log(fileCatalog[editorElement.getAttribute('file')]);
    }
}


function initializeFileCatalog(folder) {
    for (let fileName of fileList) {
        addFileToFileCatalog(folder, fileName);
    }
}

function updateFileCatalog() {
    for (let editorElement of editorElements) {
        fileCatalog[editorElement.getAttribute('file')] = editorElement.getEditorValue()
    }
}

async function copyFileCatalog() {
    updateFileCatalog()
    fileCatalog['TestObject.py'] = ""
    var strCat = JSON.stringify(fileCatalog);

    var comCat = LZString.compressToEncodedURIComponent(strCat);
    console.log(`Size of compressed Base 64 fileCatalog is: ${comCat.length} (${comCat.length/(strCat.length/100)}%)`);
    await navigator.clipboard.writeText(document.location.origin + "/?fileCatalog=" + comCat);
}

function addFileToFileCatalog(folder, fileName) {
    fetch(folder + "/" + fileName)
        .then(response => response.text())
        .then(result => { fileCatalog[fileName] = result; });
}

function loadFileToPythonProgram() {
    fetch('python/executeRobot.py')
        .then(response => response.text())
        .then(result => { pythonProgram = result; });
}

function loadFileToLibDoc() {
    fetch('python/LibDoc.py')
        .then(response => response.text())
        .then(result => { libDoc = result; });
}

function loadFileToValue(folder, element) {
    const fileName = folder + "/" + element.getAttribute("file");
    console.log(`Loading ${fileName} to element ${element.id}`);
    fetch(fileName)
        .then(response => response.text())
        .then(result => { element.setAttribute("value", result); });
}

function updateLogHtml(html) {
    iframeContent = escape(html
        .replace(/<a href="#"><\/a>/is, "")
        .replace(/\{\{if source\}\}.*?<\/tr>.*?\{\{\/if\}\}/is, ""))
    logFrame.src = "data:text/html;charset=utf-8," + iframeContent;
}

function clearLogHtml() {
    logFrame.src = "data:text/html;charset=utf-8," + escape("<html><body></body></html>");
}

function writeToOutput(console_output) {
    if (!console_output) return;
    const html = ansi_up.ansi_to_html(console_output);
    output.innerHTML += html;
    //console.log(con_out)
}

function clearOutput() {
    output.innerHTML = "";
}

function run(script, context, onSuccess, onError, initialize) {
    if (!pyodideWorker || initialize) {
        pyodideWorker = new Worker("./scripts/py_worker.js");
    }
    pyodideWorker.onerror = onError;
    pyodideWorker.onmessage = (e) => onSuccess(e.data);
    pyodideWorker.postMessage({
        ...context,
        python: script,
    });
}

function asyncRun(script, context, onMessage, initialize) {
    let finished = false;
    return new Promise((resolve) => {
        run(script, context, (data) => {
            if (data.hasOwnProperty("results")) {
                console.log("FINISHED");
                //console.log(data);
                resolve(data);
            } else {
                //console.log("MESSAGE");
                //console.log(data);
                onMessage(data);
            }
        }, onMessage, initialize);
    });
}

loadFileToLibDoc();
loadFileToPythonProgram();
if ((new URL(document.location)).searchParams.get('fileCatalog')) {
    updateEditorsFromURL();
} else {
    updateEditors(folderName);
}
clearLogHtml()

async function runRobot(initialize=false) {
    clearOutput();
    writeToOutput("Initializing...\n");
    clearLogHtml();
    updateFileCatalog();
    await asyncRun(pythonProgram, {file_catalog: JSON.stringify(fileCatalog)}, (data) => {
        //console.log(data)   logging all data coming back
        data = JSON.parse(data)
        writeToOutput(data["std_output"]);
        if (data.hasOwnProperty("html")) {
            updateLogHtml(data["html"]);
        }
    }, initialize);
    writeToOutput("\nReady!");
}

async function runLibDoc() {
    updateFileCatalog();
    await asyncRun(libDoc, {file_catalog: JSON.stringify(fileCatalog)}, (data) => {
        console.log(data)
        // data = JSON.parse(data)
        // if (data.hasOwnProperty("keyword")) {
        //     handleKeywordCall(data);
        //     return;
        // }
        // writeToOutput(data);
        // if (data.hasOwnProperty("html")) {
        //     updateLogHtml(data["html"]);
        // }
    });
}