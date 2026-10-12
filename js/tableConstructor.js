import { loadJSON, gradeForms } from "./global.js";

{
    function tableCreate(gradeSystem) {
        const tableCore = document.createElement('div'); tableCore.id = "table";
        const headerCore = document.createElement('div'); headerCore.id = "header";
        const bodyCore = document.createElement('div'); bodyCore.id = "body";
        const footerCore = document.createElement('div'); footerCore.id = "footer";

        const headerTitle = document.createElement('div'); headerTitle.className = "cell title";
        const headerGrade = document.createElement('div'); headerGrade.className = "cell";
        const headerRow = document.createElement('div'); headerRow.className = "row";
        headerTitle.textContent = "Subject";
        headerGrade.textContent = "1Q Grade";
        headerRow.appendChild(headerTitle);
        headerRow.appendChild(headerGrade);
        headerCore.appendChild(headerRow)

        for (const subject of gradeSystem.subjects) {
            const row = document.createElement('div'); row.classList = "row"
            const subjectTitle = document.createElement('div'); subjectTitle.className = "cell title";
            const subjectGrade = document.createElement('div'); subjectGrade.className = "cell";
            subjectTitle.textContent = subject[1];
            subjectGrade.id = subject[0];
            row.appendChild(subjectTitle);
            row.appendChild(subjectGrade);
            bodyCore.append(row);
        };

        const footerTitle = document.createElement('div'); footerTitle.className = "cell title";
        const footerGrade = document.createElement('div'); footerGrade.className = "cell"; 
        const gwaText = document.createElement('div'); gwaText.id = "gwa"; footerGrade.appendChild(gwaText)
        const footerRow = document.createElement('div'); footerRow.className = "row";
        footerTitle.textContent = "General Weighted Average";
        footerRow.appendChild(footerTitle);
        footerRow.appendChild(footerGrade);
        footerCore.appendChild(footerRow);

        tableCore.appendChild(headerCore);
        tableCore.appendChild(bodyCore);
        tableCore.appendChild(footerCore);
        return tableCore
    }

    async function init() {
        try {
            const gradeSystem = await loadJSON();
            console.log(gradeSystem.desc);
            document.getElementById("desc").innerHTML = gradeSystem.desc;
            document.title = `GWA Calculator - ${gradeSystem.gradeProfile}`;
            document.getElementById("title").textContent = gradeSystem.gradeProfile;
            const gradeTable = tableCreate(gradeSystem);
            document.getElementById("content").appendChild(gradeTable);
        } catch (error) {
            console.error(error);
        }
    }

    init();
}