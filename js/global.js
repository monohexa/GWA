const DEFAULT = "json/fallback.json"

const searchParams = new URLSearchParams(location.search);
const name = searchParams.get("data");

export const DATA = name
    ? `json/${name.replace(/[^a-z0-9_-]/gi, "")}.json`
    : DEFAULT;

export async function loadJSON(jsonFile = DATA) {
    try {
        const file = await fetch(jsonFile);
        if (file.ok) return await file.json();
    } catch (error) {
        console.error(`No JSON named ${jsonFile}`, error)
    }
    const fallback = await fetch(DEFAULT)
    return await fallback.json();
}

export const gradeForms = [
    1.00,
    1.25,
    1.50,
    1.75,
    2.00,
    2.25,
    2.50,
    2.75,
    3.00,
    4.00,
    5.00
]

export const antiNumericForms = [
    "COM",
    "INC"
]

export function waitForElement(id, timeout = 5000) {
    return new Promise((resolve) => {
        const found = document.getElementById(id);
        if (found) return resolve(found);

        const observer = new MutationObserver(() => {
            const el = document.getElementById(id);
            if (el) {
                observer.disconnect();
                resolve(el);
            }
        });
        observer.observe(document.body, { childList: true, subtree: true });

        setTimeout(() => {
            observer.disconnect();
            resolve(null);
        }, timeout);
    });
}

function footer() {
    const footerArea = document.getElementById("outerFooter");
    if (!footerArea) return;

    const p1 = document.createElement("p");
    p1.textContent = "The GWA Calculator is created by Marion Dominic Caleon of PSHS-CLC Batch 2030";
    const p2 = document.createElement("p");
    p2.textContent = "This website is not affiliated with PSHS-CLC, DOST-PSHSS, DOST, or the Republic of the Philippines in any way.";
    footerArea.appendChild(p1);
    footerArea.appendChild(p2);
}

footer();