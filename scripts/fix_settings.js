const fs = require('fs');
const path = require('path');

const settingsPath = path.join(process.env.APPDATA, 'Code', 'User', 'settings.json');

function cleanJson(content) {
    return content
        .replace(/\/\/.*$/gm, "") // Remove single line comments
        .replace(/\/\*[\s\S]*?\*\//g, "") // Remove multi-line comments
        .replace(/,\s*(?=[}\]])/g, ""); // Remove trailing commas
}

if (fs.existsSync(settingsPath)) {
    let raw = fs.readFileSync(settingsPath, 'utf8');
    try {
        let clean = cleanJson(raw);
        let data = JSON.parse(clean);
        
        data["jupyter.jupyterServerType"] = "remote";
        data["jupyter.pynotebook.kernelPath"] = "http://localhost:8888";
        data["google.colab.compute.localRuntimeUrl"] = "http://localhost:8888";
        data["google.colab.compute.backendUrl"] = "http://localhost:8888";
        
        fs.writeFileSync(settingsPath, JSON.stringify(data, null, 4), 'utf8');
        console.log("[OK] Settings updated via Node.js");
    } catch (e) {
        console.error("[!] Error parsing JSON: " + e.message);
    }
} else {
    console.error("[!] Settings not found at " + settingsPath);
}
