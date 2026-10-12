const list = [
    ["g7", "PSHS G7"],
    ["g8", "PSHS G8"],
    ["g9", "PSHS G9"],
    ["g10", "PSHS G10"],
    ["g11", "PSHS G11"],
    ["g12", "PSHS G12"]
]

const ulElement = document.getElementById("list");
for (const item of list) {
    const newItem = document.createElement("li");
    const link = document.createElement("a");
    link.href = `calculator.html?data=${item[0]}`;
    link.textContent = item[1];
    newItem.appendChild(link);
    ulElement.appendChild(newItem)
}