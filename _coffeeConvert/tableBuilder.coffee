grading = JSON.parse document.getElementById("grading-data").textContent

createTableElements = (system) ->
    headFinal = document.getElementById("headFinal")
    footFinal = document.getElementById("gwa")
    body = document.getElementById("body")
    div = system.academic_time_division
    totalUnits = 0
    document.getElementById("table").style.gridTemplateColumns = """auto auto repeat(#{system.academic_time_division*2}, 6rem) 6rem"""

    for q in [0...div]
        quarterCellH = document.createElement "div"
        quarterCellH.setAttribute "class", "cell"
        quarterCellH.textContent = """#{q+1}Q-T"""
        transH = document.createElement "div"
        transH.setAttribute "class", "cell"
        transH.textContent = """#{q+1}Q"""
        headFinal.parentNode.insertBefore quarterCellH, headFinal
        headFinal.parentNode.insertBefore transH, headFinal
        quarterCellF = document.createElement "div"
        quarterCellF.setAttribute "class", "cell"
        quarterCellF.id = """#{q+1}-gwa"""
        quarterCellF.innerHTML = "&mdash;&mdash;"
        transF = document.createElement "div"
        transF.setAttribute "class", "cell"
        transF.id = """#{q+1}-gwa-trans"""
        footFinal.parentNode.insertBefore quarterCellF, footFinal
        footFinal.parentNode.insertBefore transF, footFinal
    for subject in system.subjects
        row = document.createElement 'div'
        row.setAttribute "class", "row"

        title = document.createElement 'div'
        title.setAttribute "class", "cell title"
        title.textContent = subject[1]
        row.appendChild title

        unit = document.createElement 'div'
        unit.setAttribute "class", "cell"
        unit.textContent = subject[2]
        row.appendChild unit
        # transmutation 
        
        semBase = document.createElement 'div'
        semBase.setAttribute "class", "semesters"
        for repeat in [0...div]
            gradeInput = document.createElement "div"
            gradeInput.setAttribute "class", "cell gradeInput"
            gradeInput.id = """#{repeat+1}q-#{subject[0]}"""
            transmutedGrade = document.createElement 'div'
            transmutedGrade.setAttribute "class", "cell transmuted"
            transmutedGrade.id = """#{repeat+1}q-#{subject[0]}-trans"""
            semBase.appendChild gradeInput
            semBase.appendChild transmutedGrade
        row.appendChild semBase
        finalGrade = document.createElement "div"
        finalGrade.setAttribute "class", "cell gradeInput"
        finalGrade.id = """#{subject[0]}-final"""
        row.appendChild finalGrade
        body.appendChild row
        
        totalUnits += subject[2]
    document.getElementById("gwaUnit").textContent = totalUnits.toFixed(1)
    return

init = () ->
    document.getElementById("a-title").textContent = grading.title
    document.getElementById("a-desc").textContent = grading.desc
    createTableElements grading
    return

init()