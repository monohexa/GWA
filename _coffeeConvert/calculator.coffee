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
    div = grading.academic_time_division

    showFinal = (e, val) ->
        return unless e
        if val?
            e.textContent = if typeof val is "number" then val.toFixed(2) else val
        else
            e.innerHTML = "&mdash;"

    for q in [1..div]
        gwaDenominator = 0
        tempNumerator = 0
        complete = true

        for subject in grading.subjects 
            id = subject[0]
            unit = parseFloat subject[2]
            counted = subject[3] isnt true

            currentG = reader "#{q}q-#{id}"
            pastG = if q is 1 then currentG else reader "#{q-1}q-#{id}"

            display = document.getElementById "#{q}q-#{id}-trans"
            finalDisplay = document.getElementById "#{id}-final"

            final =
                if typeof currentG isnt "number"
                    currentG
                else if typeof pastG is "number"
                    transmute ((pastG + 2*currentG)/3)
                else
                    transmute currentG

            showFinal display, final
            showFinal finalDisplay, final if q is div

            if counted
                if typeof final is "number"
                    tempNumerator += (final * unit)
                    gwaDenominator += unit
                else if final is null
                    complete = false
        console.log q, complete, gwaDenominator, JSON.stringify(grading.subjects)
        quarterGWA = if complete and gwaDenominator > 0 then tempNumerator / gwaDenominator else null
        qGWADisplay = document.getElementById "#{q}-gwa-trans"
        finalGWA = document.getElementById "gwa"
        showFinal qGWADisplay, quarterGWA
        showFinal finalGWA, quarterGWA if q is div
    return

document.addEventListener "selects-ready", updateGWA
document.addEventListener "change", (e) ->
  updateGWA() if e.target.matches "select"

updateGWA()