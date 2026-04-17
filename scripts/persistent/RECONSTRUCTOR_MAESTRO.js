const fs = require('fs');
const path = require('path');

// 🧬 NEXUS THESIS RECONSTRUCTOR V2.0 (APA-7 EDITION)
// Processing context: 16GB Cloud Node

function processThesis() {
    console.log("Iniciando Fusión de Datos: ChatGPT + Claude...");
    
    // 1. Cargar corpus masivo
    const chatgpt = JSON.parse(fs.readFileSync('raw/conversations.json', 'utf8'));
    const claude = JSON.parse(fs.readFileSync('raw/conversations.claude.json', 'utf8'));
    
    let manuscript = "# CONVERGENCIA CIBER-ACÚSTICA: Informe Doctoral\n\n";
    manuscript += "## Capítulo 41: Síntesis de Hallazgos Trans-IA\n\n";
    
    // 2. Extraer "Hallazgos" usando patrones clave
    const allTurns = [...chatgpt, ...claude];
    allTurns.sort((a, b) => b.create_time - a.create_time); // Ordenar por tiempo
    
    allTurns.forEach(turn => {
        if (turn.message && turn.message.content) {
            const text = turn.message.content.parts[0];
            if (text.includes("hallazgo") || text.includes("acústica") || text.includes("diagnóstico")) {
                manuscript += `### Hallazgo Relacionado: ${new Date(turn.create_time * 1000).toLocaleDateString()}\n`;
                manuscript += `${text.substring(0, 500)}...\n\n`; // Tomar solo la esencia
            }
        }
    });

    fs.writeFileSync('output/CCA_MANUSCRIPT_COMPLETE.md', manuscript);
    console.log("✅ SÍNTESIS COMPLETADA. Manuscrito generado.");
}

processThesis();
