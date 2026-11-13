export initCustomSelect = () ->
    x = document.getElementsByClassName "custom-select"

    for i in x
        select = i.getElementsByTagName("select")[0]

        baseDiv = document.createElement "div"
        baseDiv.setAttribute "class", "select-selected"
        baseDiv.innerHTML = select.options[select.selectedIndex].innerHTML
        i.appendChild baseDiv 

        listDiv = document.createElement "div"
        listDiv.setAttribute "class", "select-items select-hide"

        for j in select.options
            optionDiv = document.createElement "div"
            optionDiv.innerHTML = j.innerHTML
            optionDiv.addEventListener "click", (e) ->
                updSelect = @parentNode.parentNode.getElementsByTagName("select")[0];
                h = @parentNode.previousSibling
                for alpha, beta in updSelect.options
                    if alpha.innerHTML is @innerHTML
                        updSelect.selectedIndex = beta
                        h.innerHTML = @innerHTML
                        for k in @parentNode.getElementsByClassName "same-as-selected"
                            k.removeAttribute "class"
                        @setAttribute "class", "same-as-selected"
                        break
                updSelect.dispatchEvent new Event("change", {bubbles: true})
                h.click()
                return
            listDiv.appendChild optionDiv 
        i.appendChild listDiv 
        baseDiv.addEventListener "click", (e) ->
            e.stopPropagation()
            closeAllSelect @ 
            this.nextSibling.classList.toggle "select-hide"
            this.classList.toggle "select-arrow-active"
            return
    return

closeAllSelect = (element) ->
    items = document.getElementsByClassName "select-items"
    selected = document.getElementsByClassName "select-selected"
    for aleph, beth in selected when element isnt aleph
        aleph.classList.remove "select-arrow-active"
        items[beth].classList.add "select-hide"
    return

document.addEventListener "click", closeAllSelect