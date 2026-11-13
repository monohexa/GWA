import { initCustomSelect } from "./selector.js"

numeric = [
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

nonNumeric = [
    "COM",
    "INC"
]

init = () ->
    grading = JSON.parse document.getElementById("grading-data").textContent
    div = grading.academic_time_division
    for subject in grading.subjects
        id = subject[0]
        grades = if subject[3] is true then nonNumeric else numeric

        for a in [1..div]
            cell = document.getElementById """#{a}q-#{subject[0]}"""
            if not cell
                console.warn("""no #{subject[0]}""")
                continue
            selectStyle = document.createElement 'div'
            selectStyle.style.width = "90%"
            selectStyle.setAttribute "class", "custom-select"

            select = document.createElement 'select'
            for grade in grades
                option = document.createElement 'option'
                option.value = grade
                option.textContent = if typeof grade is "number" then grade.toFixed 2 else grade
                select.appendChild option
            selectStyle.appendChild select
            cell.appendChild selectStyle 
    initCustomSelect()
    document.dispatchEvent new Event("selects-ready")

init()