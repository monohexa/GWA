grading = JSON.parse document.getElementById("grading-data").textContent

console.log "gwa script loaded"

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

transmute = (num) ->
    for a, b in numeric
        next = numeric[b+1]
        return a unless next? and num > (a + next)/2
    numeric[numeric.length-1]

reader = (id) ->
    select = document.getElementById(id)?.querySelector "select"
    raw = select?.value?.trim()
    return null unless raw
    value = Number raw
    if isNaN value then raw else value

updateGWA = () ->
    return unless grading
    gwaDenominator = 0
    div = grading.academic_time_division

    showFinal = (e, val) ->
        return unless e
        if val?
            e.textContent = if typeof val is "number" then val.toFixed(2) else val
        else
            e.innerHTML = "&mdash;"

    for q in [1..div]
        tempNumerator = 0
        for subject in grading.subjects 
            id = subject[0]
            unit = subject[1]
            gwaDenominator += unit
            currentG = reader "#{q}q-#{id}"
            pastG = if q is 1 and typeof currentG is "number" then currentG else reader "#{q-1}q-#{id}"
            display = document.getElementById "#{q}q-#{id}-trans"
            continue unless display

            final =
                if typeof currentG isnt "number"
                    currentG
                else if typeof pastG is "number"
                    transmute ((pastG + 2*currentG)/3)
                else
                    transmute currentG
            
            finalDisplay = document.getElementById "#{id}-final"
            showFinal display, final
            showFinal finalDisplay, final if q is div
            tempNumerator += final*unit if not subject[3]
        quarterGWA = tempNumerator/gwaDenominator
        qGWADisplay = document.getElementById "#{q}-gwa-trans"
        finalGWA = document.getElementById "gwa"
        showFinal qGWADisplay, quarterGWA
        showFinal qGWADisplay, finalGWA if q is div
    return

document.addEventListener "selects-ready", updateGWA
document.addEventListener "change", (e) ->
  updateGWA() if e.target.matches "select"

updateGWA()