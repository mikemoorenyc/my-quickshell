
function getMenus(menuRaw) {
    const menuSplit = menuRaw.split("\n\n").filter(n=>n.trim().length > 1)
    const menus = menuSplit.map(m=> {
        const rows = m.split("\n")
        const title = rows.find(r=>r.startsWith("title:"))?.replace("title:","").trim()||""
        const slug = rows.find(r => r.startsWith("slug:"))?.replace("slug:","").trim()||""
        let items = rows.filter(r=>!r.startsWith("slug:")&&!r.startsWith("title:"))
        items = items.map(r => r.split(",").map(i=>i.trim()))
        items = items.map(i => {
            return {
                title: i[0],
                exec:i[1],
                icon:i[2]||undefined
            }
        })
      
        return {title,slug,items}
    })
    return menus

}
function findMenu(menus,slug){

    return menus.find(m => m.slug ===slug)
}